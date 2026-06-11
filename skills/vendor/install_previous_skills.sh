#!/usr/bin/env bash
set -euo pipefail

export CODEX_HOME="${CODEX_HOME:-$HOME/.agents}"
SKILL_DIR="$CODEX_HOME/skills"
mkdir -p "$SKILL_DIR"

add_skill() {
  local repo="$1"
  local path="$2"
  local name="$3"
  local ref="${4:-main}"
  local dest="$SKILL_DIR/$name"
  if [ -f "$dest/SKILL.md" ]; then
    echo "already_exists $name"
    return
  fi
  local installer="$SKILL_DIR/.system/skill-installer/scripts/install-skill-from-github.py"
  if [ ! -f "$installer" ]; then
    echo "skill-installer not found at $installer" >&2
    exit 1
  fi
  python3 "$installer" --repo "$repo" --path "$path" --name "$name" --ref "$ref" --method download
}

add_skill openai/skills skills/.curated/openai-docs openai-docs
add_skill vercel-labs/skills skills/find-skills find-skills
add_skill OthmanAdi/planning-with-files skills/planning-with-files planning-with-files master
add_skill forrestchang/andrej-karpathy-skills skills/karpathy-guidelines karpathy-guidelines
add_skill axtonliu/axton-obsidian-visual-skills excalidraw-diagram excalidraw-diagram
add_skill axtonliu/axton-obsidian-visual-skills mermaid-visualizer mermaid-visualizer
add_skill axtonliu/axton-obsidian-visual-skills obsidian-canvas-creator obsidian-canvas-creator
add_skill nextlevelbuilder/ui-ux-pro-max-skill .claude/skills/ui-ux-pro-max ui-ux-pro-max
add_skill pbakaus/impeccable .agents/skills/impeccable impeccable
add_skill SHALINS428/Academic-PPT-Skill skill/academic-ppt academic-ppt
add_skill Ronnie2025/codex-ppt-skill . codex-ppt-skill

for name in brainstorming dispatching-parallel-agents executing-plans finishing-a-development-branch receiving-code-review requesting-code-review subagent-driven-development systematic-debugging test-driven-development using-git-worktrees using-superpowers verification-before-completion writing-plans writing-skills; do
  add_skill obra/superpowers "skills/$name" "$name"
done

echo 'Done. Restart Codex to pick up restored skills.'
