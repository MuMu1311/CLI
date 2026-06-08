# Security Scan

Run these checks before committing and again before claiming the publish succeeded.

## Exclude By Default

Do not publish:

```text
*.jpg, *.jpeg, *.png, *.tif, *.tiff, *.dng, *.raw, *.exr
*.mp4, *.mov, *.avi, *.mkv
*.ply, *.obj, *.fbx, *.glb, *.gltf, *.usd, *.usdz
*.rsproj, *.rcproj, *.e57, *.las, *.laz
*.ckpt, *.pt, *.pth, *.onnx, *.safetensors
.env, .env.*, *.key, *.pem, *.p12, *.crt
*.zip, *.7z, *.rar, *.tar, *.gz
logs/, log/, cache/, tmp/, temp/, __pycache__/, node_modules/, .pytest_cache/
.DS_Store, Thumbs.db
```

If a skill really needs an asset, allow only tiny public placeholder files with a clear license note.

## .gitignore Baseline

Use `templates/gitignore_template.txt` for new single-skill repos. Extend it for project-specific generated folders.

## Manual PowerShell Checks

Large files:

```powershell
Get-ChildItem -Recurse -File | Where-Object { $_.Length -gt 5MB } | Select-Object FullName, Length
```

Credential patterns:

```powershell
Get-ChildItem -Recurse -File -Force |
  Where-Object { $_.FullName -notmatch '\\.git\\' } |
  Select-String -Pattern 'api[_-]?key|secret|token|password|passwd|PRIVATE KEY|BEGIN RSA|BEGIN OPENSSH|Authorization:\s*Bearer' -ErrorAction SilentlyContinue
```

Blocked extensions:

```powershell
Get-ChildItem -Recurse -File -Force |
  Where-Object { $_.Extension.ToLowerInvariant() -in @('.jpg','.jpeg','.png','.tif','.tiff','.dng','.raw','.exr','.mp4','.mov','.avi','.mkv','.ply','.obj','.fbx','.glb','.gltf','.usd','.usdz','.rsproj','.rcproj','.e57','.las','.laz','.ckpt','.pt','.pth','.onnx','.safetensors','.zip','.7z','.rar','.tar','.gz','.key','.pem','.p12','.crt') }
```

## Scripted Check

On Windows, prefer:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .agents/skills/skill-github-publisher/scripts/scan-skill-release.ps1 -Path <repo-or-staging-path>
```

The script fails on large files, blocked file types, private-key patterns, bearer tokens, and credential-like assignments. Review its JSON output before publishing.

## Stop Conditions

Stop before commit if:

- a real secret appears,
- raw media, scan data, models, checkpoints, or private project files are present,
- the repository has unrelated staged changes,
- the remote URL does not match the intended GitHub repo,
- the license is unclear.
