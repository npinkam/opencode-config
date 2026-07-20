---
description: Review code using explore and advisor agents for comprehensive analysis
agent: build
---

# Code Review

You are orchestrating a code review. Your job: coordinate subagents, synthesize findings, deliver actionable output.

## Input

$ARGUMENTS

If empty, review the last commit (`git diff HEAD~1`).

## Step 1: Gather Context (explore agent)

Delegate to the `explore` subagent:

```
Load the codebase-search skill. For the code in $ARGUMENTS:
1. Find all callers of modified functions/methods
2. Find all tests touching these files or their imports
3. Map dependencies: what does this code import, what imports it
4. Read AGENTS.md from the repo root (or ~/.config/opencode/AGENTS.md) and include its full content
5. Check if README.md and AGENTS.md accurately reflect the codebase — are there new features, changed APIs, or removed components not documented?
6. Report file paths and line numbers, not full contents
```

Wait for explore's output before proceeding.

## Step 2: Deep Analysis (advisor agent)

Delegate to the `advisor` subagent with explore's findings as context:

```
Review this code for:
1. **Correctness**: logic errors, edge cases, race conditions
2. **Security**: injection, auth bypass, data exposure, input validation gaps
3. **Design**: violations of encapsulation, unnecessary coupling, missing abstractions
4. **Performance**: O(n²) where O(n) works, unnecessary allocations, N+1 queries
5. **Testability**: can this be tested? Are critical paths covered?
6. **AGENTS.md compliance**: violations of guidelines in the provided AGENTS.md content
7. **Docs drift**: README.md or AGENTS.md missing changes, outdated descriptions, or incorrect docs

For each finding:
- File:line — what's wrong and why it matters
- Concrete fix (not "consider improving X")
- Confidence score (0-100): how certain you are this is a real issue, not a false positive

Skip style nits. Focus on bugs, security, and design that causes real problems.
Only report findings with confidence >= 80.
```

## Step 3: Synthesize

Combine explore's context and advisor's analysis into this format:

```
## Review: [file/PR/commit]

### Critical (must fix before merge)
- [file:line] [issue] — [fix] (confidence: [score])

### Important (should fix)
- [file:line] [issue] — [fix] (confidence: [score])

### Context
- [key dependencies, callers, or test gaps from explore]

### Verdict
[APPROVE / REQUEST CHANGES / NEEDS DISCUSSION]
```

If no critical or important issues, say "LGTM" and skip the sections.

## Rules

- No praise, no "good job", no hedging. Direct statements only.
- If advisor or explore fails, say so and proceed with what you have.
- Max 5 findings per section. If more, group or prioritize.
- End with verdict. No summary paragraphs.
- Filter out any finding with confidence < 80 before synthesizing.
