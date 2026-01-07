BashBoss Contribution Guide
===========================

Thanks for considering a contribution. This project hosts small bash utilities. Please keep changes focused, safe, and well-documented.

## Ways to contribute
- Report bugs with clear steps, expected vs. actual behavior, and environment info.
- Suggest small scripts or enhancements with a short problem statement and approach.
- Submit pull requests for fixes, improvements, or documentation updates.

## Development setup
1. Fork and clone the repo.
2. Work in a git repository (required by `gcb`/`git-wip`).
3. Ensure prerequisites: bash, git, `lsof` (for `kill-port`).
4. Make scripts executable: `chmod +x scripts/<name>`.
5. Add `~/.local/bin` to `PATH` after installation if needed.

## Coding guidelines (bash)
- Use `#!/usr/bin/env bash` and `set -euo pipefail`.
- Prefer readable, defensive scripting; validate inputs early.
- Avoid `.sh` extensions for installable scripts; keep names concise.
- Keep output clear and actionable; non-zero exit codes for errors.
- Guard external calls (git, lsof, etc.) and provide helpful error messages.

## Testing checklist
- Run the script manually for common paths and edge cases.
- For git-related scripts, test inside a repo with dummy branches/commits.
- Confirm install flow via `./install.sh` and PATH behavior when applicable.

## Pull request process
1. Create a focused branch; keep PRs small and single-purpose.
2. Update docs (`README.md`/`CONTRIBUTING.md`) when behavior or usage changes.
3. Ensure scripts remain executable and follow guidelines above.
4. Describe changes, testing performed, and any follow-up work.

## Code of Conduct
Be respectful and constructive. If a formal Code of Conduct is added, follow it.

