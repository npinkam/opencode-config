---
name: codebase-search
description: Fast read-only search for codebase patterns, definitions, and class implementations using native grep and glob tools.
compatibility: opencode
---

## What I do
- Find files by name pattern using `glob`.
- Search file contents by regex using `grep` (native tool).
- Fall back to `rg` (ripgrep via bash) only when you need fixed-string search (`-F`), multiline (`-U`), or context lines (`-C`).

## When to use me
Use this skill when you need to answer: "Where is this class defined?", "Who imports this boundary?", or "Find all implementations of this interface."

## Instructions for the Agent
- Use `glob` for file name patterns (e.g. `**/*.py`).
- Use `grep` for regex content search with `include` for file type filtering.
- Only use `rg` via bash when the native tools can't express the query.
- Keep output narrow: line numbers and file paths, not full file contents.