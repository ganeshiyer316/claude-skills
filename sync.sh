#!/usr/bin/env bash
# Link every skill in this repo into ~/.claude/skills so Claude Code can use it.
# Edit skills here; the links keep ~/.claude/skills up to date. Safe to re-run.
set -euo pipefail

repo_dir="$(cd "$(dirname "$0")" && pwd)"
target="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
mkdir -p "$target"

for skill in "$repo_dir"/skills/*/; do
  [ -f "$skill/SKILL.md" ] || continue
  name="$(basename "$skill")"
  dest="$target/$name"
  if [ -L "$dest" ]; then
    ln -sfn "${skill%/}" "$dest"
    echo "updated  $name"
  elif [ -e "$dest" ]; then
    echo "skipped  $name (a real folder already exists at $dest; move it aside to link this one)"
  else
    ln -s "${skill%/}" "$dest"
    echo "linked   $name"
  fi
done
