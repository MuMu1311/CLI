# BXC/YCL Stage 2 Alignment

Use this for RC/RealityScan alignment project generation from color-sequence images.

## Diagnostic Ladder

Run in this order and stop at the first failing layer:

1. Verify `RealityScan.exe`, source image folder, target folder, and no existing output `.rsproj`.
2. Collect recursive `.jpg` / `.jpeg`.
3. Create UTF-8 `.imagelist`, one full path per line, no quotes, no blank lines, or use recursive `-addFolder`.
4. Test one representative group.
5. Only after import/save works, run import + align + select largest component + auto reconstruction region + save.
6. Batch the rest only after the representative group has passed.

## Preferred CLI Pattern

Use official commands only. Common Stage 2 shape:

```text
RealityScan.exe
  -stdConsole
  -writeProgress <progress.log> 5
  -set "appQuitOnError=true"
  -newScene
  -set "appIncSubdirs=true"
  -addFolder <校色序列>
  -align
  -selectMaximalComponent
  -setReconstructionRegionAuto
  -save <target.rsproj>
  -quit
```

If using `-silent`, put it near the start and write reports to a case-specific crash folder. Do not rely on unattended CLI if `C:\ProgramData\Epic\NotAllowedUnattendedBugReports` appears.

## Success Status

Use `saved_cli_alignment_success_needs_manual_qc` only when:

- command finished or the target was verified after a long-running process,
- `.rsproj` exists and is non-zero,
- same-name data folder exists when RealityScan created one,
- stdout/stderr/progress logs are saved,
- manual QC is still clearly required.

Manual QC must check import count, alignment quality, orientation, ground direction, and reconstruction region.

## Known BXC Results To Preserve

- BXC YS first pass: 17 groups, 15 saved, 2 `no_calibration_sequence`.
- BXC YS2 pass: 15 groups, 12 saved, 3 `no_calibration_sequence`.
- Nested calibration: 20/20 saved, then 20/20 classified into `HBB`/`FKB`.
- Large merge `BXC_MC_V01` had 7233 images. 60 and 180 minute windows were too short; 720 minutes completed in about 11155 seconds.

## Timeout Policy

- Empty stdout/stderr does not prove failure.
- GUI/headless wrappers can time out while RealityScan keeps working.
- Check process state, progress log, and target `.rsproj`.
- After timeout, rerun only the failed group. Do not restart the whole batch.
