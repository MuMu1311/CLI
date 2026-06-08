# Project Setup and Naming

Use this when creating a new RC/RealityScan production project or preparing a dry run.

## Folder Layout

Create explicit roots before processing:

```text
<ROOT>\
  YS\                         source assets, read-only
  YS2\                        optional second source batch, read-only
  DJ\                         RealityScan project outputs
  DJ_RealityScan_Stage2_Logs\  shared Stage 2 logs
  DJ\_BXC_QC_Logs\            nested calibration, recovery, QC logs
```

For YCL-style projects, use the existing YCL roots in `ycl-production.md`.

Never put batch logs inside asset folders. Asset folders should hold only project/output state.

## Source Discovery

- Only first-level folders under a source root are assets.
- Do not treat internal folders as assets.
- Valid image source is a folder named `校色序列` unless the user explicitly widens scope.
- Count only `.jpg` and `.jpeg`.
- Missing `校色序列` is a real status: `no_calibration_sequence`.
- No JPG/JPEG is a real status: `no_jpg_found`.

## Naming

Use a stable prefix and pinyin initials:

- First-level asset: `<PREFIX>_<asset-initials>_V01`
- Nested part: `<PREFIX>_<parent-initials>-<child-initials>_V01`
- BXC example: `BXC_MC_V01`, `BXC_MC_NB1_V01`
- YCL example: `YCL_<initials>_V01`

If initials collide or are unclear, write the item to a review list. Do not guess.

## Output Shape

For a normal asset:

```text
DJ\<ASSET_ID>\
  <ASSET_ID>.rsproj
  <ASSET_ID>\              same-name RealityScan data folder
  mod\                     exported model/output, when produced
```

For nested calibration:

```text
DJ\<PARENT_ASSET_ID>\
  HBB\                     merged/all-sequences version
    <PARENT_ASSET_ID>.rsproj
    <PARENT_ASSET_ID>\
  FKB\                     split/part versions
    <PART_ID>.rsproj
    <PART_ID>\
  mod\
```

`HBB` means merge/all nested calibration sequences. `FKB` means split variants. Move both `.rsproj` and same-name data folder together.

## Dry-Run Table

Before running, produce a CSV or markdown table with:

- source asset folder,
- valid image folder,
- recursive image count,
- target asset id,
- target `.rsproj`,
- existing output status,
- action: run, skip, blocked, review,
- reason.
