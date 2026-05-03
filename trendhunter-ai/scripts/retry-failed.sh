#!/bin/bash
# Retry failed articles with fixes
API_KEY="$GEMINI_API_KEY"
WORKSPACE="/root/.openclaw/workspace/trendhunter-ai"
SITE="$WORKSPACE/site"

PRODUCTS=(
    "LED Strip Lights for TV Backlight"
    "Mechanical Keyboard with Hot Swappable Switches"
    "Mini Projector for Home Theater"
    "Electric Coffee Grinder with Stainless Steel Blades"
)

for i in "${!PRODUCTS[@]}"; do
    PRODUCT="${PRODUCTS[$i]}"
    TS=$(date +%Y%m%d_%H%M%S)_retry_$i
    
    echo "[$i/4] Retrying: $PRODUCT..."
    
    # Generate article with retry
    PROMPT="Write a comprehensive 1000-word SEO-optimized product review for '${PRODUCT}'. Include: catchy title, intro hook, product overview, 5 key features with benefits, honest pros and cons, who should buy it, price analysis, 3 FAQ questions, and a strong conclusion. Include [AFFILIATE_LINK_1] and [AFFILIATE_LINK_2] placeholders. Write like a trusted friend giving advice."
    
    ARTICLE="$WORKSPACE/content/article_${TS}.md"
    
    # Try up to 3 times
    for attempt in 1 2 3; do
        curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$API_KEY" \
          -H "Content-Type: application/json" \
          -d "{\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"$PROMPT\"}]}],\"generationConfig\":{\"temperature\":0.7,\"maxOutputTokens\":3000}}" 2>/dev/null | jq -r '.candidates[0].content.parts[0].text' > "$ARTICLE"
        
        SIZE=$(wc -c < "$ARTICLE" 2>/dev/null || echo 0)
        if [ "$SIZE" -gt 1000 ]; then
            echo "  ✅ Article on attempt $attempt: $SIZE bytes"
            break
        fi
        echo "  ⚠️ Attempt $attempt failed ($SIZE bytes), retrying..."
        sleep 5
    done
    
    if [ "$SIZE" -lt 1000 ]; then
        echo "  ❌ All attempts failed — skipping"
        continue
    fi
    
    # Build HTML
    SLUG=$(echo "$PRODUCT" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
    HTML="$SITE/${SLUG}-${TS}.html"
    
    ARTICLE_HTML=$(cat "$ARTICLE" | \
        sed 's/^# \(.*\)/<h1>\1<\/h1>/' | \
        sed 's/^## \(.*\)/<h2>\1<\/h2>/' | \
        sed 's/^### \(.*\)/<h3>\1<\/h3>/' | \
        sed 's/^\* \*\*\([^*]*\)\*\*/<li><strong>\1<\/strong>/' | \
        sed 's/^\* \(.*\)/<li>\1<\/li>/' | \
        sed 's/\*\*\([^*]*\)\*\*/<strong>\1<\/strong>/g' | \
        sed 's/\*\([^*]*\)\*/<em>\1<\/em>/g' | \
        sed "s/\[AFFILIATE_LINK_1\]/<div class=\"cta-box\"><a href=\"https:\/\/amazon.com\/s?k=$SLUG\" target=\"_blank\">🛒 Check Latest Price on Amazon<\/a><\/div>/g" | \
        sed "s/\[AFFILIATE_LINK_2\]/<div class=\"cta-box\"><a href=\"https:\/\/amazon.com\/s?k=$SLUG\" target=\"_blank\">📦 See All Available Options<\/a><\/div>/g")
    
    cat > "$HTML" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${PRODUCT} Review 2026 | TrendHunter AI</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f8f9fa; color: #333; line-height: 1.7; }
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 40px 20px; text-align: center; border-radius: 0 0 20px 20px; margin-bottom: 30px; }
        .article { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .article h1 { color: #1a73e8; margin-bottom: 20px; }
        .article h2 { color: #333; margin: 30px 0 15px; font-size: 1.5em; }
        .article h3 { color: #444; margin: 25px 0 12px; font-size: 1.2em; }
        .article p { margin: 15px 0; }
        .article ul { margin: 15px 0; padding-left: 25px; }
        .article li { margin: 10px 0; }
        .article strong { color: #1a73e8; }
        .cta-box { background: linear-gradient(135deg, #ff6b6b 0%, #ee5a5a 100%); color: white; padding: 25px; border-radius: 12px; text-align: center; margin: 30px 0; }
        .cta-box a { display: inline-block; background: white; color: #ff6b6b; padding: 15px 35px; text-decoration: none; border-radius: 50px; font-weight: bold; font-size: 1.1em; }
        .disclaimer { font-size: 13px; color: #666; margin-top: 40px; padding-top: 20px; border-top: 2px solid #eee; }
        .nav { display: flex; justify-content: center; gap: 20px; margin-bottom: 20px; }
        .nav a { color: #1a73e8; text-decoration: none; font-weight: 500; }
        .product-img { width: 100%; max-width: 600px; margin: 20px auto; display: block; border-radius: 12px; }
        footer { text-align: center; margin-top: 40px; color: #666; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔥 TrendHunter AI</h1>
        <p>Discover trending products before they go mainstream</p>
    </div>
    <div class="container">
        <div class="nav">
            <a href="index.html">← Home</a>
            <a href="index.html">All Reviews</a>
        </div>
        <div class="article">
            <img src="product-${TS}.jpg" alt="${PRODUCT}" class="product-img">
            $ARTICLE_HTML
            <div class="disclaimer">
                <p><strong>Disclosure:</strong> This review contains affiliate links. We may earn a commission at no extra cost to you.</p>
                <p>© 2026 TrendHunter AI | Built by Kimiclaw 🤖 | <a href="index.html">Home</a></p>
            </div>
        </div>
        <footer>
            <p>📧 Want weekly trend reports? <a href="mailto:kimiclaw8@gmail.com">kimiclaw8@gmail.com</a></p>
        </footer>
    </div>
</body>
</html>
EOF
    
    # Generate image
    IMG="$SITE/product-${TS}.jpg"
    curl -s -L "https://image.pollinations.ai/prompt/$(echo "$PRODUCT" | sed 's/ /%20/g')%20product%20photo%20professional%20white%20background?width=800&height=600&seed=${RANDOM}&nologo=true" -o "$IMG" 2>/dev/null
    
    echo "  ✅ Built: $HTML"
    sleep 3
done

echo "Retry batch complete!"
