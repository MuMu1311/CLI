# <SKILL_NAME>

A Codex Skill for <one-sentence purpose>.

## What this skill does

- <capability 1>
- <capability 2>
- <capability 3>

## When to use

Use this skill when:

- <trigger 1>
- <trigger 2>

Do not use this skill when:

- <non-goal 1>
- <non-goal 2>

## Repository structure

```text
.agents/
  skills/
    <SKILL_NAME>/
      SKILL.md
      agents/
      references/
      scripts/
      templates/
      examples/
```

## Installation

### Option A: Repo-scoped usage

Clone this repository and open Codex inside the repo. Codex can discover repo skills from `.agents/skills`.

### Option B: User-level installation

Copy:

```text
.agents/skills/<SKILL_NAME>
```

to your user skills directory:

```text
$HOME/.agents/skills/<SKILL_NAME>
```

Restart Codex if the skill does not appear.

## Usage

Invoke explicitly:

```text
$<SKILL_NAME>
```

Or ask Codex for a task that matches the skill description.

## Safety notes

- This repository does not include private data.
- This repository does not include raw media files, scan data, models, or secrets.
- Review scripts before running them.
- Do not run destructive commands without user approval.

## Development

Edit:

```text
.agents/skills/<SKILL_NAME>/SKILL.md
```

Optional scripts go in:

```text
.agents/skills/<SKILL_NAME>/scripts/
```

## License

<LICENSE>
