---
name: skill-github-publisher
description: Use when packaging, auditing, creating, updating, or publishing Codex skills to GitHub, including locating local skill folders, choosing single-skill or multi-skill-pack layout, copying only intended skill files, generating README/LICENSE/SECURITY/CHANGELOG/.gitignore, excluding raw data, media, models, logs, caches, secrets, private paths, running safety scans, committing intentionally, pushing to GitHub, tagging releases, or updating an existing skill pack. Do not use for publishing unrelated app code or uploading user data.
---

# Skill GitHub Publisher

Use this skill to publish Codex skills safely. The goal is to publish the intended skill or skill pack only, with proof that private data, logs, raw media, scan outputs, models, and credentials were excluded.

Prefer existing local repository policy over generic defaults. If project instructions forbid new branches or worktrees, do not create them. Never force-push, delete remotes, or overwrite history.

## Route First

- **Release flow, repository layout, GitHub push**: read `references/release-workflow.md`.
- **Safety scan, blocked files, .gitignore rules**: read `references/security-scan.md`; use `scripts/scan-skill-release.ps1` on Windows.
- **Fusing local and network skills/sources**: read `references/source-fusion.md`.
- **Single-skill repository support files**: reuse `templates/repo_README.md`, `templates/gitignore_template.txt`, `templates/SECURITY.md`, `templates/CHANGELOG.md`, and `templates/LICENSE_MIT.txt`.

## Hard Rules

- Publish only the named skill or named skill pack.
- Do not publish all of `CODEX_HOME`, all of `.codex`, all of `.agents`, or all local skills.
- Do not publish raw images, videos, scan data, 3D models, training checkpoints, logs, caches, temp files, secrets, tokens, keys, private project data, or real client files.
- If the source skill cannot be found or `SKILL.md` is missing, stop and ask.
- If the skill is derived from another repository, inspect that repository's license before choosing a license.
- Default to private visibility for new GitHub repositories unless the user explicitly says public.
- Stop for GitHub login, 2FA, UAC, credential, token, or permission prompts. Never ask the user to paste a token.
- Use explicit `git add` paths. Do not use broad staging in mixed worktrees.
- Do not tag unless the main push succeeds.

## Default Inference

If the user does not specify values:

- `SKILL_NAME`: infer from the named skill, attached text, or changed skill path; ask only if ambiguous.
- `REPO_NAME`: `<SKILL_NAME>-skill` for a new single-skill repo.
- `VISIBILITY`: `private`.
- `PUBLISH_MODE`: `single-skill`, unless updating an existing skill pack or the user names multiple skills.
- `SOURCE_SKILL_PATH`: search common skill roots and the current repo.
- `LICENSE`: `MIT` only when no upstream license conflict exists.

## Minimal Workflow

1. Identify `SKILL_NAME`, `PUBLISH_MODE`, source path, destination repo, visibility, and license.
2. Verify `SKILL.md` frontmatter: `name` matches the folder, and `description` is specific.
3. Choose layout:
   - new one-skill repo: `.agents/skills/<skill-name>/...`
   - existing skill pack: `skills/<category>/<skill-name>/...`
   - CLI harness skill: keep `harness/` separate from skill instructions.
4. Copy only required skill files and allowed support files.
5. Generate support files for a new repo, or update the existing skill index for a pack.
6. Run large-file, blocked-extension, and credential-pattern scans.
7. Inspect `git status` and staged diff.
8. Commit with a clear message.
9. Push to GitHub without force.
10. Report the repo URL, commit hash, tag status, scan result, excluded file classes, and any user action needed.

## Evidence Required

The final report should include:

- publish success: yes/no,
- skill name,
- publish mode,
- GitHub URL,
- visibility,
- local repo path,
- commit hash,
- tag if created,
- safety scan result,
- excluded danger file classes,
- whether user action is needed.

Keep the report short. Do not print secrets, tokens, large logs, or full private paths unless needed to identify the local repo.
