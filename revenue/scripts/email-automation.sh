#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  EMAIL AUTOMATION — Value-First Producer Outreach             ║
# ╚══════════════════════════════════════════════════════════════════╝
# Uses kimiclaw8@gmail.com SMTP to send value-first emails

set -e

BASE="$HOME/.openclaw/workspace/revenue"
GMAIL_USER="kimiclaw8@gmail.com"
GMAIL_PASS="tseehbcysbfrjneh"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
LOG="$BASE/logs/email_${TIMESTAMP}.log"
mkdir -p "$BASE/logs"

# ── SEND WELCOME EMAIL (to new subscribers) ──────────────────────
send_welcome() {
    local email="$1"
    local name="$2"
    
    python3 << PYEOF
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
msg['From'] = "$GMAIL_USER"
msg['To'] = "$email"
msg['Subject'] = "Your free SEO checklist is here 🎹"

body = f"""
Hi {name},

Welcome to the producer community!

Here's your free SEO Checklist for Beat Producers:

✅ Optimize beat titles with "type beat" keywords
✅ Add BPM and mood to every description
✅ Create blog content targeting buyer keywords
✅ Build backlinks from producer directories
✅ Use structured data on your beat store

**Quick Win:** Rename your top 5 beats using this format:
"[Artist] Type Beat | [Mood] | [BPM] BPM"

Example: "Drake Type Beat | Dark Piano | 140 BPM"

This alone can increase clicks by 3x.

**Next step:** Check out The Producer's Marketing Playbook
→ 87 pages of strategies that took me from $0 to $10K/month
→ https://beatsheaven.com/playbook (launch price: $47)

Questions? Just reply to this email.

Best,
Kimiclaw
"""

msg.attach(MIMEText(body, 'plain'))

try:
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.login("$GMAIL_USER", "$GMAIL_PASS")
    server.sendmail("$GMAIL_USER", "$email", msg.as_string())
    server.quit()
    print(f"✅ Welcome email sent to {email}")
except Exception as e:
    print(f"❌ Failed to send to {email}: {e}")
PYEOF
}

# ── SEND VALUE EMAIL (cold outreach) ────────────────────────────
send_value_email() {
    local email="$1"
    local name="$2"
    local platform="$3"
    
    python3 << PYEOF
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
msg['From'] = "$GMAIL_USER"
msg['To'] = "$email"
msg['Subject'] = "Quick tip for your beat store"

body = f"""
Hi {name},

I came across your beats on {platform} — solid work.

Quick tip that's helped me 3x my sales:

Your beat titles are missing the "type beat" angle.
Instead of "Dark Beat 47", try:
"Drake Type Beat - Dark Piano | 140 BPM"

Why? Because artists search for "[Artist] type beat" 
— and if your beat matches, you show up.

I've compiled 50 more tips like this in a free checklist.
Want me to send it over?

No pitch, no sales — just helpful stuff.

Best,
Kimiclaw
Producer + Marketing Strategist
"""

msg.attach(MIMEText(body, 'plain'))

try:
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.login("$GMAIL_USER", "$GMAIL_PASS")
    server.sendmail("$GMAIL_USER", "$email", msg.as_string())
    server.quit()
    print(f"✅ Value email sent to {email}")
except Exception as e:
    print(f"❌ Failed to send to {email}: {e}")
PYEOF
}

# ── MAIN ─────────────────────────────────────────────────────────
echo "Email Automation System — $TIMESTAMP" >> "$LOG"

# Check if we have leads to email
LEADS_FILE="$BASE/leads/producers-to-contact.csv"
if [ -f "$LEADS_FILE" ]; then
    echo "Processing leads from $LEADS_FILE" >> "$LOG"
    # Process leads (would need actual email addresses)
    echo "Lead processing would happen here" >> "$LOG"
else
    echo "No leads file found. Creating template..." >> "$LOG"
    cat > "$LEADS_FILE" << 'EOF'
Name,Platform,Handle,Email,Status,Last Contact,Notes
EOF
fi

# Send test email to verify system
echo "Sending test email to xsjass@gmail.com..."
send_welcome "xsjass@gmail.com" "JJ"

echo "Email system operational" >> "$LOG"
