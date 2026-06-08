# Batch Monitoring and Recovery

Use this when checking, resuming, or reporting a RC/RealityScan batch.

## Files To Read

For YCL nook:

- Script: `E:\x3\codex\realityscan_batch.py`
- Log root: `F:\YCL\DJ\nook\26\_RealityScan_Batch_Logs`
- Status log: `batch_status.log`
- Current group: `batch_current_group.json`
- Summary: `batch_summary.md`
- Results JSON: `batch_results.json`

For BXC Stage 2:

- Main logs: `G:\BXC\DJ_RealityScan_Stage2_Logs`
- YS2 logs: `G:\BXC\DJ_RealityScan_Stage2_Logs_YS2`
- Nested logs: `G:\BXC\DJ\_BXC_QC_Logs\nested_calibration_rs`

## Process Checks

Always check:

- `RealityScan` process,
- `python` process when a batch script is involved,
- command line of each process,
- script path existence,
- log root existence,
- source/output drive availability.

## Recovery Policy

- If summary says final/complete, do not restart.
- If running, report current group, stage/progress, and process state only.
- If status says running but RealityScan and scheduler are gone, confirm no `RealityScan` process exists before restarting.
- Restart only when log root and project/output drive are available.
- If drive/log root is unavailable, report blocked state.
- Let the script record interrupted groups as failed and continue to the next group.

## Failure Classes

Record concrete failures:

- `no_calibration_sequence`
- `no_jpg_found`
- `timeout_failed`
- `cli_process_failed`
- `save_failed`
- `cli_align_failed`
- corrupted or missing depth map
- RealityScan crash/restart during High Detail
- out of disk space
- missing drive/log root
- missing exported `.obj`
- missing `.mtl`, `.png`, `.obj.rsInfo` warnings

## Report Shape

Keep Chinese reports short:

- current state,
- group/stage,
- last log time,
- process state,
- output found/missing,
- next safe action.
