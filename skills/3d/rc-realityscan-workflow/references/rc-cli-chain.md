# RC CLI and GUI Chain

Use this when translating the user's RealityScan/RC reconstruction and export flow into CLI, GUI automation, or a hybrid.

## User-Facing Model Workflow

Keep this order when the user asks for the correct training/reconstruction operation:

1. Open/load project.
2. Select maximal component.
3. High Detail.
4. Clean Model.
5. Check Integrity.
6. Check Topology.
7. Quality Analysis.
8. Calculate.
9. Close Holes.
10. Execute Close Holes.
11. Colorize / vertex colors.
12. Texture.
13. Export Model and Point Cloud.
14. Choose output directory.
15. Set output basename.
16. Keep default export settings unless the user says otherwise.
17. Save/export.
18. Verify outputs.
19. Write result report.
20. Continue to next group.

## Verified Backend Chain

The local batch script used this backend chain:

```text
-headless
-silent <crash_report_dir>
-writeProgress <progress_file> 30
-load <project> deleteAutosave
-selectMaximalComponent
-calculateHighModel
-cleanModel
-calculateQualityColors
-closeHoles 1024
-calculateVertexColors
-calculateTexture
-exportSelectedModel <output_obj>
-save <project>
-quit
```

Mapping:

- High Detail -> `-calculateHighModel`
- Clean Model -> `-cleanModel`
- Quality Analysis / Calculate -> `-calculateQualityColors`
- Close Holes -> `-closeHoles 1024`
- Colorize -> `-calculateVertexColors`
- Texture -> `-calculateTexture`
- Export Model -> `-exportSelectedModel`
- Save -> `-save`

## CLI Gap Policy

- Do not invent undocumented commands.
- Check Integrity and Check Topology do not have independent verified CLI markers in the local script notes. Say so.
- If a GUI-only ribbon control is required, use GUI automation.
- If UI Automation cannot see stable controls, use screen visual control.

## Export Validation

Expected model export artifacts usually include:

- `.obj`
- `.mtl`
- `.png`
- `.obj.rsInfo`

Treat `.obj` as the minimum gate only when the batch script says so. Missing sidecars are warnings that must be reported, not hidden.

## Stability

- Run one production group at a time.
- Use low/idle priority or reduced CPU affinity when stability matters.
- Redirect `TEMP`/`TMP` to the configured RC temp folder when the script does so.
- Do not run multiple RealityScan production groups in parallel unless the user explicitly changes the rule.
