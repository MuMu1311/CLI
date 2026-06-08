# RC/RealityScan to LichtFeld Handoff

This reference handles the boundary between RealityScan/RealityCapture and LichtFeld. RC owns project setup, alignment, undistortion/export decisions, and crash recovery. LichtFeld owns training once valid COLMAP/images data exists.

## Route to RC First

Use `rc-realityscan-workflow` before this skill when the task involves:

- Creating or recovering an RC/RealityScan project.
- Turning raw photos, color-sequence folders, panoramic camera sources, or video into an RC project.
- Alignment, High Detail, Clean, Texture, or model/point-cloud export.
- Export Registration / COLMAP standard files.
- Lens distortion settings, RC export settings, Mini Dump, autosave, or cache cleanup.

## Train Directly

Train directly when the user gives an input directory containing:

```text
images
sparse\0\cameras.txt
sparse\0\images.txt
sparse\0\points3D.txt
```

Equivalent layouts are acceptable when the text model files are directly under `sparse` or the input root.

## Export Settings to Record

When RC export settings are visible, record:

| Setting | Record |
| --- | --- |
| Directory structure | `COLMAP standard` |
| File type | `ASCII (.txt)` |
| Export images | `Yes/No` |
| Image format | `jpg`, `png`, or source format |
| Pixel format | e.g. `48-bit RGB` |
| Naming convention | original file name preferred |
| Undistort images | `Yes/No` |

If the settings are unknown, training may proceed only from the existing COLMAP files, and the report should say that export settings were not confirmed.

## Undistortion Boundary

The LichtFeld training flow usually runs COLMAP `image_undistorter` into `stage\undistorted`.

- If RC exported raw images plus a COLMAP sparse model, run the standard undistorter.
- If RC already exported undistorted images, inspect the structure and camera model before undistorting again.
- If a matching `stage\undistorted` already exists, reuse it.
- If unsure whether the images are already undistorted, stop and report the uncertainty instead of guessing.

## Preflight

Before training, confirm:

1. The input is not a raw source folder such as a color-sequence folder.
2. The input is not a `.rsproj` data folder.
3. `images.txt`, `cameras.txt`, and `points3D.txt` are readable.
4. Registered image names can be found in the image directory.
5. The output path is not an RC project/model folder unless the user explicitly chose it.
