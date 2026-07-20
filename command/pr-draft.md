---
description: Draft a PR from current branch changes
agent: build
---

# PR Draft

Draft a pull request for the current branch.
Base branch: if `$ARGUMENTS` is non-empty, use it; otherwise auto-detect (repo default → main → master).

## Step 1: Gather

Run a single bash block:

```bash
BASE="$ARGUMENTS"
if [ -z "$BASE" ]; then
  BASE=$(gh repo view --json defaultBranchRef --jq .defaultBranchRef.name 2>/dev/null)
  [ -z "$BASE" ] && git rev-parse --verify main >/dev/null 2>&1 && BASE=main
  [ -z "$BASE" ] && git rev-parse --verify master >/dev/null 2>&1 && BASE=master
fi
BRANCH=$(git symbolic-ref --short HEAD)
echo "Branch: $BRANCH  Base: $BASE"
git merge-base "$BASE" HEAD >/dev/null 2>&1 || { echo "ERROR: base '$BASE' not reachable from HEAD"; exit 1; }
git log --oneline "$BASE..HEAD"
echo "---DIFF---"
git diff --stat "$BASE..HEAD"
echo "---FULLDIFF---"
git diff "$BASE..HEAD"
```

If the current branch matches the base branch:
  1. Check for uncommitted changes via `git status --short`. If none, say "No changes to commit" and stop.
  2. From the diff, suggest a branch name in the format `type/scope-description` (e.g. `feat/auth-add-login`).
  3. Ask: "You're on the default branch. Create `[suggested-name]`? (yes / name: [custom] / cancel)"
  4. On `yes` or `name:`:
     Show the staged diff and ask "Commit and push? (yes / no)". On `yes`:
     ```bash
     git checkout -b [branch-name] && git add -u && git commit -m "[type(scope): description]" && git push -u origin [branch-name]
     ```
  5. Then proceed to Step 2. On `cancel`, stop.

If `gh` is not authenticated (`gh auth status` fails), say "gh is not authenticated. Run `gh auth login` first." and stop.

## Step 2: Draft

If the diff is trivial (1 file, <20 lines changed), draft the PR title and body directly.

Otherwise, delegate to the `advisor` subagent with the full output from Step 1:

```
Draft a PR title and body from these git changes.

Title: conventional commit format — type(scope): description
Types: feat, fix, chore, refactor, docs, test, ci, perf, style

Body format:
## Summary
1-2 sentences — what changed and why.

## Changes
- bullet list, max 5 points

## Breaking Changes
Include this section only if there are breaking changes.

Rules:
No emoji. No "This PR" preamble. No filler words.
Output ONLY the title on line 1, then an empty line, then the body.
```

## Step 3: Present

Format the draft as:

```
**Title:** [title]

**Body:**
[body]
```

Ask: "Create as draft PR? (yes / edit [describe changes])"

## Step 4: Create

On approval, run:

```bash
gh pr create --draft --title "[title]" --body "[body]" --base "$BASE"
```

Report the PR URL.

On edit request, apply the changes and loop back to Step 3.
