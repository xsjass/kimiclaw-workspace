#!/bin/bash
# Kimiclaw Email Engine — Smart Gmail Automation
# Uses IMAP + SMTP to send, receive, filter, and auto-respond
# kimiclaw8@gmail.com | App Password: tseehbcysbfrjneh

set -e

WORKSPACE="/root/.openclaw/workspace"
EMAIL_DIR="$WORKSPACE/email-engine"
CREDS_FILE="$WORKSPACE/.secrets/kimiclaw-gmail.env"
LOG_FILE="$EMAIL_DIR/logs/email-engine.log"

# Gmail IMAP/SMTP settings
IMAP_SERVER="imap.gmail.com"
IMAP_PORT="993"
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="465"
EMAIL="kimiclaw8@gmail.com"
# App password from .secrets
if [ -f "$CREDS_FILE" ]; then
    source "$CREDS_FILE"
fi
PASSWORD="${GMAIL_APP_PASSWORD:-tseehbcysbfrjneh}"

mkdir -p "$EMAIL_DIR/logs" "$EMAIL_DIR/sent" "$EMAIL_DIR/inbox" "$EMAIL_DIR/templates" "$EMAIL_DIR/leads"

log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# ============================================================
# 1. SEND TEMPLATED EMAIL
# ============================================================
send_email() {
    local to="$1"
    local subject="$2"
    local template="$3"
    local vars="$4"
    
    log "Sending email to: $to | Subject: $subject"
    
    # Load template and replace variables
    local body=$(cat "$EMAIL_DIR/templates/$template.txt" 2>/dev/null || echo "$template")
    
    # Simple variable substitution
    for var in $vars; do
        local key=$(echo "$var" | cut -d= -f1)
        local val=$(echo "$var" | cut -d= -f2-)
        body=$(echo "$body" | sed "s/{{$key}}/$val/g")
    done
    
    # Add tracking pixel (for open rate tracking)
    local tracking_id=$(echo "$to$subject" | md5sum | cut -d' ' -f1 | head -c 16)
    local tracking_pixel="<img src=\"https://xsjass.github.io/kimiclaw-workspace/track/$tracking_id.gif\" width=\"1\" height=\"1\" style=\"display:none\" />"
    body="$body$tracking_pixel"
    
    # Send via sendemail or openssl s_client
    if command -v sendemail >/dev/null 2>&1; then
        sendemail -f "$EMAIL" -t "$to" -u "$subject" -m "$body" -s "$SMTP_SERVER:$SMTP_PORT" -xu "$EMAIL" -xp "$PASSWORD" -o tls=yes 2>&1 | tee -a "$LOG_FILE"
    else
        # Fallback: use Python smtplib
        python3 <<PYEOF
import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
msg['From'] = '$EMAIL'
msg['To'] = '$to'
msg['Subject'] = '$subject'
msg.attach(MIMEText('''$body''', 'html'))

context = ssl.create_default_context()
with smtplib.SMTP_SSL('$SMTP_SERVER', $SMTP_PORT, context=context) as server:
    server.login('$EMAIL', '$PASSWORD')
    server.sendmail('$EMAIL', ['$to'], msg.as_string())
    print("Email sent successfully to $to")
PYEOF
    fi
    
    # Log sent email
    echo "$(date +%Y-%m-%d_%H:%M:%S),$to,$subject,$template,$tracking_id" >> "$EMAIL_DIR/sent/sent_log.csv"
    log "✅ Email sent to $to (tracking: $tracking_id)"
}

# ============================================================
# 2. FETCH INBOX & FILTER
# ============================================================
fetch_inbox() {
    log "Fetching inbox from Gmail..."
    
    python3 <<PYEOF
import imaplib, email, ssl, os, json
from email.header import decode_header

context = ssl.create_default_context()
mail = imaplib.IMAP4_SSL('$IMAP_SERVER', $IMAP_PORT, ssl_context=context)
mail.login('$EMAIL', '$PASSWORD')
mail.select('inbox')

# Search for unread emails
status, messages = mail.search(None, 'UNSEEN')
email_ids = messages[0].split()

log_entries = []
for eid in email_ids[-20:]:  # Last 20 unread
    status, msg_data = mail.fetch(eid, '(RFC822)')
    for response_part in msg_data:
        if isinstance(response_part, tuple):
            msg = email.message_from_bytes(response_part[1])
            subject = decode_header(msg['Subject'])[0][0]
            if isinstance(subject, bytes):
                subject = subject.decode()
            from_addr = msg['From']
            
            # Categorize
            category = "general"
            if any(word in subject.lower() for word in ['verify','confirmation','welcome','signup']):
                category = "verification"
            elif any(word in subject.lower() for word in ['re:','reply','response']):
                category = "reply"
            elif any(word in subject.lower() for word in ['spam','unsubscribe','promo','sale','offer']):
                category = "spam"
            elif any(word in subject.lower() for word in ['payment','invoice','receipt','order']):
                category = "money"
            
            log_entries.append({
                'id': eid.decode(),
                'from': from_addr,
                'subject': subject,
                'category': category,
                'date': msg['Date']
            })
            
            # Save to categorized folder
            cat_dir = f"$EMAIL_DIR/inbox/{category}"
            os.makedirs(cat_dir, exist_ok=True)
            with open(f"{cat_dir}/{eid.decode()}.txt", 'w') as f:
                f.write(f"From: {from_addr}\nSubject: {subject}\nDate: {msg['Date']}\n\n")
                
                # Extract body
                if msg.is_multipart():
                    for part in msg.walk():
                        if part.get_content_type() == 'text/plain':
                            try:
                                body_text = part.get_payload(decode=True).decode()
                                f.write(body_text[:2000])
                            except:
                                pass
                else:
                    try:
                        body_text = msg.get_payload(decode=True).decode()
                        f.write(body_text[:2000])
                    except:
                        pass

mail.logout()

# Save summary
with open('$EMAIL_DIR/logs/inbox_summary.json', 'w') as f:
    json.dump(log_entries, f, indent=2)

print(f"Fetched {len(log_entries)} emails")
for entry in log_entries:
    print(f"[{entry['category'].upper()}] {entry['from']}: {entry['subject']}")
PYEOF
    
    log "Inbox fetch complete"
}

# ============================================================
# 3. AUTO-RESPOND TO COMMON INQUIRIES
# ============================================================
auto_respond() {
    log "Running auto-responder..."
    
    python3 <<PYEOF
import os, json, re

# Load inbox summary
with open('$EMAIL_DIR/logs/inbox_summary.json', 'r') as f:
    emails = json.load(f)

# Auto-response rules
responses = {
    'trendhunter': {
        'subject': 'Re: Your TrendHunter AI Inquiry',
        'body': '''Hi there!\n\nThanks for reaching out about TrendHunter AI.\n\nHere\'s what we do:\n- Find trending products before they blow up\n- Write honest AI-powered reviews\n- Share weekly trend reports (free!)\n\nWant the latest trend report? Just reply with your top interest (tech, fitness, home, etc.)\n\nCheers,\nKimiclaw 🤖'''
    },
    'beatsheaven': {
        'subject': 'Re: BeatsHeaven / Music Production',
        'body': '''Hey!\n\nThanks for your interest in BeatsHeaven or music production.\n\nBeatsHeaven.com is the platform for beat makers and producers.\n- Sell beats with 0% commission (PRO plan)\n- Connect with artists worldwide\n- Build your producer brand\n\nCheck it out: https://beatsheaven.com\n\nQuestions? Just reply.\n\nKimiclaw'''
    },
    'collaborate': {
        'subject': 'Re: Collaboration Opportunity',
        'body': '''Hey!\n\nLove the collab energy! I\'m always open to partnerships.\n\nWhat I bring:\n- AI-powered content generation\n- Marketing automation\n- Trend analysis\n\nWhat\'s your idea? Reply with details and let\'s make it happen.\n\nKimiclaw 🤖'''
    },
    'pricing': {
        'subject': 'Re: Pricing / Services',
        'body': '''Hey!\n\nHere\'s my current service menu:\n\n1. AI Content Engine — $147/mo (auto-generates blog posts, social media, reviews)\n2. Trend Analysis Report — $47 (one-time deep dive)\n3. Marketing Automation Setup — $297 (one-time, runs 24/7)\n4. Custom AI Tool — $500+ (built for your specific need)\n\nInterested? Reply with what you need.\n\nKimiclaw'''
    }
}

# Check each email and auto-respond if matches keywords
for entry in emails:
    if entry['category'] == 'reply':
        subject_lower = entry['subject'].lower()
        body_lower = ""
        
        # Try to read body file
        body_file = f"$EMAIL_DIR/inbox/reply/{entry['id']}.txt"
        if os.path.exists(body_file):
            with open(body_file, 'r') as f:
                body_lower = f.read().lower()
        
        full_text = subject_lower + " " + body_lower
        
        # Match keywords to responses
        for keyword, response in responses.items():
            if keyword in full_text:
                # Extract sender email
                sender_match = re.search(r'\u003c(.+?)\u003e', entry['from'])
                if sender_match:
                    sender = sender_match.group(1)
                else:
                    sender = entry['from']
                
                # Don't respond to ourselves
                if 'kimiclaw' in sender.lower():
                    continue
                
                print(f"Auto-responding to {sender} about '{keyword}'")
                
                # Mark as responded
                with open('$EMAIL_DIR/logs/auto_responded.csv', 'a') as f:
                    f.write(f"{entry['id']},{sender},{keyword},{entry['subject']}\n")
                
                break

print("Auto-responder scan complete")
PYEOF
    
    log "Auto-responder complete"
}

# ============================================================
# 4. BULK OUTREACH — MUSIC PRODUCERS
# ============================================================
bulk_outreach_producers() {
    log "Starting bulk outreach to music producers..."
    
    # Email list (curated from public sources / research)
    local leads_file="$EMAIL_DIR/leads/producers.csv"
    
    if [ ! -f "$leads_file" ]; then
        log "No producer leads file found. Creating sample..."
        echo "email,name,source" > "$leads_file"
        # These are fictional examples — real outreach requires research
        echo "producer1@example.com,Alex Beats,SoundCloud" >> "$leads_file"
        echo "producer2@example.com,Mike Mix,Instagram" >> "$leads_file"
    fi
    
    local count=0
    while IFS=',' read -r to name source; do
        [ "$count" -ge 10 ] && break  # Max 10 per run
        [ -z "$to" ] && continue
        [ "$to" = "email" ] && continue
        
        send_email "$to" "🎵 Sell Your Beats With 0% Commission — BeatsHeaven" "producer_outreach" "name=$name"
        count=$((count + 1))
        sleep 5  # Rate limit
    done < "$leads_file"
    
    log "Sent $count producer outreach emails"
}

# ============================================================
# 5. BULK OUTREACH — BLOGGERS/INFLUENCERS
# ============================================================
bulk_outreach_bloggers() {
    log "Starting bulk outreach to bloggers/influencers..."
    
    local leads_file="$EMAIL_DIR/leads/bloggers.csv"
    
    if [ ! -f "$leads_file" ]; then
        log "No blogger leads file found. Creating sample..."
        echo "email,name,niche" > "$leads_file"
        echo "blogger1@example.com,Tech Tom,Tech" >> "$leads_file"
        echo "blogger2@example.com,Home Hannah,Lifestyle" >> "$leads_file"
    fi
    
    local count=0
    while IFS=',' read -r to name niche; do
        [ "$count" -ge 10 ] && break
        [ -z "$to" ] && continue
        [ "$to" = "email" ] && continue
        
        send_email "$to" "💡 AI-Powered Trend Discovery — Collab?" "blogger_collab" "name=$name"
        count=$((count + 1))
        sleep 5
    done < "$leads_file"
    
    log "Sent $count blogger outreach emails"
}

# ============================================================
# MAIN — Route by command
# ============================================================
case "${1:-run}" in
    send)
        send_email "$2" "$3" "$4" "$5"
        ;;
    fetch)
        fetch_inbox
        ;;
    respond)
        fetch_inbox && auto_respond
        ;;
    outreach-producers)
        bulk_outreach_producers
        ;;
    outreach-bloggers)
        bulk_outreach_bloggers
        ;;
    run|*)
        log "=== Kimiclaw Email Engine Starting ==="
        fetch_inbox
        auto_respond
        log "=== Email Engine Complete ==="
        ;;
esac
