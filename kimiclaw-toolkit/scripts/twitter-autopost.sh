#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  TWITTER AUTO-POST MODULE — Publish via Upload-Post API          ║
# ╚══════════════════════════════════════════════════════════════════╝

set -e

TOOLKIT_DIR="${TOOLKIT_DIR:-$HOME/.openclaw/workspace/kimiclaw-toolkit}"
PUBLISH_DIR="$TOOLKIT_DIR/publish-queue"
mkdir -p "$PUBLISH_DIR"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
RUN_ID=$(date -u +"%Y%m%d_%H%M%S")

echo "═══════════════════════════════════════════════════════════════"
echo "  TWITTER AUTO-POST MODULE — $TIMESTAMP"
echo "═══════════════════════════════════════════════════════════════"

# Check for Upload-Post API key
if [ -f "$HOME/.openclaw/workspace/.env.viraloop" ]; then
    source "$HOME/.openclaw/workspace/.env.viraloop"
fi

if [ -z "$UPLOADPOST_TOKEN" ]; then
    echo "❌ No UPLOADPOST_TOKEN found. Skipping auto-publish."
    echo "   Set it in ~/.openclaw/workspace/.env.viraloop"
    exit 1
fi

# Find the most recent Twitter thread
LATEST_TWITTER=$(ls -1 "$PUBLISH_DIR/twitter_"*.txt 2>/dev/null | tail -1)
LATEST_IMAGE=$(ls -1 "$PUBLISH_DIR/image_"*.jpg 2>/dev/null | tail -1)

if [ -z "$LATEST_TWITTER" ]; then
    echo "❌ No Twitter content found. Run auto-publish first."
    exit 1
fi

# Extract tweets (lines starting with numbers like 1/, 2/, etc.)
TWEETS=$(grep "^[0-9]/" "$LATEST_TWITTER" | head -5)

if [ -z "$TWEETS" ]; then
    # Try alternate format (lines starting with numbers like 1., 2., etc.)
    TWEETS=$(grep "^[0-9]\." "$LATEST_TWITTER" | head -5)
fi

if [ -z "$TWEETS" ]; then
    echo "❌ No formatted tweets found in $LATEST_TWITTER"
    exit 1
fi

echo "🐦 Posting Twitter thread..."
echo "   Content: $(echo "$TWEETS" | head -1 | cut -c1-50)..."

# Post first tweet with image if available
FIRST_TWEET=$(echo "$TWEETS" | head -1 | sed 's/^[0-9]\/. //; s/^[0-9]\. //')

if [ -n "$LATEST_IMAGE" ] && [ -f "$LATEST_IMAGE" ]; then
    echo "   With image: $LATEST_IMAGE"
    # Upload image first, then tweet with media
    # Note: Upload-Post API would handle this
fi

# For now, log what would be posted
POST_LOG="$TOOLKIT_DIR/logs/twitter_posts.log"
echo "[$TIMESTAMP] Would post: ${FIRST_TWEET:0:100}..." >> "$POST_LOG"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  TWITTER AUTO-POST LOGGED"
echo "═══════════════════════════════════════════════════════════════"
echo "  Status: Ready for Upload-Post API integration"
echo "  Content: $LATEST_TWITTER"
echo "  Image: ${LATEST_IMAGE:-None}"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "NEXT: Full API integration when Upload-Post supports Twitter threads"
