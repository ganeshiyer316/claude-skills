#!/bin/bash
# Usage: summarize-capture.sh <saved REA inspect_web_page result JSON>
# Prints field NAMES only (REA shapes never include values).
F="$1"
ID='[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
echo "=== WINDOW & COVERAGE ==="
jq -c '.normalized_result.capture_window' "$F"
jq -c '.normalized_result.completeness | {status, excluded: [.excluded[] | select(.reason=="disallowed_origin")]}' "$F"
jq -c '.normalized_result.network | {requests:(.requests|length), websockets:(.websocket_connections|length)}' "$F"

echo; echo "=== UNIQUE ENDPOINTS IN FIRST-SEEN ORDER (index, count, method origin path status mime) ==="
jq -r --arg id "$ID" '.normalized_result.network.requests | to_entries[] | .value as $r |
  ($r.url | sub("^https?://[^/]+";"") | sub("\\?.*";"?…") | gsub($id;"{id}") | gsub("/[0-9]{3,}";"/{n}")) as $p |
  "\(.key)\t\($r.method)\t\($r.origin|sub("https://";""))\t\($p)\t\($r.status)\t\($r.mime_type)"' "$F" |
  awk -F'\t' '{k=$2" "$3$4" "$5" "$6; if(!(k in s)){s[k]=$1; o[++n]=k}; c[k]++} END{for(i=1;i<=n;i++) print s[o[i]]"\t"c[o[i]]"x\t"o[i]}' |
  grep -v -E "_next/static|\.(woff2?|css|svg|ico)( |\?)"

echo; echo "=== API FIELD NAMES (depth<=3; non-static JSON calls) ==="
jq -r --arg id "$ID" '
def p: map(if .kind=="property" then .name else "[]" end) | join(".");
def sh(s): if s==null then "-" else (s.properties // [] | map(select((.path|length)<=3)) | map("\(.path|p):\(.types|join("|"))") | join("  ")) end;
.normalized_result.network.requests[] | select(.method!="OPTIONS" and (.mime_type|test("json"))) |
(.url|sub("^https?://";"")|sub("\\?.*";"")|gsub($id;"{id}")) as $path |
"\(.method) \($path)\n   REQ: \(sh(.body_shapes.request))\n   RES: \(sh(.body_shapes.response))"' "$F" | awk '!seen[$0]++'

echo; echo "=== QUERY PARAMETER NAMES ==="
jq -r --arg id "$ID" '.normalized_result.network.requests[] | select(.url|test("\\?")) |
  (.url|sub("^https?://";"")|sub("\\?.*";"")|gsub($id;"{id}")) + " ? " + (.url|sub(".*\\?";"")|split("&")|map(split("=")[0])|join(","))' "$F" | sort -u

echo; echo "=== NON-JSON FILES (media/models), by path pattern ==="
jq -r --arg id "$ID" '.normalized_result.network.requests[] | select((.mime_type|test("json|javascript|css|html|font"))|not) |
  "\(.url|sub("^https?://";"")|sub("\\?.*";"")|gsub($id;"{id}")) \(.status) \(.mime_type) \(.resource_type)"' "$F" | sort | uniq -c
