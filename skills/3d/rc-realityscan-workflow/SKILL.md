---
name: rc-realityscan-workflow
description: Use when planning, creating, running, resuming, auditing, training, exporting, or recovering RealityScan/RealityCapture (RC) production projects on Windows, including initial folder creation, asset naming, scan dataset intake, CLI alignment, crop-box handoff, preview/normal/high reconstruction, high-detail/model export, HBB/FKB organization, cache cleanup, crash recovery, and evidence-based reporting for BXC/YCL-style batches.
---

# RC RealityScan Workflow

Use this as the top-level RC/RealityScan production skill. Treat `RC` as RealityCapture/RealityScan unless the user clearly means another tool.

Prefer live filesystem/process checks over memory. Never claim success without real logs and output files.

## Route First

- **New RC project, folder layout, naming, dry run**: read `references/project-setup-naming.md`.
- **BXC/YCL Stage 2 alignment project generation**: read `references/bxc-ycl-stage2.md`.
- **High Detail / Clean / texture / export model or point cloud**: read `references/rc-cli-chain.md`.
- **Scan model training, crop-box handoff, preview/normal/high reconstruction**: read `references/scan-model-training.md`; reuse `templates/rc_project_structure.md`, `templates/agent_crop_task.md`, `templates/rc_pipeline_bat_template.bat`, and `templates/rc_pipeline_powershell_template.ps1`.
- **Batch monitor, resume, failure report**: read `references/batch-monitoring.md`.
- **Mini Dump, autosave, corrupt project, cache cleanup**: read `references/crash-recovery-cache.md`.
- **YCL-specific production paths**: read `references/ycl-production.md`.

## Hard Rules

- Do not modify source image folders. Source roots are read-only.
- Do not overwrite existing `.rsproj`, same-name RealityScan data folders, `HBB`, `FKB`, `mod`, or exported models.
- Do not run Align, High Detail, export, or long batch jobs unless the user has approved that action in the current task.
- Do not run High Quality reconstruction automatically. It needs successful alignment, existing preview, confirmed crop boxes, and explicit user approval.
- Do not mix sculpture scans, exhibition hall scans, 360/panoramic sources, screenshots, thumbnails, or social-compressed images unless the user explicitly asks for that combined input.
- Do not treat empty stdout/stderr, wrapper timeout, or valid file paths as success or failure by themselves.
- Keep logs outside asset folders in a shared log root.
- Preserve `.rsproj` together with its same-name data directory. Moving only the `.rsproj` breaks projects.
- Stop for UAC, login, license, EULA, serial-number, or admin prompts.
- When a project crashes, preserve first, then diagnose. Do not click/close/overwrite before copying recoverable state.

## Correct RC Lifecycle

1. Create project roots and log roots.
2. Discover valid source assets from approved `校色序列` folders only.
3. Assign deterministic asset names; ambiguous initials go to a review list.
4. Dry-run inventory: image count, target path, existing output, skip reason.
5. Run one representative diagnostic group first.
6. Generate `.imagelist` or use recursive `-addFolder` with UTF-8-safe paths.
7. Run import/align/auto-region/save.
8. Verify `.rsproj` exists, is non-zero, and has logs/progress evidence.
9. Queue every alignment project for manual QC before reconstruction/export.
10. For model production, run High Detail -> Clean -> Quality/Color/Texture -> export.
11. Verify `.obj` plus sidecar outputs and write a result report.
12. For nested calibration, classify merge outputs to `HBB` and split outputs to `FKB`, moving both project and data folder.
13. Clean old RealityScan cache only by explicit date boundary.

## Known Local Anchors

Verify before use:

- BXC RealityScan exe: `F:\RealityScan_2.1\RealityScan.exe`
- BXC source roots: `G:\BXC\YS`, `G:\BXC\YS2`
- BXC output root: `G:\BXC\DJ`
- BXC Stage 2 logs: `G:\BXC\DJ_RealityScan_Stage2_Logs`, `G:\BXC\DJ_RealityScan_Stage2_Logs_YS2`
- BXC nested QC logs: `G:\BXC\DJ\_BXC_QC_Logs\nested_calibration_rs`
- BXC crash recovery logs: `G:\BXC\DJ\_BXC_QC_Logs\realityscan_crash_recovery`
- BXC cache root: `D:\RealityScan.Temp`
- YCL RealityScan exe: `D:\X1\RealityScan_2.1\RealityScan.exe`
- YCL source root: `F:\YCL\M`
- YCL output root: `F:\YCL\DJ\1`
- YCL temp override: `D:\CodexTools\RealityScanTemp`

## Evidence Required

Every report should include only the useful proof:

- executable path,
- command used,
- exit code or timeout,
- stdout/stderr/progress log paths and sizes,
- project/export output paths and sizes,
- status CSV/summary/report path,
- skipped/blocked reason.

Use concise Chinese. Say failures plainly.
