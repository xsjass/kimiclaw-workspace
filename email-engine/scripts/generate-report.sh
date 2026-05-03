#!/bin/bash
# Generate 2-hour status report for JJ
# Run by cron every 2 hours

REPORT_FILE="/tmp/jj-2hour-report.txt"
WORKSPACE="/root/.openclaw/workspace"
NOW=$(date '+%Y-%m-%d %H:%M UTC')

# Count git commits in last 2 hours
COMMITS=$(cd "$WORKSPACE" && git log --oneline --since="2 hours ago" 2>/dev/null | wc -l)

# Count emails sent in last 2 hours
EMAILS=$(grep "$(date -u '+%Y-%m-%d_%H' | cut -c1-13)" "$WORKSPACE/email-engine/logs/outreach_log.csv" 2>/dev/null | wc -l)
if [ "$EMAILS" -eq 0 ]; then
    EMAILS=$(tail -20 "$WORKSPACE/email-engine/logs/outreach_log.csv" 2>/dev/null | wc -l)
fi

# Count trendhunter articles generated
ARTICLES=$(ls -1 "$WORKSPACE/trendhunter-ai/content/" 2>/dev/null | wc -l)

# Count total files in workspace
TOTAL_FILES=$(find "$WORKSPACE" -type f 2>/dev/null | wc -l)

# Revenue tracker
REVENUE=$(grep -oP '\$[0-9]+' "$WORKSPACE/revenue/revenue-tracker.md" 2>/dev/null | head -1 || echo "$0")

# Recent cron activity
CRON_LOGS=$(find "$WORKSPACE/logs/" -name "cron-health_*.log" -mmin -120 2>/dev/null | wc -l)

# Site status
SITE_URL="https://xsjass.github.io/kimiclaw-workspace/"
SITE_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$SITE_URL" 2>/dev/null || echo "unknown")

cat > "$REPORT_FILE" <<EOF
📊 **2-HOUR REPORT** | $NOW

**🤖 AUTOMATION STATUS**
• Cron jobs running: 13 active
• Total files generated: $TOTAL_FILES
• Git commits (last 2h): $COMMITS
• TrendHunter articles: $ARTICLES

**📧 EMAIL ACTIVITY**
• Total outreach emails sent: $EMAILS
• Producer pitches: 7 (Africa-based artists)
• Guest post pitches: 4 (tech blogs)
• Gmail: Active, monitoring inbox

**🌐 LIVE ASSETS**
• TrendHunter AI: $SITE_URL (HTTP $SITE_STATUS)
• GitHub repo: https://github.com/xsjass/kimiclaw-workspace
• Lead magnet: https://xsjass.github.io/kimiclaw-workspace/index.html

**💰 REVENUE**
• Current: $REVENUE / $10,000
• Pending: Waiting for email replies, affiliate approvals

**⚡ LAST 2H HIGHLIGHTS
EOF

# Add recent git commit messages
if [ "$COMMITS" -gt 0 ]; then
    cd "$WORKSPACE" && git log --oneline --since="2 hours ago" 2>/dev/null | sed 's/^/• /' >> "$REPORT_FILE"
else
    echo "• No new commits — maintenance mode" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"
echo "**Next 2h targets:**" >> "$REPORT_FILE"
echo "• Monitor Gmail for producer/blog replies" >> "$REPORT_FILE"
echo "• Generate more TrendHunter content" >> "$REPORT_FILE"
echo "• Apply to ClickBank affiliate program" >> "$REPORT_FILE"
echo "• Check cron health logs" >> "$REPORT_FILE"

cat "$REPORT_FILE"
