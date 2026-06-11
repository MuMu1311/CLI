# Skill Packs

## 3D

- `3d/rc-realityscan-workflow` - RealityScan/RealityCapture setup, naming, scan training, crop-box handoff, export, cache, and crash recovery workflow
- `3d/3dgs-lfs-handoff` - 3DGS / LichtFeld handoff readiness checks without running training
- `3d/3dgs-colmap-dataset-qc` - COLMAP / 3DGS dataset suitability checks before training
- `3d/3dgs-visual-fail-diagnosis` - diagnosis workflow for 3DGS visual failures

## Thesis

- `thesis/thesis-structure-audit` - structure-first thesis diagnosis before rewriting
- `thesis/academic-source-hunter` - credible source hunting and source grading
- `thesis/anti-aigc-rewriter` - deeper thesis prose rewriting without fact invention
- `thesis/docx-format-preserver` - Word thesis editing while preserving school formatting
- `thesis/figure-gap-planner` - missing figure, table, and diagram planning
- `thesis/citation-sanity-check` - citation reality and relevance verification
- `thesis/art-expression-enhancer` - artistic intent and visual design discussion enhancer
- `thesis/thesis-production-manager` - multi-pass thesis revision coordinator

## PPT

- `ppt/README.md` - PPT skill routing and source index for `academic-ppt`, `codex-ppt`, and `codex-ppt-skill`

## Knowledge

- `knowledge/awesome-ai-pedia` - curated AI learning paths, tools, and workflows

## Document

- `document/docx` - Word document creation, editing, validation, and conversion

## Browser

- `browser/github-chinese` - GitHub UI localization and userscript setup

## Development

- `development/skill-github-publisher` - safely package, scan, commit, and publish Codex skills to GitHub

## Manifests

- `_manifests/skill_priority_matrix.md` - conflict and priority rules for installed skills
- `_manifests/AGENTS_skill_routing.md` - routing guardrails for Codex/AGENTS usage
- `_manifests/third_party_skill_sources.md` - third-party source list, without wholesale copying
- `_manifests/published_skill_catalog.md` - compact catalog of published local custom skills

## How to use

1. Open the skill that matches the task.
2. Read its workflow and guardrails first.
3. Use source repositories as canonical references for third-party skills.
4. Keep the smallest useful example and adapt it.
5. Do not publish runtime folders, caches, dependencies, datasets, checkpoints, or generated outputs.
