# LichtFeld 3DGS Trainer Skill

Reusable Codex skill for LichtFeld Studio 3DGS training from COLMAP/RealityScan exports.

## What It Does

- Parses Chinese batch prompts and 自动下料机-style text.
- Validates COLMAP/images handoff before expensive training.
- Applies high-parameter defaults: 30000 iterations, 10M-to-8M cap fallback, 4096 width.
- Routes RealityScan project/export/undistortion problems to `rc-realityscan-workflow`.
- Requires real PLY, manifest, summary, and checksum evidence before reporting success.

## Structure

```text
SKILL.md
agents/openai.yaml
references/
scripts/parse_training_batch.py
evals/evals.json
```

## Install

Repo-scoped use:

```text
Copy this folder to .agents/skills/lichtfeld-3dgs-trainer
```

User-level use:

```text
Copy this folder to your user skills directory, then restart Codex if needed.
```

## Parser Example

```powershell
python ".agents\skills\lichtfeld-3dgs-trainer\scripts\parse_training_batch.py" `
  --input "batch.txt" `
  --format summary `
  --strict
```

## Safety

This published skill intentionally excludes raw media, scan data, models, logs, caches, private project paths, and credentials.

## License

This folder is published under the repository root license.
