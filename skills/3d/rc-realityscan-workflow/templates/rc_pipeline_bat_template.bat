@echo off
setlocal enabledelayedexpansion

set "MODE=inventory"
set "RC_EXE=<RealityScan_or_RealityCapture_exe>"
set "IMG_DIR=<input_selected_folder>"
set "OUT=<project_out_folder>"
set "LOG=<logs_folder>"
set "PROJ=%OUT%\01_alignment\aligned.rsproj"
set "BOX_AUTO=%OUT%\03_agent_crop\box_auto.rsbox"
set "BOX_TRAIN=%OUT%\03_agent_crop\box_train.rsbox"
set "BOX_CUT=%OUT%\03_agent_crop\box_cut.rsbox"
set "DONE_JSON=%OUT%\03_agent_crop\agent_done_crop.json"
set "PROJ_NORMAL=%OUT%\04_normal_model\normal_cropped.rsproj"
if /i "%MODE%"=="inventory" (
  echo Inventory mode creates reports only. Do not run RC in this mode.
  exit /b 0
)

if not exist "%RC_EXE%" (
  echo Missing RC_EXE: "%RC_EXE%" 1>&2
  exit /b 2
)

if /i "%MODE%"=="align_preview" (
  if not exist "%IMG_DIR%" (
    echo Missing IMG_DIR: "%IMG_DIR%" 1>&2
    exit /b 3
  )

  "%RC_EXE%" ^
    -addFolder "%IMG_DIR%" ^
    -align ^
    -selectMaximalComponent ^
    -setReconstructionRegionAuto ^
    -scaleReconstructionRegion 1.1 1.1 1.2 center factor ^
    -calculatePreviewModel ^
    -exportReconstructionRegion "%BOX_AUTO%" ^
    -save "%PROJ%" ^
    -quit > "%LOG%\align_preview_stdout.log" 2> "%LOG%\align_preview_stderr.log"

  exit /b !errorlevel!
)

if /i "%MODE%"=="normal_after_crop" (
  if not exist "%PROJ%" exit /b 4
  if not exist "%BOX_TRAIN%" exit /b 5
  if not exist "%BOX_CUT%" exit /b 6
  if not exist "%DONE_JSON%" exit /b 7

  "%RC_EXE%" ^
    -load "%PROJ%" ^
    -selectMaximalComponent ^
    -setReconstructionRegion "%BOX_TRAIN%" ^
    -calculateNormalModel ^
    -setReconstructionRegion "%BOX_CUT%" ^
    -cutByBox outer false ^
    -cleanModel ^
    -save "%PROJ_NORMAL%" ^
    -quit > "%LOG%\normal_after_crop_stdout.log" 2> "%LOG%\normal_after_crop_stderr.log"

  exit /b !errorlevel!
)

if /i "%MODE%"=="high_after_approval" (
  echo High quality requires explicit user approval before this template is run.
  exit /b 8
)

echo Unsupported MODE: "%MODE%" 1>&2
exit /b 9
