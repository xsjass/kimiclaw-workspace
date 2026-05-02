#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  TEXT-ONLY VIRALOOP — Carousel Content Without AI Images         ║
# ║  Generates text-based carousel slides that perform on social    ║
# ╚══════════════════════════════════════════════════════════════════╝
# Works without Gemini API key — uses text/typography-based content

set -e

# Source credentials if available
if [ -f "$HOME/.openclaw/workspace/.env.viraloop" ]; then
    source "$HOME/.openclaw/workspace/.env.viraloop"
fi

OUTPUT_DIR="${OUTPUT_DIR:-$HOME/.openclaw/workspace/viraloop-output}"
mkdir -p "$OUTPUT_DIR/carousels"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
RUN_ID=$(date -u +"%Y%m%d_%H%M%S")_$(shuf -i 1000-9999 -n 1)

# ── HOOK ROTATION (7 types, rotates daily) ─────────────────────
HOOKS=(
    "SHOCK"
    "CURIOSITY"
    "CONTRADICTION"
    "SHOCK"
    "CURIOSITY"
    "CONTRADICTION"
    "STORY"
)
DAY_OF_WEEK=$(date +%u)
HOOK="${HOOKS[$((DAY_OF_WEEK - 1))]}"

# ── CAROUSEL TOPICS (Music Production / Beat Selling) ────────────
# Each topic generates a 5-slide text carousel

declare -A CAROUSELS

CAROUSELS[0]="5 Beat Pricing Mistakes That Cost Producers Thousands"
CAROUSELS[1]="3 Platforms That Take 30% of Your Beat Sales (And 1 That Doesn't)"
CAROUSELS[2]="The Real Reason Artists Aren't Buying Your Beats"
CAROUSELS[3]="From \$0 to \$10K/Month Selling Beats: The Exact Timeline"
CAROUSELS[4]="5 Things Producers Do That Scare Buyers Away"
CAROUSELS[5]="Why Your Beats Sound Good But Don't Sell"
CAROUSELS[6]="The \$0 Marketing Strategy That Got Me 500 Beat Sales"
CAROUSELS[7]="BeatStars vs Airbit vs BeatsHeaven: The Fee Breakdown"
CAROUSELS[8]="3 Licensing Models Explained (So You Never Get Sued)"
CAROUSELS[9]="Why Mobile-First Beat Marketplaces Are Winning in 2026"
CAROUSELS[10]="The Trap Beat Producer's Secret Weapon: This One Technique"
CAROUSELS[11]="5 Red Flags That Tell Artists Your Beats Are Amateur"
CAROUSELS[12]="How to Write Beat Descriptions That Actually Convert"
CAROUSELS[13]="The \$14.99/Month Tool That Doubled My Beat Income"
CAROUSELS[14]="Why Instant License Delivery Matters (More Than You Think)"
CAROUSELS[15]="3 TikTok Strategies That Drive Beat Sales (Not Views)"
CAROUSELS[16]="The Afrobeats Boom: How Producers Are Cashing In"
CAROUSELS[17]="Why Zero Buyer Fees Change Everything for Beat Sellers"
CAROUSELS[18]="From Bedroom Producer to Full-Time: 90-Day Roadmap"
CAROUSELS[19]="5 Genre Trends That Will Explode in 2026"

# Use counter to rotate through topics
COUNTER_FILE="$OUTPUT_DIR/.carousel_counter"
if [ -f "$COUNTER_FILE" ]; then
    COUNTER=$(cat "$COUNTER_FILE")
else
    COUNTER=0
fi
TOPIC_INDEX=$((COUNTER % 20))
TOPIC="${CAROUSELS[$TOPIC_INDEX]}"
echo $(((COUNTER + 1) % 20)) > "$COUNTER_FILE"

# ── SLIDE GENERATION ─────────────────────────────────────────────
# Generate 5 slides for the carousel

SLIDE_FILE="$OUTPUT_DIR/carousels/carousel_${RUN_ID}.txt"

case $TOPIC_INDEX in
    0)
        SLIDES=(
            "STOP underpricing your beats. 💰"
            "❌ Mistake 1: Charging $5 for exclusives"
            "❌ Mistake 2: No tiered pricing"
            "❌ Mistake 3: Same price for all genres"
            "✅ Fix: $15-30 lease | $50-100 premium | $200+ exclusive"
        )
        ;;
    1)
        SLIDES=(
            "These platforms are eating your profits. 🍽️"
            "📊 BeatStars: 30% commission"
            "📊 Airbit: 20% commission"
            "📊 Traktrain: 15% commission"
            "💚 BeatsHeaven: 9% (or 0% on PRO)"
        )
        ;;
    2)
        SLIDES=(
            "Your beats are fire but NO ONE buys. 🔥❌"
            "Reason 1: No preview player on mobile"
            "Reason 2: Complicated checkout process"
            "Reason 3: No instant license delivery"
            "Fix: BeatsHeaven.com has all 3 built-in ✅"
        )
        ;;
    3)
        SLIDES=(
            "$0 → $10K/month selling beats. Here's how: 📈"
            "Month 1-2: Upload 50+ beats, set pricing"
            "Month 3-4: TikTok content, build audience"
            "Month 5-6: Email list, repeat buyers"
            "Month 7+: Scale winning genres, cut losers"
        )
        ;;
    4)
        SLIDES=(
            "5 things that SCARE beat buyers away. 👻"
            "1. No license terms visible"
            "2. Low-quality preview audio"
            "3. Generic beat names ('Untitled Beat 47')"
            "4. No social proof or reviews"
            "5. Sketchy payment process"
        )
        ;;
    5)
        SLIDES=(
            "Sounds good =/= Sells good. 🤔"
            "Problem: You're mixing, not marketing"
            "Fix 1: Name beats after trending artists"
            "Fix 2: Use tags: mood + genre + BPM"
            "Fix 3: Post 3x/week on TikTok/IG"
        )
        ;;
    6)
        SLIDES=(
            "$0 marketing budget. 500 sales. Here's the secret. 🤫"
            "Step 1: Post beat previews on TikTok"
            "Step 2: Use trending sounds + your beat"
            "Step 3: Reply to EVERY comment"
            "Step 4: Link to BeatsHeaven in bio"
        )
        ;;
    7)
        SLIDES=(
            "Fee breakdown: where does YOUR money go? 💸"
            "BeatStars Free: You keep 70%"
            "Airbit Free: You keep 80%"
            "BeatsHeaven Free: You keep 91%"
            "BeatsHeaven PRO ($14.99): You keep 100%"
        )
        ;;
    8)
        SLIDES=(
            "3 licenses. Know the difference. ⚖️"
            "📝 Lease: Non-exclusive, limited sales"
            "📝 Premium: Non-exclusive, unlimited sales"
            "📝 Exclusive: Sold once, artist owns it"
            "BeatsHeaven auto-generates all 3 licenses ✅"
        )
        ;;
    9)
        SLIDES=(
            "70% of beat buyers are on MOBILE. 📱"
            "Problem: Most platforms are desktop-first"
            "Result: Frustrated buyers, lost sales"
            "BeatsHeaven: Built mobile-first from day 1"
            "Lock-screen player. Instant checkout. Done."
        )
        ;;
    10)
        SLIDES=(
            "The trap producer's SECRET weapon. 🎯"
            "It's not the 808 (everyone has those)"
            "It's not the hi-hats (also everywhere)"
            "It's the MELODY selection"
            "Find obscure samples. Flip them uniquely. Stand out."
        )
        ;;
    11)
        SLIDES=(
            "5 red flags that scream 'amateur producer'. 🚩"
            "1. No mixing/mastering"
            "2. MP3 only (no WAV/stems)"
            "3. No tagged/untagged versions"
            "4. Generic cover art"
            "5. No license terms or contracts"
        )
        ;;
    12)
        SLIDES=(
            "Beat descriptions that CONVERT. ✍️"
            "❌ Bad: 'Hard trap beat'"
            "✅ Good: 'Dark Detroit Phonk | 140 BPM | Stuttering 808s | Perfect for aggressive rap vocals'"
            "Include: Mood + Genre + BPM + Unique Element"
            "Result: 3x more clicks, 2x more sales"
        )
        ;;
    13)
        SLIDES=(
            "$14.99/month that doubled my income. 💰"
            "BeatsHeaven PRO unlocked:"
            "→ 0% commission (was 9%)"
            "→ Featured placement"
            "→ Custom storefront"
            "→ Analytics dashboard"
            "Math: 2 sales at $30 = PRO pays for itself"
        )
        ;;
    14)
        SLIDES=(
            "Why instant delivery matters MORE than you think. ⚡"
            "Artists buy beats when inspiration strikes"
            "Wait 24h? Inspiration dies. Sale lost."
            "BeatsHeaven: License + files in 3 seconds"
            "Capture the moment. Capture the sale."
        )
        ;;
    15)
        SLIDES=(
            "3 TikTok strategies that DRIVE SALES. 📈"
            "1. 'Type beat' videos with trending sounds"
            "2. Behind-the-scenes beatmaking (process sells)"
            "3. 'This beat is $30, who wants it?' (direct CTA)"
            "Link in bio → BeatsHeaven. Every. Single. Time."
        )
        ;;
    16)
        SLIDES=(
            "Afrobeats is EXPLODING. Here's how to cash in. 💥"
            "📊 Global searches up 300%"
            "🌍 Artists from Lagos to London need beats"
            "🎵 Amapiano + Afrobeats fusion is trending"
            "Upload 5 Afrobeats to BeatsHeaven this week"
        )
        ;;
    17)
        SLIDES=(
            "Zero buyer fees = game changer. 🎮"
            "Other platforms: Buyer pays $30 + $5 fee = $35"
            "Artist sees $35, thinks 'too expensive'"
            "BeatsHeaven: Buyer pays $30. Period."
            "Lower perceived price = MORE sales for you"
        )
        ;;
    18)
        SLIDES=(
            "Bedroom → Full-time in 90 days. 🚀"
            "Days 1-30: Upload catalog, set pricing, create TikTok"
            "Days 31-60: Daily content, engage community, optimize"
            "Days 61-90: Double down on winners, cut losers, scale"
            "Start today: BeatsHeaven.com (60-second signup)"
        )
        ;;
    19)
        SLIDES=(
            "5 genres that will EXPLODE in 2026. 🔮"
            "1. Detroit Phonk (underground heat)"
            "2. Jersey Club (TikTok viral)"
            "3. Afrobeats/Amapiano (global rise)"
            "4. Rage (Gen Z favorite)"
            "5. Lo-Fi (steady, evergreen income)"
        )
        ;;
    *)
        SLIDES=(
            "Want to sell more beats? 🎹"
            "Step 1: Upload to BeatsHeaven.com"
            "Step 2: Price competitively"
            "Step 3: Post on TikTok/IG daily"
            "Step 4: Watch the sales roll in"
        )
        ;;
esac

# Write the carousel
{
    echo "# CAROUSEL: $TOPIC"
    echo "# Hook Type: $HOOK"
    echo "# Generated: $TIMESTAMP"
    echo "# Platform: Instagram / TikTok / LinkedIn"
    echo ""
    echo "=== SLIDE 1 (Cover/Hook) ==="
    echo "${SLIDES[0]}"
    echo ""
    echo "=== SLIDE 2 ==="
    echo "${SLIDES[1]}"
    echo ""
    echo "=== SLIDE 3 ==="
    echo "${SLIDES[2]}"
    echo ""
    echo "=== SLIDE 4 ==="
    echo "${SLIDES[3]}"
    echo ""
    echo "=== SLIDE 5 (CTA) ==="
    echo "${SLIDES[4]}"
    echo ""
    echo "=== HASHTAGS ==="
    echo "#beatsforsale #musicproducer #typebeats #beatsheaven #trapbeats #beatmaker #sellbeats #hiphopproduction #producerlife #musicbusiness"
    echo ""
    echo "=== CTA ==="
    echo "🔗 Link in bio: https://beatsheaven.com"
    echo "💬 Comment 'BEATS' for a discount code"
} > "$SLIDE_FILE"

echo "✅ Carousel generated: $SLIDE_FILE"
echo "   Topic: $TOPIC"
echo "   Hook: $HOOK"
echo "   Slides: 5"

# ── SAVE TO MASTER LOG ─────────────────────────────────────────
MASTER_LOG="$OUTPUT_DIR/carousels/activity.log"
echo "[$TIMESTAMP] Carousel $RUN_ID | $TOPIC | $HOOK | 5 slides" >> "$MASTER_LOG"

# ── OPTIONAL: Upload to social via upload-post API ─────────────
if [ -n "$UPLOADPOST_TOKEN" ] && [ -n "$UPLOADPOST_USER" ]; then
    echo "📤 Upload-Post credentials found — ready for auto-publishing"
    # Note: Actual upload would require converting text to image first
    # This is a text-only version — images can be added later with Gemini
fi

echo "═══════════════════════════════════════════════════════════════"
echo "  VIRALOOP TEXT CAROUSEL COMPLETE"
echo "═══════════════════════════════════════════════════════════════"
