---
name: 3dgs-visual-fail-diagnosis
description: Use when diagnosing visual failures in 3D Gaussian Splatting outputs, including floaters, holes, blurry geometry, broken scale, wrong orientation, color shift, noisy splats, or poor novel-view quality.
---

# 3DGS Visual Fail Diagnosis

## When To Use

Use when rendered 3DGS results show visual artifacts and the user needs likely causes and minimal fixes.

## Workflow

1. Inspect screenshots, logs, parameters, dataset notes, and output files.
2. Classify symptoms: floaters, holes, blur, noisy splats, broken scale, wrong orientation, color shift, or poor novel views.
3. Rank likely causes by evidence.
4. Propose verification steps that do not require full retraining first.
5. Recommend minimal corrective actions.

## Output

- symptom diagnosis
- likely-cause ranking
- verification checklist
- minimal fix plan
- unresolved evidence needs

## Guardrails

Do not run training, Blender rendering, or destructive file operations. Do not pretend diagnosis is confirmed when evidence is missing.
