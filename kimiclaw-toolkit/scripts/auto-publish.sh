#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  AUTO-PUBLISH MODULE — Publish Generated Content to Social      ║
# ╚══════════════════════════════════════════════════════════════════╝
# Takes content from toolkit outputs and formats it for publishing

set -e

TOOLKIT_DIR="${TOOLKIT_DIR:-$HOME/.openclaw/workspace/kimiclaw-toolkit}"
PUBLISH_DIR="$TOOLKIT_DIR/publish-queue"
mkdir -p "$PUBLISH_DIR"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
RUN_ID=$(date -u +"%Y%m%d_%H%M%S")

echo "═══════════════════════════════════════════════════════════════"
echo "  AUTO-PUBLISH MODULE — $TIMESTAMP"
echo "═══════════════════════════════════════════════════════════════"

# Find the most recent outputs
LATEST_ARTICLE=$(ls -1 "$TOOLKIT_DIR/outputs/article_"*.md 2>/dev/null | tail -1)
LATEST_SOCIAL=$(ls -1 "$TOOLKIT_DIR/outputs/social_"*.md 2>/dev/null | tail -1)

if [ -z "$LATEST_ARTICLE" ] || [ -z "$LATEST_SOCIAL" ]; then
    echo "❌ No content found to publish. Run toolkit first."
    exit 1
fi

# Extract article title and first paragraph for preview
ARTICLE_TITLE=$(head -1 "$LATEST_ARTICLE" | sed 's/^# //')
ARTICLE_PREVIEW=$(sed -n '6,10p' "$LATEST_ARTICLE" | head -c 200)

# Extract Twitter thread from social pack
TWITTER_THREAD=$(sed -n '/## Twitter\/X Thread/,/## LinkedIn Post/p' "$LATEST_SOCIAL" | grep -v "## LinkedIn Post")

# Extract Instagram caption
INSTAGRAM_CAPTION=$(sed -n '/## Instagram Caption/,/## Twitter\/X Thread/p' "$LATEST_SOCIAL" | grep -v "## Twitter")

# Create publishable formats

# 1. Twitter Thread (formatted for copy-paste)
TWITTER_FILE="$PUBLISH_DIR/twitter_${RUN_ID}.txt"
cat > "$TWITTER_FILE" << EOF
TWITTER THREAD — Ready to Publish
=====================================

$TWITTER_THREAD

=====================================
Copy-paste each tweet individually.
Add thread emoji (🧵) to first tweet.
Post 1 tweet every 5-10 minutes.
=====================================
EOF

echo "✅ Twitter thread ready: $TWITTER_FILE"

# 2. Instagram Post (formatted for copy-paste)
INSTAGRAM_FILE="$PUBLISH_DIR/instagram_${RUN_ID}.txt"
cat > "$INSTAGRAM_FILE" << EOF
INSTAGRAM POST — Ready to Publish
=====================================

$INSTAGRAM_CAPTION

=====================================
Recommended: Add carousel images (5 slides)
Slide 1: Hook text on solid background
Slide 2-4: Key points from article
Slide 5: CTA + "Link in bio"
=====================================
EOF

echo "✅ Instagram post ready: $INSTAGRAM_FILE"

# 3. Blog Post (formatted for Medium/Hashnode/Dev.to)
BLOG_FILE="$PUBLISH_DIR/blog_${RUN_ID}.md"
cp "$LATEST_ARTICLE" "$BLOG_FILE"
echo "" >> "$BLOG_FILE"
echo "---" >> "$BLOG_FILE"
echo "" >> "$BLOG_FILE"
echo "*Originally published on [your blog]. Follow me for more marketing automation tips.*" >> "$BLOG_FILE"
echo "" >> "$BLOG_FILE"
echo "**Want the complete toolkit?** Get it free at https://github.com/xsjass/kimiclaw-workspace" >> "$BLOG_FILE"

echo "✅ Blog post ready: $BLOG_FILE"

# 4. Reddit Post (formatted for r/entrepreneur or niche subreddit)
REDDIT_FILE="$PUBLISH_DIR/reddit_${RUN_ID}.txt"
cat > "$REDDIT_FILE" << EOF
REDDIT POST — Ready to Publish
=====================================

[${ARTICLE_TITLE} — Complete Guide]

${ARTICLE_PREVIEW}

**Full guide here:** [your blog link]

**Tools I used:**
- Kimiclaw Toolkit (free, open source)
- Mailchimp (email)
- Canva (design)

**Results after 30 days:**
- [X] followers gained
- [X] email subscribers
- $[X] revenue generated

Questions? Ask in comments!

=====================================
Post to: r/entrepreneur, r/marketing, or niche subreddit
Best time: Tuesday-Thursday, 9-11 AM EST
=====================================
EOF

echo "✅ Reddit post ready: $REDDIT_FILE"

# 5. Email Newsletter (formatted for Mailchimp/ConvertKit)
EMAIL_FILE="$PUBLISH_DIR/email_${RUN_ID}.html"
cat > "$EMAIL_FILE" << EOF
<!DOCTYPE html>
<html>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <h1 style="color: #1a1a2e;">${ARTICLE_TITLE}</h1>
    
    <p>Hey [First Name],</p>
    
    <p>${ARTICLE_PREVIEW}...</p>
    
    <p><strong>In this week's guide:</strong></p>
    
    <ul>
        <li>The exact strategy I used</li>
        <li>Tools that make it automatic</li>
        <li>Results after 30 days</li>
    </ul>
    
    <p><a href="[your blog link]" style="display: inline-block; background: #00d4aa; color: #0a0a0a; padding: 15px 30px; text-decoration: none; border-radius: 5px; font-weight: bold;">READ THE FULL GUIDE →</a></p>
    
    <hr style="border: none; border-top: 1px solid #eee; margin: 30px 0;">
    
    <p style="font-size: 0.9rem; color: #666;">
        Want more automation tips? <a href="https://github.com/xsjass/kimiclaw-workspace">Get the free toolkit</a>.
    </p>
    
</body>
</html>
EOF

echo "✅ Email newsletter ready: $EMAIL_FILE"

# Summary
MASTER_LOG="$TOOLKIT_DIR/logs/publish_activity.log"
echo "[$TIMESTAMP] Publish batch $RUN_ID | 5 formats ready" >> "$MASTER_LOG"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  AUTO-PUBLISH COMPLETE"
echo "═══════════════════════════════════════════════════════════════"
echo "  Queue:"
echo "    🐦 Twitter Thread:   publish-queue/twitter_${RUN_ID}.txt"
echo "    📸 Instagram Post:   publish-queue/instagram_${RUN_ID}.txt"
echo "    📝 Blog Post:        publish-queue/blog_${RUN_ID}.md"
echo "    🔴 Reddit Post:      publish-queue/reddit_${RUN_ID}.txt"
echo "    ✉️ Email Newsletter:  publish-queue/email_${RUN_ID}.html"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "NEXT: Copy-paste to platforms or integrate with APIs"
