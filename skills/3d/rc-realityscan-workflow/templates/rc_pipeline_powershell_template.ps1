param(
  [ValidateSet("inventory", "align_preview", "normal_after_crop", "high_after_approval")]
  [string]$Mode = "inventory",
  [string]$RcExe = "<RealityScan_or_RealityCapture_exe>",
  [string]$ImgDir = "<input_selected_folder>",
  [string]$Out = "<project_out_folder>",
  [string]$Log = "<logs_folder>"
)

$ErrorActionPreference = "Stop"

$Proj = Join-Path $Out "01_alignment\aligned.rsproj"
$BoxAuto = Join-Path $Out "03_agent_crop\box_auto.rsbox"
$BoxTrain = Join-Path $Out "03_agent_crop\box_train.rsbox"
$BoxCut = Join-Path $Out "03_agent_crop\box_cut.rsbox"
$DoneJson = Join-Path $Out "03_agent_crop\agent_done_crop.json"
$ProjNormal = Join-Path $Out "04_normal_model\normal_cropped.rsproj"
if ($Mode -ne "inventory") {
  if (-not (Test-Path -LiteralPath $RcExe -PathType Leaf)) {
    throw "Missing RC executable: $RcExe"
  }

  New-Item -ItemType Directory -Force -Path $Log | Out-Null
}

function Invoke-Rc {
  param(
    [string[]]$Arguments,
    [string]$StdoutPath,
    [string]$StderrPath
  )

  & $RcExe @Arguments > $StdoutPath 2> $StderrPath
  if ($LASTEXITCODE -ne 0) {
    throw "RC command failed with exit code $LASTEXITCODE"
  }
}

switch ($Mode) {
  "inventory" {
    Write-Output "Inventory mode creates reports only; implement project-specific inventory before RC execution."
  }
  "align_preview" {
    if (-not (Test-Path -LiteralPath $ImgDir -PathType Container)) {
      throw "Missing image folder: $ImgDir"
    }

    Invoke-Rc -Arguments @(
      "-addFolder", $ImgDir,
      "-align",
      "-selectMaximalComponent",
      "-setReconstructionRegionAuto",
      "-scaleReconstructionRegion", "1.1", "1.1", "1.2", "center", "factor",
      "-calculatePreviewModel",
      "-exportReconstructionRegion", $BoxAuto,
      "-save", $Proj,
      "-quit"
    ) -StdoutPath (Join-Path $Log "align_preview_stdout.log") -StderrPath (Join-Path $Log "align_preview_stderr.log")
  }
  "normal_after_crop" {
    foreach ($Required in @($Proj, $BoxTrain, $BoxCut, $DoneJson)) {
      if (-not (Test-Path -LiteralPath $Required)) {
        throw "Missing required crop continuation file: $Required"
      }
    }

    Invoke-Rc -Arguments @(
      "-load", $Proj,
      "-selectMaximalComponent",
      "-setReconstructionRegion", $BoxTrain,
      "-calculateNormalModel",
      "-setReconstructionRegion", $BoxCut,
      "-cutByBox", "outer", "false",
      "-cleanModel",
      "-save", $ProjNormal,
      "-quit"
    ) -StdoutPath (Join-Path $Log "normal_after_crop_stdout.log") -StderrPath (Join-Path $Log "normal_after_crop_stderr.log")
  }
  "high_after_approval" {
    throw "High quality requires explicit user approval before running this template."
  }
}
