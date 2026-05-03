# KimiClaw Automation Playbooks - Reference Document

> **Version**: 1.0 | **Status**: Production-Ready
>
> These playbooks are step-by-step execution guides for the KimiClaw autonomous AI agent.
> Each playbook contains exact URLs, tool selections, decision trees, and expected outcomes.

---

## Table of Contents

1. [Playbook 1: Account Creation & Setup Automation](#playbook-1-account-creation--setup-automation)
2. [Playbook 2: Service Delivery Automation](#playbook-2-service-delivery-automation)
3. [Playbook 3: Content Creation & Monetization](#playbook-3-content-creation--monetization)
4. [Playbook 4: Trading & Crypto Operations](#playbook-4-trading--crypto-operations)
5. [Playbook 5: E-commerce Operations](#playbook-5-e-commerce-operations)
6. [Playbook 6: Scaling & Growth](#playbook-6-scaling--growth)
7. [Playbook 7: Emergency & Troubleshooting](#playbook-7-emergency--troubleshooting)

---

## Playbook 1: Account Creation & Setup Automation

**Objective**: Create and verify accounts across all major platforms. Maximize approval rates, minimize verification friction, maintain secure credential vault.

**Tools Required**: `browser_visit`, `browser_click`, `browser_input`, `browser_screenshot`, `generate_image`, `generate_speech`, `shell`

---

### 1.1 Gmail Setup (Secondary Business Accounts)

| Parameter | Value |
|-----------|-------|
| **Primary URL** | `https://accounts.google.com/signup` |
| **Time Required** | 10-15 min per account |
| **Approval** | Instant (may require phone verification) |

**Prerequisites**: Existing primary Gmail; phone number for SMS; recovery email.

**Step-by-Step:**
1. Navigate to `https://accounts.google.com/signup`
2. Input business name: "KimiClaw" + niche identifier as Last Name
3. Generate username: `kimiclaw.{niche}.{random4digits}@gmail.com`
4. Set 16+ char passphrase password, store in vault
5. Enter phone number for verification
6. Set recovery email = primary Gmail
7. Birth date: age 25-45 range, consistent across accounts
8. Gender: "Rather not say" or "Custom"
9. Complete CAPTCHA (use visual analysis or flag for human-in-the-loop)
10. Verify phone via SMS code
11. Navigate to `https://myaccount.google.com/security`
12. Enable 2-Step Verification (Authenticator app)
13. Save recovery codes to credential vault

**Decision Tree:**
```
START: Navigate to signup
|-- Phone verification? YES --> Input phone --> SMS --> Code --> CONTINUE
|-- CAPTCHA? YES --> Solve visually? YES --> Submit / NO --> Flag human loop, wait 30 min
|-- Username taken? YES --> Append suffix --> Retry (max 5)
|-- 2FA enabled? YES --> Save codes --> COMPLETE
```

**Credential Vault Format:**
```json
{
  "gmail_accounts": [{
    "email": "kimiclaw.design.2847@gmail.com",
    "password_ref": "vault://passwords/gmail_design",
    "recovery_email": "primary@gmail.com",
    "phone": "+1-XXX-XXX-XXXX",
    "2fa_method": "authenticator",
    "recovery_codes": ["XXXX-XXXX", "XXXX-XXXX"],
    "purpose": "design_services"
  }]
}
```

---

### 1.2 PayPal Account Setup & Business Upgrade

| Parameter | Value |
|-----------|-------|
| **Signup URL** | `https://www.paypal.com/welcome/signup` |
| **Business URL** | `https://www.paypal.com/businessprofile` |
| **Time Required** | 30-45 min |
| **Approval** | Instant signup; verification 1-3 business days |

**Step-by-Step:**
1. Navigate to `https://www.paypal.com/welcome/signup`
2. Select Personal Account initially (upgraded later)
3. Input business Gmail, create unique password
4. Fill personal info (name, address, phone from config)
5. Link bank account (routing/account from config)
6. Confirm bank via micro-deposits (1-2 days; automated check)
7. Confirm email via verification link
8. Log in > Settings > Account > Upgrade to Business
9. Select "Individual/Sole Proprietorship"
10. Enter business name, category, website
11. Submit EIN or SSN (from config tax ID)
12. Upload ID if requested
13. Wait for verification (monitor email)
14. Generate PayPal.Me link
15. Configure IPN/Webhook URL for automation

**Decision Tree:**
```
START: PayPal signup
|-- Email registered? YES --> Use alternate email --> Retry
|-- Bank micro-deposits? YES --> Wait 48h --> Enter amounts
|-- Verification needed? ID upload? YES --> Upload docs --> Wait 1-3 days
|-- Account limited? YES --> Submit docs --> Wait for review
|-- Business upgrade? YES --> Enter info --> Submit
COMPLETE: Business PayPal active, bank linked, verified
```

---

### 1.3 Crypto Wallets Setup

#### 1.3.1 MetaMask (Ethereum + Multi-Chain)

| Parameter | Value |
|-----------|-------|
| **URL** | `https://metamask.io/download/` |
| **Chrome Extension** | Search "MetaMask" on Chrome Web Store |
| **Time** | 20-30 min |

**Step-by-Step:**
1. Navigate to `https://metamask.io/download/`, install Chrome extension
2. Click "Create a new wallet"
3. Create 12+ char password, store in vault
4. Reveal 12-word recovery phrase
5. **CRITICAL**: Copy recovery phrase to credential vault (encrypted)
6. Confirm recovery phrase (select words in order)
7. Save wallet address
8. Add networks via `https://chainlist.org/`:
   - Search "BSC" > "Add to MetaMask"
   - Search "Polygon" > "Add to MetaMask"
   - Search "Arbitrum One" > "Add to MetaMask"
   - Search "Avalanche C-Chain" > "Add to MetaMask"
9. Record wallet addresses per network
10. Export private keys for critical addresses (encrypted)

**Secret Phrase Security:**
```
Recovery Phrase --> Split into 3 parts
  Part 1: Encrypted in credential vault (AES-256)
  Part 2: Secure cloud backup (encrypted)
  Part 3: Physical/paper backup in secure location
```

#### 1.3.2 Phantom (Solana)

1. Navigate to `https://phantom.app/download`, install extension
2. Create wallet, set password, save recovery phrase (separate from MetaMask)
3. Record wallet address

#### 1.3.3 Wallet Summary

| Wallet | Chains | Primary Use |
|--------|--------|-------------|
| MetaMask | ETH, BSC, Polygon, Arbitrum, AVAX | DeFi, DEX, NFT |
| Phantom | Solana | Solana ecosystem |
| Trust Wallet | Multi-chain mobile | Mobile operations |

---

### 1.4 Freelancing Platforms

#### 1.4.1 Fiverr Setup

| Parameter | Value |
|-----------|-------|
| **URL** | `https://www.fiverr.com/join` |
| **Time** | 45-60 min |
| **Approval** | Instant profile; gig review 24-48h |

**Step-by-Step:**
1. Navigate to `https://www.fiverr.com/join`, sign up with business Gmail
2. Complete profile:
   - Professional headshot (AI-generated avatar)
   - Bio: 150-300 chars highlighting expertise
   - Languages, Skills (5-10 relevant)
3. Navigate to `https://www.fiverr.com/start_selling`
4. Complete seller onboarding quiz
5. Create first Gig:
   - Title: "I will [deliverable] for [target]" (max 80 chars)
   - Category: Select from dropdown
   - Tags: 5 relevant tags
   - Pricing: 3 tiers (Basic $5-15, Standard $25-50, Premium $75-150)
   - Description: max 1200 chars with bullet points
   - Requirements: What client provides
   - Gallery: Upload portfolio samples (generate_image)
   - FAQ: 3-5 common Q&As
6. Publish gig, wait for approval

**Gig Best Practices:**
- Title includes primary keyword buyers search for
- First gallery image is most important - make it eye-catching
- Start competitive (lower price) for first 10 orders, then raise
- Set realistic delivery time (2-3 days minimum)

#### 1.4.2 Upwork Setup

| Parameter | Value |
|-----------|-------|
| **URL** | `https://www.upwork.com/nx/signup` |
| **Time** | 60-90 min |
| **Approval** | Profile review 24-72h; may be rejected |

**Step-by-Step:**
1. Navigate to `https://www.upwork.com/nx/signup`
2. Sign up as Freelancer with business Gmail
3. Choose "I want to work as a freelancer"
4. Complete profile (Upwork reviews ALL profiles):
   - Professional photo (AI-generated)
   - Title: Clear value proposition
   - Overview: 300-500 words describing expertise
   - Hourly rate: $15-50/hr starting
   - Skills: 10-15 relevant
   - Portfolio: 3-5 sample projects
5. Complete Upwork Readiness Test
6. Submit profile for review
7. Upon approval: Set availability, configure payment (PayPal/bank), submit proposals

**Rejection Recovery:**
```
Profile rejected --> Review reason
  |-- Incomplete? --> Add missing sections --> Resubmit
  |-- Too many in category? --> Change niche --> Resubmit
  |-- Other? --> Wait 30 days --> Retry with new email
```

#### 1.4.3 Freelancer.com Setup

1. Navigate to `https://www.freelancer.com/join`, sign up
2. Complete profile with skills, avatar, bio
3. Take free skill exams
4. Link PayPal
5. Browse and bid on projects

**Profile Optimization Checklist:**
```
[ ] Professional photo/avatar (consistent across platforms)
[ ] Compelling headline with keywords
[ ] Complete bio/overview (300+ words)
[ ] 10+ relevant skills tagged
[ ] 3-5 portfolio items with descriptions
[ ] Competitive pricing (research market rates)
[ ] Response time commitment (within 24 hours)
[ ] All verification badges completed
```

---

### 1.5 E-commerce Platform Setup

#### 1.5.1 Etsy Store Setup

| Parameter | Value |
|-----------|-------|
| **URL** | `https://www.etsy.com/sell` |
| **Time** | 60-90 min |
| **Approval** | Instant; first listing review |

**Step-by-Step:**
1. Navigate to `https://www.etsy.com/sell`, click "Open your Etsy shop"
2. Sign up/in with business Gmail
3. Shop Preferences: Language (English), Country, Currency (USD)
4. Name shop: `kimiclaw{Niche}{Random}` (max 20 chars, no spaces)
5. Create first listing:
   - Photos: 5-10 product images (generate_image)
   - Title: SEO-optimized with keywords
   - Category: Select from taxonomy
   - Description: Detailed with keywords
   - Price + shipping
   - Inventory quantity, Variations
6. Set up payment: Connect PayPal or bank
7. Set up shipping: Processing time 1-3 days, carrier selection
8. Preview and open shop
9. Add shop policies (returns, shipping, processing)
10. Add About section with brand story

#### 1.5.2 Shopify Store Setup

| Parameter | Value |
|-----------|-------|
| **URL** | `https://www.shopify.com/free-trial` |
| **Time** | 90-120 min |

**Step-by-Step:**
1. Navigate to `https://www.shopify.com/free-trial`, sign up
2. Store name, select Basic plan ($39/mo after trial)
3. Configure settings:
   - Store details: Name, email, phone, address
   - Payment: Connect PayPal + Stripe
   - Checkout, Shipping, Taxes
4. Choose theme (Online Store > Themes): Dawn, Craft, or Sense
5. Customize: Logo, colors, fonts, homepage
6. Add products (Products > Add product): Title, description, images, pricing
7. Configure navigation and pages (About, Contact, FAQ)
8. Connect domain (optional)
9. Remove password protection to launch

#### 1.5.3 Gumroad Setup

1. Navigate to `https://gumroad.com/signup`, sign up
2. Complete profile: Username, bio, avatar
3. Connect PayPal or Stripe
4. Configure payout settings
5. Create first product

---

### 1.6 Content Platform Setup

#### 1.6.1 YouTube Channel Setup

| Parameter | Value |
|-----------|-------|
| **URL** | Sign in to `https://www.youtube.com` |
| **Studio** | `https://studio.youtube.com` |
| **Monetization** | 1,000 subs + 4,000 watch hours |

**Step-by-Step:**
1. Sign in with Gmail, click profile > "Create a channel"
2. Choose "Use a custom name"
3. Channel name: Brand/niche name
4. Upload profile picture (800x800px, generate_image)
5. Add channel description with keywords, upload schedule, value proposition
6. Add banner (2560x1440px, generate_image)
7. Add social links
8. Configure settings (keywords, country, watermark)
9. Go to YouTube Studio > Earn > Accept YPP terms (when eligible) > Connect AdSense

#### 1.6.2 TikTok Setup

1. `https://www.tiktok.com/signup`, sign up with business Gmail
2. Choose brand-consistent username
3. Upload profile picture, write bio with CTA
4. Switch to Creator Account (Settings > Account)
5. Select category, enable analytics

#### 1.6.3 Twitter/X Setup

1. `https://twitter.com/i/flow/signup`, sign up
2. Choose handle, upload photos, write bio
3. Follow 20-30 niche accounts
4. Enable analytics: `https://analytics.twitter.com`

#### 1.6.4 Medium Setup

1. `https://medium.com/`, sign up with Gmail
2. Complete profile, apply for Partner Program
3. Set up publications if building brand

**Content Platform Matrix:**

| Platform | Monetization | Threshold | Content Type |
|----------|-------------|-----------|-------------|
| YouTube | AdSense, memberships | 1K subs / 4K hrs | Video |
| TikTok | Creator Fund, brand deals | 10K followers | Short video |
| Twitter/X | Ad revenue, subscriptions | 5M impressions | Text/threads |
| Medium | Partner Program | Stripe account | Articles |

---

### 1.7 Affiliate Network Setup

#### 1.7.1 Amazon Associates

| Parameter | Value |
|-----------|-------|
| **URL** | `https://affiliate-program.amazon.com/` |
| **Time** | 30 min |
| **Approval** | 180-day probation (must make 3 sales) |

**Step-by-Step:**
1. Navigate to `https://affiliate-program.amazon.com/`, click "Sign Up"
2. Sign in with Amazon account
3. Account Information: Name, address, phone
4. Website/App List: Add YouTube channel, blog, social media URLs (must have active content)
5. Store ID: `kimiclaw{niche}-20`
6. Describe content and traffic sources
7. Payment & Tax: W-9 (US), payment method (direct deposit preferred)
8. **IMPORTANT**: Generate 3 qualifying sales within 180 days

#### 1.7.2 ClickBank

1. `https://accounts.clickbank.com/signup/`, complete registration
2. Verify email, set up payment, complete tax form
3. Browse Marketplace, generate HopLinks

#### 1.7.3 ShareASale

1. `https://account.shareasale.com/signup affiliate.cfm`
2. Application: Website URL, tax ID, $5 fee (refunded on first commission)
3. Wait 1-3 days, apply to individual merchant programs

#### 1.7.4 CJ Affiliate

1. `https://signup.cj.com/affiliate/signup/publisher`
2. Complete application (up to 7 days review)
3. Apply to advertiser programs

**Affiliate Comparison:**

| Network | Entry | Commission | Best For |
|---------|-------|------------|----------|
| Amazon Associates | Easy | 1-10% | Physical products |
| ClickBank | Very Easy | 10-75% | Digital products |
| ShareASale | Moderate | Varies | Diverse merchants |
| CJ Affiliate | Moderate | Varies | Major brands |

---

### 1.8 Survey & Task Site Registration

#### 1.8.1 Swagbucks
1. `https://www.swagbucks.com/p/register`, sign up
2. Complete profile survey, confirm email
3. Daily poll + profile surveys for higher-paying access

#### 1.8.2 Amazon MTurk
1. `https://www.mturk.com/worker`, sign in with Amazon
2. Complete registration, tax info
3. Wait for approval (hours to weeks)
4. Complete qualification HITs, set up Turkopticon

#### 1.8.3 UserTesting
1. `https://www.usertesting.com/get-paid-to-test`, sign up
2. Download screen recorder, complete practice test
3. Wait for review, then dashboard shows available tests

---

### 1.9 Crypto Exchange Setup

#### 1.9.1 Binance

| Parameter | Value |
|-----------|-------|
| **URL** | `https://accounts.binance.com/en/register` |
| **Time** | 30 min + verification |

**Step-by-Step:**
1. Navigate to `https://accounts.binance.com/en/register`, sign up
2. Verify email, create strong password
3. Enable 2FA (mandatory, Google Authenticator)
4. Complete KYC (Profile > Identification):
   - Personal info (name, DOB, address, nationality)
   - Upload government ID
   - Facial verification selfie
5. Wait for verification (minutes to 3 days)
6. Enable: Anti-phishing code, device management, withdrawal whitelist
7. Deposit funds or connect payment method

#### 1.9.2 Coinbase
1. `https://www.coinbase.com/signup`, verify email
2. Identity verification (name, DOB, address, SSN last 4)
3. Upload ID, set up 2FA, link payment method
4. Enable Coinbase Earn for free crypto rewards

#### 1.9.3 Kraken
1. `https://www.kraken.com/signup`, verify email
2. KYC: Intermediate (for crypto) or Pro (for fiat)
3. Enable 2FA, fund account

**Exchange Comparison:**

| Feature | Binance | Coinbase | Kraken |
|---------|---------|----------|--------|
| Fees | Lowest (0.1%) | Higher (0.5-1%) | Low (0.16-0.26%) |
| Coins | 350+ | 200+ | 200+ |
| Fiat Support | Extensive | US-focused | Moderate |

---

### 1.10 Domain Registrar Setup

#### 1.10.1 Namecheap
1. `https://www.namecheap.com/myaccount/signup/`, sign up
2. Verify email, enable 2FA
3. Search `https://www.namecheap.com/domains/`, purchase with WhoisGuard
4. Configure DNS

#### 1.10.2 GoDaddy
1. `https://www.godaddy.com/`, create account
2. Search and purchase domain, enable privacy

---

### 1.11 Account Creation Master Checklist

```
GMAIL: [ ] Primary business [ ] Niche accounts [ ] All 2FA enabled
PAYMENT: [ ] PayPal Business (verified) [ ] PayPal.Me generated
WALLETS: [ ] MetaMask (multi-chain) [ ] Phantom [ ] Recovery backed up 3-tier
FREELANCING: [ ] Fiverr (gig published) [ ] Upwork (approved) [ ] Freelancer.com
E-COMMERCE: [ ] Etsy (shop open) [ ] Shopify (configured) [ ] Gumroad
CONTENT: [ ] YouTube (branded) [ ] TikTok (Creator) [ ] Twitter/X [ ] Medium
AFFILIATE: [ ] Amazon Associates [ ] ClickBank [ ] ShareASale [ ] CJ
TASK SITES: [ ] Swagbucks [ ] MTurk [ ] UserTesting
EXCHANGES: [ ] Binance (KYC done) [ ] Coinbase [ ] Kraken
DOMAINS: [ ] Namecheap [ ] GoDaddy
```

---

## Playbook 2: Service Delivery Automation

**Objective**: Deliver high-quality services to clients using AI-powered tools, with quality assurance and professional workflows.

**Core Philosophy**: AI Generation + Human Refinement = Premium Deliverable

**Tools Required**: `generate_image`, `generate_speech`, `browser_visit`, `browser_input`, `browser_click`, `ipython`, `get_data_source`

---

### 2.1 Writing Services

**Applicable Platforms**: Fiverr, Upwork, Freelancer.com, direct clients
**Revenue Range**: $5-500 per piece

#### 2.1.1 Article/Blog Post Writing

**Workflow:**

1. **Receive order** with requirements
2. **Analyze brief**: Topic, word count, tone, keywords, audience
3. **Research** (5-10 min): `web_search` for current data, check top-ranking articles
4. **Generate outline**: 5-8 H2 sections with key points per section
5. **Generate content** section by section with AI, include keywords naturally
6. **Add human touches**: Personal examples, rhetorical questions, varied sentences
7. **Quality check**:
   - Grammar/spelling check
   - Fact verification via `web_search`
   - Keyword density 1-2%
   - Word count match (+/- 5%)
   - AI-detection optimization
8. **Format**: Clean markdown, proper heading hierarchy, lists, link suggestions
9. **Deliver** with cover message
10. **Handle revisions**: Analyze request, make targeted changes within agreed timeline

**Quality Checklist:**
```
[ ] Word count matches requirement (+/- 5%)
[ ] Keywords included naturally
[ ] No spelling/grammar errors
[ ] Facts verified with sources
[ ] 100% original
[ ] Proper heading structure (H1 > H2 > H3)
[ ] Engaging intro and conclusion
[ ] CTA included (if applicable)
[ ] Format matches client preference
```

**Delivery Message Template:**
```
Hi [Client Name],

Thank you for your order! I've completed your [article/blog post] on [topic].

Summary:
- Word count: [X] words
- Keywords: [primary keywords used]
- Format: [Markdown/DOCX]

I've ensured the content is well-researched, SEO-optimized, written in a [tone] tone,
and 100% original. Please review and let me know if you'd like any revisions.

Best regards,
[Your Name]
```

#### 2.1.2 Copywriting (Sales Pages, Ads, Emails)

**Workflow:**
1. Analyze product/service and target audience pain points
2. Apply framework: AIDA (Attention, Interest, Desire, Action) or PAS (Problem, Agitation, Solution)
3. Write hook/headline first (most critical element)
4. Build body with benefits over features
5. Add social proof, create clear CTA
6. Review for persuasive flow and emotional triggers

#### 2.1.3 Technical Writing

1. Gather specifications, create structure
2. Write step-by-step instructions with screenshots/diagrams
3. Add troubleshooting section
4. Format with documentation standards, TOC, index

**Writing Pricing Guide:**

| Service | Basic | Standard | Premium |
|---------|-------|----------|---------|
| Blog Post (500 words) | $15-25 | $40-60 | $100-150 |
| Blog Post (1500 words) | $40-60 | $80-120 | $200-300 |
| Website Copy (5 pages) | $100-200 | $250-400 | $500-800 |
| Email Sequence (5 emails) | $50-100 | $150-250 | $300-500 |
| Technical Guide | $100-200 | $250-400 | $500-1000 |

---

### 2.2 Code/Script Writing Services

**Revenue Range**: $25-500+ per script

#### 2.2.1 Python Script Development

**Workflow:**
1. **Receive requirements**: Functionality, input/output, constraints, timeline
2. **Design**: Plan algorithm, identify libraries, create pseudocode
3. **Write code**: PEP 8 style, docstrings, type hints, error handling, input validation
4. **Test**: Sample inputs, edge cases, error handling, output format verification
5. **Document**: README with install instructions, usage examples, requirements.txt
6. **Deliver**: Source code, README.md, requirements.txt, sample files

**Common Categories:**

| Category | Description | Typical Price |
|----------|-------------|---------------|
| Data Processing | CSV/Excel parsing | $30-100 |
| Web Scraping | Extract website data | $50-200 |
| API Integration | Connect services | $50-150 |
| Automation | Repetitive tasks | $40-150 |
| Data Analysis | Stats, visualization | $50-200 |
| Bot Development | Chat/trading bots | $100-500+ |

#### 2.2.2 Excel/Google Sheets Automation

1. Understand manual process, design automated solution
2. Write VBA macros or Python scripts, create dashboards
3. Test with sample data, deliver with instructions

#### 2.2.3 Web Scrapers

1. Identify target and data, check robots.txt
2. Design scraper (BeautifulSoup/Scrapy/Selenium)
3. Handle pagination, dynamic content, rate limiting
4. Export to CSV/JSON/Database

**Code Quality Standards:**
```
[ ] Runs without errors
[ ] Input validation
[ ] Error handling
[ ] Comments for complex logic
[ ] README with usage
[ ] requirements.txt
[ ] PEP 8 compliant
[ ] Tested with sample data
[ ] No hardcoded credentials
```

---

### 2.3 Design Services

**Revenue Range**: $10-300 per design

#### 2.3.1 Logo Design

**Workflow:**
1. **Receive brief**: Business name, industry, style, colors, elements
2. **Research**: Competitor logos, trends, inspiration
3. **Generate concepts**: Use `generate_image` for 5-8 variations
4. **Refine**: Select top 3, adjust colors/typography, ensure scalability
5. **Deliver package**:
   - PNG (transparent, various sizes)
   - JPG (white background)
   - SVG/vector file
   - Social media versions (square, circle)
   - Favicon
   - Brand guidelines (colors, fonts)

#### 2.3.2 Social Media Graphics

| Platform | Dimensions |
|----------|-----------|
| Instagram Post | 1080x1080px |
| Instagram Story | 1080x1920px |
| Facebook Post | 1200x630px |
| Twitter/X Post | 1200x675px |
| Pinterest | 1000x1500px |

1. Generate background/images with `generate_image`
2. Add text overlays (headline, CTA), brand colors/fonts
3. Export in correct format

#### 2.3.3 Presentation Design

1. Receive content, design master template
2. Create slides: Title, Content, Data (charts), CTA
3. Apply consistent design, add animations if requested
4. Deliver in PPTX format

**Design Pricing Guide:**

| Service | Basic | Standard | Premium |
|---------|-------|----------|---------|
| Logo (3 concepts) | $20-40 | $50-100 | $150-300 |
| Social Media (10) | $15-30 | $40-60 | $80-120 |
| Presentation (10 slides) | $30-60 | $80-150 | $200-400 |
| Infographic | $30-60 | $80-150 | $200-350 |

---

### 2.4 Data Services

**Revenue Range**: $20-200 per project

#### 2.4.1 Data Entry
1. Receive source (images, PDFs, audio), create template
2. Extract and enter data, double-check (10% random sample)
3. Validate data types, deliver in requested format

#### 2.4.2 Data Cleaning
1. Profile data: missing values, duplicates, inconsistent formats, outliers
2. Clean: handle missing values, deduplicate, standardize, correct types
3. Deliver: clean dataset + cleaning report + change documentation

#### 2.4.3 Data Analysis & Visualization
1. Explore data (EDA), perform analysis (stats, correlation, trends)
2. Create charts, dashboards, summary tables
3. Deliver: report + visualizations + Jupyter notebook (optional)

**Data Service Pricing:**

| Service | Price Range | Turnaround |
|---------|-------------|------------|
| Data Entry (100 entries) | $10-30 | 1 day |
| Data Cleaning (1000 rows) | $30-80 | 1-2 days |
| Data Analysis + Viz | $50-200 | 2-5 days |
| Dashboard | $100-500 | 3-7 days |

---

### 2.5 Translation Services

**Revenue Range**: $0.05-0.20 per word

**Supported Pairs**: English <-> Spanish, French, German, Italian, Portuguese, Chinese, Japanese, Korean, Arabic, Hindi, Russian

**Workflow:**
1. Pre-translate with AI for base
2. Refine: cultural context, idioms, technical terms, tone
3. Quality check: back-translation, meaning preservation
4. Proofread, format to match original layout

**QA Protocol:**
```
Layer 1: AI Translation (base)
Layer 2: Cultural/Contextual Refinement
Layer 3: Grammar/Spelling Check
Layer 4: Back-translation Verification
Layer 5: Format Matching
```

---

### 2.6 Virtual Assistant Tasks

**Revenue Range**: $10-50/hour or $50-500 per project

#### 2.6.1 Email Management
- Access via delegation/IMAP, categorize (respond/archive/escalate/delete)
- Respond to routine inquiries with templates, flag urgent items
- Organize with labels, unsubscribe from unwanted lists, daily summary report

#### 2.6.2 Research Tasks
- Search multiple sources, compile findings in structured format
- Include source links, summarize key insights

**Research Quality Standards:**
```
[ ] Minimum 5 sources cited
[ ] Mix of primary and secondary
[ ] Current data (check dates)
[ ] Credible sources
[ ] Fact-checked
[ ] Executive summary included
```

#### 2.6.3 Scheduling & Calendar Management
- Respond to meeting requests per preferences, coordinate time zones
- Send invites and reminders, block focus time, daily/weekly briefs

**VA Pricing:**

| Model | Price Range |
|---|---|
| Hourly | $15-50/hr |
| Daily (4 hrs) | $50-150 |
| Weekly Retainer (20 hrs) | $300-800 |
| Per-Task | $10-100 |

---

### 2.7 Service Delivery Master Workflow

```
NEW ORDER RECEIVED
|-- Acknowledge within 1 hour (auto-message)
|-- Review requirements, ask clarifying questions within 2 hours
|-- Requirements clear? NO --> Request clarification
|-- YES --> BEGIN WORK
|   |-- Research & gather materials
|   |-- Generate/create deliverable
|   |-- Quality check against standards
|   |-- Format for delivery
|-- DELIVER with summary message, offer revisions
|-- Revision requested? YES --> Analyze --> Change --> Redeliver (within 24h)
|-- ORDER COMPLETE --> Request review --> Archive --> Update portfolio
```

---

## Playbook 3: Content Creation & Monetization

**Objective**: Build and monetize content assets across platforms using AI-powered creation workflows.

**Tools Required**: `generate_image`, `generate_speech`, `generate_video`, `browser_visit`, `web_search`, `ipython`

---

### 3.1 Faceless YouTube Channel

**Revenue Model**: AdSense, affiliate links, sponsorships, digital products
**Timeline to Monetization**: 3-6 months (1K subs + 4K watch hours)

#### 3.1.1 Niche Selection

**High-Potential Faceless Niches:**
1. Educational (tutorials, explainers, top 10s)
2. Motivational (success stories, compilations)
3. Tech Reviews (comparisons, tutorials)
4. Finance (investment explainers, market analysis)
5. Health/Fitness (routines, nutrition)
6. History (events, biographies)
7. Science (space, nature, facts)
8. Business (case studies, analysis)
9. Travel (virtual tours, guides)
10. Meditation/Sleep (ambient, guided)

**Selection Criteria** (Score 1-10 each):
```
[ ] Search demand (high monthly searches)
[ ] Competition level (lower better for new channels)
[ ] Content availability (can we generate it?)
[ ] Monetization potential (CPM rates)
[ ] Sustainability (can maintain long-term?)
[ ] Evergreen potential (stays relevant)
Minimum average: 6.5
```

#### 3.1.2 Video Production Workflow

**Phase 1: Script Generation (20-30 min)**
1. Topic selection via trends/keyword research
2. Research facts and data via `web_search`
3. Write script with structure:
   - Hook (0:00-0:10) - critical for retention
   - Intro (0:10-0:40)
   - Main content (0:40-9:00) - 4 sections
   - CTA (9:00-9:30)
   - Outro (9:30-10:00)
4. Optimize for retention: Pattern interrupts every 30-60s, curiosity gaps, direct address

**Phase 2: Voiceover (10 min)**
1. Paste script into text-to-speech tool
2. Select voice (professional, appropriate accent)
3. Generate audio (.mp3/.wav), check quality, save as `voiceover_final.mp3`
4. Settings: Speed 0.9-1.0x, natural pitch, pauses at punctuation

**Phase 3: Visual Gathering (20-30 min)**
1. Search stock footage: Pexels, Pixabay, Coverr, Mixkit, Videvo
2. Generate AI visuals for custom graphics, thumbnails, b-roll
3. Create text overlays for key points, quotes, stats
4. Organize assets by timestamp: `010_030_scene1`

**Free Stock Video Sources:**
| Source | URL |
|--------|-----|
| Pexels | `https://www.pexels.com/videos/` |
| Pixabay | `https://pixabay.com/videos/` |
| Coverr | `https://coverr.co/` |
| Mixkit | `https://mixkit.co/free-stock-video/` |
| Videvo | `https://www.videvo.net/` |

**Phase 4: Video Editing (30-60 min)**
1. Import voiceover, create timeline matching script
2. Add video clips to match narration
3. Add text overlays, transitions, background music (low volume)
4. Add intro/outro graphics
5. Export at 1080p minimum (4K preferred)

**Phase 5: Thumbnail (15 min)**
1. Generate eye-catching background with `generate_image`
2. Add bold readable text (3-5 words max), high contrast
3. Include face/expressive element for CTR
4. Export at 1280x720px

**Thumbnail Best Practices:**
- Text readable at 154x86px (small display)
- Bright contrasting colors (avoid YouTube red/white)
- Match channel branding
- Convey curiosity/surprise
- One focal point, minimal text

**Phase 6: Upload & SEO (15 min)**
1. YouTube Studio > Upload
2. **Title**: Primary keyword + compelling hook (60 chars max)
3. **Description**: 200+ words, keywords natural, CTA in first 2 lines, timestamps, links
4. **Tags**: 10-15 relevant
5. **Thumbnail**: Upload custom
6. **End screens**: Subscribe + suggested videos
7. **Cards**: 2-3 info cards
8. **Playlist**: Add to relevant playlist

**YouTube SEO Checklist:**
```
[ ] Title includes primary keyword (front-loaded)
[ ] Description 200+ words
[ ] 3-5 hashtags
[ ] 10-15 tags
[ ] Custom thumbnail
[ ] End screen configured
[ ] 2-3 cards added
[ ] Added to playlist
[ ] Category correct
[ ] Captions/subtitles added
[ ] NOT made for kids (unless actually for kids)
```

**Content Calendar:**

| Day | Video Type | Example |
|-----|-----------|---------|
| Monday | Tutorial | "How to Set Up a Budget" |
| Wednesday | Listicle | "5 Passive Income Ideas That Work" |
| Friday | Deep Dive | "How Company X Grew 1000%" |

**Upload Frequency**: Minimum 2x/week for growth
**Video Length**: 8-15 minutes optimal

---

### 3.2 Blogging (SEO-Focused)

**Revenue Model**: AdSense, affiliate links, sponsored posts, digital products
**Timeline to Revenue**: 3-6 months

#### 3.2.1 Niche & Keyword Research

**Niche Criteria:**
- Search volume: 10K+ monthly for primary keywords
- Competition: Checkable (domain authority of top 10)
- Monetization: Products/services to promote
- Evergreen: Content stays relevant

**Keyword Research Workflow:**
1. Brainstorm seed keywords
2. Use Google autocomplete for long-tail variations
3. Check search volume and difficulty
4. Analyze top 10 competition level
5. Select: Volume > 500/mo, Difficulty < 40 (new sites)
6. Group into topic clusters, create content calendar

#### 3.2.2 Article Creation Workflow

1. **Select target keyword**
2. **Analyze top-ranking content**: Length, format, gaps
3. **Create outline** (beat competitors): Cover everything they do + add unique angles
4. **Write article** (1,500-3,000 words):
   - SEO title with keyword
   - Meta description (155 chars, keyword + CTA)
   - Hook intro, H2 headings with keywords, H3 subheadings
   - Internal/external links, images with alt text, FAQ, CTA conclusion
5. **Optimize**: Keyword in title, first paragraph, 2-3 H2s, LSI keywords throughout
6. **Add affiliate links** naturally
7. **Proofread and format**

#### 3.2.3 Publishing & Promotion

1. Publish on blog
2. Submit to Google Search Console for indexing
3. Share on social media (Twitter, Pinterest, LinkedIn)
4. Add to email newsletter
5. Build internal links from existing content
6. Update quarterly with fresh information

**Blog Monetization Timeline:**

| Month | Milestone | Revenue |
|-------|-----------|---------|
| 1-2 | Publish 20-30 articles | $0 |
| 3 | Search traffic begins | $0-50 |
| 4-5 | Apply for ad networks | $50-200 |
| 6+ | Add affiliate content | $200-500+ |

---

### 3.3 Social Media Automation

#### 3.3.1 Content Calendar

| Platform | Posts/Day | Best Times (EST) |
|----------|-----------|-----------------|
| Twitter/X | 3-5 | 8am, 12pm, 5pm |
| Instagram | 1-2 | 11am, 2pm, 7pm |
| TikTok | 1-2 | 7am, 12pm, 7pm |
| LinkedIn | 1 | 8am, 12pm |
| Pinterest | 3-5 | 8pm-11pm |

#### 3.3.2 Batch Content Creation (2-3 hour weekly session)

1. **Planning** (30 min): Review trends, select 5-7 themes
2. **Text content** (45 min): 5 Twitter threads, 7 Instagram captions, 3 LinkedIn posts
3. **Visuals** (60 min): 7 Instagram graphics, 5 Pinterest pins, 3 carousel slides
4. **Video** (30 min): Plan 2 short videos, scripts, gather assets

#### 3.3.3 Scheduling

**Buffer**: `https://buffer.com` - 3 accounts free, 10 posts/queue
**Hootsuite**: `https://hootsuite.com` - 2 accounts free
**Later**: `https://later.com` - 1 account, 30 posts/mo free
**TweetDeck**: Free, unlimited (Twitter only)

Setup: Connect accounts, upload content, schedule for optimal times

#### 3.3.4 Engagement Automation

- Auto-respond DMs where allowed
- Reply to comments within 2-4 hours
- Engage 10-20 niche accounts daily
- Share UGC (with permission)
- Monitor brand mentions
- Weekly analytics review

**Engagement Budget**: ~50 min/day total

---

### 3.4 Newsletter Creation & Monetization

**Revenue Model**: Sponsorships, affiliate links, premium subscriptions
**Timeline to Revenue**: 500-1,000 subscribers for first sponsors

#### 3.4.1 Lead Magnet Creation

**Lead Magnet Ideas:** Free ebook, checklist, mini-course, resource list, exclusive report

**Workflow:**
1. Identify top pain point in niche
2. Create valuable resource addressing it
3. Design cover with `generate_image`
4. Export as PDF

#### 3.4.2 Landing Page (Beehiiv recommended)

1. Sign up at `https://www.beehiiv.com`
2. Create publication, design signup page
3. Set up welcome email sequence (3-5 emails)
4. Landing page elements: Headline, subheadline, signup form, social proof, preview

#### 3.4.3 Newsletter Content Workflow

**Weekly Format:**
```
Subject: [Curiosity-driven, < 50 chars]
[Personal greeting]
[Lead story/insight - 3-5 paragraphs]
[Curated links - 3-5 articles/tools]
[Quick tip - 2-3 paragraphs]
[Sponsor or affiliate]
[CTA - reply, share, upgrade]
```

**Steps:**
1. Research top stories via `web_search`
2. Read, summarize, add personal analysis
3. Curate 3-5 external links
4. Write actionable tip
5. Write 2-3 subject line variations
6. Preview, test send, schedule

**Frequency Options:**
| Frequency | Best For | Open Rate |
|-----------|----------|-----------|
| Daily | News-heavy | 25-35% |
| 3x/week | High-value | 30-40% |
| Weekly (recommended) | Most niches | 35-50% |
| Bi-weekly | Long-form | 40-55% |

#### 3.4.4 Monetization Pathways

**Path 1: Sponsorships** - Reach 1,000+ subs, create media kit, pitch brands
  Rate: $25-50 per 1,000 subscribers per issue

**Path 2: Affiliate Links** - Product recommendations, track conversions

**Path 3: Premium Subscriptions** - Free + paid tiers, $5-15/month

**Path 4: Digital Products** - Courses, ebooks, templates (higher margins)

---

### 3.5 Medium Partner Program

**Revenue Model**: Paid per member reading time
**Eligibility**: Stripe account in supported country

#### 3.5.1 Setup

1. Sign up at `https://medium.com` with Gmail
2. Complete profile, apply for Partner Program at `https://medium.com/creators`
3. Connect Stripe, set up tax info

#### 3.5.2 High-Earning Niches

Technology, Business, Personal Development, Writing, Science, Health, Finance, Psychology

#### 3.5.3 Story Creation Workflow

1. Topic selection via trends/keyword research
2. Create outline with hook title, compelling intro, 3-5 sections, conclusion
3. Write 1,500-3,000 words, add formatting, images (Unsplash or AI-generated)
4. Add 5 relevant tags (critical for distribution)
5. SEO title (< 100 chars), subtitle, reading time 5-8 minutes optimal

#### 3.5.4 Earnings Optimization

- Publish consistently (2-4x/week)
- Submit to publications for wider reach
- Write about Medium (meta content performs well)
- Engage with other writers
- Eye-catching featured images
- Compelling first lines

**Earnings Growth:**

| Month | Articles/Mo | Earnings |
|-------|-------------|----------|
| 1 | 8-12 | $0-50 |
| 2-3 | 8-12 | $50-200 |
| 4-6 | 8-12 | $200-500 |
| 6-12 | 8-12 | $500-2000+ |

---

### 3.6 Content Monetization Summary

```
REVENUE FLOWS
|-- YouTube: AdSense ($2-10/1K views), affiliates, memberships
|-- Blog: Display ads, affiliates, sponsored posts, products
|-- Newsletter: Sponsorships ($25-50/1K subs), affiliates, paid subs
|-- Social Media: Brand deals, affiliate traffic, product sales
|-- Medium: Partner Program (reading time), affiliate links
```

---

## Playbook 4: Trading & Crypto Operations

**Objective**: Execute trading strategies, manage crypto assets, generate returns through DeFi and trading.

**Risk Warning**: Trading involves significant risk. Never invest more than you can afford to lose.

**Tools Required**: `browser_visit`, `browser_click`, `browser_input`, `get_data_source` (binance_crypto, yahoo_finance), `shell`, `ipython`

---

### 4.1 Wallet Management

#### 4.1.1 Multi-Wallet Security Architecture

```
TIER 1: HARDWARE/COLD WALLET (60% portfolio - Long-term)
|-- Ledger or Trezor
|-- Never connects except for transactions
|-- Holds: Long-term investments
|-- Backup: Recovery phrase in secure physical location

TIER 2: HOT WALLETS (25% - Active DeFi)
|-- MetaMask (ETH, BSC, Polygon, Arbitrum)
|-- Phantom (Solana)
|-- Used for: DeFi, staking, airdrops, DEX trading
|-- Backup: Recovery phrase in encrypted digital storage

TIER 3: EXCHANGE WALLETS (15% - Trading)
|-- Binance, Coinbase, Kraken
|-- Used for: Active trading, fiat conversion
|-- Backup: 2FA + withdrawal whitelist

TIER 4: BURNER WALLETS (Minimal funds)
|-- Separate MetaMask instance
|-- Only holds gas fees
|-- Used for: New/untested protocols
```

#### 4.1.2 Security Best Practices

```
REQUIRED CHECKLIST:
[ ] Hardware wallet for holdings > $1,000
[ ] 2FA on ALL exchanges
[ ] Unique passwords everywhere (password manager)
[ ] Withdrawal whitelist enabled
[ ] Anti-phishing code set
[ ] Recovery phrases stored offline (metal backup)
[ ] Recovery phrases NEVER stored unencrypted digitally
[ ] Crypto email has 2FA
[ ] Separate email for crypto
[ ] Quarterly security audits
[ ] NEVER share private keys or seed phrases
[ ] NEVER enter seed phrases into websites
[ ] Verify links before clicking
```

**Transaction Security Protocol:**
```
BEFORE EVERY TRANSACTION:
1. Verify recipient address (first/last 6 characters)
2. Verify network/chain (ETH to BSC = lost funds)
3. Send test amount first for new addresses
4. Verify gas fees are reasonable
5. Double-check token contract address
6. Never rush transactions
```

#### 4.1.3 Transaction Tracking

| Tool | URL | Purpose |
|------|-----|---------|
| Etherscan | `https://etherscan.io` | Ethereum |
| BscScan | `https://bscscan.com` | BSC |
| Polygonscan | `https://polygonscan.com` | Polygon |
| Solscan | `https://solscan.io` | Solana |
| DeBank | `https://debank.com` | Multi-chain portfolio |
| Zapper | `https://zapper.fi` | DeFi positions |

**Setup:**
1. Create portfolio tracker spreadsheet
2. Record all wallet addresses
3. Use DeBank API or manual entry
4. Track cost basis for taxes
5. Weekly balance reconciliation

---

### 4.2 DEX Trading

#### 4.2.1 Uniswap (Ethereum)

| Parameter | Value |
|-----------|-------|
| **URL** | `https://app.uniswap.org` |
| **Chains** | Ethereum, Arbitrum, Optimism, Polygon, Base, BNB |
| **Wallet** | MetaMask or compatible |
| **Gas** | ETH (or respective chain token) |

**Step-by-Step:**
1. Navigate to `https://app.uniswap.org`, connect MetaMask
2. Select network, choose token pair
3. **Verify token contract** on Etherscan (name, symbol, holders, no honeypot)
4. Enter swap amount, review:
   - Exchange rate, price impact (< 2%)
   - Minimum received (slippage tolerance)
   - Network fee (gas)
5. **Adjust slippage**: Standard 0.5%, volatile 1-3%, extreme 5%+
6. Confirm swap, approve token if first time, confirm in MetaMask
7. Wait for blockchain confirmation, verify on Etherscan

**Price Impact Guidelines:**
```
< 1%: Safe to proceed
1-2%: Acceptable, monitor
2-5%: Large/low liquidity, consider splitting
> 5%: EXTREME RISK - Split or avoid
```

#### 4.2.2 PancakeSwap (BSC)

1. `https://pancakeswap.finance`, connect MetaMask (BSC network)
2. Trade > Swap, select tokens, verify on BscScan
3. Set slippage 1-3%, review and confirm

#### 4.2.3 Liquidity Provision

1. DEX > "Pool" or "Liquidity" > "Add Liquidity"
2. Select pair (e.g., ETH/USDC), equal dollar value
3. Review pool share and fee tier
4. Approve both tokens, confirm supply, receive LP tokens

**Impermanent Loss:**
```
Stablecoin pairs (USDC/DAI): MINIMAL risk
Major pairs (ETH/USDC): MODERATE risk
Volatile pairs (NEWTOKEN/ETH): HIGH risk
Only provide liquidity if fee earnings > potential IL
```

**DEX Safety Checklist:**
```
[ ] Token contract verified on explorer
[ ] Liquidity locked (tokensniffer.com)
[ ] No honeypot (test small amount)
[ ] Price impact < 2%
[ ] Sufficient gas token
[ ] Slippage appropriate
[ ] Correct network
[ ] Recipient is DEX router contract
```

---

### 4.3 Staking

#### 4.3.1 Exchange Staking

**Binance Earn**: `https://www.binance.com/en/earn`
- Simple Earn (flexible/locked), ETH 2.0, DeFi Staking, Launchpool
- Choose: Flexible (redeem anytime, lower APY) / Locked (fixed, higher) / DeFi (highest, most risk)

**Coinbase Staking**: `https://www.coinbase.com/staking`
- Select asset (ETH, SOL, ATOM), enter amount, confirm

#### 4.3.2 Wallet Staking (DeFi)

**Ethereum (Lido)**: `https://stake.lido.fi`
- Connect MetaMask, enter ETH amount, confirm, receive stETH
- Rewards accrue automatically (stETH balance grows)

**Solana (Phantom)**:
- Open Phantom > SOL > "Stake SOL" > Choose validator > Enter amount > Confirm
- Rewards every epoch (2-3 days)

#### 4.3.3 Staking Strategy

```
Conservative (60%):
|-- ETH staking (Lido/Rocket Pool): 4-5% APY
|-- Stablecoin lending (AAVE/Compound): 3-8% APY
|-- Exchange staking: 3-10% APY

Moderate (30%):
|-- SOL staking: 6-7% APY
|-- ATOM staking: 10-15% APY
|-- AVAX staking: 8-10% APY

Aggressive (10%):
|-- New protocols: 15-50%+ APY
|-- Liquidity mining: Variable
```

**Staking Risks:**
| Risk | Mitigation |
|------|------------|
| Slashing | Choose reputable validators |
| Smart contract risk | Use audited protocols |
| Lock-up period | Keep emergency funds liquid |
| Protocol risk | Diversify across protocols |

---

### 4.4 Airdrop Farming

#### 4.4.1 Finding Opportunities

| Source | URL |
|--------|-----|
| Airdrops.io | `https://airdrops.io` |
| CoinMarketCap | `https://coinmarketcap.com/airdrop/` |
| DefiLlama | `https://defillama.com/airdrops` |
| Twitter | @AirdropAlert, @MingoAirdrop |

#### 4.4.2 Farming Workflow

1. **Research**: Protocol with funding, no token yet, active on-chain metrics
2. **Qualify**: Bridge assets, interact (swap, lend, stake), maintain activity
3. **Track**: Record all interactions, maintain minimum balances
4. **Claim**: Follow official channels, use official claim site, verify contract
5. **Manage**: Hold, sell, or stake airdropped tokens

**High-Value Strategy:**
```
LAYER 2 PROTOCOLS:
|-- Bridge ETH to Arbitrum, Optimism, zkSync, StarkNet
|-- Use native DEXs, provide liquidity, use lending protocols

COSMOS ECOSYSTEM:
|-- Stake ATOM, participate in governance, use IBC chains

SOLANA ECOSYSTEM:
|-- Use Jupiter DEX, lending protocols, NFT marketplaces
```

**Airdrop Safety:**
```
[ ] Official source verified
[ ] NEVER share private keys
[ ] NEVER send crypto to "receive" airdrops
[ ] Check URL carefully for phishing
[ ] Revoke approvals after claiming (revoke.cash)
[ ] Use burner wallet for unknown airdrops
```

---

### 4.5 Grid Trading

#### 4.5.1 Binance Grid Trading

| Parameter | Value |
|-----------|-------|
| **URL** | `https://www.binance.com/en/trading-bot` |
| **Type** | Spot Grid (beginners) or Futures Grid |

**Step-by-Step:**
1. `https://www.binance.com/en/trading-bot` > "Spot Grid"
2. Choose pair (e.g., BTC/USDT)
3. **Set parameters**:
   - Lower Price: Support level
   - Upper Price: Resistance level
   - Grid Number: 20-100 levels
   - Investment: Total USDT to allocate
4. **Mode**: Arithmetic (stable ranges) or Geometric (volatile pairs)
5. Review grid preview, set trigger/stop-loss/take-profit (optional)
6. Confirm and create, monitor in Active Bots

**Parameter Guide:**
```
PRICE RANGE: Lower = support - 5%, Upper = resistance + 5%
GRID NUMBER: Narrow (10%): 20-40, Medium (20%): 40-80, Wide (50%+): 80-150
INVESTMENT: Max 10% of portfolio per grid
```

#### 4.5.2 Pionex Grid Trading

| Parameter | Value |
|-----------|-------|
| **URL** | `https://www.pionex.com` |
| **Advantage** | 12 free built-in bots, 0.05% fee |

1. Sign up, complete KYC, deposit USDT
2. Select pair, choose "Grid Trading Bot"
3. Use "AI Strategy" for auto-parameters or manual setup
4. Create and monitor

**Grid Best Practices:**
```
[ ] Trade high-volatility pairs
[ ] Avoid trending markets (works best sideways)
[ ] Set stop-loss
[ ] Monitor daily
[ ] Take profits, re-create periodically
[ ] Spot only, no leverage
```

---

### 4.6 DCA Strategy

#### 4.6.1 Setup

**Binance Recurring Buy:**
1. `https://www.binance.com/en/buy-sell-crypto` > "Recurring Buy"
2. Select asset, amount (e.g., $50), frequency (daily/weekly/bi-weekly/monthly)
3. Select payment, confirm and activate

**Coinbase**: Buy/Sell > Select crypto > Enter amount > "Schedule" > Select frequency > Confirm

#### 4.6.2 Portfolio Allocation

**Conservative:**
```
50% BTC | 30% ETH | 10% SOL | 10% Stablecoins
```

**Moderate:**
```
40% BTC | 25% ETH | 10% SOL | 5% AVAX | 5% ATOM | 5% MATIC | 5% LINK | 5% Stablecoins
```

**DCA Rules:**
```
1. NEVER skip scheduled purchases
2. DON'T time the market
3. INCREASE during significant dips (optional)
4. REVIEW allocation quarterly
5. HOLD 2+ years minimum
6. TRACK cost basis for taxes
7. WITHDRAW to personal wallet for security
```

---

### 4.7 Crypto Operations Daily/Weekly Schedule

```
DAILY:
[ ] Check portfolio (DeBank/Zapper)
[ ] Review staking rewards
[ ] Check grid bot performance
[ ] Review pending transactions
[ ] Check airdrop claim opportunities

WEEKLY:
[ ] Adjust grid parameters if needed
[ ] Check new airdrop opportunities
[ ] Verify security (no unauthorized access)
[ ] Update portfolio spreadsheet
[ ] Review DCA purchases

MONTHLY:
[ ] Rebalance portfolio
[ ] Claim and compound staking rewards
[ ] Review tax reporting
[ ] Security audit (revoke unnecessary approvals)
[ ] Update cost basis records
```

---

## Playbook 5: E-commerce Operations

**Objective**: Build and operate profitable e-commerce businesses.

**Tools Required**: `generate_image`, `browser_visit`, `browser_click`, `browser_input`, `ipython`, `shell`

---

### 5.1 Print-on-Demand (POD)

**Overview**: Create designs, upload to POD, sell on marketplaces. Platform handles fulfillment.
**Timeline to First Sale**: 1-4 weeks
**Startup Cost**: $0-50

#### 5.1.1 Niche & Design Strategy

**High-Performing Niches:** Professions, Hobbies, Relationships, Humor, Motivation, Seasonal, Identity

**Selection Framework** (Score 1-10 each):
```
[ ] Audience size [ ] Passion level [ ] Design potential
[ ] Competition level [ ] Evergreen potential [ ] Cross-product appeal
Minimum average: 7.0
```

#### 5.1.2 Design Creation Workflow

1. **Research**: Search Etsy/Amazon for best sellers, check Pinterest, social hashtags
2. **Generate concepts**: `generate_image` for 5-10 variations per concept
3. **Design specs by product:**

| Product | Dimensions | Format | Background |
|---------|-----------|--------|------------|
| T-shirt (front) | 4500x5400px | PNG | Transparent |
| T-shirt (pocket) | 1800x1800px | PNG | Transparent |
| Mug | 2700x1125px | PNG | Transparent |
| Phone case | 2200x3400px | PNG | Transparent |
| Tote bag | 4500x5400px | PNG | Transparent |
| Poster | 3000x4200px | JPG | White |

4. **Text designs**: Bold readable fonts, max 2-3 styles, large enough for printing
5. **Illustration designs**: High-res, vector-style, test on multiple backgrounds
6. **Mockups**: Generate product mockups with `generate_image`, lifestyle/context images

#### 5.1.3 Printful Setup & Integration

| Parameter | Value |
|-----------|-------|
| **URL** | `https://www.printful.com` |
| **Products** | 300+ (apparel, accessories, home goods) |

**Step-by-Step:**
1. `https://www.printful.com/sign-up`, complete profile
2. Add products: Catalog > Category > Product > Upload design > Position on mockup
3. Set pricing (Printful base + your margin)
4. Configure shipping regions
5. **Connect sales channel**:
   - Etsy: Store Manager > Apps > Printful
   - Shopify: Apps > Search "Printful" > Install
6. Sync products, **place test order** (highly recommended)
7. Publish listings

**Pricing Strategy:**
```
T-shirts: Base $8-12, Retail $22-28 (100%+ markup)
Mugs: Base $7-9, Retail $16-20
Phone cases: Base $10-12, Retail $20-25
Tote bags: Base $12-15, Retail $24-30
Posters: Base $8-12, Retail $18-25
Always check competitor pricing!
```

#### 5.1.4 Etsy POD Integration

1. In Printful: Stores > Etsy > Connect > Authorize
2. Create products in Printful, publish to Etsy
3. **Optimize Etsy listings**:
   - Title: Keyword-rich, 140 chars max
   - Tags: All 13 tags, long-tail keywords
   - Images: Use all 10 slots (mockups + flat designs)
   - Processing time: 3-5 days for POD
4. Etsy SEO: Front-load title with keyword, use all 13 tags, renew regularly

#### 5.1.5 Shopify POD Integration

1. Shopify Admin > Apps > Printful > Install > Connect
2. Add products in Printful, sync to Shopify
3. Optimize product pages: Compelling title, description, mockups, size chart
4. Set up automated emails: Confirmation, shipping, review request

#### 5.1.6 Daily Operations

```
DAILY:
[ ] Check orders (auto-fulfilled but verify)
[ ] Respond to customer messages (within 24h)
[ ] Check inventory/stock issues
[ ] Check sales analytics
[ ] Create 1-3 new designs
[ ] Optimize underperforming listings

WEEKLY:
[ ] Analyze best sellers, create similar designs
[ ] Review customer feedback
[ ] Update mockups if needed
[ ] Research trending niches
[ ] Add new products to best sellers

MONTHLY:
[ ] Review profit margins per product
[ ] Remove zero-sales listings after 3 months
[ ] Plan holiday designs
[ ] Evaluate Printful vs alternatives (SPOD, Gooten)
```

---

### 5.2 Digital Products

**Types**: Ebooks, templates, courses, tools, graphics, presets, printables
**Margins**: 90%+ after creation

#### 5.2.1 Product Ideation

**Discovery Framework:**
```
1. IDENTIFY PROBLEMS: Search forums, Reddit, Quora for pain points
2. VALIDATE DEMAND: Check search volume, existing product reviews
3. ASSESS COMPETITION: Count products, check quality, find differentiation
4. DETERMINE FORMAT: PDF, Video, Software, Audio
```

#### 5.2.2 Creation Workflow

**Ebook/Guide:**
1. Outline: 8-12 chapters, target audience, transformation
2. Write content (AI-assisted), include actionable steps, visuals
3. Design: Professional cover (`generate_image`), formatting, TOC, CTA boxes
4. Export: PDF (primary), EPUB (optional), MOBI (optional)
5. Preview on multiple devices

**Template/Tool:**
1. Identify type (Excel, Notion, Canva, WordPress)
2. Build functional template with instructions, example data
3. Package: Template file + Instruction PDF + Demo video (optional)

#### 5.2.3 Gumroad Listing

1. `https://app.gumroad.com/dashboard` > Products > New product
2. Product details: Name, URL slug, description, cover image (1280x720px)
3. Upload files (max 250MB free, 16GB premium)
4. Pricing: Fixed / Pay-what-you-want / Free
5. Advanced: License keys, ratings, variants, quantity limits
6. Publish

#### 5.2.4 Marketing Funnel

```
AWARENESS: Free content (blog, social, YouTube), SEO articles
INTEREST: Lead magnet (free chapter, preview, checklist) --> Email capture
CONSIDERATION: Email sequence (5-7 emails):
  Email 1: Welcome + deliver lead magnet
  Email 2: Problem agitation
  Email 3: Solution preview
  Email 4: Social proof
  Email 5: Case study
  Email 6: FAQ/objection handling
  Email 7: Limited offer
PURCHASE: Gumroad checkout + launch pricing + bonus stack
POST-PURCHASE: Welcome email, follow-up, upsell, review request
```

**Pricing Guide:**

| Product | Entry | Premium | Typical |
|---------|-------|---------|---------|
| Printable | $3-7 | $15-25 | $5-15 |
| Ebook | $7-15 | $30-50 | $10-27 |
| Template Pack | $10-20 | $40-80 | $17-47 |
| Online Course | $50-100 | $200-500 | $97-297 |
| Tool/Software | $20-50 | $100-300 | $27-97 |
| Membership | $10-20/mo | $50-100/mo | $20-50/mo |

---

### 5.3 Dropshipping

**Platforms**: Shopify, WooCommerce, Facebook Marketplace

#### 5.3.1 Store Setup

1. Set up Shopify (Playbook 1.5.2)
2. Install dropshipping app:
   - **DSers** (AliExpress integration)
   - **Spocket** (US/EU suppliers)
   - **Zendrop** (curated suppliers)
   - **CJ Dropshipping**
3. Configure app settings

#### 5.3.2 Product Selection

**Criteria:**
```
[ ] Price: $20-80 retail sweet spot
[ ] Cost: Under 30% of selling price
[ ] Weight: Lightweight
[ ] Size: Small
[ ] Problem-solving: Specific pain point
[ ] Impulse buy: Minimal research needed
[ ] Not in local stores
[ ] Good supplier rating
```

**Research Sources:** AliExpress best sellers, Amazon Movers & Shakers, TikTok trends, Google Trends, Facebook Ad Library

#### 5.3.3 Supplier Integration (DSers + AliExpress)

1. Install DSers app, connect AliExpress
2. Browse/import products, edit title/description/images
3. Set pricing rules (auto-markup)
4. Map variants, set shipping methods (ePacket, AliExpress Standard)

#### 5.3.4 Order Automation

```
Customer orders --> Order in DSers
  Option A (Manual): Click "Order" in DSers, auto-fills AliExpress
  Option B (Auto): Enable auto-order
Supplier ships --> Tracking auto-syncs --> Customer gets confirmation
```

#### 5.3.5 Customer Service Templates

**Shipping Inquiry:**
```
"Thank you for your order! Your package is on its way.
Track it here: [link]. Expected delivery: [date].
Let us know if you have questions!"
```

**Return Request:**
```
"We're sorry it didn't meet expectations. We offer full refunds
within 30 days. Please [send photo/provide order number].
We'll resolve this within 24 hours."
```

#### 5.3.6 Daily Operations

```
DAILY:
[ ] Check/fulfill orders
[ ] Respond to customer messages
[ ] Check tracking for delays
[ ] Monitor ad performance (if running ads)

WEEKLY:
[ ] Analyze sales data and margins
[ ] Remove low-performers, add trending products
[ ] Check competitor pricing
[ ] Review customer feedback

MONTHLY:
[ ] Calculate net profit (revenue - COGS - ads - fees)
[ ] Optimize descriptions
[ ] Update pricing
[ ] Review supplier performance
[ ] Plan seasonal products
```

**Profit Calculation:**
```
Revenue - Product cost - Shipping - Payment processing (2.9%+$0.30)
- Platform fee ($29/mo) - App fees - Advertising - Refunds (2-5%)
= NET PROFIT (Target: 20-40% margin)
```

---

### 5.4 E-commerce Model Comparison

```
Print-on-Demand:  Startup $0-50 | Margins 30-50% | Scalability High | Risk Low
Digital Products:  Startup $0-100 | Margins 90%+ | Scalability Infinite | Risk Very Low
Dropshipping:      Startup $50-500 | Margins 20-40% | Scalability High | Risk Medium
```

---

## Playbook 6: Scaling & Growth

**Objective**: Scale operations through automation, delegation, and partnerships.

**Tools Required**: `browser_visit`, `browser_click`, `browser_input`, `ipython`, `shell`

---

### 6.1 Hiring Virtual Assistants

#### 6.1.1 Finding VAs

| Platform | URL | Best For | Rate Range |
|----------|-----|----------|------------|
| OnlineJobs.ph | `https://www.onlinejobs.ph` | Long-term Filipino VAs | $3-8/hr |
| Upwork | `https://www.upwork.com` | Project-based skilled VAs | $5-25/hr |
| Fiverr | `https://www.fiverr.com` | Task-based services | $5-50/task |
| Belay | `https://belaysolutions.com` | US-based professional | $15-40/hr |
| Time Etc | `https://www.timeetc.com` | UK/US VAs | $20-35/hr |

#### 6.1.2 Hiring Process

1. **Define tasks**: List all current tasks, mark repetitive/rule-based vs expertise-required
2. **Create job description**:
```
TITLE: Virtual Assistant - [Role, e.g., "E-commerce Order Processing"]
RESPONSIBILITIES:
- [Task 1] - [Task 2] - [Task 3]
- Hours: [X/week] - Tools: [List]
REQUIREMENTS:
- [Skill 1] - [Skill 2]
- Availability: [Timezone] - Experience: [Level]
COMPENSATION: $X/hour via [PayPal/Upwork], [Weekly/Bi-weekly]
```
3. **Post and screen**: Review applications, check reviews, shortlist top 5
4. **Interview**: Initial message, video interview (long-term), paid test task
5. **Hire and onboard**: Send offer, provide training materials, set up tool access

#### 6.1.3 VA Training System

```
TRAINING DOCUMENTATION:
1. ROLE OVERVIEW: Purpose, how it fits, success metrics
2. TOOLS ACCESS: Login via secure method, tutorials
3. TASK LIBRARY: Per task: purpose, steps (screenshots), issues, standards, time
4. COMMUNICATION: Daily check-in format, escalation, reporting
5. QUALITY CONTROL: Review process (2 weeks), error correction, performance reviews
```

#### 6.1.4 Delegation Priority Matrix

```
DELEGATE FIRST (High Impact, Low Skill):
[ ] Data entry and copying
[ ] Order processing
[ ] Customer service (template-based)
[ ] Social media posting (pre-created)
[ ] Email management
[ ] Research tasks
[ ] Listing creation (templates)

DELEGATE LATER (Medium Impact):
[ ] Content creation (with guidelines)
[ ] Design work (with briefs)
[ ] Ad management (with oversight)
[ ] Product research

KEEP IN-HOUSE (Strategic):
[ ] Strategy and planning
[ ] High-stakes client communication
[ ] Financial decisions
[ ] Partnership negotiations
```

**VA Progression:**

| Week | Tasks | Supervision |
|------|-------|-------------|
| 1-2 | Simple, documented | Daily check-ins |
| 3-4 | More complex | Every other day |
| 5-8 | Independent | Weekly review |
| 9+ | Full delegation | Monthly review |

---

### 6.2 Building Automation Scripts

**Objective**: Create reusable Python scripts for repetitive tasks.

#### 6.2.1 Script Categories

**Category 1: Data Collection**
- Competitor price monitoring
- Market research scraping
- Trend tracking

**Category 2: Content Automation**
- Social media post generation from templates
- Cross-platform content distribution
- Engagement metric collection

**Category 3: Financial Tracking**
- Multi-platform revenue aggregation
- P&L report generation
- Tax summary preparation

**Category 4: Customer Service**
- Auto-response to common queries
- Ticket categorization and routing
- Follow-up sequences

**Category 5: Inventory & Listings**
- Multi-platform stock sync
- Pricing rule automation
- Out-of-stock monitoring

#### 6.2.2 Development Standards

```
ALL SCRIPTS MUST HAVE:
[ ] README.md (setup + usage)
[ ] requirements.txt
[ ] Config file for settings
[ ] Error handling and logging
[ ] Input validation
[ ] .env for credentials (no hardcoded secrets)
[ ] Rate limiting for APIs
[ ] Backup/restore for data
[ ] Scheduling instructions (cron/systemd)
[ ] Monitoring/alerts for failures
```

#### 6.2.3 Automation Architecture

```
SCHEDULED:
|-- Daily 8am: Revenue report
|-- Daily 10am: Competitor price check
|-- Daily 2pm: Social media scheduling
|-- Daily 6pm: Email auto-response
|-- Weekly Mon: Dashboard update
|-- Weekly Fri: Data backup

EVENT-DRIVEN:
|-- New order --> Auto-fulfillment check
|-- New message --> Auto-response + notification
|-- Price threshold --> Alert
|-- Low stock --> Reorder notification
|-- Negative review --> Escalation alert
```

---

### 6.3 API Integrations

#### 6.3.1 Key APIs

| API | URL | Use |
|-----|-----|-----|
| Etsy API | `https://developers.etsy.com` | Listings, orders, reviews |
| Shopify API | `https://shopify.dev/api` | Full store management |
| Gumroad API | `https://gumroad.com/api` | Sales data, products |
| Binance API | `https://binance-docs.github.io/apidocs` | Trading, portfolio |
| Stripe API | `https://stripe.com/docs/api` | Payments, subscriptions |
| Twitter API | `https://developer.twitter.com/en/docs` | Posting, analytics |

#### 6.3.2 Integration Patterns

**Revenue Aggregation:**
```
Etsy + Shopify + Gumroad + Stripe --> Central Dashboard
```

**Inventory Sync:**
```
Printful API --> Central DB --> Etsy + Shopify
```

**Customer Sync:**
```
Shopify + Gumroad + Email --> CRM/Email Marketing
```

#### 6.3.3 API Security

```
[ ] Keys in .env (never in code)
[ ] Environment variables for secrets
[ ] Rate limiting
[ ] Webhook signature verification
[ ] Encrypt sensitive data at rest
[ ] Rotate keys quarterly
[ ] Read-only keys where possible
[ ] Log all API calls
[ ] Retry logic with exponential backoff
[ ] Graceful error handling
```

---

### 6.4 Partnership Outreach

#### 6.4.1 Partnership Types

| Type | Description | Value Exchange |
|------|-------------|----------------|
| Cross-promotion | Promote each other | Audience exposure |
| Affiliate | Promote for commission | Revenue share |
| Content collab | Joint content | Shared content, backlinks |
| Joint product | Create together | Revenue split |
| Supplier | Better terms | Cost savings |
| Influencer | Creator collab | Exposure |
| Guest posting | Write for each other | Backlinks |

#### 6.4.2 Finding Partners

**Sources:** Social media hashtags, blog directories, YouTube, podcasts, Reddit/Discord, competitor analysis

**Selection Criteria:**
```
[ ] Complementary (not competitive) audience
[ ] Similar or larger audience size
[ ] Aligned brand values
[ ] Quality products/content
[ ] Active, engaged audience
[ ] Professional communication
```

#### 6.4.3 Outreach Templates

**Cold Outreach:**
```
Subject: Collaboration Idea - [Your Brand] x [Their Brand]

Hi [Name],
I've been following [Their Brand] and really admire [specific thing].
Your [content/product] on [topic] was particularly valuable.

I'm [Your Name] from [Your Brand] ([what you do]). Our audience of
[number] [description] would love your work.

Idea: [brief pitch - 2 sentences]
Open to a 15-minute chat?
Best, [Your Name] [Website]
```

#### 6.4.4 Partnership Management

**CRM Tracking:**
```
Partner: [Name] | Brand: [Brand] | Type: [Cross-promo/Affiliate]
Status: [Outreach/Active/Completed] | Last Contact: [Date]
Next Action: [Task] | Value: [Revenue/Growth]
```

**Follow-up:** Day 1 (initial), Day 5 (first follow-up), Day 12 (second), Day 21 (final)

---

### 6.5 Review Building & Social Proof

**IMPORTANT**: Never use fake/purchased reviews. Violates terms, risks permanent bans.

#### 6.5.1 Ethical Strategies

**Strategy 1: Follow-up Sequence**
```
Day 1: Order confirmation
Day 7 (post-delivery): "How's everything? Any issues?"
Day 14 (if satisfied): "Please leave a review? It helps! [Link]"
Day 30: Thank you note
```

**Strategy 2: Platform-Permitted Incentives**
- Discount on next purchase for honest review
- Must disclose; cannot require positive review

**Strategy 3: Beta Tester Program**
- Free/discounted product to early users
- Request honest feedback
- Turn testimonials into reviews

**Strategy 4: Exceptional Service**
- Over-deliver, fast response, bonus notes
- Fix problems immediately and generously
- Delighted customers review organically

#### 6.5.2 Review Response Templates

**Positive:**
```
"Thank you [Name]! We're thrilled you loved [specific mention].
It was a pleasure working with you. Feel free to reach out anytime!"
```

**Negative:**
```
"Hi [Name], sorry about [issue]. Customer satisfaction is our priority.
Contact us at [email] and we'll resolve this immediately.
Thank you for your patience."
```

#### 6.5.3 Social Proof Collection

```
REVIEWS: Etsy, Fiverr/Upwork, Google, Trustpilot
TESTIMONIALS: Quotes with name/photo, video testimonials, case studies
SOCIAL SIGNALS: Followers, engagement, UGC, press mentions
```

---

### 6.6 Scaling Master Plan

```
PHASE 1: FOUNDATION (Months 1-3)
[ ] Core systems automated
[ ] 1-2 VAs for repetitive tasks
[ ] Basic scripts operational
[ ] 2-3 partnerships
[ ] 20+ reviews per platform

PHASE 2: ACCELERATION (Months 4-6)
[ ] API integrations complete
[ ] 3-5 specialized VAs
[ ] Advanced automation
[ ] 5-10 partnerships
[ ] 50+ reviews per platform

PHASE 3: SCALE (Months 7-12)
[ ] Full automation of routine ops
[ ] VA team 5-10 people
[ ] Real-time dashboards
[ ] 10-20 partnerships
[ ] 100+ reviews
[ ] Consider incorporation
```

---

## Playbook 7: Emergency & Troubleshooting

**Objective**: Handle crises, account issues, payment problems, security incidents with minimal business impact.

**Tools Required**: `browser_visit`, `browser_click`, `browser_input`, `browser_screenshot`, `shell`

---

### 7.1 Account Banned / Suspended

#### 7.1.1 Immediate Response (Within 1 hour)

**Assessment:**
```
BAN RECEIVED
|-- What platform? (E-commerce/Freelancing/Content/Payment/Crypto)
|-- What type? (Temporary suspension / Permanent ban / Warning)
|-- What reason? (Policy violation / ToS / Suspicious activity / IP / None given)
```

**Evidence Gathering:**
- Screenshot ban notice, account activity, order records, communication history
- Document timeline

**Policy Review:**
- Read cited policy, check if justified, identify misunderstandings

#### 7.1.2 Appeal Process by Platform

**Etsy:**
1. Check email for reason
2. `https://www.etsy.com/help/contact` > "Reopening a Suspended Account"
3. Submit appeal: Explain, acknowledge mistakes, state corrections, provide evidence
4. Wait 2-5 days. Can appeal once more. If final: New shop with different identity (last resort)

**Upwork:**
1. Check email, submit appeal at `https://support.upwork.com`
2. Be specific. Wait 3-7 days. Rarely reverses permanent bans.
3. Alternative: New account with different email/identity

**Fiverr:**
1. Check violation, contact `https://www.fiverr.com/support`
2. Submit appeal. Wait 2-5 days. Sometimes gives second chances.
3. If permanent: New account (different email + IP)

**PayPal Limited:**
1. Log in > Resolution Center > View limitation
2. Complete ALL actions: Upload ID, proof of address, supplier invoices
3. Call 1-888-221-1161, ask for timeline
4. Follow up every 2-3 days. If permanently limited: Business account with different entity

**YouTube Termination:**
1. Check Community Guidelines violation cited
2. Submit appeal at `https://support.google.com/youtube/contact/terminated`
3. Wait 1-2 weeks. Rarely reinstates.
4. If denied: New Google account and channel (follow all guidelines strictly)

#### 7.1.3 Prevention

```
[ ] Read and follow all ToS
[ ] Don't use VPN/proxy for access
[ ] Maintain consistent IP/geolocation
[ ] Respond to warnings immediately
[ ] Keep documentation (invoices, licenses)
[ ] Don't create multiple accounts
[ ] Use original content only
[ ] Deliver on commitments
[ ] Excellent customer service
[ ] Keep verification info current
[ ] Use real identity matching payment accounts
[ ] Monitor account health regularly
```

**Recovery Decision Tree:**
```
SUSPENDED
|-- Justified? YES --> Fix issue --> Appeal --> Denied? --> Fresh start
|-- NO? --> Gather evidence --> Strong appeal --> Denied? --> Escalate --> Still denied? --> Legal or fresh start
|-- Critical account? YES --> Prioritize appeal + activate backup plan
BACKUP: Maintain 2-3 platforms, no single platform >50% revenue, backup payment ready, customer email list outside platforms
```

---

### 7.2 Payment Issues

#### 7.2.1 PayPal Holds

**Causes**: New seller, sales spike, high disputes, suspicious activity, expired verification

**Resolution:**
1. Resolution Center > View limitation > Complete ALL required actions
2. Call 1-888-221-1161, ask timeline, follow up every 2-3 days

**Prevention:**
```
[ ] Gradual payment growth (no $100 to $10K overnight)
[ ] Tracked shipping for all orders
[ ] Mark shipped immediately
[ ] Respond to disputes within 24h
[ ] Maintain <1% dispute rate
[ ] Keep verification current
[ ] Enable Seller Protection
[ ] Consistent business name across platforms
```

#### 7.2.2 Stripe Issues

1. Check Dashboard for notifications
2. Respond to verification requests immediately
3. For disputes: Submit evidence within deadline

**Dispute Evidence:**
```
[ ] Proof of delivery (tracking + confirmation)
[ ] Customer communication
[ ] Product description
[ ] Customer IP + timestamp
[ ] Receipt/invoice
[ ] Terms of service
[ ] Customer acknowledgment
```

#### 7.2.3 Payment Processor Alternatives

| Primary | Backup 1 | Backup 2 | Backup 3 |
|---------|----------|----------|----------|
| PayPal | Stripe | Square | Wise Business |
| Stripe | PayPal | Square | Braintree |
| Square | Stripe | PayPal | SumUp |

**Crypto Alternatives:**
| Processor | URL |
|-----------|-----|
| Coinbase Commerce | `https://commerce.coinbase.com` |
| NOWPayments | `https://nowpayments.io` |
| BTCPay Server | `https://btcpayserver.org` |

#### 7.2.4 International Payments

| Tool | URL | Best For |
|------|-----|----------|
| Wise | `https://wise.com` | Low-cost transfers |
| Payoneer | `https://www.payoneer.com` | Global receiving |
| Revolut | `https://www.revolut.com` | Multi-currency |
| OFX | `https://www.ofx.com` | Large transfers |

---

### 7.3 Negative Reviews & Reputation

#### 7.3.1 Response Protocol (Within 24 hours)

1. Read carefully (don't react emotionally)
2. Determine legitimacy, check history
3. Draft professional response, attempt private resolution, post public response

**Product Issue Response:**
```
"Hi [Name], we sincerely apologize that [product] didn't meet expectations.
We take this seriously and want to make it right.
Contact us at [email] so we can resolve this."
```

**Shipping Issue Response:**
```
"Hi [Name], sorry for the shipping delay. Here's what happened: [explanation].
Here's what we're doing: [solution].
Contact us at [email] for [refund/replacement/discount]."
```

**Wrong Seller Response:**
```
"Hi [Name], this review seems to be for a different seller.
If you purchased from us, please contact [email] with order number."
```

#### 7.3.2 Review Removal

**Removable when:** Profanity, personal info, wrong seller, promotional content, fraudulent

| Platform | Process |
|----------|---------|
| Etsy | Shop Manager > Reviews > "Report this review" |
| Fiverr | Cannot remove; respond publicly; earn positive reviews |
| Google | Maps > Review > "Flag as inappropriate" |

#### 7.3.3 Proactive Reputation Management

```
[ ] Respond to ALL reviews within 24h
[ ] Maintain 95%+ positive rate
[ ] Generate 3-5 positive per negative
[ ] Monitor mentions (Google Alerts)
[ ] Address issues before public complaints
[ ] Create positive content ranking for brand name
[ ] Engage with community
[ ] Be transparent about mistakes
```

---

### 7.4 Platform Policy Changes

#### 7.4.1 Monitoring

```
TRACK: Platform blog, newsletters, forums, industry news, Reddit communities,
       Twitter executives, Google Alerts for "[platform] policy change"
```

#### 7.4.2 Response Framework

```
POLICY CHANGE DETECTED
|-- What changed?
|   Fee increase? --> Calculate impact --> Adjust pricing --> Find savings --> Consider alternatives
|   New restriction? --> Review operations --> Modify process --> Document
|   Feature removal? --> Find alternative --> Implement replacement --> Test
|   New requirement? --> Gather docs --> Submit by deadline --> Follow up
|-- Impact: Revenue [X%], Operational [changes], Deadline [date], Severity [C/H/M/L]
```

#### 7.4.3 Platform Diversification

```
REVENUE TARGETS: Primary <40%, Secondary 25-35%, Tertiary 15-25%, Direct 10-20%

ALTERNATIVES:
Etsy --> Amazon Handmade, Shopify, Big Cartel, Folksy
Fiverr --> Upwork, Freelancer, PeoplePerHour, Toptal
YouTube --> Rumble, Odysee, Vimeo, TikTok
Shopify --> WooCommerce, BigCommerce, Squarespace
PayPal --> Stripe, Square, Wise, crypto
Amazon Associates --> Impact, Sovrn, Awin
```

---

### 7.5 Scam Detection & Avoidance

#### 7.5.1 Common Scams

**Scam 1: Fake Buyer Overpayment**
- Red flags: Overpays, asks refund of difference, "accidental" overpayment, pressure
- Response: NEVER refund overpayments, cancel order, report

**Scam 2: Phishing (Fake Login Pages)**
- Red flags: Urgent suspension email, similar but wrong URL, password/2FA request, urgency
- Response: NEVER click email links, type URL directly, check sender, flag phishing

**Scam 3: Investment/Ponzi**
- Red flags: Guaranteed returns, requires recruiting, unregistered, pressure, crypto payment required
- Response: If too good to be true, it is. Never invest in unregistered schemes.

**Scam 4: Fake Freelancing Jobs**
- Red flags: Pay to start, banking info upfront, "sample" is real work, rate too high, off-platform comms
- Response: Never pay to get a job, use platform messaging, research client

**Scam 5: Rug Pull (Crypto)**
- Red flags: Anonymous team, no locked liquidity, unusual tokenomics, no working product, no audit
- Response: Check team backgrounds, verify locked liquidity (DexScreener), read contract, use tokensniffer.com, rugcheck.xyz

**Scam 6: Chargeback Fraud**
- Red flags: "Not received" when delivered, "not as described" won't return, stolen card, large order new account
- Response: Use tracked shipping, require signatures, document everything, submit dispute evidence

#### 7.5.2 Verification Checklist

```
BEFORE ENGAGING:
[ ] Website > 1 year old (whois)
[ ] Verifiable physical address
[ ] Active social media with real engagement
[ ] Independent reviews (Trustpilot, Reddit)
[ ] No scam reports (ScamAdviser)
[ ] Verifiable team LinkedIn
[ ] Registered/incorporated business
[ ] Payment methods with buyer protection
[ ] Terms and conditions exist
[ ] Responsive contact info
[ ] Returns/refund policy
[ ] No grammar errors on site

3+ FAILS = HIGH RISK - DO NOT PROCEED
2 FAILS = MEDIUM RISK - PROCEED WITH CAUTION
```

#### 7.5.3 Reporting Scams

| Authority | URL |
|-----------|-----|
| FTC | `https://reportfraud.ftc.gov` |
| IC3 (FBI) | `https://www.ic3.gov` |
| Platform | Use "Report" function |
| Google | `https://safebrowsing.google.com/safebrowsing/report_phish` |
| Crypto | `https://chainabuse.com` |

---

### 7.6 Security Breach Response

#### 7.6.1 Immediate Response (First 30 Minutes)

```
STEP 1 (0-5 min): ASSESS
|-- What compromised? (Password/Email/Wallet/Exchange/System)
|-- What do attackers have access to?
|-- Is attack ongoing?

STEP 2 (5-15 min): CONTAIN
|-- Change ALL passwords (start with email)
|-- Revoke all active sessions
|-- Disable API keys
|-- Transfer crypto to new wallets (if compromised)
|-- Freeze exchange accounts
|-- Disconnect internet if system compromised

STEP 3 (15-30 min): SECURE
|-- Enable 2FA on all (use NEW device if old compromised)
|-- Generate new API keys
|-- Create new wallets, transfer funds
|-- Scan devices for malware
|-- Check unauthorized transactions
|-- Document everything
```

#### 7.6.2 Recovery (Next 24-48 Hours)

```
[ ] File police report (significant loss)
[ ] Contact bank/credit cards
[ ] Report to platforms
[ ] Document losses with evidence
[ ] Change security questions
[ ] Revoke third-party app access
[ ] Check all accounts for unauthorized changes
[ ] Notify partners/customers if their data affected
[ ] Implement additional security
```

#### 7.6.3 Crypto-Specific Incidents

**Wallet Compromised:**
```
1. Create new wallet on CLEAN device IMMEDIATELY
2. Transfer ALL remaining funds
3. NEVER use compromised wallet again
4. Identify cause: Phishing? Malware? Seed phrase exposed? Malicious dApp?
5. Report to authorities
6. Consider hardware wallet
```

**Exchange Hacked:**
```
1. Change password
2. Re-enroll 2FA with new device
3. Check withdrawal history
4. Freeze account via support
5. Report unauthorized transactions
6. Revoke all API keys, create new
7. Enable all security features
```

#### 7.6.4 Post-Incident Hardening

```
[ ] Hardware wallet for significant holdings
[ ] Dedicated crypto email
[ ] Password manager (unique everywhere)
[ ] 2FA on ALL (hardware key preferred)
[ ] Weekly security audits
[ ] Transaction monitoring alerts
[ ] Whitelist withdrawal addresses
[ ] Seed phrases NEVER digital
[ ] Regular device scans
[ ] Separate burner wallet for risky interactions
[ ] Multi-sig wallets for large amounts
[ ] Regular data backups
```

---

### 7.7 Emergency Contact Directory

**Payment Processors:**
- PayPal: 1-888-221-1161
- Stripe: Via dashboard or support@stripe.com
- Square: 1-855-700-6000
- Wise: Via app or help@wise.com

**Platform Support:**
- Etsy: help@etsy.com / Shop Manager > Help
- Shopify: Via admin / 1-888-746-7439
- Fiverr: Via help center
- Upwork: Via help portal
- YouTube: Via Creator Studio > Help

**Crypto Exchanges:**
- Binance: Via in-app support chat
- Coinbase: Via help center / support@coinbase.com
- Kraken: Via support portal

**Security Tools:**
- Revoke.cash: `https://revoke.cash` (revoke approvals)
- Chainabuse: `https://chainabuse.com` (report crypto scams)
- HaveIBeenPwned: `https://haveibeenpwned.com`
- VirusTotal: `https://www.virustotal.com`

**Legal/Regulatory:**
- FTC: `https://reportfraud.ftc.gov`
- IC3 (FBI): `https://www.ic3.gov`
- IdentityTheft.gov: `https://www.identitytheft.gov`

---

## Appendix A: Tool Reference Matrix

| Tool | Purpose | Playbooks |
|------|---------|-----------|
| `browser_visit` | Load web pages | All |
| `browser_click` | Click buttons/links | All |
| `browser_input` | Fill form fields | 1, 5 |
| `browser_screenshot` | Capture page state | All |
| `browser_find` | Locate elements | All |
| `web_search` | Research | 2, 3, 5 |
| `search_image_by_text` | Find images | 2, 3, 5 |
| `search_image_by_image` | Reverse image search | 2, 5 |
| `generate_image` | Create designs | 2, 3, 5 |
| `generate_speech` | Voiceovers | 3 |
| `generate_video` | Video content | 3 |
| `generate_sound_effects` | Audio elements | 3 |
| `get_available_voices` | Voice selection | 3 |
| `get_data_source` | Financial data | 4 |
| `ipython` | Data processing, scripts | 2, 4, 5, 6 |
| `shell` | System operations | 6 |

---

## Appendix B: Daily Operations Schedule

```
06:00-06:30: Check overnight orders, emails, messages
06:30-07:00: Review portfolio, staking, grid bot
07:00-07:30: Respond to urgent messages
07:30-08:00: Check airdrop claims, opportunities
08:00-10:00: Service delivery (priority client work)
10:00-10:15: Break
10:15-12:00: Content creation (writing, design, video)
12:00-13:00: Lunch
13:00-14:00: Platform management (listings, optimization)
14:00-15:00: Marketing (social media, outreach)
15:00-16:00: Automation development / script maintenance
16:00-16:30: Review VA work, feedback
16:30-17:00: Financial reconciliation, reporting
17:00-17:30: Plan next day, review goals
```

---

## Appendix C: Revenue Tracking Template

```
WEEKLY REVENUE:
Freelancing:   Fiverr $____ + Upwork $____ + Direct $____ = $____
E-commerce:    Etsy $____ + Shopify $____ + Gumroad $____ = $____
Content:       YouTube $____ + Medium $____ + Newsletter $____ = $____
Affiliate:     Amazon $____ + ClickBank $____ + ShareASale $____ = $____
Crypto:        Staking $____ + Trading $____ + Airdrops $____ = $____
TOTAL REVENUE: $____
EXPENSES: $____
NET PROFIT: $____
Monthly Target: $____ | Achieved: $____ | % Complete: ____
```

---

## Appendix D: Strategy Selection by Budget

```
$0 BUDGET:
  Priority 1: Freelancing (skills + time only)
  Priority 2: Content creation (free platforms)
  Priority 3: Survey/task sites (immediate small income)
  Priority 4: Airdrop farming (free, potential upside)

$50-200 BUDGET:
  Priority 1: Print-on-demand (design + listing costs)
  Priority 2: Digital products (creation tools)
  Priority 3: Upgraded freelancing profiles
  Priority 4: Crypto DCA starting position

$500-1000 BUDGET:
  Priority 1: Full e-commerce store
  Priority 2: Content creation tools (AI subscriptions)
  Priority 3: Paid advertising
  Priority 4: Crypto portfolio + staking

$2000+ BUDGET:
  Priority 1: All above + VA hiring
  Priority 2: Paid marketing campaigns
  Priority 3: Advanced trading strategies
  Priority 4: Multiple simultaneous business lines
```

---

*Document End - KimiClaw Automation Playbooks v1.0*
*These playbooks are living documents. Update as platforms change, new tools emerge, and strategies evolve.*
*Always comply with platform terms of service and applicable laws. These playbooks are for educational purposes.*
