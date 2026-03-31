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

## Core workflow

1. Read or unpack the document.
2. Edit the XML or generate a new document.
3. Pack or validate the result.

## Key rules

- Set page size explicitly.
- Use proper numbering for lists.
- Use dual widths for tables.
- Put page breaks inside paragraphs.
- Validate the final file.

## Practical notes

- Use `pandoc` for extraction when possible.
- Use the DOCX skill reference for detailed XML and layout rules.
