---
name: codebase-search
description: Fast read-only search for codebase patterns, definitions, and class implementations using ripgrep.
compatibility: opencode
---

## What I do
- Execute fast, multi-file text searches via `rg` to find where patterns or interfaces are used.
- Safely discover structures, imports, and cross-references without loading full files into the primary LLM context window.

## When to use me
Use this skill when you need to answer: "Where is this class defined?", "Who imports this boundary?", or "Find all implementations of this interface."

## Instructions for the Agent
Run queries using `rg`. Keep output narrow using flags like `-l` (filenames only), `-n` (line numbers), or context window limits (`-C 2`). Never read whole files sequentially if you can locate structural lines using this tool.