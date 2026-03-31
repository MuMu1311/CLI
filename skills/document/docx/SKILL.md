---
name: docx
description: Use when creating, reading, editing, validating, or converting Word documents (.docx), including structured reports, templates, letters, and documents with tables, images, headings, or tracked changes.
---

# DOCX creation, editing, and analysis

Source: `https://github.com/anthropics/skills/blob/main/skills/docx/SKILL.md`

## When to use

- create new `.docx` files
- edit existing Word documents
- extract text from documents
- convert legacy `.doc` to `.docx`
- handle comments, tracked changes, tables, images, headers, footers, and TOC

## What I learned

- DOCX work is XML-first: generate or unpack, then edit safely, then validate.
- Layout correctness depends on explicit page size, table widths, and style choices.
- Many problems come from Word compatibility rather than the content itself.
- The skill expects disciplined formatting, not ad hoc HTML-style markup.

## Core workflow

1. Read or unpack the document.
2. Edit the XML or generate a new document.
3. Pack or validate the result.

## Decision guide

- Need a report, memo, letter, or template? Use this skill.
- Need tracked changes or comments? Use XML-aware editing.
- Need a polished layout? Define page size, styles, and table widths up front.
- Need a conversion or extraction? Prefer pandoc / unpack / pack flow.

## Key rules

- Set page size explicitly.
- Use proper numbering for lists.
- Use dual widths for tables.
- Put page breaks inside paragraphs.
- Validate the final file.

## Practical notes

- Use `pandoc` for extraction when possible.
- Use the DOCX skill reference for detailed XML and layout rules.
- Keep tables, images, and headings consistent across editors.
- Validate after every structural change, not just at the end.

## Common failure modes

- Missing explicit page size.
- Broken table widths or cell widths.
- Manual bullet characters instead of numbering config.
- Page breaks outside paragraphs.
- Invalid XML nesting around tracked changes.
