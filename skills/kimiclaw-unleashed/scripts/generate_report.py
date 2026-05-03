#!/usr/bin/env python3
"""
generate_report.py

Report generation script for the Kimiclaw autonomous AI agent.
Produces multiple report types in Markdown (default) or JSON format.

Report Types:
  --daily      Daily activity and earnings report
  --weekly     7-day trend and performance report
  --strategy   Per-strategy performance analysis
  --financial  Cash flow, revenue breakdown, and projections

Usage:
    python generate_report.py --daily              # Daily report
    python generate_report.py --weekly             # Weekly report
    python generate_report.py --strategy           # Strategy performance
    python generate_report.py --financial          # Financial summary
    python generate_report.py --daily --json       # JSON output
    python generate_report.py --daily --print      # Console output only
    python generate_report.py --start 2024-01-01 --end 2024-01-31
    python generate_report.py --weekly --compare   # Compare with previous week
"""

from __future__ import annotations

import argparse
import csv
import json
import logging
import sys
from collections import defaultdict
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

DEFAULT_BASE_DIR = Path("/mnt/agents/output/kimiclaw")
REPORTS_DIR_NAME = "reports"

logger = logging.getLogger("kimiclaw.report")

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------


def setup_logging(base_dir: Path) -> None:
    """Configure minimal logging for the report generator."""
    logs_dir = base_dir / "logs"
    logs_dir.mkdir(parents=True, exist_ok=True)
    log_file = logs_dir / "report_generator.log"

    handlers = [logging.FileHandler(log_file, mode="a")]
    if sys.stdout.isatty():
        handlers.append(logging.StreamHandler(sys.stdout))

    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s [%(levelname)s] %(name)s - %(message)s",
        handlers=handlers,
        force=True,
    )


# ---------------------------------------------------------------------------
# Data loading
# ---------------------------------------------------------------------------


def load_state(base_dir: Path) -> Dict[str, Any]:
    """Load the agent state from state.json."""
    state_path = base_dir / "state" / "state.json"
    if not state_path.exists():
        raise FileNotFoundError(
            f"State file not found: {state_path}. Run init_kimiclaw.py first."
        )
    with state_path.open("r", encoding="utf-8") as f:
        return json.load(f)


def load_earnings_csv(base_dir: Path) -> List[Dict[str, Any]]:
    """Load earnings records from the CSV file."""
    csv_path = base_dir / "data" / "earnings.csv"
    records: List[Dict[str, Any]] = []
    if not csv_path.exists():
        return records

    with csv_path.open("r", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            try:
                row["amount"] = float(row.get("amount", 0))
            except (ValueError, TypeError):
                row["amount"] = 0.0
            records.append(row)
    return records


# ---------------------------------------------------------------------------
# Date helpers
# ---------------------------------------------------------------------------


def parse_date(date_str: str) -> datetime:
    """Parse a date string in YYYY-MM-DD format."""
    return datetime.strptime(date_str, "%Y-%m-%d").replace(tzinfo=timezone.utc)


def filter_by_date_range(
    records: List[Dict[str, Any]],
    start: Optional[datetime] = None,
    end: Optional[datetime] = None,
    date_key: str = "date",
) -> List[Dict[str, Any]]:
    """Filter records to those within [start, end] (inclusive)."""
    filtered: List[Dict[str, Any]] = []
    for rec in records:
        try:
            rec_date = datetime.fromisoformat(rec[date_key].replace("Z", "+00:00"))
        except (ValueError, KeyError):
            continue
        if start and rec_date.date() < start.date():
            continue
        if end and rec_date.date() > end.date():
            continue
        filtered.append(rec)
    return filtered


# ---------------------------------------------------------------------------
# ASCII chart helpers (no external dependencies)
# ---------------------------------------------------------------------------


def ascii_bar_chart(
    data: Dict[str, float],
    width: int = 40,
    unit: str = "",
    title: str = "",
) -> str:
    """
    Generate a horizontal ASCII bar chart.

    Args:
        data: Mapping of label -> value.
        width: Maximum bar width in characters.
        unit: Unit suffix for values.
        title: Optional chart title.
    """
    if not data:
        return "(no data)"

    lines: List[str] = []
    if title:
        lines.append(f"  {title}")
        lines.append(f"  {'-' * len(title)}")

    max_label = max(len(str(k)) for k in data)
    max_val = max(abs(v) for v in data.values()) or 1.0

    for label, value in data.items():
        bar_len = int(round((abs(value) / max_val) * width))
        bar_char = "█" if value >= 0 else "░"
        bar = bar_char * bar_len
        sign = "+" if value > 0 and unit.startswith("$") else ""
        lines.append(f"  {str(label):>{max_label}} │{bar} {sign}{value:.4f}{unit}")

    return "\n".join(lines)


def ascii_line_chart(
    points: List[float],
    labels: Optional[List[str]] = None,
    height: int = 10,
    width: int = 50,
    title: str = "",
) -> str:
    """
    Generate a simple ASCII line chart from a series of points.

    Args:
        points: Numeric data points.
        labels: Optional x-axis labels (must match len(points)).
        height: Chart height in rows.
        width: Chart width in columns.
        title: Optional chart title.
    """
    if not points:
        return "(no data)"

    lines: List[str] = []
    if title:
        lines.append(f"  {title}")

    min_val = min(points)
    max_val = max(points)
    val_range = max_val - min_val or 1.0

    # Build grid
    grid: List[List[str]] = [[" " for _ in range(width)] for _ in range(height)]

    if len(points) == 1:
        x_positions = [width // 2]
    else:
        step = (width - 1) / (len(points) - 1)
        x_positions = [int(round(i * step)) for i in range(len(points))]

    # Place points
    y_positions: List[int] = []
    for val in points:
        normalized = (val - min_val) / val_range
        y = height - 1 - int(round(normalized * (height - 1)))
        y = max(0, min(height - 1, y))
        y_positions.append(y)

    for x_idx, (x, y) in enumerate(zip(x_positions, y_positions)):
        grid[y][x] = "●"
        # Connect to previous point
        if x_idx > 0:
            prev_x = x_positions[x_idx - 1]
            prev_y = y_positions[x_idx - 1]
            # Draw line between points
            if prev_x < x:
                for mx in range(prev_x + 1, x):
                    ratio = (mx - prev_x) / (x - prev_x)
                    my = int(round(prev_y + (y - prev_y) * ratio))
                    my = max(0, min(height - 1, my))
                    if grid[my][mx] == " ":
                        grid[my][mx] = "·"

    # Render
    for row_idx, row in enumerate(grid):
        val_label = ""
        if row_idx == 0:
            val_label = f" {max_val:.2f}"
        elif row_idx == height - 1:
            val_label = f" {min_val:.2f}"
        lines.append(f"  {val_label:>8} │" + "".join(row))

    lines.append(f"  {'':>8} └{'─' * width}")
    if labels and len(labels) == len(points):
        # Show first, middle, last labels
        first_l = str(labels[0])[:8]
        last_l = str(labels[-1])[:8]
        lines.append(f"  {'':>10}{first_l:<{width - len(last_l)}}{last_l}")

    return "\n".join(lines)


def ascii_pie_chart(data: Dict[str, float], width: int = 30) -> str:
    """
    Generate an ASCII pie chart using block characters.

    Args:
        data: Mapping of label -> value.
        width: Width of the chart display.
    """
    if not data:
        return "(no data)"

    total = sum(data.values()) or 1.0
    blocks = ["█", "▓", "▒", "░", "▪", "▫", "◾", "◽"]
    lines: List[str] = []
    for idx, (label, value) in enumerate(data.items()):
        pct = (value / total) * 100
        block = blocks[idx % len(blocks)]
        bar = block * max(1, int(round((value / total) * width)))
        lines.append(f"  {block} {label:<20} ${value:>10.2f}  ({pct:>5.1f}%)")
        lines.append(f"     {bar}")

    lines.append(f"  {'Total':<22} ${total:>10.2f}")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Report generators
# ---------------------------------------------------------------------------


def generate_daily_report(
    state: Dict[str, Any],
    earnings: List[Dict[str, Any]],
    start: Optional[datetime] = None,
    end: Optional[datetime] = None,
) -> str:
    """Generate a daily activity and earnings report (Markdown)."""
    today = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    now_iso = datetime.now(timezone.utc).isoformat()

    agent_state = state.get("state", {})
    config = state.get("config", {})

    # Filter earnings
    filtered = filter_by_date_range(earnings, start, end)
    today_earnings = filter_by_date_range(
        earnings,
        parse_date(today),
        parse_date(today) + timedelta(days=1),
    )

    total_today = sum(e["amount"] for e in today_earnings)
    total_period = sum(e["amount"] for e in filtered)

    tasks_today = len(today_earnings)
    active_strategies = agent_state.get("active_strategies", [])

    # Top strategies by today's earnings
    strat_earnings: Dict[str, float] = defaultdict(float)
    for e in today_earnings:
        strat_earnings[e.get("strategy", "unknown")] += e["amount"]
    top_strategies = dict(sorted(strat_earnings.items(), key=lambda x: -x[1])[:5])

    lines: List[str] = [
        f"# Daily Report — Kimiclaw Agent",
        f"",
        f"**Date:** {today}  ",
        f"**Generated:** {now_iso}  ",
        f"**Agent:** {state.get('agent_name', 'kimiclaw')} v{state.get('version', '?')}",
        f"",
        f"---",
        f"",
        f"## Summary",
        f"",
        f"| Metric | Value |",
        f"|---|---|",
        f"| Total Earnings (today) | ${total_today:.4f} |",
        f"| Total Earnings (period) | ${total_period:.4f} |",
        f"| Tasks Completed | {tasks_today} |",
        f"| Active Strategies | {len(active_strategies)} |",
        f"| Net Profit | ${agent_state.get('net_profit', 0.0):.4f} |",
        f"| Status | {agent_state.get('status', 'unknown')} |",
        f"",
        f"## Active Strategies",
        f"",
    ]

    if active_strategies:
        lines.append("| Strategy | Type | Status | Scale |")
        lines.append("|---|---|---|---|")
        for s in active_strategies:
            lines.append(
                f"| {s.get('name', '?')} | {s.get('type', '?')} | "
                f"{s.get('status', '?')} | {s.get('scale_factor', 1.0):.2f}x |"
            )
    else:
        lines.append("*No active strategies.*")

    lines.extend([
        f"",
        f"## Top Performing Strategies (Today)",
        f"",
        ascii_bar_chart(top_strategies, unit="$"),
        f"",
        f"## Issues & Roadblocks",
        f"",
    ])

    # Identify issues
    issues: List[str] = []
    if not active_strategies:
        issues.append("No active strategies — agent needs initialization")
    if total_today < 0.01:
        issues.append("Minimal earnings today — consider activating more strategies")
    paused = [s for s in active_strategies if s.get("status") == "paused"]
    for s in paused:
        issues.append(f"Strategy '{s.get('name')}' is paused: {s.get('pause_reason', 'unknown')}")

    if issues:
        for issue in issues:
            lines.append(f"- ⚠ {issue}")
    else:
        lines.append("*No issues detected.*")

    lines.extend([
        f"",
        f"---",
        f"*Generated by Kimiclaw Report Generator*",
    ])

    return "\n".join(lines)


def generate_weekly_report(
    state: Dict[str, Any],
    earnings: List[Dict[str, Any]],
    start: Optional[datetime] = None,
    end: Optional[datetime] = None,
) -> str:
    """Generate a 7-day trend and performance report (Markdown)."""
    now = datetime.now(timezone.utc)
    now_iso = now.isoformat()

    # Default to last 7 days
    if not start:
        start = now - timedelta(days=7)
    if not end:
        end = now

    agent_state = state.get("state", {})
    performance = state.get("performance", {})
    weekly_summary = performance.get("weekly_summary", [])
    config = state.get("config", {})

    # Daily breakdown
    daily: Dict[str, float] = {}
    current = start
    while current <= end:
        day_str = current.strftime("%Y-%m-%d")
        day_earnings = filter_by_date_range(
            earnings,
            current,
            current + timedelta(days=1),
        )
        daily[day_str] = sum(e["amount"] for e in day_earnings)
        current += timedelta(days=1)

    total_week = sum(daily.values())
    avg_daily = total_week / max(len(daily), 1)

    # Strategy performance comparison
    strat_totals: Dict[str, Dict[str, float]] = defaultdict(lambda: {"revenue": 0.0, "costs": 0.0})
    filtered = filter_by_date_range(earnings, start, end)
    for e in filtered:
        sname = e.get("strategy", "unknown")
        strat_totals[sname]["revenue"] += e["amount"]

    # ROI by category
    strategy_roi = performance.get("strategy_roi", {})
    roi_data = {
        name: data.get("roi", 0.0)
        for name, data in strategy_roi.items()
    }

    # Skills acquired
    skills = agent_state.get("skills_learned", [])

    lines: List[str] = [
        f"# Weekly Report — Kimiclaw Agent",
        f"",
        f"**Period:** {start.strftime('%Y-%m-%d')} to {end.strftime('%Y-%m-%d')}  ",
        f"**Generated:** {now_iso}  ",
        f"**Risk Tolerance:** {config.get('risk_tolerance', 'unknown')}",
        f"",
        f"---",
        f"",
        f"## 7-Day Earnings Trend",
        f"",
        f"**Total:** ${total_week:.4f} | **Daily Average:** ${avg_daily:.4f}",
        f"",
        ascii_line_chart(
            list(daily.values()),
            labels=list(daily.keys()),
            title="Daily Earnings ($)",
        ),
        f"",
        f"## Strategy Performance Comparison",
        f"",
    ]

    if strat_totals:
        lines.append("| Strategy | Revenue | Costs | Net |")
        lines.append("|---|---|---|---|")
        for name, data in sorted(strat_totals.items(), key=lambda x: -x[1]["revenue"]):
            net = data["revenue"] - data["costs"]
            lines.append(
                f"| {name} | ${data['revenue']:.4f} | ${data['costs']:.4f} | ${net:.4f} |"
            )
    else:
        lines.append("*No strategy data available.*")

    lines.extend([
        f"",
        f"## ROI by Category",
        f"",
        ascii_bar_chart(roi_data, unit=""),
        f"",
        f"## Skills Acquired",
        f"",
    ])

    if skills:
        for skill in skills:
            lines.append(f"- ✅ {skill}")
    else:
        lines.append("*No new skills recorded this week.*")

    # Goals for next week
    lines.extend([
        f"",
        f"## Goals for Next Week",
        f"",
        f"- [ ] Increase daily average earnings above ${avg_daily * 1.2:.2f}",
        f"- [ ] Activate at least one new revenue stream",
        f"- [ ] Maintain positive ROI across all active strategies",
        f"- [ ] Complete daily reviews without missed cycles",
        f"",
        f"---",
        f"*Generated by Kimiclaw Report Generator*",
    ])

    return "\n".join(lines)


def generate_strategy_report(
    state: Dict[str, Any],
    earnings: List[Dict[str, Any]],
    start: Optional[datetime] = None,
    end: Optional[datetime] = None,
) -> str:
    """Generate a per-strategy performance analysis report (Markdown)."""
    now_iso = datetime.now(timezone.utc).isoformat()
    agent_state = state.get("state", {})
    performance = state.get("performance", {})
    active_strategies = agent_state.get("active_strategies", [])
    strategy_roi = performance.get("strategy_roi", {})

    filtered = filter_by_date_range(earnings, start, end)

    lines: List[str] = [
        f"# Strategy Performance Report — Kimiclaw Agent",
        f"",
        f"**Generated:** {now_iso}",
        f"",
        f"---",
        f"",
    ]

    if not active_strategies:
        lines.append("*No strategies are currently active.*")
        return "\n".join(lines)

    for strat in active_strategies:
        name = strat.get("name", "unnamed")
        strat_type = strat.get("type", "general")
        revenue = strat.get("total_revenue", 0.0)
        costs = strat.get("total_costs", 0.0)
        roi_data = strategy_roi.get(name, {})
        roi = roi_data.get("roi", 0.0)
        scale = strat.get("scale_factor", 1.0)
        weight = strat.get("allocation_weight", 1.0)
        status = strat.get("status", "unknown")
        completed = len(strat.get("completed_tasks", []))
        pending = len(strat.get("pending_tasks", []))

        # Earnings from this strategy in period
        strat_earnings = [e for e in filtered if e.get("strategy") == name]
        period_revenue = sum(e["amount"] for e in strat_earnings)

        # Recommendation
        if roi < -0.05:
            recommendation = "⛔ PAUSE — Underperforming significantly"
        elif roi > 0.20:
            recommendation = "🚀 SCALE — Strong performance, increase allocation"
        elif roi > 0.05:
            recommendation = "✅ HOLD — Stable positive returns"
        else:
            recommendation = "⚠ PIVOT — Consider strategy adjustment"

        lines.extend([
            f"## {name}",
            f"",
            f"| Attribute | Value |",
            f"|---|---|",
            f"| Type | {strat_type} |",
            f"| Status | {status} |",
            f"| Total Revenue | ${revenue:.4f} |",
            f"| Total Costs | ${costs:.4f} |",
            f"| Net | ${revenue - costs:.4f} |",
            f"| ROI | {roi:.2%} |",
            f"| Scale Factor | {scale:.2f}x |",
            f"| Allocation Weight | {weight:.4f} |",
            f"| Tasks Completed | {completed} |",
            f"| Tasks Pending | {pending} |",
            f"| Period Revenue | ${period_revenue:.4f} |",
            f"",
            f"**Recommendation:** {recommendation}",
            f"",
        ])

    # Summary table
    lines.extend([
        f"---",
        f"",
        f"## Strategy Comparison",
        f"",
        ascii_bar_chart(
            {s.get("name", "?"): strategy_roi.get(s.get("name"), {}).get("roi", 0.0)
             for s in active_strategies},
            unit="",
            title="ROI by Strategy",
        ),
        f"",
        f"---",
        f"*Generated by Kimiclaw Report Generator*",
    ])

    return "\n".join(lines)


def generate_financial_report(
    state: Dict[str, Any],
    earnings: List[Dict[str, Any]],
    start: Optional[datetime] = None,
    end: Optional[datetime] = None,
) -> str:
    """Generate a financial summary report with cash flow and projections (Markdown)."""
    now = datetime.now(timezone.utc)
    now_iso = now.isoformat()
    agent_state = state.get("state", {})
    config = state.get("config", {})

    filtered = filter_by_date_range(earnings, start, end)

    # Cash flow statement
    total_income = sum(e["amount"] for e in filtered if e["amount"] > 0)
    total_expenses = sum(abs(e["amount"]) for e in filtered if e["amount"] < 0)
    net_cash_flow = total_income - total_expenses

    # Revenue by source (pie chart data)
    source_revenue: Dict[str, float] = defaultdict(float)
    for e in filtered:
        if e["amount"] > 0:
            source_revenue[e.get("source", "unknown")] += e["amount"]

    # Cumulative earnings over time
    date_earnings: Dict[str, float] = defaultdict(float)
    for e in filtered:
        try:
            d = datetime.fromisoformat(e["date"].replace("Z", "+00:00")).strftime("%Y-%m-%d")
        except (ValueError, AttributeError):
            d = "unknown"
        date_earnings[d] += e["amount"]

    sorted_dates = sorted(date_earnings.keys())
    cumulative: List[float] = []
    running = 0.0
    for d in sorted_dates:
        running += date_earnings[d]
        cumulative.append(running)

    # Projections (simple linear extrapolation)
    projected_30d = 0.0
    projected_90d = 0.0
    if len(sorted_dates) >= 2 and cumulative:
        daily_rate = cumulative[-1] / max(len(sorted_dates), 1)
        projected_30d = daily_rate * 30
        projected_90d = daily_rate * 90

    lines: List[str] = [
        f"# Financial Summary — Kimiclaw Agent",
        f"",
        f"**Generated:** {now_iso}  ",
        f"**Initial Capital:** ${config.get('initial_capital', 0.0):.2f}  ",
        f"**Period:** {start.strftime('%Y-%m-%d') if start else 'all time'} to {end.strftime('%Y-%m-%d') if end else 'now'}",
        f"",
        f"---",
        f"",
        f"## Cash Flow Statement",
        f"",
        f"| Category | Amount |",
        f"|---|---|",
        f"| Total Income | +${total_income:.4f} |",
        f"| Total Expenses | -${total_expenses:.4f} |",
        f"| **Net Cash Flow** | **${net_cash_flow:.4f}** |",
        f"| Current Net Profit | ${agent_state.get('net_profit', 0.0):.4f} |",
        f"",
        f"## Revenue by Source",
        f"",
        ascii_pie_chart(dict(source_revenue)),
        f"",
        f"## Cumulative Earnings",
        f"",
    ]

    if cumulative:
        lines.append(ascii_line_chart(
            cumulative,
            labels=sorted_dates,
            title="Cumulative Earnings ($)",
        ))
    else:
        lines.append("*No earnings data available.*")

    lines.extend([
        f"",
        f"## Projections",
        f"",
        f"| Horizon | Projected Earnings |",
        f"|---|---|",
        f"| 30 Days | ${projected_30d:.4f} |",
        f"| 90 Days | ${projected_90d:.4f} |",
        f"",
        f"*Projections based on average daily performance during the reporting period.*",
        f"",
        f"---",
        f"*Generated by Kimiclaw Report Generator*",
    ])

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Report dispatch & output
# ---------------------------------------------------------------------------


def generate_report(
    report_type: str,
    state: Dict[str, Any],
    earnings: List[Dict[str, Any]],
    start: Optional[datetime] = None,
    end: Optional[datetime] = None,
    as_json: bool = False,
) -> str:
    """Dispatch to the appropriate report generator and return the output."""
    generators: Dict[str, Callable[..., str]] = {
        "daily": generate_daily_report,
        "weekly": generate_weekly_report,
        "strategy": generate_strategy_report,
        "financial": generate_financial_report,
    }

    gen_func = generators.get(report_type)
    if not gen_func:
        raise ValueError(f"Unknown report type: {report_type}")

    markdown = gen_func(state, earnings, start, end)

    if as_json:
        # Wrap Markdown in JSON structure
        return json.dumps(
            {
                "report_type": report_type,
                "generated_at": datetime.now(timezone.utc).isoformat(),
                "agent_name": state.get("agent_name", "kimiclaw"),
                "agent_version": state.get("version", "?"),
                "format": "markdown",
                "content": markdown,
            },
            indent=2,
        )

    return markdown


def save_report(
    base_dir: Path,
    report_type: str,
    content: str,
    as_json: bool = False,
) -> Path:
    """Save the report to the reports directory with a dated filename."""
    reports_dir = base_dir / REPORTS_DIR_NAME
    reports_dir.mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now(timezone.utc).strftime("%Y%m%d_%H%M%S")
    ext = "json" if as_json else "md"
    filename = f"{report_type}_report_{timestamp}.{ext}"
    report_path = reports_dir / filename

    report_path.write_text(content, encoding="utf-8")
    logger.info("Report saved: %s", report_path)
    return report_path


# ---------------------------------------------------------------------------
# Period comparison
# ---------------------------------------------------------------------------


def generate_comparison(
    report_type: str,
    state: Dict[str, Any],
    earnings: List[Dict[str, Any]],
    end: datetime,
) -> str:
    """Generate a side-by-side comparison of current vs previous period."""
    # Determine period length from report type
    if report_type == "daily":
        period_days = 1
    elif report_type == "weekly":
        period_days = 7
    else:
        period_days = 7

    current_start = end - timedelta(days=period_days)
    previous_start = current_start - timedelta(days=period_days)
    previous_end = current_start

    current_earnings = filter_by_date_range(earnings, current_start, end)
    previous_earnings = filter_by_date_range(earnings, previous_start, previous_end)

    current_total = sum(e["amount"] for e in current_earnings)
    previous_total = sum(e["amount"] for e in previous_earnings)

    change = current_total - previous_total
    change_pct = (change / (previous_total + 0.0001)) * 100

    arrow = "📈" if change >= 0 else "📉"

    lines = [
        f"## Period Comparison",
        f"",
        f"| Metric | Previous | Current | Change |",
        f"|---|---|---|---|",
        f"| Period | {previous_start.strftime('%Y-%m-%d')} to {previous_end.strftime('%Y-%m-%d')} | "
        f"{current_start.strftime('%Y-%m-%d')} to {end.strftime('%Y-%m-%d')} | — |",
        f"| Earnings | ${previous_total:.4f} | ${current_total:.4f} | "
        f"{arrow} ${change:+.4f} ({change_pct:+.1f}%) |",
        f"",
    ]

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------


def parse_arguments() -> argparse.Namespace:
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(
        description="Generate reports for the Kimiclaw agent",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s --daily                           # Daily Markdown report
  %(prog)s --weekly --json                   # Weekly JSON report
  %(prog)s --strategy --print                # Strategy report to console
  %(prog)s --financial --start 2024-01-01    # Financial report with date range
  %(prog)s --weekly --compare                # Compare with previous week
        """,
    )

    # Report type flags
    parser.add_argument("--daily", action="store_true", help="Generate daily report")
    parser.add_argument("--weekly", action="store_true", help="Generate weekly report")
    parser.add_argument("--strategy", action="store_true", help="Generate strategy performance report")
    parser.add_argument("--financial", action="store_true", help="Generate financial summary")

    # Output options
    parser.add_argument("--json", action="store_true", help="Output as JSON instead of Markdown")
    parser.add_argument("--print", action="store_true", help="Print to console, do not save file")
    parser.add_argument(
        "--base-dir",
        type=Path,
        default=DEFAULT_BASE_DIR,
        help=f"Base directory (default: {DEFAULT_BASE_DIR})",
    )

    # Date range
    parser.add_argument("--start", type=str, help="Start date (YYYY-MM-DD)")
    parser.add_argument("--end", type=str, help="End date (YYYY-MM-DD)")

    # Comparison
    parser.add_argument("--compare", action="store_true", help="Compare with previous period")

    return parser.parse_args()


def main() -> int:
    """Main entry point."""
    args = parse_arguments()
    base_dir: Path = args.base_dir.resolve()

    setup_logging(base_dir)

    # Determine which reports to generate
    report_types: List[str] = []
    if args.daily:
        report_types.append("daily")
    if args.weekly:
        report_types.append("weekly")
    if args.strategy:
        report_types.append("strategy")
    if args.financial:
        report_types.append("financial")

    if not report_types:
        print("Error: No report type specified. Use --daily, --weekly, --strategy, or --financial.",
              file=sys.stderr)
        return 1

    # Parse date range
    start: Optional[datetime] = None
    end: Optional[datetime] = None
    if args.start:
        start = parse_date(args.start)
    if args.end:
        end = parse_date(args.end)

    # Load data
    try:
        state = load_state(base_dir)
    except FileNotFoundError as exc:
        logger.critical("%s", exc)
        print(f"Error: {exc}", file=sys.stderr)
        return 1

    earnings = load_earnings_csv(base_dir)

    # Generate reports
    exit_code = 0
    for report_type in report_types:
        try:
            logger.info("Generating %s report...", report_type)
            content = generate_report(report_type, state, earnings, start, end, as_json=args.json)

            # Add comparison section if requested
            if args.compare:
                compare_end = end or datetime.now(timezone.utc)
                comparison = generate_comparison(report_type, state, earnings, compare_end)
                if args.json:
                    # Parse, append, re-serialize
                    data = json.loads(content)
                    data["content"] = data["content"] + "\n\n" + comparison
                    content = json.dumps(data, indent=2)
                else:
                    content = content + "\n\n" + comparison

            if args.print:
                print(content)
            else:
                report_path = save_report(base_dir, report_type, content, as_json=args.json)
                print(f"Report saved: {report_path}")

            logger.info("%s report generated successfully.", report_type)

        except Exception as exc:
            logger.error("Failed to generate %s report: %s", report_type, exc)
            print(f"Error generating {report_type} report: {exc}", file=sys.stderr)
            exit_code = 1

    return exit_code


if __name__ == "__main__":
    sys.exit(main())
