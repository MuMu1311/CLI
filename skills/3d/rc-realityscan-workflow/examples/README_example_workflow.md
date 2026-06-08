# Example RC Scan Workflow

Example goal: process one sculpture scan without risking raw files.

1. Create the project structure from `templates/rc_project_structure.md`.
2. Put untouched camera files in `input/sculpture_001/raw/`.
3. Copy approved reconstruction inputs into `input/sculpture_001/selected/`.
4. Run Mode A inventory and write `reports/inventory.md`.
5. If inventory is clean, run Mode B alignment/preview.
6. Write `agent_handoff/AGENT_CROP_TASK.md` from `templates/agent_crop_task.md`.
7. Stop until the Agent/user exports `box_train.rsbox`, `box_cut.rsbox`, and `agent_done_crop.json`.
8. After crop confirmation, run Mode D normal reconstruction into a new project.
9. Run export prep only after logs and output files confirm the model exists.
10. Run Mode E high quality only after explicit user approval.

Minimum final report:

```text
Stage: normal reconstruction
Status: PASS|WARN|FAIL|BLOCKED
Project: <normal_cropped.rsproj>
Logs: <logs_folder>
Missing: <none_or_files>
Need user/Agent: <yes_or_no>
Next: <shortest_safe_step>
```
