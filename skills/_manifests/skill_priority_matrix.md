# Skill Priority Matrix

This file keeps installed skills from stepping on each other. It does not disable any skill; it tells Codex which one should win when descriptions overlap.

## Global Rules

- Project `AGENTS.md` and safety constraints win over every skill.
- Explicit user choice wins unless unsafe.
- Narrow domain skill wins over broad workflow skill.
- One primary skill is the default. Add helper skills only when useful.
- Never claim success without verification.
- Do not delete, overwrite, train, render, or run production processing unless the user explicitly asks and the project rules allow it.

## Priority Table

| Situation | Primary Skill | Helper Skills | Notes |
| --- | --- | --- | --- |
| Thesis revision planning | thesis-production-manager | thesis-structure-audit, figure-gap-planner | Coordinator first, then specific pass. |
| Thesis outline/chapters | thesis-structure-audit | none | No prose polishing during structure pass. |
| Thesis sources | academic-source-hunter | citation-sanity-check | Browse/verify exact sources when accuracy matters. |
| Thesis prose sounds AI-like | anti-aigc-rewriter | citation-sanity-check | Rewrite only after facts and citations are stable. |
| Existing Word thesis editing | docx-format-preserver | anti-aigc-rewriter | Preserve school formatting and styles. |
| Thesis art/design discussion | art-expression-enhancer | figure-gap-planner | Tie technology to artistic intent and evidence visuals. |
| Academic or defense PPT | academic-ppt | docx-format-preserver | Use for thesis defense and research decks. |
| Business/image-first PPT | codex-ppt-skill | codex-ppt | Prefer image/page reconstruction workflow here. |
| Ordinary frontend implementation | frontend-design | test-driven-development | Build real UI, then verify responsive behavior. |
| UI strategy/deep visual direction | ui-ux-pro-max | frontend-design | Use when design thinking is the main work. |
| Landing page | landing-page-design | frontend-design | Only for true landing pages. |
| Mobile layout fixes | mobile-responsiveness | frontend-design | Use after a UI exists. |
| Mermaid diagram | mermaid-visualizer | none | Use for Mermaid output. |
| Sketch-style diagram | excalidraw-diagram | none | Use for Excalidraw-style output. |
| Obsidian canvas | obsidian-canvas-creator | none | Only for `.canvas` output. |
| Code bug investigation | systematic-debugging | test-driven-development | Debug first, test/fix second. |
| Feature or bugfix implementation | test-driven-development | requesting-code-review | Write/verify tests where feasible. |
| Large multi-step coding work | subagent-driven-development | executing-plans | Use only when parallel tasks are real. |
| Code review request | receiving-code-review | none | Findings first, summaries later. |
| Ask for review before finishing | requesting-code-review | verification-before-completion | Useful before merge/completion. |
| 3DGS dataset QC | 3dgs-colmap-dataset-qc | none | No original dataset modification. |
| 3DGS/LichtFeld handoff | 3dgs-lfs-handoff | none | No training or rendering. |
| 3DGS visual failure | 3dgs-visual-fail-diagnosis | none | Diagnose from evidence, do not fabricate certainty. |
| RealityScan UI operation | realityscan-gui-automation | screen-visual-control | No CLI and no production processing unless re-enabled. |
| RealityScan batch validation | realityscan-batch-ycl | realityscan-gui-automation | Keep original resources untouched. |
| Xiaohongshu image cards | baoyu-image-cards | baoyu-infographic | `baoyu-xhs-images` is deprecated. |
| Skill installation | skill-installer | none | Do not duplicate existing skills. |
| Skill creation/editing | skill-creator | writing-skills | Keep skills concise and scoped. |

## Duplicates And Soft Deprecations

- `baoyu-xhs-images`: use `baoyu-image-cards` first.
- `codex-ppt`, `codex-ppt-skill`, `academic-ppt`: choose by deck type, not by name similarity.
- `skill-installer` and `skill-creator`: system/built-in behavior wins; do not reinstall as ordinary user skills.
- Story and prose skills are intentionally granular. Use the most specific stage skill.
