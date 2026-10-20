---
name: be-ambitious
description: Push a goal, project or task further along four lenses (altitude, depth, range, show) and return a stretch target, an outside judge, next moves and a sharper prompt. Use when the user asks to be more ambitious, raise the bar, stretch a goal, or runs /be-ambitious.
---

# Be ambitious

Adapted from the kinds of ambition described in Anthropic's post "How to be more ambitious: A tutorial for humans with models" (October 2026): speed, altitude, depth and range. This skill turns them into a repeatable pass. The wording, the goal types, the Show lens and portfolio mode are additions.

## Step 1: Pin it down

Capture in one or two lines:

- **The goal or task** as given.
- **The goal type:** revenue, audience and credibility, learning, craft, or an outcome at work. Ambition looks different for each. A learning project is ambitious when it teaches something hard, not when it earns.
- **The real constraint:** hours per week, budget, data or tool access.
- **The current plan**, if there is one.

If the goal type or constraint is missing and changes the answer, ask one question. Otherwise state your assumption and carry on.

## Step 2: Run the lenses

For each lens, write a ladder of three rungs: a modest step up, a clear stretch, and a version that feels slightly unreasonable. Keep each rung to one or two concrete sentences that could start this week.

### Altitude: the goal behind the goal

Ask what the user wants to be true once this is done, and what decision it feeds. Move the request up: from doing the task, to owning the outcome, to redesigning how the outcome gets achieved. Note what a model would need to work at that level without being fed task after task: access to data, tools, and a way to check its own work.

### Depth: how the best in the field would do it

Answer four questions:

1. What would a leading practitioner do here that the user hasn't asked for?
2. What is the rawest material they'd start from, rather than a summary someone already made?
3. Which methods and tools would they use? Insist on the real instruments (a database, a statistical test, a profiler, customer interviews), not just the vocabulary.
4. What, other than the user or the model, would show the result is right?

Then set one target far beyond the current one (10x, not 2x) and treat it as reachable. Name one belief the user holds and say how to test it against raw data.

### Range: fields the task doesn't obviously need

Rewrite the task as verbs: what it actually does, for whom. List three to five fields that are good at those verbs, including one adversarial field whose job is to find the flaw. For each, name the technique to borrow. Borrow the method, not the voice: never answer in character.

### Show: make the work worth sharing

Ambitious work compounds when people can see it. Name the artefact this work could produce that someone outside would find useful or interesting: an open-source tool, a teardown with real numbers, a before-and-after, an honest write-up of what failed. Say who it's for and where it would land. Use only real results; never imply traction that doesn't exist.

Speed (the same work, faster) is the default use of AI and needs no lens. Mention it only if it is the bottleneck.

## Step 3: Pick and commit

- **Choose one rung per lens** that is the best stretch within the real constraint. Ambitious is not bigger: prefer the deeper version over a longer to-do list.
- **Name the outside judge** for the whole thing: a test, a metric from a real system, a paying customer, an expert who isn't the user, a reader's reply. If nothing outside can judge it, say so; fixing that comes first.
- **Name a precedent** if one exists: someone who already did something comparable. Seeing it done makes it believable. Search for it or leave it out; never invent one.
- **Give permission to fail:** describe the smallest version still worth doing if the big one misses.

## Step 4: Output

Keep the top to one screen:

1. **Goal at altitude** (one line)
2. **Stretch target** and its outside judge
3. **Three moves for this week**, each with what it proves
4. **Rewritten prompt:** the prompt the user could hand to a model to do the ambitious version, including the access and tools it needs
5. **What to share** (one line from the Show lens)

Put the lens ladders below, kept short, for anyone who wants the reasoning.

## Several goals at once (portfolio mode)

When the user lists several goals or projects:

- Tag each with its goal type, so learning projects aren't judged on revenue.
- Look for moves that serve more than one goal (one build that is a product, a post and a portfolio piece). Rank those first.
- Flag where effort is spread so thin that no goal will reach its judge, and suggest what to park for now. Parking is not killing.
- Output one table: goal, type, stretch target, outside judge, next move, also serves.

## Guardrails

- No invented numbers, customers, precedents or results. Label estimates as estimates.
- Use experts' methods; don't role-play them.
- Don't let the model grade its own work. Always name an outside check.
- Respect the real constraint. An ambitious plan that can't start this week is a wish.
- If the goal is already outcome-level with a good judge, say so and spend the effort on depth.

## Example

Goal: "Write a blog post about our churn numbers." Type: credibility.

- **Altitude:** the post exists so customers trust the product. Top rung: a public churn dashboard plus a monthly note on what changed and why.
- **Depth:** start from raw cancellation events, not the dashboard. Run a cohort survival analysis. Test the belief that churn is an onboarding problem.
- **Range:** verbs are "earn trust by showing bad news honestly". Borrow candour from investor letters, one-chart-one-claim from data journalism, and a short seller's habit of attacking the claim before publishing.
- **Show:** the open dashboard is the shareable artefact.
- **Outside judge:** renewal rates among customers who read the note against those who didn't, over the next quarter.
