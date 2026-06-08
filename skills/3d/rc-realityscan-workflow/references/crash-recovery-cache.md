# Crash Recovery and Cache Cleanup

Use this for `RealityScan Mini Dump`, autosave recovery, corrupt projects, or RealityScan cache cleanup.

## Mini Dump Recovery

When the user is afraid to click because a project may be unsaved:

1. Do not click `确定`.
2. Identify active RealityScan process and command line.
3. Record opened project path.
4. Copy, never move:
   - current `.rsproj`,
   - same-name data directory,
   - `.rsproj.autosave`,
   - `.autosave` data directory,
   - crash `.dmp` and `.metadata` if present.
5. Put backups under a shared recovery log folder.
6. Skip `.lock` if it is held by the crashed process. `.lock` is not core project data.
7. Validate XML references before suggesting a recovery candidate.

## Autosave Rule

The useful recovery pair is:

```text
<project>.rsproj.autosave
<project>.autosave\
```

The autosave XML may use relative paths. A recovery candidate must stay in the original project folder layout so paths resolve. Do not put the only openable candidate in a log folder.

## If Opening Still Crashes

Path integrity is not enough. If RealityScan crashes while loading point cloud/model state:

- keep the original untouched,
- create safe-open copies,
- remove `<model>` nodes,
- set `selectedModel="-1"`,
- set `sfmVisible="0"`,
- remove stale `<appConfig>` when it stores bad view state,
- remove missing autosave `<resource>` nodes only in a copy,
- mark invalid copies `DO_NOT_OPEN`.

Do not overwrite the original project until RealityScan opens the copy and the user manually verifies it.

## Cache Cleanup

Known BXC cache root: `D:\RealityScan.Temp`.

Rules:

- Do read-only size/count stats first.
- If user says "today之前", use local midnight as cutoff, e.g. `2026-06-08 00:00:00`.
- Delete only files older than the cutoff.
- Keep current-day files.
- It is acceptable to skip occupied files.
- Do not stop RealityScan just to clear cache unless the user asks.

Report freed space, skipped files, and cutoff time.
