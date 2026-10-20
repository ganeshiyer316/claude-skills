---
name: publish-skill
description: Open-source a Claude skill from a private skills repo to the public claude-skills GitHub repo. Checks it for private or company information, tidies the frontmatter and README, adds it to the index, tags a release with a zip, and drafts X and LinkedIn posts. Use when asked to publish, open-source or share a skill, or on /publish-skill.
---

# Publish a skill

Turns a skill from the private repo into a public, installable skill in the `claude-skills` repo, then drafts the posts to share it. Stop and ask before anything that publishes (push, release, post).

## The two repos

```
claude-skills-private/   (private) where skills are written and drafted
  skills/<name>/SKILL.md
claude-skills/           (public) scrubbed copies only
  README.md              index table of every skill
  LICENSE                MIT, covers every skill
  sync.sh                links skills into ~/.claude/skills
  skills/<name>/
    SKILL.md
    README.md            what it does, install, use, credits
    (any scripts or reference files the skill needs)
```

Content flows one way: private to public. The public copy is a scrubbed copy, never a move. The private copy keeps its real examples and context and is never edited by this skill.

Both repos usually sit side by side (e.g. `~/code/claude-skills` and `~/code/claude-skills-private`). If the private repo isn't next to this one, ask where it is.

## Step 1: Find the skill

Take the skill the user names. By default look for `../claude-skills-private/skills/<name>/`; also accept any folder or SKILL.md path the user gives. If it's already in the public repo, this is an update: compare the private and public versions, carry over only the improvements, and note what changed for the release notes.

**Work skills stop here.** If the skill was written for an employer or a client (its instructions, templates or examples are about that company's product, process, customers or data), don't publish a scrubbed copy: the content may belong to them. Tell the user, and offer to write a generic version from scratch instead, built from the general method and not the company's material.

## Step 2: Privacy and safety check (blocking)

Read every file in the skill folder. Flag and fix before going further:

- Employer names, client names, internal systems, colleagues' names, internal URLs
- Personal details: family names, addresses, email addresses, phone numbers
- Secrets: API keys, tokens, `.env` contents, credentials in examples
- Invented numbers or results presented as real
- Text copied from another source beyond a short attributed quote

Show the user each finding with a suggested rewrite. Do not continue until each one is fixed or the user says it's fine. A skill written for personal use often names real people in examples; replace them with neutral ones.

## Step 3: Tidy

- **Frontmatter:** `name` matches the folder, kebab-case, no "claude" or "anthropic". `description` says what it does and when to use it, in one or two sentences under 1024 characters.
- **Instructions:** generic enough for a stranger. Remove references to the author's own projects unless they're labelled as examples.
- **README.md:** one-line pitch; what it does; install (Claude Code: copy folder to `~/.claude/skills/`; Claude app: upload the zip from Releases); use (an example prompt); principles or limits; credits for any source it builds on, saying clearly what's original.
- Plain, direct copy. British spelling.

## Step 4: Try it

Run the skill once on a realistic example that has nothing private in it. Save the output as `skills/<name>/example.md` if it helps people see what they'll get. If the output is weak, say so and fix the skill before publishing.

## Step 5: Add to the repo

- Write the scrubbed copy into `skills/<name>/` in the public repo. Make all Step 2 and 3 edits there, not in the private repo.
- Add or update its row in the root README table: skill link, one-line description, month added (MM/YYYY).
- Commit: `Add <name> skill` or `Update <name> skill: <what changed>`.

## Step 6: Publish (ask first)

Show the user the diff summary and ask before each of these:

1. `git push` to `main`.
2. Zip the skill folder so the zip contains `<name>/SKILL.md` at its top level: `cd skills && zip -r ../<name>.zip <name>`.
3. Create a release tagged `<name>-v<n>` (start at v1, increase on each update) with the zip attached and two or three lines of notes:
   `gh release create <name>-v1 <name>.zip --title "<name> v1" --notes "..."`
4. Delete the local zip.

## Step 7: Draft the posts

Draft, don't post. Give the user:

- **X:** a short post (under 280 characters) or a thread of 3 to 5 posts. Lead with the problem it solves or a real result from Step 4, not "I built a skill". Link to the skill folder on GitHub.
- **LinkedIn:** 120 to 200 words. What it does, why it was built, one concrete example, how to install, link. Credit any source.

Use only real results. No hashtag walls, no "game-changer".

## Rules

- Never push secrets or private information. Step 2 blocks everything else.
- Never push, release or post without the user's go-ahead in this conversation.
- Never rewrite git history on `main`. If something private was pushed by mistake, stop and tell the user: deleting the file isn't enough, because it stays in the history. They need to rotate any secret and decide whether to rewrite history.
- Never copy anything from the public repo into the private one, and never edit the private copy.
- Never publish a work skill as a scrubbed copy (see Step 1).
