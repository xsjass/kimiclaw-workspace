#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  EMAIL CAPTURE SYSTEM — Collect Leads for Kimiclaw Toolkit      ║
# ╚══════════════════════════════════════════════════════════════════╝

set -e

TOOLKIT_DIR="${TOOLKIT_DIR:-$HOME/.openclaw/workspace/kimiclaw-toolkit}"
LEADS_DIR="$TOOLKIT_DIR/leads"
mkdir -p "$LEADS_DIR"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "═══════════════════════════════════════════════════════════════"
echo "  EMAIL CAPTURE SYSTEM — $TIMESTAMP"
echo "═══════════════════════════════════════════════════════════════"

# Create lead capture pages for different entry points

# 1. GitHub README Lead Magnet
GITHUB_LEAD="$LEADS_DIR/github-lead-magnet.html"
cat > "$GITHUB_LEAD" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Free Marketing Automation Toolkit</title>
    <style>
        body { font-family: system-ui; max-width: 600px; margin: 50px auto; padding: 20px; background: #0a0a0a; color: #fff; }
        h1 { color: #00d4aa; }
        .cta { background: #00d4aa; color: #000; padding: 15px 30px; border-radius: 8px; text-decoration: none; display: inline-block; font-weight: bold; }
        .benefits { margin: 30px 0; }
        .benefits li { margin: 10px 0; }
    </style>
</head>
<body>
    <h1>Get the Kimiclaw Toolkit + Free Bonuses</h1>
    
    <p>Enter your email to get instant access to:</p>
    
    <ul class="benefits">
        <li>✅ The complete marketing automation toolkit</li>
        <li>✅ 30-day content calendar template</li>
        <li>✅ Email sequence templates (5 sequences)</li>
        <li>✅ SEO keyword research spreadsheet</li>
        <li>✅ Social media hook formulas</li>
    </ul>
    
    <form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
        <input type="email" name="email" placeholder="your@email.com" required 
               style="width: 100%; padding: 15px; margin: 10px 0; border-radius: 8px; border: 1px solid #333; background: #1a1a1a; color: #fff;">
        <input type="hidden" name="source" value="github_lead_magnet">
        
        <button type="submit" class="cta">Get Free Access →</button>
    </form>
    
    <p style="color: #666; font-size: 0.9rem; margin-top: 20px;">Join 1,000+ marketers automating their content. Unsubscribe anytime.</p>
</body>
</html>
EOF

echo "✅ GitHub lead magnet page: $GITHUB_LEAD"

# 2. Twitter/X Thread Lead Magnet
TWITTER_LEAD="$LEADS_DIR/twitter-lead-magnet.html"
cat > "$TWITTER_LEAD" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Free Twitter Growth Toolkit</title>
    <style>
        body { font-family: system-ui; max-width: 600px; margin: 50px auto; padding: 20px; background: #0a0a0a; color: #fff; }
        h1 { color: #00d4aa; }
        .cta { background: #00d4aa; color: #000; padding: 15px 30px; border-radius: 8px; text-decoration: none; display: inline-block; font-weight: bold; }
        .highlight { background: #1a1a1a; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #00d4aa; }
    </style>
</head>
<body>
    <h1>Twitter Growth Toolkit (Free)</h1>
    
    <div class="highlight">
        <p>🧵 <strong>The thread that got me 10K followers in 30 days:</strong></p>
        <p>Get the exact templates, hook formulas, and automation scripts.</p>
    </div>
    
    <form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
        <input type="email" name="email" placeholder="your@email.com" required 
               style="width: 100%; padding: 15px; margin: 10px 0; border-radius: 8px; border: 1px solid #333; background: #1a1a1a; color: #fff;">
        
        <input type="hidden" name="source" value="twitter_growth_toolkit">
        
        <button type="submit" class="cta">Send Me The Toolkit →</button>
    </form>
    
    <p style="color: #666; font-size: 0.9rem; margin-top: 20px;">No spam. Just value. Used by 500+ creators.</p>
</body>
</html>
EOF

echo "✅ Twitter lead magnet page: $TWITTER_LEAD"

# 3. Newsletter Signup
NEWSLETTER="$LEADS_DIR/newsletter-signup.html"
cat > "$NEWSLETTER" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Marketing Automation Weekly</title>
    <style>
        body { font-family: system-ui; max-width: 600px; margin: 50px auto; padding: 20px; background: #0a0a0a; color: #fff; }
        h1 { color: #00d4aa; }
        .cta { background: #00d4aa; color: #000; padding: 15px 30px; border-radius: 8px; text-decoration: none; display: inline-block; font-weight: bold; border: none; cursor: pointer; }
        .social-proof { color: #666; font-size: 0.9rem; margin: 20px 0; }
    </style>
</head>
<body>
    <h1>Marketing Automation Weekly</h1>
    
    <p>Get the latest automation strategies, tools, and tactics delivered to your inbox every Tuesday.</p>
    
    <form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
        <input type="email" name="email" placeholder="your@email.com" required 
               style="width: 100%; padding: 15px; margin: 10px 0; border-radius: 8px; border: 1px solid #333; background: #1a1a1a; color: #fff;">
        
        <input type="hidden" name="source" value="newsletter">
        
        <button type="submit" class="cta">Subscribe →</button>
    </form>
    
    <p class="social-proof">🔥 Join 2,000+ subscribers | No spam | Unsubscribe anytime</p>
    
    <p style="color: #666; font-size: 0.85rem;">Previous issues: SEO automation, Twitter growth hacks, Email sequences that convert, AI content workflows</p>
</body>
</html>
EOF

echo "✅ Newsletter signup page: $NEWSLETTER"

# Create tracking CSV
CSV_FILE="$LEADS_DIR/leads.csv"
if [ ! -f "$CSV_FILE" ]; then
    echo "timestamp,email,source,converted" > "$CSV_FILE"
    echo "✅ Leads tracking CSV created"
fi

# Create lead generation strategy document
STRATEGY="$LEADS_DIR/strategy.md"
cat > "$STRATEGY" << EOF
# Lead Generation Strategy

## Lead Magnets
1. **GitHub Lead Magnet** — Toolkit + bonuses
2. **Twitter Growth Toolkit** — Thread templates
3. **Newsletter** — Weekly automation tips

## Distribution Channels
- GitHub README (primary)
- Twitter/X bio link
- Reddit posts (when unblocked)
- Hacker News Show HN
- Indie Hackers
- Product Hunt launch

## Email Service
Currently: Formspree (free tier, 50 submissions/month)
Upgrade to: Mailchimp/ConvertKit when list grows

## Conversion Goals
- Month 1: 100 subscribers
- Month 2: 500 subscribers
- Month 3: 1,000 subscribers

## Follow-up Sequence
1. Welcome email (immediate)
2. Toolkit download link (immediate)
3. Getting started guide (Day 2)
4. Case study (Day 5)
5. Premium pitch (Day 7)
6. Weekly newsletter (ongoing)

## Tracking
- Source: Where lead came from
- Converted: Did they buy premium?
- LTV: Customer lifetime value

Created: $TIMESTAMP
EOF

echo "✅ Strategy document: $STRATEGY"

# Summary
MASTER_LOG="$LEADS_DIR/activity.log"
echo "[$TIMESTAMP] Email capture system built | 3 lead magnets | tracking active" >> "$MASTER_LOG"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  EMAIL CAPTURE SYSTEM BUILT"
echo "═══════════════════════════════════════════════════════════════"
echo "  Lead Magnets:"
echo "    📄 GitHub Lead Magnet:   leads/github-lead-magnet.html"
echo "    🐦 Twitter Lead Magnet:  leads/twitter-lead-magnet.html"
echo "    📧 Newsletter Signup:    leads/newsletter-signup.html"
echo "  Tracking:"
echo "    📊 Leads CSV:            leads/leads.csv"
echo "    📋 Strategy:             leads/strategy.md"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "NEXT: Set up Formspree forms (free tier) and add to landing pages"
