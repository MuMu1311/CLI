# Auto-Feeder Template

The file name `自动下料机.txt` is only a sample name. Do not treat it as a fixed path. Actual job content should come from the current user message, pasted text, or whatever `.txt` path the user names for that run.

## Recommended Prompt

```text
下面你自动进行这 N 组的训练，完成一组再训练下一组：
全局参数：迭代30000，高斯数10M-8M，图像精度4096。

1. 用高参数训练3DGS，images和COLMAP位置：X:\Example\SceneA\COLMAP\Component1，输出文件放这：X:\Example\SceneA\PLY\Component1
2. 用高参数训练3DGS，images和COLMAP位置：X:\Example\SceneA\COLMAP\Component2，输出文件放这：X:\Example\SceneA\PLY\Component2
```

If the user writes:

```text
高参数试试迭代30000，高斯数10M-8M，图像精度试试5k，不行就改回4096
```

Interpret it as `30000 / 10M->8M / 4096`, with a cheap 5K probe only.

## Supported Forms

Numbered form:

```text
1.用高参数训练3DGS，images和COLMAP位置：X:\Example\A\COLMAP\Component0，输出文件放这：X:\Example\A\PLY\Component0
```

Path-pair form:

```text
区域名称
X:\Example\A\COLMAP\Component1
X:\Example\A\COLMAP\Component8

X:\Example\A\PLY\Component1
X:\Example\A\PLY\Component8
```

## Parser

Prefer the Python parser:

```powershell
python ".agents\skills\lichtfeld-3dgs-trainer\scripts\parse_training_batch.py" `
  --input "<template-file.txt>" `
  --output "<control-root>\queue.json" `
  --format queue `
  --strict
```

Use `--format summary` for a short human-readable check.

## Cleanup Rules

- Remove filler like repeated `ok`, blank lines, and repeated "用高参数训练3DGS".
- Keep semantic details: component id, input path, output path, parameter hints, and sequential requirement.
- Warn or block when several jobs share one output folder because later jobs can overwrite or mix artifacts.
