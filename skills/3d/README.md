# 3D Skills

## Existing

- `rc-realityscan-workflow` - RealityScan/RealityCapture workflow.

## 3DGS / LichtFeld

- `3dgs-lfs-handoff` - check 3DGS/LichtFeld handoff readiness without running training.
- `3dgs-colmap-dataset-qc` - check dataset suitability before COLMAP/3DGS reconstruction.
- `3dgs-visual-fail-diagnosis` - diagnose visual artifacts in 3D Gaussian Splatting outputs.

## Guardrails

Do not run training, rendering, reconstruction, destructive cleanup, or original dataset modification unless explicitly requested and allowed by project rules.
