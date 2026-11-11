#!/bin/bash
# Usage: summarize-origins.sh <origins.json from log-origins.mjs>
jq -r '"elapsed \(.elapsed_s)s", (.rows | group_by(.origin)[] | "\(.[0].origin)  n=\(map(.count)|add)  first=\(map(.first_s)|min)s  types=\(map(.type)|unique|join(","))  mimes=\(map(.mime)|unique|join(","))")' "$1"
