---
name: 3dgs-lfs-handoff
description: Use when handing off 3DGS / LichtFeld Studio outputs into downstream tools such as Unreal Engine, Blender, DaVinci Resolve, or archive folders, especially when checking file integrity, metadata, paths, and delivery readiness without running training.
---

# 3DGS LFS Handoff

## When To Use

Use when 3DGS or LichtFeld Studio outputs need delivery checking before use in downstream tools.

## Workflow

1. Inventory `.ply`, `.nvol`, camera files, transforms, previews, logs, and version notes.
2. Check file existence, size, naming, paths, and expected folder layout.
3. Identify missing metadata or ambiguous versions.
4. Prepare a handoff checklist for the target tool.
5. Record risks and next steps plainly.

## Output

- handoff manifest
- missing file list
- downstream readiness notes
- risk list
- next-step checklist

## Guardrails

Do not run LichtFeld training, Blender rendering, or destructive cleanup. Do not modify original datasets.
