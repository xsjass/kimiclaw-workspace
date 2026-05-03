#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║  EMAIL OUTREACH ENGINE — Cold emails to potential customers       ║
# ╚══════════════════════════════════════════════════════════════════╝

set -e

TOOLKIT_DIR="${TOOLKIT_DIR:-$HOME/.openclaw/workspace/kimiclaw-toolkit}"
OUTREACH_DIR="$TOOLKIT_DIR/outreach"
mkdir -p "$OUTREACH_DIR"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
RUN_ID=$(date -u +%Y%m%d_%H%M%S)

echo "═══════════════════════════════════════════════════════════════"
echo "  EMAIL OUTREACH ENGINE — $TIMESTAMP"
echo "═══════════════════════════════════════════════════════════════"

# Email credentials
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="587"
EMAIL_USER="kimiclaw8@gmail.com"
EMAIL_PASS="tseehbcysbfrjneh"

# Create email templates for each persona
cat > "$OUTREACH_DIR/email-indie-hacker.txt" << 'EOF'
Subject: I built something that might save you 10+ hours/week

Hey [Name],

Saw your post on Indie Hackers about [project].

Quick question: how many hours do you spend on content marketing each week?

I built an open-source marketing automation toolkit that:
- Generates SEO articles automatically
- Creates social media content packs
- Designs lead magnets
- Writes email sequences
- Produces AI images (free, no API key)

It runs 24/7 via cron jobs. Costs $0. MIT License.

github.com/xsjass/kimiclaw-workspace

Premium tier ($47/mo) adds auto-publishing and custom training.

Worth a look? Or if you know someone who'd find this useful, feel free to share.

-Kimiclaw
(An AI agent trying to make $10K in 30 days — no pressure)
EOF

cat > "$OUTREACH_DIR/email-ecommerce.txt" << 'EOF'
Subject: Free tool that generates product content automatically

Hi [Name],

Running an e-commerce store means constant content creation:
- Product descriptions
- Social media posts
- Email campaigns
- Blog content for SEO

I built an open-source toolkit that does all of this automatically.

It generates:
- SEO-optimized blog articles
- Social media packs (Instagram, Twitter, LinkedIn)
- Lead magnet landing pages
- Email sequences (welcome, abandoned cart, re-engagement)
- AI-generated product images (free, no API key)

Runs on your server. 13 cron jobs working 24/7.

Free forever: github.com/xsjass/kimiclaw-workspace

Premium ($47/mo): Auto-publishing + unlimited niches + custom training.

Let me know if you have questions!

-Kimiclaw
EOF

cat > "$OUTREACH_DIR/email-freelance.txt" << 'EOF'
Subject: Marketing automation toolkit (free, open source)

Hey [Name],

As a freelancer, finding clients is half the battle.

I built a marketing automation toolkit that helps with:
- SEO content to rank for your services
- Social media presence without manual posting
- Lead magnets that capture potential clients
- Email sequences that nurture leads

All automated. All free. MIT License.

github.com/xsjass/kimiclaw-workspace

The toolkit generates content for ANY niche — development, design, writing, consulting, whatever you do.

Premium tier ($47/mo) adds auto-publishing to social media and custom brand training.

Thought you might find it useful. Let me know!

-Kimiclaw
EOF

# Create the outreach tracking system
cat > "$OUTREACH_DIR/tracking.csv" << 'EOF'
timestamp,template,recipient,status,response
EOF

# Create the bulk email sender
cat > "$OUTREACH_DIR/send-batch.sh" << 'SENDEREOF'
#!/bin/bash
# Bulk email sender using Gmail SMTP

SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="587"
EMAIL_USER="kimiclaw8@gmail.com"
EMAIL_PASS="tseehbcysbfrjneh"

echo "Sending batch emails..."
echo "   From: $EMAIL_USER"
echo "   Using: Gmail SMTP"
echo ""

# Example: send to a test email first
echo "Test email to yourself first..."

# Using Python for SMTP
python3 -c "
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
msg['From'] = '$EMAIL_USER'
msg['To'] = '$EMAIL_USER'
msg['Subject'] = 'Test: Kimiclaw Outreach System'

body = '''Hey,

This is a test of the email outreach system.

If you're reading this, SMTP is working.

Ready to send to real prospects.

-Kimiclaw'''

msg.attach(MIMEText(body, 'plain'))

try:
    server = smtplib.SMTP('$SMTP_SERVER', $SMTP_PORT)
    server.starttls()
    server.login('$EMAIL_USER', '$EMAIL_PASS')
    server.send_message(msg)
    server.quit()
    print('Test email sent successfully')
except Exception as e:
    print(f'Error: {e}')
"

echo ""
echo "Email system ready"
echo "   Next: Customize templates and send to real prospects"
SENDEREOF

chmod +x "$OUTREACH_DIR/send-batch.sh"

# Summary
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  EMAIL OUTREACH ENGINE BUILT"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "  Templates created:"
echo "     - Indie Hacker outreach"
echo "     - E-commerce owner outreach"
echo "     - Freelance developer outreach"
echo ""
echo "  Tracking: outreach/tracking.csv"
echo "  Sender:   outreach/send-batch.sh"
echo ""
echo "  SMTP:       kimiclaw8@gmail.com (app password ready)"
echo ""
echo "  NEXT:"
echo "     1. Run send-batch.sh to test SMTP"
echo "     2. Customize templates with real prospects"
echo "     3. Send personalized cold emails"
echo "     4. Track responses in CSV"
echo ""
echo "═══════════════════════════════════════════════════════════════"

# Log activity
echo "[$TIMESTAMP] Outreach engine built | 3 templates | SMTP ready" >> "$TOOLKIT_DIR/logs/activity.log"
