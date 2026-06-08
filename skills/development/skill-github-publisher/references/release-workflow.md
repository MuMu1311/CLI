# Release Workflow

Use this reference after the source skill is identified.

## Parameters

Confirm or infer these values:

- `SKILL_NAME`: required.
- `SOURCE_SKILL_PATH`: must contain `SKILL.md`.
- `PUBLISH_MODE`: `single-skill`, `multi-skill-pack`, or `cli-harness-skill`.
- `REPO_NAME`: defaults to `<SKILL_NAME>-skill` only for new single-skill repos.
- `VISIBILITY`: defaults to `private`.
- `LICENSE`: defaults to `MIT` only when no upstream license conflict exists.
- `DESTINATION_REPO`: existing repo path or a new repo path.

If more than one value is ambiguous and cannot be inferred from local context, ask the user before publishing.

## Source Search Order

Windows:

```text
D:\CodexTools\codex-home\skills\<SKILL_NAME>
D:\CodexTools\codex-home\.agents\skills\<SKILL_NAME>
%USERPROFILE%\.agents\skills\<SKILL_NAME>
%USERPROFILE%\.codex\skills\<SKILL_NAME>
.\.agents\skills\<SKILL_NAME>
.\skills\<SKILL_NAME>
```

Linux/macOS:

```text
$HOME/.agents/skills/<SKILL_NAME>
$HOME/.codex/skills/<SKILL_NAME>
./.agents/skills/<SKILL_NAME>
./skills/<SKILL_NAME>
```

Stop if `SKILL.md` is not found.

## Layouts

### New Single-Skill Repo

```text
<repo>/
  README.md
  LICENSE
  SECURITY.md
  CHANGELOG.md
  .gitignore
  .agents/
    skills/
      <SKILL_NAME>/
        SKILL.md
        agents/
        references/
        scripts/
        templates/
        assets/
        examples/
```

Only create directories that exist or are needed.

### Existing Skill Pack

Use the existing pack convention. For this user's `MuMu1311/CLI` repository, prefer:

```text
skills/<category>/<SKILL_NAME>/
```

Update `skills/README.md` or the local registry if the repository uses one. Do not create a new repo unless the user asks.

### CLI Harness Skill

Keep skill instructions and executable harness code separate:

```text
<repo>/
  .agents/skills/<SKILL_NAME>/
  harness/
```

Do not mix CLI tool implementation into `SKILL.md`.

## GitHub Flow

1. Run `git status --short` before staging.
2. If unrelated changes exist, stage explicit skill paths only.
3. Commit with a terse message such as `add <skill-name> skill` or `update <skill-name> skill`.
4. Check `gh auth status` only when creating a new GitHub repo or when authentication is unclear.
5. For a new private repo:

```bash
gh repo create <REPO_NAME> --private --source=. --remote=origin --push
```

6. For an existing repo with a correct remote:

```bash
git push origin <branch>
```

7. Never use `--force`.
8. Optional tag only after push succeeds:

```bash
git tag v0.1.0
git push origin v0.1.0
```

If tag creation fails, report it without treating the main publish as failed.

## Final Report Shape

```text
Publish success: yes/no
Skill name:
Publish mode:
GitHub URL:
Visibility:
Local repo path:
Commit hash:
Tag:
Safety scan:
Excluded danger classes:
User action needed:
```
