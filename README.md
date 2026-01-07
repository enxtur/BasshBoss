BashBoss
========

Small bash helpers for everyday development: clean merged git branches, save quick WIP commits, and free up busy ports.

## Features
- `gcb`: remove local branches already merged into your target branch (dry-run by default).
- `git-wip`: stage everything and create (or amend) lightweight WIP commits.
- `kill-port`: find and kill any processes listening on given TCP ports.

## Requirements
- bash (tested on macOS/Linux shells)
- git CLI (`gcb`, `git-wip`)
- `lsof` (`kill-port`)
- Ability to create symlinks in `~/.local/bin` (default install target)

## Installation
```bash
./install.sh
```

What it does:
- Creates `~/.local/bin` if missing.
- Warns if `~/.local/bin` is not on `PATH`.
- Symlinks every executable (non-`.sh`) script in `scripts/` into `~/.local/bin`.

If `~/.local/bin` is not on your `PATH`, add:
```bash
export PATH="$PATH:$HOME/.local/bin"
```

## Usage

### gcb — clean merged branches
- Dry run (default target is current branch):
```bash
gcb
```
- Delete merged branches relative to `main`:
```bash
gcb -f main
```
Notes: Skips main/master/develop/dev; fetches/prunes before checking; requires a git repo.

### git-wip — quick work-in-progress commits
- Save all changes as a WIP commit:
```bash
git-wip "tweak auth flow"
```
- Amend the last commit if it was a WIP:
```bash
git-wip -a "refine tests"
```
Notes: Stages modified/deleted/untracked files; exits if no staged changes.

### kill-port — free busy TCP ports
- Single port:
```bash
kill-port 3000
```
- Multiple ports:
```bash
kill-port 3000 8080 5000
```
Notes: Validates port numbers; uses `lsof` to find PIDs; sends `kill -9` to each.

## Troubleshooting
- `command not found`: ensure `~/.local/bin` is on your `PATH` and re-source your shell rc.
- Git errors: run inside a git repository for `gcb`/`git-wip`; ensure `git fetch` works.
- lsof missing: install `lsof` via your package manager.
- Permissions: scripts must be executable (`chmod +x scripts/<name>`).

## Contributing
See `CONTRIBUTING.md` for guidelines, development tips, and PR expectations.
