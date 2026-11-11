// Passive origin logger: records ONLY origin, resource type, MIME type and HTTP method
// for each network request in all page targets of a loopback CDP browser.
// No headers, cookies, bodies, query strings or paths are recorded.
// Usage: node log-origins.mjs <durationSeconds> <outFile>   (CDP_PORT env var, default 9222)
import { writeFileSync } from 'node:fs';

const [durationS = '900', outFile = 'origins.json'] = process.argv.slice(2);
const ver = await (await fetch(`http://127.0.0.1:${process.env.CDP_PORT || 9222}/json/version`)).json();
const ws = new WebSocket(ver.webSocketDebuggerUrl);
let id = 0;
const send = (method, params = {}, sessionId) =>
  ws.send(JSON.stringify({ id: ++id, method, params, ...(sessionId ? { sessionId } : {}) }));

const stats = new Map(); // key -> {origin,type,mime,method,count,first,last}
const reqInfo = new Map(); // requestId -> {origin,method,type}
const t0 = Date.now();
const rel = () => Math.round((Date.now() - t0) / 1000);
const originOf = (u) => { try { const x = new URL(u); return x.protocol.startsWith('http') || x.protocol.startsWith('ws') ? x.origin : null; } catch { return null; } };
const bump = (origin, type, mime, method) => {
  const k = [origin, type, mime, method].join('|');
  const s = stats.get(k) ?? { origin, type, mime, method, count: 0, first_s: rel() };
  s.count++; s.last_s = rel(); stats.set(k, s);
};
const flush = () => {
  const rows = [...stats.values()].sort((a, b) => a.first_s - b.first_s);
  writeFileSync(outFile, JSON.stringify({ started: new Date(t0).toISOString(), elapsed_s: rel(), rows }, null, 1));
};

ws.onopen = () => {
  send('Target.setDiscoverTargets', { discover: true });
  send('Target.setAutoAttach', { autoAttach: true, waitForDebuggerOnStart: false, flatten: true });
  send('Target.getTargets');
};
const attached = new Set();
ws.onmessage = (ev) => {
  const m = JSON.parse(ev.data);
  if (m.result?.targetInfos) for (const t of m.result.targetInfos) if (t.type === 'page' && !t.attached) send('Target.attachToTarget', { targetId: t.targetId, flatten: true });
  if (m.method === 'Target.targetCreated' && m.params.targetInfo.type === 'page') send('Target.attachToTarget', { targetId: m.params.targetInfo.targetId, flatten: true });
  if (m.method === 'Target.attachedToTarget') {
    const sid = m.params.sessionId;
    if (!attached.has(sid)) { attached.add(sid); send('Network.enable', {}, sid); send('Runtime.runIfWaitingForDebugger', {}, sid); }
  }
  if (m.method === 'Network.requestWillBeSent') {
    const o = originOf(m.params.request.url);
    if (o) reqInfo.set(m.params.requestId, { origin: o, method: m.params.request.method, type: m.params.type ?? 'Other' });
  }
  if (m.method === 'Network.responseReceived') {
    const r = reqInfo.get(m.params.requestId);
    const o = r?.origin ?? originOf(m.params.response.url);
    if (o) bump(o, m.params.type ?? r?.type ?? 'Other', (m.params.response.mimeType || '').split(';')[0], r?.method ?? '?');
  }
  if (m.method === 'Network.webSocketCreated') { const o = originOf(m.params.url); if (o) bump(o, 'WebSocket', '', 'GET'); }
};
const timer = setInterval(flush, 5000);
setTimeout(() => { flush(); clearInterval(timer); ws.close(); process.exit(0); }, Number(durationS) * 1000);
