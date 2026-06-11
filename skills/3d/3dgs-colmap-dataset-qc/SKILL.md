---
name: 3dgs-colmap-dataset-qc
description: Use when checking whether a photo or video-frame dataset is suitable for COLMAP / 3DGS reconstruction before training.
---

# 3DGS COLMAP Dataset QC

## When To Use

Use before COLMAP or 3DGS processing to decide whether a dataset is likely to reconstruct cleanly.

## Workflow

1. Inventory image count, resolution, format, EXIF, and folder layout.
2. Check blur, duplicates, exposure, reflections, transparency, sky dominance, and coverage.
3. Assess viewpoint continuity, overlap, focal consistency, and capture path.
4. Grade the dataset as pass, warn, or fail.
5. Recommend minimal reshoot or cleanup actions.

## Output

- dataset QC table
- pass/warn/fail rating
- reshoot recommendations
- cleanup suggestions
- training-readiness notes

## Guardrails

Do not delete or modify original images. Do not run COLMAP, 3DGS training, or heavy reconstruction unless the user explicitly asks.
