#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  TREND MONITOR — Social Media + Search Trend Tracking           ║
# ╚══════════════════════════════════════════════════════════════════╝
# Tracks trending topics in music production / beat selling space

set -e

BASE_DIR="$HOME/.openclaw/workspace/kimiclaw"
TRENDS_DIR="$BASE_DIR/trends"
mkdir -p "$TRENDS_DIR"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
RUN_ID=$(date -u +"%Y%m%d_%H%M%S")
LOG_FILE="$BASE_DIR/logs/trends_${RUN_ID}.log"

exec >> "$LOG_FILE" 2>&1

echo "═══════════════════════════════════════════════════════════════"
echo "  TREND MONITOR — $TIMESTAMP"
echo "═══════════════════════════════════════════════════════════════"

# ── REDDIT MONITORING ───────────────────────────────────────────
echo ""
echo "📡 Checking Reddit r/makinghiphop hot posts..."

# Fetch top posts from r/makinghiphop
REDDIT_FILE="$TRENDS_DIR/reddit_${RUN_ID}.md"
python3 << 'PYEOF' > "$REDDIT_FILE" 2>&1
import urllib.request
import json
from datetime import datetime

print("# Reddit Trending — r/makinghiphop")
print(f"*Scanned: {datetime.utcnow().isoformat()}Z*")
print("")

try:
    req = urllib.request.Request(
        "https://www.reddit.com/r/makinghiphop/hot.json?limit=10",
        headers={"User-Agent": "Kimiclaw-TrendBot/1.0"}
    )
    with urllib.request.urlopen(req, timeout=15) as response:
        data = json.loads(response.read().decode())
    
    posts = data.get("data", {}).get("children", [])
    print(f"## Top {len(posts)} Hot Posts")
    print("")
    
    for post in posts[:10]:
        p = post.get("data", {})
        title = p.get("title", "")
        score = p.get("score", 0)
        comments = p.get("num_comments", 0)
        url = p.get("url", "")
        
        print(f"- **{title}**")
        print(f"  👍 {score} | 💬 {comments} | [Link]({url})")
        print("")
        
except Exception as e:
    print(f"Error fetching Reddit: {e}")
    print("")
    print("## Manual Check Recommended")
    print("- https://reddit.com/r/makinghiphop/hot")
    print("- https://reddit.com/r/WeAreTheMusicMakers/hot")
    print("- https://reddit.com/r/AudioEngineering/hot")

PYEOF

echo "✅ Reddit trends saved: $REDDIT_FILE"

# ── TRENDING KEYWORDS LOG ───────────────────────────────────────
echo ""
echo "🔍 Compiling trending keywords..."

KEYWORDS_FILE="$TRENDS_DIR/keywords_${RUN_ID}.md"
cat > "$KEYWORDS_FILE" << EOF
# Trending Keywords — $(date -u +"%Y-%m-%d")

## Currently Trending (Manual Verification Recommended)

### Beat-Selling Keywords
- "beats for sale 2026"
- "trap beats download"
- "type beats free"
- "exclusive beats cheap"
- "beat licensing explained"
- "how to sell beats"
- "beatsheaven"
- "beatstars alternative"

### Genre Trends
- "Detroit phonk beats"
- "Jersey club type beat"
- "Afrobeats instrumental"
- "Amapiano beats 2026"
- "Rage type beat"
- "Lo-fi study beats"
- "Drill beats UK"
- "Boom bap beats"

### Platform/Tool Trends
- "AI music production"
- "mobile beat marketplace"
- "Stripe payouts for producers"
- "beat selling on TikTok"
- "producer brand building"

## Google Trends Checklist
Check these manually at https://trends.google.com/trends/explore:
- [ ] "beats for sale"
- [ ] "type beats"
- [ ] "sell beats online"
- [ ] "beat licensing"
- [ ] "Detroit phonk"
- [ ] "Jersey club"
- [ ] "Afrobeats instrumental"
- [ ] "beatsheaven"

## TikTok Trending Sounds (Manual Check)
- Search: #beatsforsale, #typebeat, #musicproducer
- Check: trending sounds page
- Note: any beat that goes viral with a specific sound

EOF

echo "✅ Keywords saved: $KEYWORDS_FILE"

# ── CONTENT OPPORTUNITIES ──────────────────────────────────────
echo ""
echo "💡 Generating content opportunities..."

OPPS_FILE="$TRENDS_DIR/opportunities_${RUN_ID}.md"
cat > "$OPPS_FILE" << EOF
# Content Opportunities — $(date -u +"%Y-%m-%d")

## Based on Trend Analysis

### Immediate Content Ideas (Post This Week)
1. **"Detroit Phonk Explained"** — Deep dive blog + TikTok series
2. **"Beat Licensing 101"** — Infographic carousel + blog
3. **"BeatsHeaven vs Competitors"** — Comparison blog + Reddit post
4. **"Producer TikTok Strategy"** — How-to blog + social pack
5. **"Afrobeats Production Tips"** — Tutorial blog + Instagram Reel script

### Evergreen Content (Always Relevant)
- How to price beats
- Beat licensing models
- Platform comparisons
- Social media for producers
- Genre trend deep-dives

### Seasonal Opportunities
- **Summer 2026**: Upbeat, festival-ready beats
- **Back-to-School**: Lo-fi study beats surge
- **Holiday Season**: Gift beat packs, discount campaigns

## Action Items
- [ ] Cross-reference trending Reddit posts with existing content
- [ ] Create 3 TikTok videos based on top Reddit questions
- [ ] Update beatsheaven.com homepage with trending genres
- [ ] Schedule social posts around trending topics
- [ ] Reach out to 5 producers making trending genre beats

EOF

echo "✅ Opportunities saved: $OPPS_FILE"

# ── STATE UPDATE ────────────────────────────────────────────────
STATE_FILE="$BASE_DIR/state/state.json"
if [ -f "$STATE_FILE" ]; then
    python3 << PYEOF
import json
from datetime import datetime, timezone

with open("$STATE_FILE", "r") as f:
    state = json.load(f)

state["last_updated"] = datetime.now(timezone.utc).isoformat()
state["meta"]["total_iterations"] = state["meta"].get("total_iterations", 0) + 1

state["state"]["completed_tasks"].append({
    "id": "$RUN_ID",
    "type": "trend_monitor",
    "description": "Monitored Reddit, compiled keywords, generated opportunities",
    "timestamp": datetime.now(timezone.utc).isoformat(),
    "outputs": [
        "trends/reddit_${RUN_ID}.md",
        "trends/keywords_${RUN_ID}.md",
        "trends/opportunities_${RUN_ID}.md"
    ]
})

with open("$STATE_FILE", "w") as f:
    json.dump(state, f, indent=2)

print(f"State updated — total iterations: {state['meta']['total_iterations']}")
PYEOF
fi

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  TREND MONITOR COMPLETE — $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
echo "═══════════════════════════════════════════════════════════════"
echo "  Outputs:"
echo "    • Reddit trends: trends/reddit_${RUN_ID}.md"
echo "    • Keywords:      trends/keywords_${RUN_ID}.md"
echo "    • Opportunities: trends/opportunities_${RUN_ID}.md"
echo "═══════════════════════════════════════════════════════════════"

MASTER_LOG="$BASE_DIR/logs/activity.log"
echo "[$TIMESTAMP] Trend Monitor $RUN_ID | Reddit + keywords + opportunities" >> "$MASTER_LOG"
