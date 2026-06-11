---
name: docx-format-preserver
description: Use when editing thesis content inside an existing .docx while keeping the original cover, declarations, TOC hierarchy, headers, footers, numbering, styles, and school formatting intact.
---

# DOCX Format Preserver

## When To Use

Use when the user needs content edits in an existing Word thesis without damaging school formatting.

## Workflow

1. Work on a copy unless the user explicitly asks to modify the original.
2. Inspect document structure, styles, numbering, headers, footers, cover pages, declarations, and table of contents.
3. Edit only target content regions.
4. Preserve paragraph styles and numbering instead of recreating them.
5. Verify output by reopening or inspecting the resulting `.docx` structure.

## Output

- edited `.docx`
- change summary
- formatting preservation notes
- any sections that require manual Word refresh, such as TOC update

## Guardrails

Do not rebuild the whole document unless necessary. Do not break cover pages, declarations, TOC hierarchy, page numbering, headers, footers, or school-required styles.
