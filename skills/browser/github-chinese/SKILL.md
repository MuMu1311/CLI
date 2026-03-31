---
name: github-chinese
description: Use when working on GitHub Chinese localization, GitHub UI translation, userscript installation, or browser-side translation behavior.
---

# GitHub Chinese Localization

Source: `https://github.com/maboloshi/github-chinese`

Use this skill when you need to:

- translate or localize GitHub UI
- install or troubleshoot the GitHub Chinese userscript
- work with GreasyFork / Tampermonkey / Violentmonkey setup
- test local file-based userscript loading

## What I learned

- This repo is a mature userscript with two main distribution paths: GitHub and GreasyFork.
- The project cares about browser compatibility, extension permissions, and ignore-rule quality.
- Local testing depends on `file:///` require paths and extension security settings.
- The repo is as much about translation logic as it is about installation reliability.

## Best use

1. Pick the right script source (GitHub / GreasyFork).
2. Verify browser extension permissions.
3. Test on the target GitHub page.
4. Adjust ignore rules or local path settings if needed.

## Installation mental model

- GitHub source = development track.
- GreasyFork source = stable track.
- Local file mode = fast debugging / offline testing.

## Troubleshooting checklist

- Is the userscript manager installed and allowed to run scripts?
- Is local file access enabled if using `file:///`?
- Is the right build source selected for the browser?
- Are ignore rules too broad or too narrow?
- Does the page require a refresh after installation?

## Useful references

- GitHub source: development build
- GreasyFork source: stable build
- Local debugging with `file:///` require paths

## Notes

- Prefer the repo's script and ignore-rule model over ad hoc translation.
- Keep browser compatibility in mind: Chrome, Firefox, Safari, and Android browsers differ.
- When reporting issues, include browser, script source, and the page URL.
