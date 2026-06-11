# AGENTS Skill Routing

## Priority Order

1. Follow the current project `AGENTS.md` first. RealityScan safety rules override any general skill.
2. Follow explicit user skill names next, unless they conflict with safety, file-protection, or project rules.
3. Prefer the narrowest domain skill over a broad workflow skill.
4. Use one primary skill by default, plus at most two helper skills when the task genuinely crosses domains.
5. Do not use deprecated or duplicate skills when a preferred replacement exists.
6. If a skill would require heavy processing, credentials, admin rights, training, rendering, production RealityScan work, or destructive file operations, stop and report the requirement.

## Conflict Rules

For thesis work, use `thesis-production-manager` only as the coordinator. Route the actual pass to the specific thesis skill.

For PPT work:

- Use `academic-ppt` for thesis defense, academic report, or research presentation decks.
- Use `codex-ppt-skill` for Chinese business decks, image-first PPT workflows, screenshot/page reconstruction, and editable PPTX element rebuilding.
- Use `codex-ppt` only when explicitly requested or when its local instructions fit better.

For UI and frontend work:

- Use `frontend-design` as the primary skill for building or editing real web UI.
- Use `ui-ux-pro-max` when visual/product design intelligence is the main deliverable.
- Use `landing-page-design` only for true landing pages.
- Use `mobile-responsiveness` after a responsive UI exists.

For 3DGS and RealityScan:

- Use `3dgs-colmap-dataset-qc`, `3dgs-lfs-handoff`, or `3dgs-visual-fail-diagnosis` for non-destructive 3DGS work.
- Use `realityscan-gui-automation`, `screen-visual-control`, and `realityscan-batch-ycl` for RealityScan work.
- Do not run RealityScan CLI, production processing, training, rendering, or destructive dataset operations unless explicitly allowed.

## Default Operating Rule

When multiple skills could apply, state the chosen primary skill briefly, name any helper skill, and keep the route stable for that task. If the selected skill proves wrong after reading files, switch once and explain why.
