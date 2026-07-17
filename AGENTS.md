# Global Rules

## Response

- Never commit unless explicitly asked.
- Always run lint, typecheck, and tests after changes.
- No comments in code unless explicitly requested.
- Read and understand existing code before writing new code.
- Be concise. No preambles, summaries, or unnecessary explanations.
- Always respond in English.

## Preferences

- **Languages:** Python, TypeScript/JavaScript, Rust
- **Style:** OOP — classes, interfaces, encapsulation, clear boundaries
- **Git:** Conventional commits (feat:, fix:, chore:, refactor:, etc.)

## Testing

**Pyramid:** Unit → Integration (testcontainers) → E2E. Prefer integration over mocking.

**Unit:** Pure logic, algorithms, transformations. No DB, no network, no filesystem.
**Integration (testcontainers):** Any code touching Postgres, Redis, queues, or external services. Real containers, never mock drivers or HTTP clients.
**E2E:** Only critical user flows spanning frontend → backend → DB. Run sparingly.

**Definition of done:**
- Unit tests pass for changed logic.
- Integration tests pass with real containers for any component boundary crossed.
- DB schema, migrations, or API contracts: integration test is mandatory.
- Frontend ↔ backend communication: verify full request/response cycle against real backend.

## Think Before Coding / Delegation

- State assumptions. If uncertain, ask before implementing.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- Complex multi-file changes or architectural decisions: delegate to advisor first.
- **Codebase Discovery & Structural Mapping:** If you need to find where an interface, class, or dependency is defined, invoke the `explore` subagent immediately.
- Direct the `explore` agent to explicitly load the `codebase-search` skill to map out code using `rg` flags instead of iterating with `cat`. Treat its output as read-only structural truth before editing.

## Simplicity First

- Minimum code that solves the problem. No speculative features.
- No abstractions for single-use code. No error handling for impossible scenarios.
- If 200 lines could be 50, rewrite it.

## Surgical Changes

- Touch only what you must. Match existing style.
- Don't "improve" adjacent code, comments, or formatting.
- Remove orphans YOUR changes created. Don't touch pre-existing dead code.
- Every changed line must trace directly to the user's request.

## Goal-Driven Execution

- Define success criteria before starting. Transform tasks into verifiable goals.
- For multi-step tasks, state a brief plan with verification steps.
- Loop until verified. Don't assume it works — check.

## Safety

**Always ask before:** destructive DB operations (`DROP`, `TRUNCATE`, `DELETE` without `WHERE`), database migrations, or anything irreversible. Shell-level guards live in `opencode.json` → `permission.bash`.

---

**Working if:** fewer unnecessary diffs, fewer rewrites, clarifying questions before mistakes.
