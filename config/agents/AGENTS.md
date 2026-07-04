# Agent instructions

Global agent preferences for Nick Ball.

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
