# ComfyUI 3DGS Handoff

This reference handles the boundary between ComfyUI 3D generation and LichtFeld training.

## Route to ComfyUI First

Use `comfyui-3dgs-project-operator` if available, or a ComfyUI project workflow, when the task involves:

- Installing, starting, or restarting ComfyUI.
- Managing `custom_nodes`, ComfyUI-3D-Pack, ComfyUI_3DGaussianSplatting, SAM3D, MVDream, LGM, TripoSR, or Hunyuan3D nodes.
- Running or repairing ComfyUI workflow JSON.
- Generating single-image or few-image 3DGS, mesh, OBJ, GLB, texture, or preview images.
- Checking ComfyUI history, node errors, missing models, missing dependencies, CUDA build issues, or compiler requirements.

These are ComfyUI project operations, not LichtFeld multi-view COLMAP training.

## Route to LichtFeld

Use this skill only when valid training data exists:

```text
<ROOT>\images
<ROOT>\sparse\0\cameras.txt
<ROOT>\sparse\0\images.txt
<ROOT>\sparse\0\points3D.txt
```

If the user has only a ComfyUI-generated `.ply`, `.obj`, `.glb`, texture, or preview image, do not claim it can continue into LichtFeld training. It can be inspected, archived, viewed, or handed to Blender/viewer workflows.

## Output Meaning

| Output | Meaning | Action |
| --- | --- | --- |
| `gaussian.ply`, `*_3DGS.ply` | ComfyUI-generated Gaussian or preview artifact | Inspect PLY header and size; not a COLMAP training input |
| `.obj/.mtl/.png` | Mesh and texture asset | Archive or hand off to Blender/viewer workflows |
| workflow JSON | ComfyUI node graph | Hand off to the ComfyUI project operator |
| multi-view images + camera poses/COLMAP | Trainable data | Enter LichtFeld preflight |

## Quality Checks

Do not judge only by whether a PLY exists:

1. Read the PLY header and record `element vertex`.
2. Record file size.
3. Identify whether the source is ComfyUI node output or LichtFeld training output.
4. If the user says "too blurry" or "PLY too small", check view coverage, COLMAP registrations, cap, and width instead of treating ComfyUI preview output as a trained model.
