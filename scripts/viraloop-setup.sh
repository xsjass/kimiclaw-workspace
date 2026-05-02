#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  VIRALOOP SETUP — One-time configuration                        ║
# ╚══════════════════════════════════════════════════════════════════╝

echo "🔄 Viraloop Setup for JJ's BeatsHeaven Automation"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Installing..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
fi
node -v

# Check jq
if ! command -v jq &> /dev/null; then
    echo "❌ jq not found. Installing..."
    apt-get install -y jq
fi

# Check uv (Python runner)
if ! command -v uv &> /dev/null; then
    echo "❌ uv not found. Installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Check Playwright
if ! npx playwright --version &> /dev/null; then
    echo "📦 Installing Playwright..."
    npm install -g playwright
    npx playwright install chromium
fi

# Create env file
cat > ~/.openclaw/workspace/.env.viraloop << 'ENV'
# Viraloop Credentials — Get these from:
# GEMINI_API_KEY: https://aistudio.google.com/app/apikey (FREE)
# UPLOADPOST_TOKEN: https://upload-post.com → Dashboard → API Keys
# UPLOADPOST_USER: Your upload-post.com username

GEMINI_API_KEY=your-gemini-key-here
UPLOADPOST_TOKEN=your-uploadpost-token-here
UPLOADPOST_USER=your-username-here
ENV

echo ""
echo "✅ Dependencies installed!"
echo ""
echo "📝 NEXT STEPS:"
echo "1. Edit ~/.openclaw/workspace/.env.viraloop"
echo "2. Add your GEMINI_API_KEY (free at https://aistudio.google.com/app/apikey)"
echo "3. Add your UPLOADPOST_TOKEN (get at https://upload-post.com)"
echo "4. Add your UPLOADPOST_USER"
echo ""
echo "🚀 Then run: source ~/.openclaw/workspace/.env.viraloop && ./scripts/viraloop-master.sh"
echo ""
echo "📅 For daily automation, add to crontab:"
echo "   0 9 * * * cd /root/.openclaw/workspace && source .env.viraloop && ./scripts/viraloop-master.sh"
