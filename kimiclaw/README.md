# Kimiclaw Agent — v1.0.0

Autonomous AI agent configured on **2026-05-02T20:40:46.361869+00:00**.

## Configuration

| Setting           | Value                          |
|-------------------|--------------------------------|
| Gmail             | kimiclaw8@gmail.com              |
| Initial Capital   | $0.00 |
| Risk Tolerance    | medium     |
| Timezone          | America/Toronto           |

## Quick Start

```bash
# Run the main loop
python scripts/autoloop.py

# Generate a report
python scripts/generate_report.py --daily

# Check status
python scripts/autoloop.py --status
```

## Directory Layout

```
kimiclaw/
├── data/       # Earnings CSV, datasets
├── logs/       # Activity, error, and strategy logs
├── reports/    # Generated Markdown/JSON reports
├── state/      # state.json snapshots
├── scripts/    # Automation scripts
└── backups/    # Automatic state backups
```
