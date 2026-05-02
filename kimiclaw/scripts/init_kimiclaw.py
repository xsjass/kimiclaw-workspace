#!/usr/bin/env python3
"""
init_kimiclaw.py

Initialization script for the Kimiclaw autonomous AI agent.
Sets up directory structure, initial state, configuration, and tracking files.

Usage:
    python init_kimiclaw.py                          # Interactive mode
    python init_kimiclaw.py --gmail user@gmail.com    # Non-interactive
    python init_kimiclaw.py --reset                   # Reset with confirmation
    python init_kimiclaw.py --force-reset             # Reset without confirmation
"""

import argparse
import json
import logging
import os
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List, Optional

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

VERSION = "1.0.0"
AGENT_NAME = "kimiclaw"

DEFAULT_BASE_DIR = Path("/mnt/agents/output/kimiclaw")
DEFAULT_RISK_TOLERANCE = "medium"
DEFAULT_TIMEZONE = "UTC"
DEFAULT_INITIAL_CAPITAL = 0

DIRECTORIES: List[str] = [
    "data",
    "logs",
    "reports",
    "state",
    "scripts",
    "backups",
]

EARNINGS_CSV_COLUMNS = [
    "date", "source", "amount", "strategy", "platform", "notes"
]

WELCOME_BANNER = r"""
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║   ██╗  ██╗██╗███╗   ███╗██╗ ██████╗██╗      █████╗ ██╗    ██╗   ║
║   ██║ ██╔╝██║████╗ ████║██║██╔════╝██║     ██╔══██╗██║    ██║   ║
║   █████╔╝ ██║██╔████╔██║██║██║     ██║     ███████║██║ █╗ ██║   ║
║   ██╔═██╗ ██║██║╚██╔╝██║██║██║     ██║     ██╔══██║██║███╗██║   ║
║   ██║  ██╗██║██║ ╚═╝ ██║██║╚██████╗███████╗██║  ██║╚███╔███╔╝   ║
║   ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝ ╚══╝╚══╝    ║
║                                                                  ║
║         Autonomous AI Agent — 24/7 Online Income System           ║
║                       Version {version}                              ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
"""

# ---------------------------------------------------------------------------
# Logging setup
# ---------------------------------------------------------------------------

logger = logging.getLogger("kimiclaw.init")


def setup_logging(log_dir: Path, log_to_console: bool = True) -> None:
    """Configure logging handlers for file and optional console output."""
    log_dir.mkdir(parents=True, exist_ok=True)
    log_file = log_dir / f"init_{datetime.now(timezone.utc).strftime('%Y%m%d_%H%M%S')}.log"

    handlers: List[logging.Handler] = [
        logging.FileHandler(log_file, mode="a")
    ]
    if log_to_console:
        handlers.append(logging.StreamHandler(sys.stdout))

    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s [%(levelname)s] %(name)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S %Z",
        handlers=handlers,
        force=True,
    )
    logger.info("Logging initialized. Log file: %s", log_file)


# ---------------------------------------------------------------------------
# State management
# ---------------------------------------------------------------------------

def create_initial_state(
    gmail: str,
    initial_capital: float,
    risk_tolerance: str,
    timezone_str: str,
) -> Dict:
    """Build the initial state dictionary for a fresh Kimiclaw agent."""
    now = datetime.now(timezone.utc).isoformat()
    return {
        "agent_name": AGENT_NAME,
        "version": VERSION,
        "created_at": now,
        "last_updated": now,
        "config": {
            "gmail": gmail,
            "initial_capital": initial_capital,
            "risk_tolerance": risk_tolerance,
            "timezone": timezone_str,
        },
        "state": {
            "status": "active",
            "current_phase": "startup",
            "active_strategies": [],
            "completed_tasks": [],
            "total_earnings": 0.0,
            "total_expenses": 0.0,
            "net_profit": 0.0,
            "skills_learned": [],
            "accounts_created": [],
            "revenue_streams": [],
        },
        "performance": {
            "daily_earnings": [],
            "weekly_summary": [],
            "strategy_roi": {},
        },
        "meta": {
            "total_iterations": 0,
            "total_runtime_hours": 0.0,
            "last_tick": None,
            "last_phase_3_run": None,
            "last_phase_4_run": None,
            "last_phase_5_run": None,
            "last_phase_6_run": None,
        },
    }


def write_state_json(state: Dict, state_dir: Path) -> Path:
    """Persist state dictionary to state.json."""
    state_dir.mkdir(parents=True, exist_ok=True)
    state_path = state_dir / "state.json"
    state_path.write_text(json.dumps(state, indent=2), encoding="utf-8")
    logger.info("State written to %s", state_path)
    return state_path


# ---------------------------------------------------------------------------
# Directory & file creation
# ---------------------------------------------------------------------------

def create_directories(base_dir: Path) -> None:
    """Create all required Kimiclaw directories under base_dir."""
    for name in DIRECTORIES:
        dir_path = base_dir / name
        dir_path.mkdir(parents=True, exist_ok=True)
        logger.info("Directory ready: %s", dir_path)


def create_earnings_csv(base_dir: Path) -> Path:
    """Create the earnings tracking CSV with header row."""
    data_dir = base_dir / "data"
    data_dir.mkdir(parents=True, exist_ok=True)
    csv_path = data_dir / "earnings.csv"
    header = ",".join(EARNINGS_CSV_COLUMNS) + "\n"
    csv_path.write_text(header, encoding="utf-8")
    logger.info("Earnings CSV created: %s", csv_path)
    return csv_path


def create_log_files(base_dir: Path) -> None:
    """Create placeholder log files."""
    logs_dir = base_dir / "logs"
    logs_dir.mkdir(parents=True, exist_ok=True)

    log_files = ["activity.log", "errors.log", "strategies.log"]
    for filename in log_files:
        log_path = logs_dir / filename
        if not log_path.exists():
            log_path.write_text(
                f"# {filename} - created {datetime.now(timezone.utc).isoformat()}\n",
                encoding="utf-8",
            )
            logger.info("Log file created: %s", log_path)


def create_readme(base_dir: Path, config: Dict) -> Path:
    """Create a brief README documenting the installation."""
    readme_path = base_dir / "README.md"
    content = f"""# Kimiclaw Agent — v{VERSION}

Autonomous AI agent configured on **{datetime.now(timezone.utc).isoformat()}**.

## Configuration

| Setting           | Value                          |
|-------------------|--------------------------------|
| Gmail             | {config['gmail']}              |
| Initial Capital   | ${config['initial_capital']:.2f} |
| Risk Tolerance    | {config['risk_tolerance']}     |
| Timezone          | {config['timezone']}           |

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
"""
    readme_path.write_text(content, encoding="utf-8")
    logger.info("README created: %s", readme_path)
    return readme_path


# ---------------------------------------------------------------------------
# User input helpers
# ---------------------------------------------------------------------------

def prompt_gmail(default: Optional[str] = None) -> str:
    """Prompt for a valid Gmail address."""
    while True:
        prompt = "Enter Gmail address"
        if default:
            prompt += f" [{default}]"
        prompt += ": "
        value = input(prompt).strip()
        if not value and default:
            value = default
        if "@" in value and "." in value:
            return value
        print("  ⚠ Invalid email. Please try again.")


def prompt_initial_capital(default: float = DEFAULT_INITIAL_CAPITAL) -> float:
    """Prompt for initial capital amount."""
    while True:
        raw = input(f"Enter initial capital in USD [{default}]: ").strip()
        if not raw:
            return default
        try:
            value = float(raw)
            if value < 0:
                print("  ⚠ Capital cannot be negative.")
                continue
            return value
        except ValueError:
            print("  ⚠ Please enter a valid number.")


def prompt_risk_tolerance(default: str = DEFAULT_RISK_TOLERANCE) -> str:
    """Prompt for risk tolerance level."""
    valid = {"low", "medium", "high"}
    while True:
        raw = input(f"Enter risk tolerance (low/medium/high) [{default}]: ").strip().lower()
        if not raw:
            return default
        if raw in valid:
            return raw
        print(f"  ⚠ Must be one of: {', '.join(sorted(valid))}")


def prompt_timezone(default: str = DEFAULT_TIMEZONE) -> str:
    """Prompt for timezone string."""
    raw = input(f"Enter timezone [{default}]: ").strip()
    return raw if raw else default


# ---------------------------------------------------------------------------
# Reset handling
# ---------------------------------------------------------------------------

def confirm_reset() -> bool:
    """Ask user to confirm destructive reset."""
    print("\n⚠  WARNING: This will delete all state, logs, and earnings data!")
    answer = input("Type 'yes' to confirm reset: ").strip().lower()
    return answer == "yes"


def reset_agent(base_dir: Path, force: bool = False) -> bool:
    """Reset the agent by clearing data directories. Returns True if reset."""
    state_file = base_dir / "state" / "state.json"
    if not state_file.exists():
        logger.info("No existing state found — nothing to reset.")
        return False

    if not force and not confirm_reset():
        logger.info("Reset cancelled by user.")
        return False

    targets = ["state", "logs", "data", "reports", "backups"]
    for name in targets:
        target_dir = base_dir / name
        if target_dir.exists():
            for child in target_dir.iterdir():
                if child.is_file():
                    child.unlink()
                elif child.is_dir():
                    import shutil

                    shutil.rmtree(child)
            logger.info("Cleared: %s", target_dir)

    logger.info("Agent state has been reset.")
    return True


# ---------------------------------------------------------------------------
# Configuration summary
# ---------------------------------------------------------------------------

def print_summary(config: Dict, base_dir: Path, state_path: Path) -> None:
    """Print a formatted configuration summary after initialization."""
    print("\n" + "=" * 64)
    print("  INITIALIZATION COMPLETE")
    print("=" * 64)
    print(f"  Base Directory    : {base_dir}")
    print(f"  State File        : {state_path}")
    print(f"  Gmail             : {config['gmail']}")
    print(f"  Initial Capital   : ${config['initial_capital']:.2f}")
    print(f"  Risk Tolerance    : {config['risk_tolerance']}")
    print(f"  Timezone          : {config['timezone']}")
    print("-" * 64)
    print("  Directories created:")
    for name in DIRECTORIES:
        print(f"    • {base_dir / name}")
    print("=" * 64)
    print("\n  Next steps:")
    print(f"    python {base_dir / 'scripts' / 'autoloop.py'}")
    print()


# ---------------------------------------------------------------------------
# Main entrypoint
# ---------------------------------------------------------------------------


def parse_arguments() -> argparse.Namespace:
    """Parse CLI arguments."""
    parser = argparse.ArgumentParser(
        description="Initialize the Kimiclaw autonomous AI agent.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s                                    # Interactive setup
  %(prog)s --gmail me@gmail.com --capital 100 # Quick setup
  %(prog)s --reset                            # Reset with confirmation
  %(prog)s --force-reset                      # Reset without confirmation
        """,
    )
    parser.add_argument(
        "--gmail", type=str, help="Gmail address for the agent"
    )
    parser.add_argument(
        "--capital",
        type=float,
        default=DEFAULT_INITIAL_CAPITAL,
        help=f"Initial capital in USD (default: {DEFAULT_INITIAL_CAPITAL})",
    )
    parser.add_argument(
        "--risk",
        type=str,
        choices=["low", "medium", "high"],
        default=DEFAULT_RISK_TOLERANCE,
        help=f"Risk tolerance level (default: {DEFAULT_RISK_TOLERANCE})",
    )
    parser.add_argument(
        "--timezone",
        type=str,
        default=DEFAULT_TIMEZONE,
        help=f"Agent timezone (default: {DEFAULT_TIMEZONE})",
    )
    parser.add_argument(
        "--base-dir",
        type=Path,
        default=DEFAULT_BASE_DIR,
        help=f"Base directory for all agent files (default: {DEFAULT_BASE_DIR})",
    )
    parser.add_argument(
        "--reset",
        action="store_true",
        help="Reset agent state (with confirmation)",
    )
    parser.add_argument(
        "--force-reset",
        action="store_true",
        help="Reset agent state without confirmation",
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="Suppress non-error output",
    )
    return parser.parse_args()


def main() -> int:
    """Main entry point for the initialization script."""
    args = parse_arguments()
    base_dir: Path = args.base_dir.resolve()

    # Ensure scripts can find the base directory
    base_dir.mkdir(parents=True, exist_ok=True)

    setup_logging(base_dir / "logs", log_to_console=not args.quiet)

    print(WELCOME_BANNER.format(version=VERSION))

    # Handle reset
    if args.reset or args.force_reset:
        reset_agent(base_dir, force=args.force_reset)
        # After reset, continue to re-initialize

    # Gather configuration
    if args.gmail:
        gmail = args.gmail
        capital = args.capital
        risk = args.risk
        tz = args.timezone
        if not args.quiet:
            print(f"Using CLI arguments for configuration.\n")
    else:
        print("Please configure your Kimiclaw agent:\n")
        gmail = prompt_gmail()
        capital = prompt_initial_capital(args.capital)
        risk = prompt_risk_tolerance(args.risk)
        tz = prompt_timezone(args.timezone)
        print()

    config = {
        "gmail": gmail,
        "initial_capital": capital,
        "risk_tolerance": risk,
        "timezone": tz,
    }

    logger.info("Configuration: %s", config)

    # Create structure
    create_directories(base_dir)
    csv_path = create_earnings_csv(base_dir)
    create_log_files(base_dir)

    # Build and save state (map timezone key to function parameter name)
    state_kwargs = dict(config)
    state_kwargs["timezone_str"] = state_kwargs.pop("timezone")
    state = create_initial_state(**state_kwargs)
    state_path = write_state_json(state, base_dir / "state")

    # README
    create_readme(base_dir, config)

    # Summary
    if not args.quiet:
        print_summary(config, base_dir, state_path)

    logger.info("Kimiclaw v%s initialization complete.", VERSION)
    return 0


if __name__ == "__main__":
    sys.exit(main())
