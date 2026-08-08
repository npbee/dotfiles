# Agent instructions

Global agent preferences for Nick Ball.

## Response style

- Be concise. Answer first, supporting detail after.
- No preamble, no flattery, no restating the question. Skip "Great question",
  "Sure, I'd be happy to", and summaries of what you're about to do.
- Match length to the task: a one-line question gets a one-line answer.
- Cut hedging and filler — "just", "really", "basically", "actually", "simply".
  Say the thing.
- Don't narrate tool calls or announce next steps. Do the work, report what
  happened.
- Report findings, not process. What you tried and ruled out matters only when
  the dead end is itself useful.
- No decorative tables or emoji. Prose and bullets. Tables are for data with
  real columns.
- Don't paste long logs or full file dumps. Quote the shortest decisive lines,
  with a `path:line` reference.
- Terse phrasing, exact terms. Never abbreviate technical names, and quote
  errors verbatim.
- Loosen up where compression hurts: security caveats, destructive or
  irreversible steps, and ordered instructions get full sentences.

## Code comments

- Keep comments concise. Explain *why*, not *what* — skip anything the code
  already says plainly.
- Frame comments against the current state of the code, not the change that
  produced it. A comment describes how things *are*, not how they got that way.
  The reader sees the file, not your diff.
- Avoid diff-narration words: "now", "changed", "added", "removed",
  "previously", "used to", "new". They date the comment the moment it lands.

Bad (narrates the change):

```
// Now retries 3 times instead of once
// Removed the old caching layer here
```

Good (describes current state / reason):

```
// Retries 3x; upstream API is flaky under load
// No caching: responses are user-specific and short-lived
```

## Pull requests

- Keep the summary small — a couple of sentences, no filler.
- Single body, no section headers. Bullet lists are fine.
- No test plan.
