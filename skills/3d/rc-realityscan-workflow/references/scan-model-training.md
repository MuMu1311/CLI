# Scan Model Training

Use this reference for RealityCapture/RealityScan scan reconstruction jobs: dataset intake, alignment, reconstruction region setup, Agent/user crop-box handoff, preview/normal/high model calculation, cleanup, export prep, and reporting.

## Core Principle

Codex controls repeatable work:

- create folders,
- inventory files,
- count images/videos,
- generate commands,
- run RC/RealityScan CLI,
- capture logs,
- validate outputs,
- preserve raw data.

Agent or user controls visual judgment:

- login/license/EULA/plugin popups,
- crop-box adjustment,
- visual quality approval,
- checking whether geometry is cut off,
- approving high-quality reconstruction.

## Safety Rules

- Never delete raw images, videos, camera files, source projects, or raw scan data.
- Never overwrite an existing RC/RealityScan project unless the user explicitly says so.
- Never run high-quality reconstruction unless alignment succeeded, preview exists, crop boxes are confirmed, and the user explicitly approves.
- If DJI Osmo, 360, fisheye, panoramic, or equirectangular sources are detected, pause and ask whether to export perspective frames, process as spherical/panoramic images, or keep them separate.
- Never mix sculpture scans and exhibition hall scans in the same project unless explicitly requested.
- Never include unrelated photos, screenshots, thumbnails, WeChat images, edited previews, or social media compressed images.
- Never run VPN, cloud upload, account login, or license activation unless explicitly requested.
- Never claim model success unless output files exist and logs confirm completion.

## Preferred Project Structure

Create this structure for each scan project. For multiple sculpture works, keep one folder per sculpture. For exhibition halls, keep one folder per hall or room.

```text
RC_Project/
  input/
    sculpture_001/
      raw/
      selected/
      rejected/
    hall_001/
      raw/
      selected/
      rejected/
  out/
    00_inventory/
    01_alignment/
    02_preview/
    03_agent_crop/
    04_normal_model/
    05_high_model/
    06_crop_clean/
    07_export/
  scripts/
  logs/
  agent_handoff/
  reports/
```

## Input Checks

Before running RC/RealityScan:

1. Count images and videos.
2. Check extension types.
3. Check file sizes.
4. Flag tiny or compressed images.
5. Detect duplicate names.
6. Detect mixed sources.
7. Detect 360/fisheye/equirectangular images where possible.
8. Write an inventory report.

Supported inputs may include `jpg`, `jpeg`, `png`, `tif`, `tiff`, supported RAW formats, and extracted video frames.

For video, do not blindly extract every frame. Write a frame extraction plan first:

- sculpture: slower interval, higher detail coverage,
- hall/interior: stable walking path, avoid motion blur,
- skip blurred frames,
- skip near-duplicates.

## Executable Detection

On Windows, check these paths first:

```text
C:\Program Files\Epic Games\RealityScan\RealityScan.exe
C:\Program Files\Epic Games\RealityCapture\RealityCapture.exe
C:\Program Files\Capturing Reality\RealityCapture\RealityCapture.exe
```

If none exists, ask the user for the executable path. Do not invent paths.

## Pipeline Modes

### Mode A: Inventory Only

Use when the user only wants dataset inspection.

Actions:

- create folder structure,
- scan files,
- generate inventory report,
- do not run RC.

### Mode B: Alignment And Auto Region

Use for the first reconstruction check.

Actions:

- add image folder,
- align,
- select maximal component,
- set reconstruction region automatically,
- scale reconstruction region slightly larger,
- calculate preview model,
- export `box_auto.rsbox`,
- save project,
- write logs.

Expected outputs:

- aligned project,
- preview state inside project,
- `box_auto.rsbox`,
- alignment report,
- preview report.

### Mode C: Agent-Assisted Crop Box

Use when crop needs visual confirmation.

Codex must write `AGENT_CROP_TASK.md` and stop. Do not continue until all exist:

- `box_train.rsbox`,
- `box_cut.rsbox`,
- `agent_done_crop.json`.

Agent/user should open the aligned project, inspect sparse cloud or preview model, adjust the Reconstruction Region, export both boxes, and write the JSON completion file.

### Mode D: Normal Reconstruction

Use only after crop confirmation.

Actions:

- load aligned project,
- set reconstruction region from `box_train.rsbox`,
- calculate normal model,
- set reconstruction region from `box_cut.rsbox`,
- `cutByBox outer false`,
- `cleanModel` if supported,
- save as a new normal project,
- write logs.

If `cutByBox` or `cleanModel` fails, preserve the project and write the error log. Do not delete anything.

### Mode E: High Quality

Use only after explicit user approval.

Actions:

- check GPU/CPU/disk availability,
- check preview/normal model result,
- confirm crop boxes,
- run high model,
- save as a separate project,
- never overwrite normal project.

## Command Templates

Prefer copying the bundled templates into the project `scripts/` folder and resolving placeholders safely:

- `templates/rc_pipeline_bat_template.bat`
- `templates/rc_pipeline_powershell_template.ps1`

Before any run, verify:

- RC executable exists,
- input folder exists,
- output folders are new or approved,
- logs folder exists,
- mode-specific required files exist.

## Agent Crop Handoff

Use `templates/agent_crop_task.md` for `AGENT_CROP_TASK.md`.

Required `agent_done_crop.json` shape:

```json
{
  "status": "done",
  "box_train": "<box_train_path>",
  "box_cut": "<box_cut_path>",
  "notes": "brief visual notes",
  "risk": "low|medium|high"
}
```

Codex must validate that the two box files exist and the JSON status is `done` before running Mode D.

## Dataset Guidance

### Sculpture

Prefer one project per sculpture.

Require:

- full 360-degree coverage,
- low/mid/high camera heights,
- close-up detail passes,
- stable exposure,
- minimal motion blur,
- enough overlap,
- no people moving around the sculpture.

Watch for glossy material, transparent parts, black surfaces, repeated textures, thin structures, underside missing, and pedestal/floor merging.

### Exhibition Hall

Prefer one project per hall or room.

Require:

- slow stable capture,
- wall/floor/ceiling overlap,
- avoiding fast walking blur,
- avoiding too many moving visitors,
- separating hall scan from sculpture scan.

Watch for reflective glass, blank white walls, repetitive corridors, people ghosts, lighting changes, and panorama stitching artifacts.

### DJI Osmo / 360

If source appears to be 360/equirectangular:

- do not treat it as normal pinhole photos without confirmation,
- ask whether perspective frame extraction is available,
- keep original 360 source untouched,
- create a separate folder for perspective exports,
- avoid mixing 360 panoramas and normal photos unless deliberately configured.

## Quality Report

After each stage, write a concise report with:

- project name,
- source folder,
- image count,
- rejected count,
- executable path,
- command used,
- start/end time,
- output project path,
- reconstruction region files,
- preview/normal/high status,
- warnings,
- failed commands,
- next shortest safe step.

Allowed status values:

- `PASS`
- `WARN`
- `FAIL`
- `BLOCKED`
- `NEEDS_AGENT`
- `NEEDS_USER_APPROVAL`

## Failure Diagnosis

Alignment failures usually mean too few images, low overlap, blurred frames, reflective/transparent surfaces, mixed camera types, equirectangular images handled incorrectly, featureless surfaces, moving people, or wrong folder.

Broken preview models usually mean oversized reconstruction region, insufficient viewpoints, poor alignment, bad exposure, low texture detail, reflective subject, or missing underside.

If crop cuts important geometry, stop and require Agent/user to adjust the box. Do not proceed to normal/high reconstruction.

If high model takes too long, stop only if safe, preserve logs, and recommend a normal model or smaller region.

## Response Rules

When reporting to the user, include only:

1. stage completed,
2. `PASS` / `WARN` / `FAIL` / `BLOCKED`,
3. important output paths,
4. missing files,
5. whether Agent/user action is needed,
6. next shortest safe step.

Do not paste raw logs unless asked.
