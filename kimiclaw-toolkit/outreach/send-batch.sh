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
