# YCL Production Rules

Use this reference for YCL RealityScan/RC asset planning, dry runs, and batch reporting.

## Source and Output

- Source root: `F:\YCL\M`
- Valid image source: folders belonging to `校色序列` only
- Output root: `F:\YCL\DJ\1`
- Shared Stage 2 logs: `F:\YCL\DJ\1\_RealityScan_Stage2_Logs`
- Nook batch logs: `F:\YCL\DJ\nook\26\_RealityScan_Batch_Logs`
- RealityScan temp override: `D:\CodexTools\RealityScanTemp`

## Hard Rules

- Do not modify `F:\YCL\M` source material.
- Search only `.jpg` and `.jpeg` under approved color-sequence folders unless the user widens scope.
- Skip assets with an existing target `.rsproj`; do not overwrite.
- Keep logs/reports in shared log roots.
- Preserve RealityScan same-name data folders beside `.rsproj`.
- Preserve real project identity and aliases instead of flattening by file type.

## Naming

- First-level prop: `YCL_<parent-pinyin-initials>_V01`
- Second-level part: `YCL_<parent-initials>-<child-initials>_V01`
- Ambiguous initials go to review, not guessing.

## Dry-Run Output

For planning, produce:

- source folder,
- image count,
- target asset name,
- target path,
- existing project/output status,
- skip/failure reason,
- required handoff: CLI, GUI, visual, or manual review.
