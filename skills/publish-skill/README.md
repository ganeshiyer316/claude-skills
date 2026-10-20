# publish-skill

A Claude Code skill that open-sources another skill. It takes a skill from your private skills repo, checks it for private information, writes a scrubbed copy into this public repo, adds it to the index, tags a release with an installable zip, and drafts the X and LinkedIn posts to share it.

## Setup

Keep two repos side by side:

- `claude-skills-private` (private): where you write and draft skills
- `claude-skills` (public): scrubbed copies only

Content flows one way, private to public. Your private copy is never changed.

Copy this `publish-skill` folder to `~/.claude/skills/` (or run `./sync.sh` from the public repo). It needs `git` and the GitHub CLI (`gh`) signed in.

## Use

In Claude Code, from the public repo folder: "Publish the my-skill skill" or `/publish-skill my-skill`.

It stops and asks before it pushes, creates a release or does anything else public.

## Principles

- The privacy check blocks everything else
- Work skills written for an employer are rewritten from scratch, not scrubbed
- Nothing public happens without your go-ahead
- Posts lead with a real result, not "I built a thing"
