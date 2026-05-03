#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  IMAGE GENERATION MODULE — Free AI Images via Pollinations      ║
# ╚══════════════════════════════════════════════════════════════════╝
# Uses pollinations.ai — free, no API key, no signup required

set -e

TOOLKIT_DIR="${TOOLKIT_DIR:-$HOME/.openclaw/workspace/kimiclaw-toolkit}"
IMAGES_DIR="$TOOLKIT_DIR/images"
mkdir -p "$IMAGES_DIR"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
RUN_ID=$(date -u +"%Y%m%d_%H%M%S")

echo "═══════════════════════════════════════════════════════════════"
echo "  IMAGE GENERATION MODULE — $TIMESTAMP"
echo "  Provider: pollinations.ai (free, no API key)"
echo "═══════════════════════════════════════════════════════════════"

# Default prompt or use argument
PROMPT="${1:-modern minimalist marketing automation toolkit logo, dark background, neon green geometric design, professional, high quality}"

# URL-encode the prompt
ENCODED_PROMPT=$(echo "$PROMPT" | sed 's/ /%20/g; s/,/%2C/g; s/!/%21/g')

# Generate image
OUTPUT_FILE="$IMAGES_DIR/image_${RUN_ID}.jpg"

echo "🎨 Prompt: $PROMPT"
echo "📥 Downloading..."

curl -s "https://image.pollinations.ai/prompt/${ENCODED_PROMPT}?width=1024&height=1024&seed=${RANDOM}&nologo=true" \
  -o "$OUTPUT_FILE" \
  -w "HTTP Status: %{http_code}\nSize: %{size_download} bytes\n" 2>&1 | head -5

# Verify the image
if [ -f "$OUTPUT_FILE" ] && [ -s "$OUTPUT_FILE" ]; then
    FILE_SIZE=$(stat -c%s "$OUTPUT_FILE" 2>/dev/null || stat -f%z "$OUTPUT_FILE" 2>/dev/null)
    echo ""
    echo "✅ IMAGE GENERATED SUCCESSFULLY"
    echo "   File: $OUTPUT_FILE"
    echo "   Size: ${FILE_SIZE} bytes"
    echo "   Type: JPEG"
    
    # Log success
    echo "[$TIMESTAMP] Image generated | Size: ${FILE_SIZE} bytes | Prompt: ${PROMPT:0:50}..." >> "$TOOLKIT_DIR/logs/activity.log"
    
    # Copy to publish queue for social media use
    cp "$OUTPUT_FILE" "$TOOLKIT_DIR/publish-queue/image_${RUN_ID}.jpg"
    echo "   Copied to publish-queue for social media"
    
    echo ""
    echo "═══════════════════════════════════════════════════════════════"
    echo "  IMAGE READY FOR USE"
    echo "═══════════════════════════════════════════════════════════════"
    echo "  Use this image in:"
    echo "    • Social media posts"
    echo "    • Blog post featured images"
    echo "    • Product thumbnails"
    echo "    • Carousel slides"
    echo "═══════════════════════════════════════════════════════════════"
else
    echo "❌ Image generation failed — file not created or empty"
    exit 1
fi
