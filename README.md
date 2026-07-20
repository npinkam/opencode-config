# opencode-config

Personal [opencode](https://opencode.ai) configuration for fast, minimal AI-assisted coding on Linux.

## Features

- **DeepSeek V4 Flash** (main agent) + **Qwen 3.7 Max** (planner) + **DeepSeek V4 Pro** (advisor) — fast for volume, planner for orchestration, Pro for deep reasoning
- **Ponytail plugin** — lazy mode to keep code simple and minimal
- **rtk** — reduced token output for leaner context
- **ripgrep** — fast codebase search via `explore` subagent
- **codebase-search skill** — structural mapping without reading full files
- **`/code-review` command** — multi-agent code review with confidence scoring and AGENTS.md compliance

## Prerequisites

- [opencode](https://opencode.ai) installed
- API keys for your LLM providers (set as environment variables, not in config)

## Installation

```bash
git clone https://github.com/npinkam/opencode-config.git ~/.config/opencode
cd ~/.config/opencode
chmod +x setup.sh
./setup.sh
```

## What's included

| File | Purpose |
|---|---|
| `opencode.jsonc` | Model, agent, and permission config |
| `AGENTS.md` | Global rules for coding style, testing, and delegation |
| `command/code-review.md` | Multi-agent code review command |
| `command/pr-draft.md` | Draft PR with conventional commit format |
| `skills/codebase-search/` | Skill for ripgrep-based codebase exploration |
| `setup.sh` | Bootstrap script for new machines |
| `package.json` | Ponytail plugin dependency |

## License

MIT