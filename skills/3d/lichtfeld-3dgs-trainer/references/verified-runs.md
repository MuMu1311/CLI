# Verified Run Notes

These notes summarize local experience without publishing private project paths or source data.

## Key Rules Learned

| Rule | Evidence |
| --- | --- |
| 5K is not safe as a default | A local LichtFeld build rejected `--max-width 5000` with `--max-width cannot be higher than 4096` |
| 10M can fail late | A high-cap run hit `cudaEventDestroy failed: driver shutting down` |
| 8M is a practical high setting | The same dataset completed successfully after reducing cap from 10M to 8M |
| Success needs artifacts | A valid run had a non-empty `splat_30000.ply`, manifest, summary, and checksum |

## How to Use This

Use these rules to explain fallback decisions briefly. Do not expand historical details unless the user asks.
