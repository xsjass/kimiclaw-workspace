#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  DAILY VIRALOOP CRON — Runs every day at 9AM                     ║
# ║  Auto-posts 1 carousel to TikTok + Instagram                      ║
# ╚══════════════════════════════════════════════════════════════════╝

# Load credentials
source /root/.openclaw/workspace/.env.viraloop 2>/dev/null || {
    echo "❌ .env.viraloop not found. Run ./scripts/viraloop-setup.sh first"
    exit 1
}

# Rotate hook types for variety
HOOK_TYPES=(shock curiosity contradiction)
DAY_OF_WEEK=$(date +%w)
HOOK_TYPE=${HOOK_TYPES[$((DAY_OF_WEEK % 3))]}

# Randomize posting time slightly (9:00-9:15)
SLEEP_TIME=$((RANDOM % 900))
sleep $SLEEP_TIME

# Run master script
/root/.openclaw/workspace/scripts/viraloop-master.sh \
    https://beatsheaven.com \
    "$HOOK_TYPE" \
    >> /root/.openclaw/workspace/logs/viraloop-daily.log 2>&1

# Log completion
echo "[$(date)] Daily viraloop complete: hook=$HOOK_TYPE" >> /root/.openclaw/workspace/logs/viraloop-daily.log
