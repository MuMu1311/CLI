$ErrorActionPreference = 'Stop'

$Root = 'D:\CodexTools'
$env:CODEX_HOME = "$Root\codex-home"
$SkillDir = "$env:CODEX_HOME\skills"
New-Item -ItemType Directory -Force -Path $SkillDir | Out-Null
npm config set prefix "$Root\npm-global"
npm config set cache "$Root\npm-cache" --global

function Add-SkillFromGitHub {
  param(
    [string]$Repo,
    [string]$Path,
    [string]$Name,
    [string]$Ref = 'main'
  )
  $Dest = Join-Path $SkillDir $Name
  if (Test-Path (Join-Path $Dest 'SKILL.md')) {
    Write-Host "already_exists $Name"
    return
  }
  $Installer = Join-Path $SkillDir '.system\skill-installer\scripts\install-skill-from-github.py'
  if (-not (Test-Path $Installer)) {
    throw "skill-installer not found at $Installer. Install/enable Codex built-in skills first."
  }
  python $Installer --repo $Repo --path $Path --name $Name --ref $Ref --method download
}

Add-SkillFromGitHub -Repo 'openai/skills' -Path 'skills/.curated/openai-docs' -Name 'openai-docs'
Add-SkillFromGitHub -Repo 'vercel-labs/skills' -Path 'skills/find-skills' -Name 'find-skills'
Add-SkillFromGitHub -Repo 'OthmanAdi/planning-with-files' -Path 'skills/planning-with-files' -Name 'planning-with-files' -Ref 'master'
Add-SkillFromGitHub -Repo 'forrestchang/andrej-karpathy-skills' -Path 'skills/karpathy-guidelines' -Name 'karpathy-guidelines'
Add-SkillFromGitHub -Repo 'axtonliu/axton-obsidian-visual-skills' -Path 'excalidraw-diagram' -Name 'excalidraw-diagram'
Add-SkillFromGitHub -Repo 'axtonliu/axton-obsidian-visual-skills' -Path 'mermaid-visualizer' -Name 'mermaid-visualizer'
Add-SkillFromGitHub -Repo 'axtonliu/axton-obsidian-visual-skills' -Path 'obsidian-canvas-creator' -Name 'obsidian-canvas-creator'
Add-SkillFromGitHub -Repo 'nextlevelbuilder/ui-ux-pro-max-skill' -Path '.claude/skills/ui-ux-pro-max' -Name 'ui-ux-pro-max'
Add-SkillFromGitHub -Repo 'pbakaus/impeccable' -Path '.agents/skills/impeccable' -Name 'impeccable'
Add-SkillFromGitHub -Repo 'SHALINS428/Academic-PPT-Skill' -Path 'skill/academic-ppt' -Name 'academic-ppt'
Add-SkillFromGitHub -Repo 'Ronnie2025/codex-ppt-skill' -Path '.' -Name 'codex-ppt-skill'

$super = @('brainstorming','dispatching-parallel-agents','executing-plans','finishing-a-development-branch','receiving-code-review','requesting-code-review','subagent-driven-development','systematic-debugging','test-driven-development','using-git-worktrees','using-superpowers','verification-before-completion','writing-plans','writing-skills')
foreach ($name in $super) {
  Add-SkillFromGitHub -Repo 'obra/superpowers' -Path "skills/$name" -Name $name
}

Write-Host 'Done. Restart Codex to pick up restored skills.'
