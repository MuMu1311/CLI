# Source Fusion

Use outside sources to improve the publish workflow, but do not blindly copy unrelated material.

## Local Skills To Reuse

- `skill-creator`: skill structure, frontmatter, progressive disclosure, `agents/openai.yaml`, and validation.
- `github:yeet`: intentional staging, commit, push, GitHub authentication boundaries, and no broad staging in mixed worktrees.
- `verification-before-completion`: run fresh verification before claiming success.
- `find-skills`: search `skills.sh` or local skill registries when the user asks for related skills.
- `cli-hub-meta-skill`: check CLI-Hub only when the skill needs an agent-native CLI or harness idea.

## Network Sources To Prefer

Use primary or ecosystem sources:

- OpenAI skills catalog: https://github.com/openai/skills
- skills.sh docs: https://www.skills.sh/docs
- Agent Skills open standard when needed: https://agentskills.io/
- Official GitHub docs for `gh` and repository operations.
- The source repository of any skill being reused.

## Fusion Rules

- Keep only behavior that helps publishing skills safely.
- Preserve license compatibility. If the source has Apache-2.0, GPL, proprietary, or unclear terms, do not convert it to MIT without review.
- Do not copy long source text. Summarize operational rules.
- Keep `SKILL.md` concise and put long procedures in `references/`.
- Use templates for generated repository files instead of embedding long boilerplate in `SKILL.md`.
- If a network skill looks useful but is from an unknown author or has low trust, treat it as inspiration only and verify its commands manually.

## What Not To Fuse

- unrelated CLI harnesses,
- unrelated marketplace registry entries,
- unrelated agent prompts,
- author branding from another repo,
- license text from another repo unless license compatibility is verified,
- commands that upload local user files to third-party services.
