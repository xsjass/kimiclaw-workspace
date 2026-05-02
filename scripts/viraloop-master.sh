#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  VIRALOOP AUTOMATION MASTER — JJ's Money Printer               ║
# ║  Auto-generates TikTok/Instagram carousels + auto-publishes    ║
# ║  Usage: ./viraloop-master.sh [website-url] [hook-type]        ║
# ╚══════════════════════════════════════════════════════════════════╝

set -e

# ── CONFIG ───────────────────────────────────────────────────────
WEBSITE_URL="${1:-https://beatsheaven.com}"
HOOK_TYPE="${2:-curiosity}"  # shock | curiosity | contradiction
SKILL_DIR="$HOME/.openclaw/skills/viraloop"
WORK_DIR="/tmp/carousel-$(date +%Y%m%d-%H%M%S)"
LEARNINGS_FILE="$HOME/.openclaw/workspace/.learnings/viraloop-learnings.json"

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; PURPLE='\033[0;35m'; CYAN='\033[0;36m'
NC='\033[0m' # No Color

log() { echo -e "${CYAN}[$(date +%H:%M:%S)]${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; }

# ── CHECK CREDENTIALS ────────────────────────────────────────────
check_credentials() {
    log "${PURPLE}🔐 Checking credentials...${NC}"
    
    if [ -z "$GEMINI_API_KEY" ]; then
        error "GEMINI_API_KEY not set!"
        echo "Get one free at: https://aistudio.google.com/app/apikey"
        exit 1
    fi
    
    if [ -z "$UPLOADPOST_TOKEN" ]; then
        error "UPLOADPOST_TOKEN not set!"
        echo "Get one at: https://upload-post.com → Dashboard → API Keys"
        exit 1
    fi
    
    if [ -z "$UPLOADPOST_USER" ]; then
        warn "UPLOADPOST_USER not set — using 'default'"
        export UPLOADPOST_USER="default"
    fi
    
    success "Credentials OK"
}

# ── STEP 1: RESEARCH ───────────────────────────────────────────
step_research() {
    log "${BLUE}🔍 Step 1: Researching $WEBSITE_URL${NC}"
    mkdir -p "$WORK_DIR"
    
    node "$SKILL_DIR/scripts/analyze-web.js" "$WEBSITE_URL" 2>/dev/null || {
        warn "analyze-web.js failed — using fallback analysis"
        cat > "$WORK_DIR/analysis.json" << 'ANALYSIS'
{
  "brand": { "name": "BeatsHeaven", "colors": ["#FF6B35", "#1A1A2E"], "fonts": ["Inter", "Poppins"] },
  "headline": "Premium Music Licensing Platform",
  "tagline": "Find the perfect beat for your next project",
  "features": ["Unlimited Downloads", "Commercial License", "Stem Files", "AI Search"],
  "niche": "music-licensing",
  "painPoints": ["Expensive music licenses", "Hard to find quality beats", "Copyright strikes"]
}
ANALYSIS
    }
    
    success "Research complete → $WORK_DIR/analysis.json"
}

# ── STEP 2: GENERATE HOOKS ─────────────────────────────────────
step_hooks() {
    log "${BLUE}🎯 Step 2: Generating 3 hook variants${NC}"
    
    cd "$SKILL_DIR"
    GEMINI_API_KEY="$GEMINI_API_KEY" bash scripts/generate-hooks.sh 2>/dev/null || {
        warn "Hook generation failed — using fallback hooks"
        cat > "$WORK_DIR/hooks.json" << 'HOOKS'
{
  "hooks": [
    { "type": "shock", "text": "This beat made $50K in licensing fees last month" },
    { "type": "curiosity", "text": "The #1 secret producers use to find beats that don't get copyright struck" },
    { "contradiction": "text", "text": "I used to pay $500 per beat. Now I pay $0 and make MORE money." }
  ]
}
HOOKS
    }
    
    success "Hooks generated"
}

# ── STEP 3: GENERATE SLIDES ────────────────────────────────────
step_slides() {
    log "${BLUE}🎨 Step 3: Generating 6-slide carousel ($HOOK_TYPE hook)${NC}"
    
    cd "$SKILL_DIR"
    GEMINI_API_KEY="$GEMINI_API_KEY" bash scripts/generate-slides.sh "$HOOK_TYPE" 2>/dev/null || {
        warn "Slide generation failed — creating placeholder workflow"
        echo "SLIDE_GEN_FAILED=true" >> "$WORK_DIR/status.env"
    }
    
    # Check if slides were generated
    if [ -f "/tmp/carousel/slide-1.jpg" ]; then
        success "Slides generated in /tmp/carousel/"
        ls -la /tmp/carousel/slide-*.jpg 2>/dev/null | while read line; do
            echo "  $line"
        done
    else
        warn "Slides not found — may need manual generation"
    fi
}

# ── STEP 4: REVIEW SLIDES ──────────────────────────────────────
step_review() {
    log "${BLUE}👁 Step 4: Reviewing slides with vision${NC}"
    
    if [ ! -f "/tmp/carousel/slide-1.jpg" ]; then
        warn "No slides to review — skipping"
        return
    fi
    
    # Vision review would happen here via agent
    success "Slides ready for vision review (agent will verify)"
}

# ── STEP 5: PUBLISH ────────────────────────────────────────────
step_publish() {
    log "${BLUE}📱 Step 5: Publishing to TikTok + Instagram${NC}"
    
    if [ ! -f "/tmp/carousel/slide-1.jpg" ]; then
        error "No slides to publish — aborting"
        return 1
    fi
    
    cd "$SKILL_DIR"
    UPLOADPOST_TOKEN="$UPLOADPOST_TOKEN" \
    UPLOADPOST_USER="$UPLOADPOST_USER" \
    bash scripts/publish-carousel.sh 2>/dev/null || {
        error "Publishing failed — check credentials and try again"
        return 1
    }
    
    success "Published to TikTok + Instagram!"
    
    # Save post info for tracking
    if [ -f "/tmp/carousel/post-info.json" ]; then
        cp "/tmp/carousel/post-info.json" "$WORK_DIR/"
        success "Post info saved → $WORK_DIR/post-info.json"
    fi
}

# ── STEP 6: ANALYTICS (DELAYED) ────────────────────────────────
step_analytics() {
    log "${BLUE}📊 Step 6: Analytics check (run after 24-48h)${NC}"
    log "To check analytics later, run:"
    echo "  UPLOADPOST_TOKEN=xxx UPLOADPOST_USER=xxx bash $SKILL_DIR/scripts/check-analytics.sh 7"
}

# ── STEP 7: LEARN ──────────────────────────────────────────────
step_learn() {
    log "${BLUE}🧠 Step 7: Learning from performance${NC}"
    
    cd "$SKILL_DIR"
    node scripts/learn-from-analytics.js 2>/dev/null || {
        warn "Learning analytics not available yet (need 24-48h data)"
    }
    
    # Update learnings file
    cat >> "$LEARNINGS_FILE" 2>/dev/null << LEARN
{
  "date": "$(date -Iseconds)",
  "website": "$WEBSITE_URL",
  "hook_type": "$HOOK_TYPE",
  "work_dir": "$WORK_DIR",
  "status": "published"
}
LEARN
    
    success "Learning recorded"
}

# ── MAIN EXECUTION ─────────────────────────────────────────────
main() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║           🔄 VIRALOOP AUTOMATION MASTER                      ║"
    echo "║     Auto TikTok/Instagram Carousel Money Printer             ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    log "Website: $WEBSITE_URL"
    log "Hook type: $HOOK_TYPE"
    log "Working directory: $WORK_DIR"
    
    check_credentials
    step_research
    step_hooks
    step_slides
    step_review
    step_publish
    step_analytics
    step_learn
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✅ CAROUSEL AUTOMATION COMPLETE                              ║${NC}"
    echo -e "${GREEN}║  📁 Work files: $WORK_DIR${NC}"
    echo -e "${GREEN}║  📊 Check analytics in 24-48h                                 ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
}

# Run if called directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
