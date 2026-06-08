#!/usr/bin/env python3
"""Parse Chinese LichtFeld/3DGS batch training prompts into compact jobs."""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path
from typing import Any


WINDOWS_PATH_RE = re.compile(r"[A-Za-z]:\\[^\r\n，,]+")
NUMBERED_JOB_RE = re.compile(
    r"(?P<index>\d+)\s*[\.、]\s*(?P<label>.*?)(?:images\s*和\s*COLMAP\s*位置|COLMAP\s*位置|输入(?:文件)?位置)[：:]\s*"
    r"(?P<input>[A-Za-z]:\\.*?)[，,]\s*(?:输出文件放这|输出文件位置|输出位置|输出)[：:]\s*"
    r"(?P<output>[A-Za-z]:\\[^\r\n，,]+)",
    re.IGNORECASE,
)


def _clean_path(value: str) -> str:
    return value.strip().strip("。；; ")


def _cap_to_int(value: str) -> int:
    value = value.strip().lower()
    if value.endswith("m"):
        return int(float(value[:-1]) * 1_000_000)
    return int(value)


def _parse_caps(value: str) -> list[int]:
    caps: list[int] = []
    for part in re.split(r"[,;>\s\-~到至]+", value):
        part = part.strip()
        if part:
            caps.append(_cap_to_int(part))
    return caps


def _extract_params(text: str) -> dict[str, Any]:
    params: dict[str, Any] = {}
    iteration = re.search(r"迭代\s*([0-9]{4,6})", text)
    if iteration:
        params["iterations"] = int(iteration.group(1))
    gauss_range = re.search(r"高斯(?:数)?\s*([0-9]+)\s*[mM]\s*[-~到至]\s*([0-9]+)\s*[mM]", text)
    if gauss_range:
        params["max_gaussians_try"] = [int(gauss_range.group(1)) * 1_000_000, int(gauss_range.group(2)) * 1_000_000]
    else:
        gauss_single = re.search(r"高斯(?:数)?\s*([0-9]+)\s*[mM]", text)
        if gauss_single:
            params["max_gaussians_try"] = [int(gauss_single.group(1)) * 1_000_000]
    if re.search(r"5\s*k", text, re.IGNORECASE):
        params["max_width_try"] = [5000, 4096]
    elif re.search(r"4\s*k|4096", text, re.IGNORECASE):
        params["max_width_try"] = [4096]
    if "高参数" in text:
        params["quality"] = "high"
    if "完成一组再训练下一组" in text or "完成一组再" in text:
        params["sequential"] = True
    if re.search(r"RealityScan|RealityCapture|COLMAP\s*standard|Registration", text, re.IGNORECASE):
        params["rc_export_handoff"] = True
    return params


def _line_region(lines: list[str], line_no: int) -> str | None:
    for i in range(line_no - 1, -1, -1):
        value = lines[i].strip()
        if not value or value.lower() == "ok" or WINDOWS_PATH_RE.search(value) or NUMBERED_JOB_RE.search(value):
            continue
        return value
    return None


def _task_name(input_path: str, index: int) -> str:
    leaf = Path(input_path).name or f"task{index}"
    safe = re.sub(r"[^A-Za-z0-9._-]+", "_", leaf).strip("_") or f"task{index}"
    return f"{index:02d}_{safe}"


def parse_text(text: str, default_iter: int, default_caps: list[int], default_width: int) -> dict[str, Any]:
    lines = text.splitlines()
    global_params = _extract_params(text)
    jobs: list[dict[str, Any]] = []
    consumed_lines: set[int] = set()

    for match in NUMBERED_JOB_RE.finditer(text):
        start_line = text[: match.start()].count("\n")
        consumed_lines.add(start_line)
        jobs.append({
            "index": len(jobs) + 1,
            "source_index": int(match.group("index")),
            "source": "numbered",
            "label": (match.group("label").strip(" ，,") or None),
            "input_path": _clean_path(match.group("input")),
            "output_path": _clean_path(match.group("output")),
            "params": dict(global_params),
        })

    colmap_paths: list[tuple[int, str]] = []
    output_paths: list[tuple[int, str]] = []
    for line_no, line in enumerate(lines):
        if line_no in consumed_lines:
            continue
        stripped = line.strip()
        if not stripped or stripped.lower() == "ok":
            continue
        paths = WINDOWS_PATH_RE.findall(stripped)
        if len(paths) != 1 or not stripped.startswith(paths[0]):
            continue
        path = _clean_path(paths[0])
        lower = path.lower()
        if "\\colmap" in lower or "\\cplmap" in lower:
            colmap_paths.append((line_no, path))
        elif "\\ply" in lower:
            output_paths.append((line_no, path))

    pair_count = min(len(colmap_paths), len(output_paths))
    existing_pairs = {(job["input_path"].casefold(), job["output_path"].casefold()) for job in jobs}
    for offset in range(pair_count):
        colmap_line, input_path = colmap_paths[offset]
        _, output_path = output_paths[offset]
        pair_key = (input_path.casefold(), output_path.casefold())
        if pair_key in existing_pairs:
            continue
        existing_pairs.add(pair_key)
        jobs.append({
            "index": len(jobs) + 1,
            "source": "path-pair",
            "label": _line_region(lines, colmap_line),
            "input_path": input_path,
            "output_path": output_path,
            "params": dict(global_params),
        })

    warnings: list[str] = []
    output_counts: dict[str, int] = {}
    for job in jobs:
        key = job["output_path"].casefold()
        output_counts[key] = output_counts.get(key, 0) + 1
    for path_key, count in output_counts.items():
        if count > 1:
            warnings.append(f"duplicate output folder used by {count} jobs: {path_key}")
    if len(colmap_paths) != len(output_paths):
        warnings.append(f"unpaired path-pair entries: colmap={len(colmap_paths)}, output={len(output_paths)}")

    queue = []
    for job in jobs:
        params = job.get("params", {})
        queue.append({
            "name": _task_name(job["input_path"], job["index"]),
            "input_colmap_root": job["input_path"],
            "output_dir": job["output_path"],
            "iter": params.get("iterations", default_iter),
            "max_caps": params.get("max_gaussians_try", default_caps),
            "max_width": (params.get("max_width_try") or [default_width])[-1],
            "source": job["source"],
            "label": job.get("label"),
        })

    return {
        "schema": "lichtfeld_training_batch_v2",
        "job_count": len(jobs),
        "global_params": global_params,
        "jobs": jobs,
        "queue": queue,
        "warnings": warnings,
    }


def _summary(result: dict[str, Any]) -> str:
    lines = [f"jobs={result['job_count']}"]
    if result["global_params"]:
        lines.append(f"params={json.dumps(result['global_params'], ensure_ascii=False)}")
    for job in result["queue"]:
        label = f" [{job['label']}]" if job.get("label") else ""
        lines.append(f"{job['name']}. {job['input_colmap_root']} -> {job['output_dir']}{label}")
    for warning in result["warnings"]:
        lines.append(f"warning: {warning}")
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", "-i", help="Prompt/template text file. Reads stdin when omitted.")
    parser.add_argument("--output", "-o", help="Optional output file.")
    parser.add_argument("--format", choices=["json", "summary", "queue"], default="json")
    parser.add_argument("--default-iter", type=int, default=30000)
    parser.add_argument("--default-max-caps", default="10M-8M")
    parser.add_argument("--default-max-width", type=int, default=4096)
    parser.add_argument("--strict", action="store_true", help="Exit non-zero when warnings are produced.")
    args = parser.parse_args()

    text = Path(args.input).read_text(encoding="utf-8") if args.input else sys.stdin.read()
    result = parse_text(text, args.default_iter, _parse_caps(args.default_max_caps), args.default_max_width)
    rendered = _summary(result) if args.format == "summary" else json.dumps(result["queue"] if args.format == "queue" else result, ensure_ascii=False, indent=2)
    if args.output:
        Path(args.output).write_text(rendered + "\n", encoding="utf-8")
    else:
        print(rendered)
    return 2 if args.strict and result["warnings"] else 0


if __name__ == "__main__":
    raise SystemExit(main())
