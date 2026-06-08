# RC Project Structure Template

```text
<RC_Project>/
  input/
    sculpture_001/
      raw/
      selected/
      rejected/
    hall_001/
      raw/
      selected/
      rejected/
  out/
    00_inventory/
    01_alignment/
    02_preview/
    03_agent_crop/
    04_normal_model/
    05_high_model/
    06_crop_clean/
    07_export/
  scripts/
  logs/
  agent_handoff/
  reports/
```

Rules:

- keep raw data untouched,
- use one folder per sculpture or hall,
- put rejected/non-input material under `rejected/`,
- write generated scripts under `scripts/`,
- write all command logs under `logs/`,
- write handoff files under `agent_handoff/`,
- write concise stage reports under `reports/`.
