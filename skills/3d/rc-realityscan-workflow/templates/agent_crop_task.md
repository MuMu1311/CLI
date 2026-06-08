# AGENT_CROP_TASK

You are responsible only for visual crop-box adjustment.

Open:

```text
<aligned_project_path>
```

Tasks:

1. Inspect sparse cloud / preview model.
2. Adjust Reconstruction Region so it includes the full target.
3. Export training crop box:

```text
<box_train_path>
```

This box should be slightly larger than the object/space.

4. Export final crop box:

```text
<box_cut_path>
```

This box should remove unwanted background but not cut important geometry.

5. Create:

```text
<agent_done_crop_json_path>
```

`agent_done_crop.json` format:

```json
{
  "status": "done",
  "box_train": "<box_train_path>",
  "box_cut": "<box_cut_path>",
  "notes": "brief visual notes",
  "risk": "low|medium|high"
}
```

Do not run high-quality reconstruction.
Do not delete images.
Do not export final model.
Do not overwrite project files.
