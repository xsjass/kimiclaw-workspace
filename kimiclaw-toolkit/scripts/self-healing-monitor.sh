#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  SELF-HEALING CRON MONITOR — Detect and Fix Failed Jobs         ║
# ╚══════════════════════════════════════════════════════════════════╝

set -e

LOG_DIR="$HOME/.openclaw/workspace/logs"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
RUN_ID=$(date -u +"%Y%m%d_%H%M%S")

HEALTH_LOG="$LOG_DIR/cron-health_${RUN_ID}.log"

echo "═══════════════════════════════════════════════════════════════"
echo "  SELF-HEALING CRON MONITOR — $TIMESTAMP"
echo "═══════════════════════════════════════════════════════════════"

# Check if cron service is running
if ! pgrep -x "cron" > /dev/null; then
    echo "🔴 CRON SERVICE NOT RUNNING — Restarting..."
    service cron start || systemctl start cron || cron
    echo "✅ Cron service restarted" | tee -a "$HEALTH_LOG"
else
    echo "✅ Cron service running" | tee -a "$HEALTH_LOG"
fi

# Check if autoloop daemon is running
if ! pgrep -f "autoloop.py" > /dev/null; then
    echo "🔴 AUTOLOOP DAEMON NOT RUNNING — Restarting..."
    cd "$HOME/.openclaw/workspace/kimiclaw/scripts"
    nohup python3 autoloop.py --interval 1800 --base-dir "$HOME/.openclaw/workspace/kimiclaw" > /dev/null 2>&1 &
    echo "✅ Autoloop daemon restarted" | tee -a "$HEALTH_LOG"
else
    echo "✅ Autoloop daemon running" | tee -a "$HEALTH_LOG"
fi

# Check disk space
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt 90 ]; then
    echo "🔴 DISK SPACE CRITICAL ($DISK_USAGE%) — Cleaning up..."
    # Clean old logs
    find "$HOME/.openclaw/workspace" -name "*.log" -mtime +7 -delete
    # Clean old content
    find "$HOME/.openclaw/workspace/kimiclaw/content" -name "*.md" -mtime +30 -delete
    echo "✅ Old logs and content cleaned" | tee -a "$HEALTH_LOG"
else
    echo "✅ Disk space OK ($DISK_USAGE%)" | tee -a "$HEALTH_LOG"
fi

# Check memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
if [ "$MEMORY_USAGE" -gt 85 ]; then
    echo "🟡 MEMORY HIGH ($MEMORY_USAGE%) — Monitoring..." | tee -a "$HEALTH_LOG"
else
    echo "✅ Memory OK ($MEMORY_USAGE%)" | tee -a "$HEALTH_LOG"
fi

# Check if GitHub is accessible
if ! curl -s -o /dev/null -w "%{http_code}" https://github.com | grep -q "200"; then
    echo "🟡 GitHub not accessible — Will retry on next cycle" | tee -a "$HEALTH_LOG"
else
    echo "✅ GitHub accessible" | tee -a "$HEALTH_LOG"
fi

# Log health check
MASTER_LOG="$LOG_DIR/cron-health-master.log"
echo "[$TIMESTAMP] Health check complete | Disk: ${DISK_USAGE}% | Memory: ${MEMORY_USAGE}%" >> "$MASTER_LOG"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  HEALTH CHECK COMPLETE"
echo "═══════════════════════════════════════════════════════════════"
