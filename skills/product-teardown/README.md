# product-teardown

A skill for Claude Code and Codex. While you use any web app in your own browser, it watches the traffic and hands back a plain-English map of how the app works. You get a diagram, the steps in order, the API calls and their field names, where images, audio and video come from, and a best guess at the AI services behind it.

It's built for product managers and builders who want to understand how a product is put together without reading its code.

## What you get

A single HTML page with:

- a big-picture diagram of the pipeline
- the user journey step by step, with what each step **sends** and **gets back** (field names only)
- a table of the domains that serve media
- the likely AI provider for each stage, with every claim tagged **Seen** or **Best guess**
- ideas to borrow for your own product, and what's still unknown

## How it works

1. Opens a separate Chrome window with a throwaway profile. You log in there yourself.
2. A small bundled logger notes only the **domain names** the page contacts.
3. [REA](https://github.com/morluto/rea) records about 10 minutes of the app's own requests while you do one real task. It records JSON field names, never their values.
4. Two bundled scripts turn the capture into a summary, and the agent writes up the page from it.

## Install

You need [REA](https://github.com/morluto/rea) connected to your agent (`npx rea-agents@latest setup`, then restart), Google Chrome, Node.js 22+ and `jq`.

- **Claude Code:** copy this `product-teardown` folder to `~/.claude/skills/`.
- **Codex:** copy the folder to `~/.codex/skills/`.
- **Claude app:** download `product-teardown.zip` from the latest release and upload it as a custom skill. Note that the browser-watching steps need a local agent such as Claude Code.

## Use

> Tear down how example.com turns a prompt into a video. I'll make one in my logged-in session.

The agent opens the browser, tells you when to start, and tells you when it's done.

## Principles and limits

- **Observe only.** No replaying requests, no clicking for you, no unlocking paid features, no saved source code.
- **Field names, not values.** Bodies, headers, cookies and tokens are never recorded. Account and project IDs are kept out of the write-up.
- **Seen vs Best guess.** AI usually runs on the product's own server, so vendor names are inferences, and the page says so.
- Only use it on products you have a legitimate account for, within their terms of service. It's for learning, not for scraping, bypassing paywalls or security testing.

## Files

- `SKILL.md`: the instructions the agent follows
- `scripts/log-origins.mjs`: a passive domain logger (origin, type, MIME type, method only)
- `scripts/summarize-capture.sh`: turns a REA capture into endpoints, field names and media lists
- `scripts/summarize-origins.sh`: summarises the domain log
- `templates/teardown.html`: the write-up layout, filled with a fictional example

## Credits

Built on [REA](https://github.com/morluto/rea) by morluto, which does the browser observation. The workflow, privacy rules, domain logger, summary scripts and write-up template are original to this skill.
