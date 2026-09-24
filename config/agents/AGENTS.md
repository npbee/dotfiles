# Agent instructions

Global agent preferences for Nick Ball.

## Response style

- Lead with the conclusion in 1-2 sentences. Expand only if I ask.
- No preamble, no flattery, no restating the question. Skip "Great question",

## Code comments

- Keep comments concise. Explain _why_, not _what_ — skip anything the code
  already says plainly.
- Frame comments against the current state of the code, not the change that
  produced it. A comment describes how things _are_, not how they got that way.
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
