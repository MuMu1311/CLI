---
name: lichtfeld-3dgs-trainer
description: Use this whenever the user asks for LichtFeld, LichtFeld Studio, letchfeild, letechfield, 3DGS high-parameter training, COLMAP-to-PLY training, RealityScan/RealityCapture COLMAP handoff, batch 3DGS queues, "自动下料机", "完成一组再训练下一组", "高斯数10M-8M", "30000迭代", or parsing many images/COLMAP/output paths for sequential 3DGS training. This skill captures a verified Windows workflow, parameter fallback rules, output cleanup rules, monitoring, and final success checks for LichtFeld 3DGS training.
---

# LichtFeld 3DGS Trainer

Use this skill to turn terse LichtFeld/3DGS training requests into concrete, verified work. Favor execution over advice when the user provides paths.

## Read First

- Before training, read `references/training-rules.md`.
- For Chinese batch prompts, pasted path lists, or 自动下料机 text, read `references/auto-feeder-template.md` and prefer `scripts/parse_training_batch.py`.
- For RealityScan/RealityCapture/RC export, Registration, COLMAP standard, undistortion, or project-folder handoff, read `references/rc-realityscan-handoff.md`.
- For ComfyUI, ComfyUI-3D-Pack, ComfyUI_3DGaussianSplatting, SAM3D, MVDream, LGM, workflow JSON, or ComfyUI-generated PLY/OBJ/GLB handoff, read `references/comfyui-3dgs-handoff.md`.
- For the reason behind `5K -> 4096` and `10M -> 8M` fallback rules, read `references/verified-runs.md`.
- Treat any bundled or named 自动下料机 file as a sample only. The actual job list comes from the current user message or the file path the user names.

## Core Rules

1. Interpret common misspellings such as `letchfeild` as `LichtFeld Studio`.
2. If the user says "高参数", default to `30000` iterations, `10M -> 8M` max-cap fallback, and `4096` max image width unless the user gives other values.
3. If the user asks for `5k`, do a low-cost probe only; many LichtFeld builds reject `--max-width > 4096`.
4. Run one training job at a time. Do not launch a whole batch in parallel.
5. Keep batch control, queues, and summary files outside the user's final PLY output directory.
6. Final output directories should contain LichtFeld training artifacts only, such as `splat_30000.ply`, `training_manifest.json`, `training_summary.md`, `checksums.sha256`, `logs`, `stage`, and `training_output_high_*`.
7. If the user needs RC project creation, RC export, lens/undistortion decisions, or crash recovery, route to `rc-realityscan-workflow`; this skill takes over once valid COLMAP/images data exists.
8. If the user needs ComfyUI nodes, workflows, previews, single-image/few-image 3D assets, or ComfyUI-generated PLY/Mesh inspection, route to `comfyui-3dgs-project-operator` if available; this skill trains only from images + COLMAP sparse.

## Workflow

1. Parse the queue. Every job must have `input_colmap_root` and `output_dir`.
2. Preflight inputs. Confirm an image directory, COLMAP text model files, and non-empty registered images in `images.txt`.
3. For RC/RealityScan exports, confirm the input is an exported COLMAP directory, not a raw source folder, `.rsproj` data folder, or model export folder.
4. For ComfyUI outputs, confirm the input is not just a PLY/OBJ/GLB/texture. Without COLMAP sparse files, do not train.
5. Create a clear control directory named with date, iteration, caps, and width, for example `<CONTROL_ROOT>\_3DGS_BATCH_CONTROL\<SCENE>_30000_10m8m_4096`.
6. Train sequentially. Try `10M/4096/30000`, then fall back to `8M`, then `6M` only if needed.
7. Reuse a valid `stage\undistorted` for the same input and parameters instead of repeating expensive preprocessing after a cap-only fallback.
8. Verify each job from real artifacts and manifest fields. Do not call a process launch a success.
9. Report briefly in Chinese: job count, actual parameters, PLY path, and blocker if any.

## Success Standard

A job is complete only when all of these are true:

- `training_manifest.json` exists and has `verified=true`.
- Manifest parameters match the final actual `iter`, `max_cap`, and `max_width`.
- A non-empty root `splat_30000.ply` exists.
- `training_summary.md` and `checksums.sha256` exist.
- No LichtFeld/COLMAP training process is still running for that job.

## Supporting Skills

- Use `rc-realityscan-workflow` for RealityScan/RealityCapture project setup, export, undistortion decisions, cache cleanup, or crash recovery.
- Use `comfyui-3dgs-project-operator` for ComfyUI project setup, workflow JSON, custom nodes, generated previews, and ComfyUI-produced PLY/Mesh inspection.
- Use `systematic-debugging` for unknown errors: collect evidence first, then judge.
- Use `verification-before-completion` before claiming a training, parser, or publish task is complete.

## Publish Safety

When publishing or moving this skill, publish only the skill folder. Do not upload raw images, video, PLY/OBJ/FBX/GLB models, scan projects, training outputs, logs, caches, credentials, or private project paths.
