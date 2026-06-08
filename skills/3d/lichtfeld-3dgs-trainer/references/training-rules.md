# LichtFeld / 3DGS Training Rules

## Tool Binding

Every run must verify the current machine's executable paths before use:

- `COLMAP_EXE`
- `LICHTFELD_EXE`
- batch/control root

Do not assume paths from another workstation. Prefer non-system drives for tools, control folders, and outputs.

## Dataset Gate

Before training, check:

- COLMAP root exists.
- Required sparse files exist and are non-empty: `cameras.txt`, `images.txt`, `points3D.txt`.
- Image folder exists and contains real image files.
- No obvious zero-byte images.
- Image records and real files roughly agree.
- Sparse point count and bounds are plausible for the scene.

For RC/RealityScan exports, also read `rc-realityscan-handoff.md`.

## Parameters

Explicit user values override defaults.

| Field | Practical default |
| --- | --- |
| Iterations | `30000` |
| Max Gaussian cap | `10M`, then `8M` |
| Max image width | `4096` |
| Strategy | `mrnf` |
| Tile mode | `4` |
| Resize factor | `1` |
| Test every | `100` |

If the user asks for `5k`, treat it as a probe. Many LichtFeld builds reject `--max-width > 4096`.

## Failure Fallbacks

For OOM, driver shutdown, allocation failure, or repeated crash:

1. Reduce max Gaussian cap.
2. Keep `30000` iterations unless the user asks for shorter.
3. Reduce max image width only after cap fallback is not enough.
4. Restart the app/process if GPU context appears poisoned.
5. Do not keep retrying the same failed parameters.

Known high-signal failures:

| Error | Action |
| --- | --- |
| `--max-width cannot be higher than 4096` | Use `4096`; do not keep trying 5K |
| `cudaEventDestroy failed: driver shutting down` | Reduce cap, commonly `10M -> 8M` |
| duplicate output folder | Stop or rename output folders before training |

## Sequential Batch Training

- For requests like `完成一组再训练下一组`, never launch all jobs together.
- Write or preserve a small status record for each output folder.
- After each job, verify artifacts before moving to the next.
- If one job fails, report the failed job and fallback used; continue only if the failure mode is understood and the user requested automatic continuation.

## Verification

Call a job successful only when there is evidence:

- Process finished, not just launched.
- Exit code or trainer log indicates completion.
- Expected PLY exists, commonly `splat_30000.ply` for 30000-iteration runs.
- `training_manifest.json` says `verified=true` when this wrapper is available.
- `training_summary.md` and `checksums.sha256` exist when the wrapper generates them.
- PLY header or file size is plausible for the requested cap.

If a supervisor status file conflicts with trainer logs and artifacts, trust trainer logs plus real output artifacts.

## Output Style

Keep user-facing progress compact:

```text
第 3/10 组: running, 18400/30000, output=<path>
完成: splat_30000.ply exists, verified=true, final_splats=8000000
失败: CUDA driver shutdown at 10M/4096; retrying 8M/4096
```
