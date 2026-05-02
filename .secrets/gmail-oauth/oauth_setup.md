# Gmail API OAuth Setup

## Step 1: Create Google Cloud Project
URL: https://console.cloud.google.com/projectcreate
- Project name: kimiclaw-gmail-access
- Create

## Step 2: Enable Gmail API
URL: https://console.cloud.google.com/apis/library/gmail.googleapis.com
- Click "Enable"

## Step 3: Configure OAuth Consent Screen
URL: https://console.cloud.google.com/apis/credentials/consent
- User Type: External
- App name: Kimiclaw Gmail Access
- User support email: kimiclaw8@gmail.com
- Developer contact email: kimiclaw8@gmail.com
- Scopes needed:
  - https://www.googleapis.com/auth/gmail.readonly (read emails)
  - https://www.googleapis.com/auth/gmail.send (send emails)
  - https://www.googleapis.com/auth/gmail.modify (manage labels, mark read)
- Add test users: kimiclaw8@gmail.com
- Publish status: Testing (fine for personal use)

## Step 4: Create OAuth Credentials
URL: https://console.cloud.google.com/apis/credentials
- Create Credentials → OAuth client ID
- Application type: Web application
- Name: Kimiclaw Web Client
- Authorized redirect URIs:
  - http://localhost:8085/ (for local auth flow)
- Save → copy Client ID and Client Secret

## Step 5: Run OAuth Flow
Use the client ID/secret to generate an authorization URL.
User clicks URL → authorizes → code is returned → exchange for tokens.
