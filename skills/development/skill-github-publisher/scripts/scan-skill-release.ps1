param(
  [Parameter(Mandatory = $true)]
  [string]$Path,
  [int64]$MaxBytes = 5MB
)

$ErrorActionPreference = "Stop"

$root = (Resolve-Path -LiteralPath $Path).Path
$blockedExtensions = @(
  ".jpg", ".jpeg", ".png", ".tif", ".tiff", ".dng", ".raw", ".exr",
  ".mp4", ".mov", ".avi", ".mkv",
  ".ply", ".obj", ".fbx", ".glb", ".gltf", ".usd", ".usdz",
  ".rsproj", ".rcproj", ".e57", ".las", ".laz",
  ".ckpt", ".pt", ".pth", ".onnx", ".safetensors",
  ".zip", ".7z", ".rar", ".tar", ".gz",
  ".key", ".pem", ".p12", ".crt"
)

$selfPath = if ($PSCommandPath) { (Resolve-Path -LiteralPath $PSCommandPath).Path } else { $null }
$files = Get-ChildItem -LiteralPath $root -Recurse -File -Force |
  Where-Object { $_.FullName -notmatch [regex]::Escape([IO.Path]::DirectorySeparatorChar + ".git" + [IO.Path]::DirectorySeparatorChar) } |
  Where-Object { -not $selfPath -or $_.FullName -ne $selfPath }

$largeFiles = $files |
  Where-Object { $_.Length -gt $MaxBytes } |
  Select-Object FullName, Length

$blockedFiles = $files |
  Where-Object { $blockedExtensions -contains $_.Extension.ToLowerInvariant() -or $_.Name -match '^\.env(\..*)?$' } |
  Select-Object FullName, Length

$credentialPattern = '(?i)(-----BEGIN [A-Z ]*PRIVATE KEY-----|Authorization:\s*Bearer\s+\S+|(api[_-]?key|secret|token|password|passwd)\s*[:=]\s*[''"]?[^''"\s]{12,})'
$textExtensions = @(".md", ".txt", ".ps1", ".psm1", ".py", ".js", ".ts", ".json", ".yaml", ".yml", ".toml", ".ini", ".cfg", ".gitignore", "")

$credentialHits = foreach ($file in $files) {
  if ($textExtensions -contains $file.Extension.ToLowerInvariant() -or $file.Name -eq ".gitignore") {
    Select-String -LiteralPath $file.FullName -Pattern $credentialPattern -ErrorAction SilentlyContinue |
      ForEach-Object {
        [pscustomobject]@{
          Path = $_.Path
          LineNumber = $_.LineNumber
          Match = $_.Matches[0].Value
        }
      }
  }
}

$result = [pscustomobject]@{
  root = $root
  file_count = @($files).Count
  large_file_count = @($largeFiles).Count
  blocked_file_count = @($blockedFiles).Count
  credential_hit_count = @($credentialHits).Count
  large_files = @($largeFiles)
  blocked_files = @($blockedFiles)
  credential_hits = @($credentialHits)
}

$result | ConvertTo-Json -Depth 6

if (@($largeFiles).Count -gt 0 -or @($blockedFiles).Count -gt 0 -or @($credentialHits).Count -gt 0) {
  exit 2
}

exit 0
