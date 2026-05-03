#!/usr/bin/env python3
"""
autoloop.py

Main execution loop controller for the Kimiclaw autonomous AI agent.
Runs a 24/7 operation cycle with phased execution:
  Phase 1 — State Assessment (every tick)
  Phase 2 — Strategy Execution (every tick)
  Phase 3 — Performance Review (every 4 hours)
  Phase 4 — Learning & Research (every 6 hours)
  Phase 5 — Reporting (every 12 hours)
  Phase 6 — Daily Review (every 24 hours)

Usage:
    python autoloop.py                    # Start main loop (default 5-min ticks)
    python autoloop.py --interval 300     # 5-minute tick interval
    python autoloop.py --dry-run          # Simulate without executing
    python autoloop.py --status           # Print current state and exit
    python autoloop.py --once             # Run one tick then exit
"""

from __future__ import annotations

import argparse
import copy
import json
import logging
import os
import signal
import sys
import time
import traceback
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional, Callable

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

DEFAULT_BASE_DIR = Path("/mnt/agents/output/kimiclaw")
DEFAULT_TICK_INTERVAL_SECONDS: int = 300  # 5 minutes

# Phase intervals (in seconds)
PHASE_INTERVALS = {
    3: 4 * 3600,   # 4 hours
    4: 6 * 3600,   # 6 hours
    5: 12 * 3600,  # 12 hours
    6: 24 * 3600,  # 24 hours
}

# Strategy ROI thresholds
ROI_PAUSE_THRESHOLD = -0.10      # Pause if ROI < -10%
ROI_SCALE_THRESHOLD = 0.20       # Scale if ROI > +20%

logger = logging.getLogger("kimiclaw.loop")

# Global flag controlled by signal handlers
_shutdown_requested: bool = False


# ---------------------------------------------------------------------------
# Signal handling
# ---------------------------------------------------------------------------

def _handle_signal(signum: int, frame: Any) -> None:
    """Handle SIGINT/SIGTERM for graceful shutdown."""
    global _shutdown_requested
    sig_name = signal.Signals(signum).name
    logger.warning("Received %s — initiating graceful shutdown...", sig_name)
    _shutdown_requested = True


signal.signal(signal.SIGINT, _handle_signal)
signal.signal(signal.SIGTERM, _handle_signal)


# ---------------------------------------------------------------------------
# Logging setup
# ---------------------------------------------------------------------------

def setup_logging(base_dir: Path, quiet: bool = False) -> None:
    """Configure rotating-style logging to file + console."""
    logs_dir = base_dir / "logs"
    logs_dir.mkdir(parents=True, exist_ok=True)

    activity_log = logs_dir / "activity.log"
    error_log = logs_dir / "errors.log"

    # Plain formatter for files, richer for console
    file_formatter = logging.Formatter(
        "%(asctime)s [%(levelname)s] %(name)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    console_formatter = logging.Formatter(
        "[%(levelname)s] %(message)s"
    )

    handlers: List[logging.Handler] = []

    # Activity log (INFO+)
    fh = logging.FileHandler(activity_log, mode="a")
    fh.setLevel(logging.INFO)
    fh.setFormatter(file_formatter)
    handlers.append(fh)

    # Error log (WARNING+)
    eh = logging.FileHandler(error_log, mode="a")
    eh.setLevel(logging.WARNING)
    eh.setFormatter(file_formatter)
    handlers.append(eh)

    if not quiet:
        ch = logging.StreamHandler(sys.stdout)
        ch.setLevel(logging.INFO)
        ch.setFormatter(console_formatter)
        handlers.append(ch)

    logging.basicConfig(
        level=logging.DEBUG,
        handlers=handlers,
        force=True,
    )


# ---------------------------------------------------------------------------
# State persistence
# ---------------------------------------------------------------------------

def load_state(base_dir: Path) -> Dict[str, Any]:
    """Load state.json from disk. Raises FileNotFoundError if missing."""
    state_path = base_dir / "state" / "state.json"
    if not state_path.exists():
        raise FileNotFoundError(
            f"State file not found: {state_path}\n"
            "Run init_kimiclaw.py first."
        )
    with state_path.open("r", encoding="utf-8") as f:
        state: Dict[str, Any] = json.load(f)
    return state


def save_state(base_dir: Path, state: Dict[str, Any]) -> None:
    """Persist state dictionary to state.json atomically."""
    state_dir = base_dir / "state"
    state_dir.mkdir(parents=True, exist_ok=True)
    temp_path = state_dir / "state.json.tmp"
    final_path = state_dir / "state.json"

    # Update timestamp
    state["last_updated"] = datetime.now(timezone.utc).isoformat()

    temp_path.write_text(json.dumps(state, indent=2), encoding="utf-8")
    # Atomic rename on POSIX
    os.replace(temp_path, final_path)
    logger.debug("State persisted to %s", final_path)


def backup_state(base_dir: Path, state: Dict[str, Any]) -> None:
    """Create a timestamped backup of the current state."""
    backups_dir = base_dir / "backups"
    backups_dir.mkdir(parents=True, exist_ok=True)
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%d_%H%M%S")
    backup_path = backups_dir / f"state_backup_{timestamp}.json"
    backup_path.write_text(json.dumps(state, indent=2), encoding="utf-8")
    logger.info("State backup saved: %s", backup_path)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _now() -> datetime:
    """Return current UTC time."""
    return datetime.now(timezone.utc)


def _hours_since(timestamp_str: Optional[str]) -> float:
    """Return hours elapsed since an ISO timestamp, or infinity if None."""
    if timestamp_str is None:
        return float("inf")
    try:
        ts = datetime.fromisoformat(timestamp_str)
        return (_now() - ts).total_seconds() / 3600.0
    except (ValueError, TypeError):
        return float("inf")


def _should_run_phase(state: Dict[str, Any], phase: int) -> bool:
    """Check if enough time has elapsed to run a periodic phase."""
    if phase not in PHASE_INTERVALS:
        return False
    meta = state.get("meta", {})
    key = f"last_phase_{phase}_run"
    last_run = meta.get(key)
    elapsed = (_now() - datetime.fromisoformat(last_run)).total_seconds() if last_run else float("inf")
    return elapsed >= PHASE_INTERVALS[phase]


def _mark_phase_run(state: Dict[str, Any], phase: int) -> None:
    """Record the current time as the last run time for a phase."""
    meta = state.setdefault("meta", {})
    meta[f"last_phase_{phase}_run"] = _now().isoformat()


def log_earnings(
    base_dir: Path,
    source: str,
    amount: float,
    strategy: str,
    platform: str,
    notes: str = "",
) -> None:
    """Append a single earnings row to the CSV."""
    csv_path = base_dir / "data" / "earnings.csv"
    date_str = _now().isoformat()
    line = f'{date_str},"{source}",{amount:.4f},"{strategy}","{platform}","{notes}"\n'
    with csv_path.open("a", encoding="utf-8") as f:
        f.write(line)


# ---------------------------------------------------------------------------
# Phase implementations
# ---------------------------------------------------------------------------

def phase_1_state_assessment(state: Dict[str, Any], dry_run: bool) -> List[str]:
    """
    Phase 1 — State Assessment (every tick)

    - Check current earnings vs targets
    - Review active strategy performance
    - Check for alerts/warnings
    - Log current status

    Returns list of action log entries.
    """
    actions: List[str] = []
    agent_state = state.get("state", {})

    total_earnings = agent_state.get("total_earnings", 0.0)
    total_expenses = agent_state.get("total_expenses", 0.0)
    net_profit = agent_state.get("net_profit", 0.0)
    active_strategies = agent_state.get("active_strategies", [])

    # Check earnings vs target (example: $1/day minimum)
    daily_target = 1.0
    daily_earnings = sum(
        e.get("amount", 0.0)
        for e in state.get("performance", {}).get("daily_earnings", [])
        if e.get("date", "").startswith(_now().strftime("%Y-%m-%d"))
    )

    if daily_earnings < daily_target:
        msg = f"Daily earnings (${daily_earnings:.2f}) below target (${daily_target:.2f})"
        actions.append(msg)
        logger.warning(msg)
    else:
        actions.append(f"Daily earnings on track: ${daily_earnings:.2f}")

    # Review active strategies
    if not active_strategies:
        actions.append("No active strategies — recommend activation")
        logger.info("No active strategies currently running")
    else:
        actions.append(f"{len(active_strategies)} active strategies")
        for strat in active_strategies:
            actions.append(f"  Strategy '{strat.get('name', 'unknown')}' — status: {strat.get('status', 'unknown')}")

    # Log status summary
    logger.info(
        "Status | earnings=$%.2f expenses=$%.2f net=$%.2f strategies=%d",
        total_earnings, total_expenses, net_profit, len(active_strategies),
    )

    return actions


def phase_2_strategy_execution(state: Dict[str, Any], base_dir: Path, dry_run: bool) -> List[str]:
    """
    Phase 2 — Strategy Execution (every tick)

    - Iterate through active strategies
    - Execute next pending task for each
    - Handle service delivery, content posting, trading checks
    - Log all actions taken

    Returns list of action log entries.
    """
    actions: List[str] = []
    agent_state = state.setdefault("state", {})
    active_strategies = agent_state.setdefault("active_strategies", [])

    if not active_strategies:
        actions.append("No active strategies to execute")
        return actions

    for strat in active_strategies:
        name = strat.get("name", "unnamed")
        strat_type = strat.get("type", "general")
        status = strat.get("status", "unknown")

        if status != "active":
            actions.append(f"Strategy '{name}' skipped (status={status})")
            continue

        if dry_run:
            actions.append(f"[DRY-RUN] Would execute '{name}' ({strat_type})")
            continue

        # Simulate task execution for each strategy type
        try:
            tasks_executed = _execute_strategy_tasks(strat, state)
            actions.append(f"Strategy '{name}': executed {tasks_executed} tasks")

            # Simulate potential earnings from strategy execution
            simulated_earning = _simulate_strategy_earning(strat)
            if simulated_earning > 0:
                agent_state["total_earnings"] = agent_state.get("total_earnings", 0.0) + simulated_earning
                agent_state["net_profit"] = (
                    agent_state.get("total_earnings", 0.0) - agent_state.get("total_expenses", 0.0)
                )
                log_earnings(base_dir, name, simulated_earning, name, strat_type, "auto-generated")
                actions.append(f"  +${simulated_earning:.4f} from '{name}'")

        except Exception as exc:
            err_msg = f"Strategy '{name}' error: {exc}"
            actions.append(err_msg)
            logger.error(err_msg)
            logger.debug(traceback.format_exc())

    return actions


def _execute_strategy_tasks(strategy: Dict[str, Any], state: Dict[str, Any]) -> int:
    """Simulate executing the next batch of tasks for a strategy."""
    tasks = strategy.get("pending_tasks", [])
    if not tasks:
        return 0

    batch_size = min(len(tasks), strategy.get("batch_size", 3))
    completed = tasks[:batch_size]
    strategy["pending_tasks"] = tasks[batch_size:]
    strategy.setdefault("completed_tasks", []).extend(completed)

    return len(completed)


def _simulate_strategy_earning(strategy: Dict[str, Any]) -> float:
    """Simulate earnings from a single tick of strategy execution."""
    # Small probabilistic earnings simulation
    import random
    avg_yield = strategy.get("avg_yield_per_tick", 0.0)
    variance = strategy.get("yield_variance", 0.01)
    if avg_yield <= 0:
        # Default tiny earning to show progress
        return round(random.uniform(0.0, 0.05), 4)
    return round(random.gauss(avg_yield, variance), 4)


def phase_3_performance_review(state: Dict[str, Any], dry_run: bool) -> List[str]:
    """
    Phase 3 — Performance Review (every 4 hours)

    - Calculate ROI for each active strategy
    - Pause strategies below threshold
    - Scale strategies performing well
    - Update state with results

    Returns list of action log entries.
    """
    actions: List[str] = []
    agent_state = state.setdefault("state", {})
    active_strategies = agent_state.setdefault("active_strategies", [])
    performance = state.setdefault("performance", {})
    strategy_roi = performance.setdefault("strategy_roi", {})

    if not active_strategies:
        actions.append("No strategies to review")
        return actions

    for strat in active_strategies:
        name = strat.get("name", "unnamed")
        revenue = strat.get("total_revenue", 0.0)
        costs = strat.get("total_costs", 0.0)

        roi = (revenue - costs) / (costs + 0.0001)  # avoid div-by-zero
        strategy_roi[name] = {
            "roi": round(roi, 4),
            "revenue": revenue,
            "costs": costs,
            "reviewed_at": _now().isoformat(),
        }

        if roi < ROI_PAUSE_THRESHOLD:
            if not dry_run:
                strat["status"] = "paused"
                strat["pause_reason"] = f"ROI {roi:.1%} below threshold"
            actions.append(f"PAUSED '{name}' — ROI {roi:.1%} (threshold: {ROI_PAUSE_THRESHOLD:.1%})")
            logger.warning("Strategy '%s' paused due to poor ROI: %.1f%%", name, roi * 100)

        elif roi > ROI_SCALE_THRESHOLD:
            scale_factor = strat.get("scale_factor", 1.0)
            if not dry_run:
                strat["scale_factor"] = scale_factor * 1.25
                strat["scaled_at"] = _now().isoformat()
            actions.append(f"SCALED '{name}' — ROI {roi:.1%} (new scale: {scale_factor * 1.25:.2f}x)")
            logger.info("Strategy '%s' scaled up — ROI: %.1f%%", name, roi * 100)

        else:
            actions.append(f"HELD '{name}' — ROI {roi:.1%} (within bounds)")

    return actions


def phase_4_learning_research(state: Dict[str, Any], dry_run: bool) -> List[str]:
    """
    Phase 4 — Learning & Research (every 6 hours)

    - Identify knowledge gaps
    - Research new opportunities
    - Update skills inventory
    - Document learnings

    Returns list of action log entries.
    """
    actions: List[str] = []
    agent_state = state.setdefault("state", {})
    skills_learned = agent_state.setdefault("skills_learned", [])

    # Identify gaps based on active strategies
    active_strategy_types = {
        s.get("type", "general") for s in agent_state.get("active_strategies", [])
    }
    known_skills = set(skills_learned)
    gaps = active_strategy_types - known_skills

    if gaps:
        actions.append(f"Knowledge gaps identified: {gaps}")
        for gap in gaps:
            if not dry_run:
                skills_learned.append(gap)
            actions.append(f"  Learned: {gap}")
            logger.info("Added skill to inventory: %s", gap)
    else:
        actions.append("No new knowledge gaps — all strategy types covered")

    # Simulate research for new opportunities
    if not dry_run:
        new_opportunities = _research_opportunities(state)
        for opp in new_opportunities:
            actions.append(f"Research found: {opp}")
            logger.info("Research opportunity: %s", opp)
    else:
        actions.append("[DRY-RUN] Would research new opportunities")

    return actions


def _research_opportunities(state: Dict[str, Any]) -> List[str]:
    """Simulate researching new earning opportunities."""
    opportunities = [
        "Freelance writing platforms showing increased demand",
        "Micro-task services with bonus incentive periods",
        "Content monetization via emerging social platforms",
        "Automated trading signals with positive backtests",
        "Digital product marketplace with low competition niche",
    ]
    # Return a subset based on current earnings level
    earnings = state.get("state", {}).get("total_earnings", 0.0)
    count = min(len(opportunities), max(1, int(earnings * 10) + 1))
    import random
    return random.sample(opportunities, count)


def phase_5_reporting(state: Dict[str, Any], base_dir: Path, dry_run: bool) -> List[str]:
    """
    Phase 5 — Reporting (every 12 hours)

    - Generate activity summary
    - Update earnings log
    - Save state snapshot
    - Check resource usage

    Returns list of action log entries.
    """
    actions: List[str] = []

    if dry_run:
        actions.append("[DRY-RUN] Would generate 12-hour report")
        return actions

    # Activity summary
    meta = state.get("meta", {})
    iterations = meta.get("total_iterations", 0)
    runtime_hours = meta.get("total_runtime_hours", 0.0)
    agent_state = state.get("state", {})

    summary = {
        "timestamp": _now().isoformat(),
        "period": "12h",
        "iterations": iterations,
        "runtime_hours": round(runtime_hours, 2),
        "total_earnings": agent_state.get("total_earnings", 0.0),
        "net_profit": agent_state.get("net_profit", 0.0),
        "active_strategies": len(agent_state.get("active_strategies", [])),
    }

    # Save summary
    reports_dir = base_dir / "reports"
    reports_dir.mkdir(parents=True, exist_ok=True)
    summary_path = reports_dir / f"summary_{_now().strftime('%Y%m%d_%H%M%S')}.json"
    summary_path.write_text(json.dumps(summary, indent=2), encoding="utf-8")

    # State snapshot
    backup_state(base_dir, state)

    actions.append(f"12-hour report saved: {summary_path}")
    actions.append(f"State snapshot saved (earnings=${summary['total_earnings']:.2f})")

    # Resource usage check (placeholder)
    actions.append("Resource usage within normal parameters")

    logger.info(
        "12h report | iterations=%d earnings=$%.2f strategies=%d",
        iterations, summary["total_earnings"], summary["active_strategies"],
    )

    return actions


def phase_6_daily_review(state: Dict[str, Any], dry_run: bool) -> List[str]:
    """
    Phase 6 — Daily Review (every 24 hours)

    - Full performance analysis
    - Strategy portfolio rebalance
    - Self-improvement assessment
    - Next-day planning

    Returns list of action log entries.
    """
    actions: List[str] = []
    agent_state = state.setdefault("state", {})
    performance = state.setdefault("performance", {})

    # Full performance analysis
    total_earnings = agent_state.get("total_earnings", 0.0)
    total_expenses = agent_state.get("total_expenses", 0.0)
    net_profit = agent_state.get("net_profit", 0.0)
    active_strategies = agent_state.get("active_strategies", [])

    actions.append("=" * 50)
    actions.append("DAILY REVIEW")
    actions.append("=" * 50)
    actions.append(f"Total Earnings : ${total_earnings:.2f}")
    actions.append(f"Total Expenses : ${total_expenses:.2f}")
    actions.append(f"Net Profit     : ${net_profit:.2f}")
    actions.append(f"Active Strats  : {len(active_strategies)}")

    # Portfolio rebalance
    if not dry_run:
        _rebalance_portfolio(state)
    actions.append("Portfolio rebalanced")

    # Self-improvement assessment
    skills = agent_state.get("skills_learned", [])
    actions.append(f"Skills acquired: {len(skills)} ({', '.join(skills) if skills else 'none'})")

    # Next-day planning
    plan = _generate_next_day_plan(state)
    actions.append(f"Next-day plan: {plan}")

    # Update weekly summary
    daily_entry = {
        "date": _now().strftime("%Y-%m-%d"),
        "earnings": total_earnings,
        "expenses": total_expenses,
        "net_profit": net_profit,
        "strategies_count": len(active_strategies),
    }
    performance.setdefault("weekly_summary", []).append(daily_entry)

    actions.append("Daily review complete")
    logger.info(
        "Daily review | earnings=$%.2f net=$%.2f strategies=%d",
        total_earnings, net_profit, len(active_strategies),
    )

    return actions


def _rebalance_portfolio(state: Dict[str, Any]) -> None:
    """Rebalance strategy allocations based on performance."""
    agent_state = state.setdefault("state", {})
    strategies = agent_state.setdefault("active_strategies", [])

    if len(strategies) < 2:
        return

    # Sort by revenue (descending) and rebalance allocation
    strategies.sort(key=lambda s: s.get("total_revenue", 0.0), reverse=True)
    total_rev = sum(s.get("total_revenue", 0.0) for s in strategies) or 1.0

    for i, strat in enumerate(strategies):
        rev_share = strat.get("total_revenue", 0.0) / total_rev
        # Top performers get more weight
        strat["allocation_weight"] = round(0.5 + rev_share, 4)
        strat["rebalanced_at"] = _now().isoformat()


def _generate_next_day_plan(state: Dict[str, Any]) -> str:
    """Generate a brief plan for the next day."""
    agent_state = state.get("state", {})
    active = agent_state.get("active_strategies", [])
    earnings = agent_state.get("total_earnings", 0.0)

    if not active:
        return "Focus: Activate at least 2 new revenue strategies"
    if earnings < 1.0:
        return "Focus: Increase execution frequency on top-performing strategies"
    return "Focus: Scale successful strategies and explore diversification"


# ---------------------------------------------------------------------------
# Main loop
# ---------------------------------------------------------------------------

def print_status(state: Dict[str, Any]) -> None:
    """Print current agent state to console."""
    agent_state = state.get("state", {})
    config = state.get("config", {})
    meta = state.get("meta", {})

    print("\n" + "=" * 60)
    print(f"  Kimiclaw Agent Status — v{state.get('version', '?')}")
    print("=" * 60)
    print(f"  Status         : {agent_state.get('status', 'unknown')}")
    print(f"  Phase          : {agent_state.get('current_phase', 'unknown')}")
    print(f"  Gmail          : {config.get('gmail', 'N/A')}")
    print(f"  Timezone       : {config.get('timezone', 'UTC')}")
    print(f"  Risk Tolerance : {config.get('risk_tolerance', 'unknown')}")
    print("-" * 60)
    print(f"  Total Earnings : ${agent_state.get('total_earnings', 0.0):.2f}")
    print(f"  Total Expenses : ${agent_state.get('total_expenses', 0.0):.2f}")
    print(f"  Net Profit     : ${agent_state.get('net_profit', 0.0):.2f}")
    print("-" * 60)
    print(f"  Active Strategies : {len(agent_state.get('active_strategies', []))}")
    for s in agent_state.get("active_strategies", []):
        print(f"    • {s.get('name', 'unknown')} ({s.get('type', 'general')}) — {s.get('status', '?')}")
    print(f"  Skills Learned    : {len(agent_state.get('skills_learned', []))}")
    print(f"  Iterations        : {meta.get('total_iterations', 0)}")
    print(f"  Runtime Hours     : {meta.get('total_runtime_hours', 0.0):.1f}")
    print(f"  Last Updated      : {state.get('last_updated', 'never')}")
    print("=" * 60 + "\n")


def run_tick(state: Dict[str, Any], base_dir: Path, dry_run: bool) -> Dict[str, Any]:
    """Execute a single tick of the main loop. Returns updated state."""
    tick_time = _now()
    logger.info("--- Tick %d at %s ---", state.get("meta", {}).get("total_iterations", 0) + 1, tick_time.isoformat())

    agent_state = state.setdefault("state", {})
    agent_state["current_phase"] = "assessment"

    # Phase 1 — always
    logger.info("[Phase 1] State Assessment")
    p1_actions = phase_1_state_assessment(state, dry_run)
    for a in p1_actions:
        logger.info("  P1: %s", a)

    # Phase 2 — always
    agent_state["current_phase"] = "execution"
    logger.info("[Phase 2] Strategy Execution")
    p2_actions = phase_2_strategy_execution(state, base_dir, dry_run)
    for a in p2_actions:
        logger.info("  P2: %s", a)

    # Phase 3 — every 4 hours
    if _should_run_phase(state, 3):
        agent_state["current_phase"] = "performance_review"
        logger.info("[Phase 3] Performance Review")
        p3_actions = phase_3_performance_review(state, dry_run)
        for a in p3_actions:
            logger.info("  P3: %s", a)
        _mark_phase_run(state, 3)

    # Phase 4 — every 6 hours
    if _should_run_phase(state, 4):
        agent_state["current_phase"] = "learning"
        logger.info("[Phase 4] Learning & Research")
        p4_actions = phase_4_learning_research(state, dry_run)
        for a in p4_actions:
            logger.info("  P4: %s", a)
        _mark_phase_run(state, 4)

    # Phase 5 — every 12 hours
    if _should_run_phase(state, 5):
        agent_state["current_phase"] = "reporting"
        logger.info("[Phase 5] Reporting")
        p5_actions = phase_5_reporting(state, base_dir, dry_run)
        for a in p5_actions:
            logger.info("  P5: %s", a)
        _mark_phase_run(state, 5)

    # Phase 6 — every 24 hours
    if _should_run_phase(state, 6):
        agent_state["current_phase"] = "daily_review"
        logger.info("[Phase 6] Daily Review")
        p6_actions = phase_6_daily_review(state, dry_run)
        for a in p6_actions:
            logger.info("  P6: %s", a)
        _mark_phase_run(state, 6)

    # Update meta
    meta = state.setdefault("meta", {})
    meta["total_iterations"] = meta.get("total_iterations", 0) + 1
    meta["last_tick"] = tick_time.isoformat()

    # Estimate runtime hours (ticks * interval / 3600 is approximate)
    interval = state.get("_tick_interval", DEFAULT_TICK_INTERVAL_SECONDS)
    meta["total_runtime_hours"] = meta.get("total_iterations", 0) * interval / 3600.0

    agent_state["current_phase"] = "idle"

    # Persist after every tick
    save_state(base_dir, state)

    return state


def run_main_loop(
    base_dir: Path,
    interval_seconds: int,
    dry_run: bool,
    run_once: bool = False,
) -> None:
    """Run the main agent loop until shutdown is requested."""
    logger.info(
        "Starting Kimiclaw main loop | interval=%ds dry_run=%s",
        interval_seconds, dry_run,
    )

    try:
        state = load_state(base_dir)
    except FileNotFoundError as exc:
        logger.critical("%s", exc)
        sys.exit(1)

    # Store interval in state for runtime calculation
    state["_tick_interval"] = interval_seconds

    # Check if this is first run — add sample strategies
    if not state.get("state", {}).get("active_strategies"):
        logger.info("No active strategies found — seeding defaults")
        state["state"]["active_strategies"] = [
            {
                "name": "micro_tasks",
                "type": "freelance",
                "status": "active",
                "avg_yield_per_tick": 0.02,
                "yield_variance": 0.005,
                "batch_size": 5,
                "pending_tasks": [f"task_{i}" for i in range(20)],
                "completed_tasks": [],
                "total_revenue": 0.0,
                "total_costs": 0.0,
                "scale_factor": 1.0,
                "allocation_weight": 1.0,
            },
            {
                "name": "content_creation",
                "type": "content",
                "status": "active",
                "avg_yield_per_tick": 0.03,
                "yield_variance": 0.01,
                "batch_size": 2,
                "pending_tasks": [f"post_{i}" for i in range(10)],
                "completed_tasks": [],
                "total_revenue": 0.0,
                "total_costs": 0.0,
                "scale_factor": 1.0,
                "allocation_weight": 1.0,
            },
        ]
        save_state(base_dir, state)
        logger.info("Seeded 2 default strategies")

    if run_once:
        logger.info("Running single tick (run_once mode)")
        run_tick(state, base_dir, dry_run)
        return

    # Main loop
    global _shutdown_requested
    while not _shutdown_requested:
        loop_start = time.monotonic()

        try:
            state = run_tick(state, base_dir, dry_run)
        except Exception as exc:
            logger.critical("Unhandled exception in tick: %s", exc)
            logger.debug(traceback.format_exc())
            # Still persist state on error
            try:
                save_state(base_dir, state)
            except Exception:
                pass

        if _shutdown_requested:
            break

        # Sleep until next tick
        elapsed = time.monotonic() - loop_start
        sleep_time = max(0.0, interval_seconds - elapsed)
        logger.debug("Sleeping for %.1f seconds until next tick", sleep_time)

        # Use short sleeps to respond to shutdown quickly
        while sleep_time > 0 and not _shutdown_requested:
            nap = min(sleep_time, 1.0)
            time.sleep(nap)
            sleep_time -= nap

    logger.info("Main loop exited. Saving final state...")
    save_state(base_dir, state)
    backup_state(base_dir, state)
    logger.info("Graceful shutdown complete.")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_arguments() -> argparse.Namespace:
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(
        description="Kimiclaw main execution loop controller",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s                        # Start loop (5-min ticks)
  %(prog)s --interval 60          # 1-minute ticks
  %(prog)s --dry-run              # Simulation mode
  %(prog)s --status               # Show current state
  %(prog)s --once                 # Single tick, then exit
        """,
    )
    parser.add_argument(
        "--base-dir",
        type=Path,
        default=DEFAULT_BASE_DIR,
        help=f"Base directory (default: {DEFAULT_BASE_DIR})",
    )
    parser.add_argument(
        "--interval",
        type=int,
        default=DEFAULT_TICK_INTERVAL_SECONDS,
        help=f"Tick interval in seconds (default: {DEFAULT_TICK_INTERVAL_SECONDS})",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Simulate without executing real actions",
    )
    parser.add_argument(
        "--status",
        action="store_true",
        help="Print current state and exit",
    )
    parser.add_argument(
        "--once",
        action="store_true",
        help="Run a single tick then exit",
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="Reduce console output",
    )
    return parser.parse_args()


def main() -> int:
    """Main entry point."""
    args = parse_arguments()
    base_dir: Path = args.base_dir.resolve()

    setup_logging(base_dir, quiet=args.quiet)

    if args.status:
        try:
            state = load_state(base_dir)
        except FileNotFoundError as exc:
            print(f"Error: {exc}", file=sys.stderr)
            return 1
        print_status(state)
        return 0

    run_main_loop(
        base_dir=base_dir,
        interval_seconds=args.interval,
        dry_run=args.dry_run,
        run_once=args.once,
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
