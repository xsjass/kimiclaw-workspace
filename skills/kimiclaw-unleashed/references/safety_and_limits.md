# Kimiclaw: Safety & Legal Limits Reference

> **CRITICAL DOCUMENT - AGENT MUST READ BEFORE ANY ACTION**
>
> This file defines the absolute boundaries within which Kimiclaw MUST operate.
> When in doubt, consult this document. If still uncertain, DO NOT PROCEED - alert the user.
>
> **Last Updated:** Auto-updated on each session start
> **Applies To:** All Kimiclaw automated money-making activities globally
> **Compliance Standard:** Conservative interpretation of all platform rules and applicable laws

---

## Table of Contents

1. [Platform Terms of Service Compliance](#section-1-platform-terms-of-service-compliance)
2. [Financial & Legal Compliance](#section-2-financial--legal-compliance)
3. [Prohibited Activities (NEVER DO)](#section-3-prohibited-activities-never-do)
4. [Risk Management Framework](#section-4-risk-management-framework)
5. [Security Best Practices](#section-5-security-best-practices)
6. [Transparency & Disclosure](#section-6-transparency--disclosure)
7. [Geographic Considerations](#section-7-geographic-considerations)
8. [Incident Response](#section-8-incident-response)
9. [Quick Decision Checklist](#quick-decision-checklist)
10. [Emergency Contacts & Resources](#emergency-contacts--resources)

---

## Section 1: Platform Terms of Service Compliance

> **CORE RULE:** Every platform interaction must respect the most restrictive interpretation of that platform's Terms of Service. When ambiguous, default to the conservative option.

---

### 1.1 PayPal

**What IS Allowed:**
- Receiving payments for legitimate goods and services
- Using PayPal API for legitimate business operations (with approved developer account)
- Automated invoicing through official PayPal API
- Scheduled/automated transfers between linked accounts you own
- Using PayPal Checkout for e-commerce transactions
- Accepting donations through approved PayPal.Me links
- Business account features (multi-user access with proper permissions)

**What is PROHIBITED:**
- Using PayPal for any gambling, gaming, or lottery activities (without pre-approval)
- Processing payments for cryptocurrency purchases/sales (without explicit approval)
- Using multiple personal accounts (one personal + one business permitted per person)
- Rapid-fire transactions designed to exploit velocity limits
- Using VPN/proxy to mask actual location
- Accepting payments for prohibited items (weapons, drugs, counterfeit goods, adult services)
- Structuring transactions to evade reporting thresholds (>$600 annually under current US rules)
- Using friends & family payments for commercial transactions (fee avoidance)
- Automated login via scraping or browser automation (violates TOU Section 9)
- Selling "high-risk" digital goods without approval (e.g., social media accounts, digital currencies)

**Consequences of Violations:**
- 21-day holds on funds (new sellers, high-risk categories)
- Account limitation (frozen funds, inability to send/receive)
- Permanent account ban + 180-day hold on remaining balance
- Reserve requirements (rolling 30-90 day holds on a percentage of transactions)
- $2,500 penalty per violation (debit from linked accounts under updated TOU)
- Reported to relevant financial authorities for serious violations

**Detection Methods:**
- IP geolocation matching with account address
- Velocity monitoring (transaction frequency patterns)
- Buyer complaint tracking
- Link analysis (connecting banned accounts via linked cards/accounts)
- Browser fingerprinting
- Risk scoring on transaction types and amounts
- Machine learning on behavioral patterns

**Compliance Checklist:**
- [ ] Account fully verified with real identity (no synthetic identities)
- [ ] Business account used if annual volume exceeds $2,500
- [ ] Proper category codes selected for transaction types
- [ ] Goods & Services payments used for all commercial transactions
- [ ] No more than one personal account per individual
- [ ] VPN disconnected before accessing PayPal
- [ ] Linked bank account/card matches account name
- [ ] SSN/TIN provided when requested (US accounts)

---

### 1.2 Fiverr / Upwork (Freelance Platforms)

**What IS Allowed:**
- Creating a single account per individual with real identity
- Using automation to draft proposals (manual submission required)
- Auto-bidding tools that work within platform API (Fiverr Pro, Upwork Plus)
- Automated project delivery via approved integrations (Dropbox, Google Drive links)
- Using calendar scheduling tools for client meetings
- Automated invoicing through platform's built-in systems
- Portfolio website linking (with platform badge)

**What is PROHIBITED:**
- Multiple accounts per person (strictly banned)
- Account sharing or selling accounts
- Using bots to place bids or send messages
- Automated acceptance of orders without review
- Requesting payment outside platform (circumventing fees)
- Offering services that violate platform's prohibited services list
- Fake portfolio items or misrepresented credentials
- Automated review solicitation
- Using client contact information for off-platform solicitation
- Plagiarized or AI-generated deliverables presented as original work (without disclosure)
- Impersonating another freelancer

**Consequences:**
- Account suspension (temporary)
- Permanent account termination
- Forfeiture of pending earnings
- IP address banned
- Legal action for fraud in severe cases

**Detection Methods:**
- Browser fingerprinting and device tracking
- IP address monitoring for multiple accounts
- Payment method linkage across accounts
- Message pattern analysis (AI-generated vs. human)
- Delivery pattern analysis (impossibly fast turnaround)
- Client complaint tracking
- Portfolio image reverse-searching

**Compliance Checklist:**
- [ ] Only one active account per platform per person
- [ ] Real identity used for verification
- [ ] All payments processed through platform
- [ ] Service descriptions accurately represent deliverables
- [ ] AI involvement disclosed where relevant
- [ ] Response times humanly plausible
- [ ] Deliverables reviewed before submission

---

### 1.3 YouTube / TikTok (Content Platforms)

**What IS Allowed:**
- Creating original or properly licensed content
- Using YouTube API (Data API v3) within quota limits
- Automated thumbnail generation for your own videos
- Scheduled publishing through YouTube Studio API
- Automated comment moderation tools
- Content monetization through approved Partner Program
- Cross-platform content posting (with each platform's rules)
- Using AI tools for script writing, video editing, and production (with disclosure)

**What is PROHIBITED:**
- Sub4Sub, view4view, or any artificial engagement schemes
- Buying views, likes, subscribers from third parties
- Using bots to comment, like, or subscribe
- Automated content upload via unofficial methods (YouTube cracking down on AI-generated bulk content)
- Reuploading others' content without transformative value
- Clickbait titles/thumbnails that grossly misrepresent content
- Impersonating other creators
- Manipulating YouTube algorithm through artificial engagement pods
- TikTok: Using automation tools to like, follow, or comment en masse
- YouTube: More than 10,000 API quota units per day without approval

**Consequences:**
- Video removal
- Channel strike (3 strikes = channel termination)
- Demonetization (loss of Partner Program access)
- AdSense account ban
- Channel termination
- Legal liability for copyright infringement
- TikTok: Shadowban (content suppressed without notice)

**Detection Methods:**
- View velocity analysis (sudden spikes trigger audits)
- Engagement ratio analysis (views vs. likes vs. comments)
- Subscriber growth pattern monitoring
- Content ID fingerprint matching (copyright)
- IP tracking for fake engagement
- Session pattern analysis (bot vs. human behavior)
- Repeat view filtering

**Compliance Checklist:**
- [ ] Content is original or properly licensed
- [ ] AI-generated content disclosed per platform policy
- [ ] No engagement purchasing or exchange schemes
- [ ] Monetization requirements met organically (YouTube: 1K subs + 4K watch hours)
- [ ] Copyright-free or properly licensed music/media used
- [ ] Thumbnails/titles accurately represent content
- [ ] API usage within quota limits

---

### 1.4 Amazon (Associates + MTurk)

**Amazon Associates:**

**What IS Allowed:**
- Using Product Advertising API within rate limits (1 request/sec)
- Creating affiliate links for legitimate product recommendations
- Auto-generating price comparison tables from API data
- Using approved affiliate WordPress plugins
- Disclosure of affiliate relationship on site

**What is PROHIBITED:**
- Using affiliate links in email marketing (banned since 2020)
- Cloaking or shortening affiliate links (must show Amazon URL)
- Offering incentives for clicking affiliate links
- Using Amazon reviews/content without permission
- Operating in states/countries where Associates program is suspended
- Automated cookie-stuffing or forced clicks
- Making price claims that aren't real-time ("always cheapest")
- Operating more than one Associates account per person without approval

**Amazon MTurk:**

**What IS Allowed:**
- Automated task qualification monitoring via API
- Script-assisted task finding (browser extensions)
- Auto-accept with known requesters (via approved tools)
- Data collection within task parameters

**What is PROHIBITED:**
- Using bots to complete HITs (answers must be human-verified)
- Creating fake worker/requester accounts
- Automated survey completion without human oversight
- Scraping proprietary task data
- Account selling or transferring

**Consequences:**
- Associates: Account closure + forfeiture of unpaid commissions
- Associates: Permanent ban from program
- MTurk: Account suspension + forfeit of pending earnings
- Both: Legal action for fraud or theft of services

---

### 1.5 Etsy

**What IS Allowed:**
- Selling handmade items (designed/created by seller)
- Using production partners (must be disclosed)
- Selling vintage items (20+ years old)
- Craft supplies (commercial or handmade)
- Using Etsy API for shop management
- Automated inventory management through approved tools
- Digital downloads (original designs)

**What is PROHIBITED:**
- Reselling mass-produced items as "handmade"
- Dropshipping without explicit production partner disclosure
- Selling prohibited items (weapons, drugs, hate items, live animals)
- Using copyrighted/trademarked material without license
- Creating multiple shops without approval (requires separate business entities)
- Keyword stuffing in titles/tags
- Fake reviews (purchased or incentivized)
- Automated messaging spam
- Fee avoidance (directing buyers off-platform)

**Consequences:**
- Listing removal
- Shop suspension
- Permanent account closure
- Star Seller status revocation
- Payment account reserve (frozen funds)
- Legal action for IP infringement

**Handmade Policy Requirements:**
- Seller must design OR physically make item OR use approved production partner
- Reselling is only permitted for vintage (20+ years) or craft supplies
- Production partner must be listed on item listings

---

### 1.6 Shopify

**What IS Allowed:**
- Automated store management via Shopify API
- Using approved payment gateways (Shopify Payments, Stripe, PayPal)
- Dropshipping through approved suppliers (Oberlo, DSers, etc.)
- Automated inventory syncing
- Email marketing automation (with consent)
- Abandoned cart recovery sequences

**What is PROHIBITED:**
- Selling prohibited products (weapons, drugs, counterfeit goods)
- Using Shopify for unlicensed gambling/gaming
- Processing payments outside Shopify Payments without approval
- Chargeback rate exceeding 1% (triggers account review)
- False advertising or bait-and-switch pricing
- Automated checkout abuse (botting limited products)
- Using Shopify to facilitate fraud or money laundering
- Violating intellectual property rights
- Operating high-risk businesses without proper disclosure

**Consequences:**
- Account hold (frozen payouts)
- Shopify Payments termination (forced to use third-party processor)
- Store suspension
- Permanent account closure
- Funds held in reserve for 90-120 days

**Risk Thresholds:**
- Chargeback rate > 1%: Account review
- Chargeback rate > 3%: Shopify Payments termination likely
- Fraud rate > 0.5%: Mandatory 3D Secure implementation

---

### 1.7 Crypto Exchanges (Binance, Coinbase)

**Binance:**

**What IS Allowed:**
- API trading within rate limits (1,200 WAPI weight/minute for Spot)
- Grid trading and DCA bots through Binance's official Trading Bots
- Automated portfolio rebalancing (self-custody tools)
- Staking through official Binance Earn products
- Recurring buy setups

**What is PROHIBITED:**
- Wash trading or self-trading to manipulate volume
- Front-running or market manipulation
- Using VPN to access from restricted jurisdictions (US, Canada, Singapore for main platform)
- Exploiting API latency arbitrage against other users
- Creating multiple KYC accounts
- API key sharing
- Automated deposits/withdrawals that trigger AML alerts
- Using Binance P2P for unauthorized fiat money transmission

**Coinbase:**

**What IS Allowed:**
- API trading (Coinbase Advanced Trade API)
- Recurring buys
- Automated portfolio management via Advanced API
- Coinbase Commerce for merchant payments
- Staking eligible assets

**What is PROHIBITED:**
- Market manipulation or wash trading
- Using Coinbase from sanctioned countries
- Automated account creation (one account per individual)
- Circumventing geographic restrictions
- High-frequency trading that degrades platform performance
- Using Coinbase for unlicensed money services business

**API Limits:**
- Binance Spot: 1,200 request weight per minute per IP
- Binance Futures: 2,400 request weight per minute
- Coinbase: 10 requests per second (public), 15/sec (private)
- Rate limit violations result in temporary IP ban (increasing duration)

**KYC Requirements:**
- All exchanges require government-issued ID
- Address verification (utility bill/bank statement)
- Source of funds documentation for large deposits
- Enhanced due diligence for transactions >$10K equivalent
- Travel Rule compliance for transfers >$3K (sharing recipient info)

---

### 1.8 Google (AdSense / Gmail)

**Google AdSense:**

**What IS Allowed:**
- Displaying ads on original content websites
- Using AdSense API for reporting
- Auto ads placement (Google-managed)
- A/B testing ad placements through AdSense experiments
- Mobile app monetization through AdMob

**What is PROHIBITED:**
- Clicking your own ads or encouraging others to click
- Using bots to generate ad impressions or clicks
- Placing ads on pages with prohibited content (adult, violence, hate speech)
- Auto-refreshing pages to generate impressions
- Using traffic sources that violate policies (paid-to-click, traffic exchanges)
- Ad placement encouraging accidental clicks
- Hidden ads or ads in pop-unders
- Using multiple AdSense accounts per person

**Gmail Sending Limits:**
- 500 emails/day (free Gmail accounts)
- 2,000 emails/day (Google Workspace)
- Rate limit: 1 email per second (free), higher for Workspace
- Exceeding limits triggers 24-hour block
- Bulk emailing without unsubscribe option violates CAN-SPAM

**Consequences:**
- AdSense: Account ban + payment forfeiture (permanent, rarely reversed)
- Gmail: Sending suspension (24 hours to permanent)
- Google account termination (affects ALL Google services)
- Legal action for ad fraud (click fraud is wire fraud in many jurisdictions)

---

### 1.9 Reddit / Quora

**Reddit:**

**What IS Allowed:**
- Creating one account per person (alts permitted if not for ban evasion)
- Sharing relevant content in appropriate subreddits
- Participating in promotional threads where self-promotion is explicitly allowed
- Using Reddit API for data collection (within rate limits: 60 requests/minute for OAuth)
- Creating and moderating subreddits related to your niche

**What is PROHIBITED:**
- Using bots to upvote/downvote content (including vote manipulation services)
- Creating accounts to evade subreddit or sitewide bans
- Spamming self-promotional links across multiple subreddits
- Using vote manipulation rings or services
- Automated commenting/posting without consent of moderators
- Karmaboosting services or engagement purchasing
- Ban evasion (new accounts after sitewide ban)
- Coordinated harassment or brigading

**Quora:**

**What IS ALLOWED:**
- Answering questions relevant to your expertise
- Including relevant links in answers (with value provision)
- Using Quora Spaces for content curation
- Quora Partner Program (QPP) for question monetization (if invited)

**What is PROHIBITED:**
- Mass self-promotion without answering the question
- Using multiple accounts to upvote own content
- Plagiarized answers
- Spam links in answers
- Automated question/answer posting
- Fake credentials or impersonation

**Consequences:**
- Subreddit ban or post removal
- Shadowban (invisible to other users)
- Account suspension
- Sitewide ban (IP and device fingerprinting)
- Quora: Content collapse, edit-block, permanent ban

---

### 1.10 Twitter/X

**What IS Allowed:**
- Automated posting of original content via official API
- Scheduled tweets through approved management tools
- Auto-DM responses (with user opt-in)
- Automated analytics and reporting
- Using Twitter API v2 for legitimate business purposes

**What is PROHIBITED:**
- Buying followers, likes, retweets from third parties
- Using follow/unfollow bots at aggressive rates
- Automated liking/retweeting at scale (triggers spam detection)
- Creating multiple accounts for ban evasion
- Scraping tweet data without API (violates CFAA in many cases)
- Spam replies to trending tweets
- Coordinated inauthentic behavior (bot networks)
- Misuse of verified badge (impersonation, misleading identity)

**API Tiers (Current):**
- Free: 1,500 tweet reads/month, limited posting
- Basic ($100/month): 10,000 reads/month, 3,000 tweets/month
- Pro ($5,000/month): 1M reads/month, 300 tweets/day
- Enterprise: Custom pricing, full access

**Consequences:**
- Tweet suppression (shadowban)
- Account lock (phone verification required)
- Temporary suspension (hours to weeks)
- Permanent suspension
- API access revocation
- Legal action for scraping violations

**Rate Limits to Observe:**
- Following: < 400/day (aggressive following triggers review)
- Tweets: Stay within API tier limits
- DMs: < 500/day
- Unfollowing: < 500/day
- Automated actions must include human-like delays (3-10 seconds between actions)

---

## Section 2: Financial & Legal Compliance

> **CORE RULE:** All income must be reported. All taxes must be paid. No exceptions. When in doubt, report it.

---

### 2.1 Tax Obligations

**When Income Becomes Taxable:**
- **United States:** ALL income is taxable from the first dollar (IRS Code Section 61: gross income = all income from whatever source derived)
- **No minimum threshold** for reporting self-employment income (Form 1040 Schedule C)
- Self-employment tax kicks in at **$400 net profit** (Schedule SE required)
- **1099-K Threshold:** $600+ in aggregate payments per year (threshold reduced from $20K/$200 transactions in recent legislation)
- Platforms will issue 1099-K, 1099-NEC, or 1099-MISC for reportable payments

**Record Keeping Requirements:**
- Retain records for **minimum 3 years** (7 years recommended for self-employment)
- Required documentation:
  - All income receipts (platform payouts, client payments, crypto gains)
  - All business expense receipts (software, hosting, equipment)
  - Bank statements showing business transactions
  - Crypto transaction records (every trade, cost basis, date)
  - Mileage logs (if applicable)
  - Home office documentation (if applicable)

**Estimated Tax Requirements (US):**
- Quarterly estimated payments required if expecting to owe $1,000+ in tax
- Due dates: April 15, June 15, September 15, January 15
- Underpayment penalty: Federal short-term rate + 3%
- Safe harbor: Pay 100% of prior year tax (110% if AGI > $150K)

**Crypto Tax Specifics:**
- Crypto-to-crypto trades are taxable events (not just cashing out)
- Mining/staking rewards taxed as ordinary income at fair market value on receipt date
- NFT sales subject to capital gains tax
- Every transaction must be tracked for cost basis calculation
- Use FIFO (First In, First Out) unless specific identification elected

**International Considerations:**
- Most countries tax worldwide income for tax residents
- Double-taxation treaties may reduce liability
- FBAR filing required for foreign accounts >$10K aggregate (US persons)
- FATCA reporting for foreign financial assets
- VAT/GST obligations if selling to EU/UK/AU customers (varies by threshold)

**Tax Filing Deadlines:**
- US Federal: April 15 (or extended to October 15)
- US State: Varies by state
- Quarterly estimates: 15th of April, June, September, January

---

### 2.2 Business Registration

**Sole Proprietorship (Default):**
- No formal registration required to start
- Business income reported on personal tax return (Schedule C)
- Unlimited personal liability for business debts
- DBA ("Doing Business As") required if operating under name different from legal name
- DBA registration: County Clerk's office, typically $10-$100

**LLC (Limited Liability Company):**
- **Form when:** Annual net profit > $10K, or significant liability risk, or multiple business partners
- Provides liability protection (separates personal/business assets)
- Pass-through taxation (income flows to personal return)
- Annual filing fees: $50-$800/year depending on state
- Registered agent required
- Operating agreement recommended
- EIN (Employer Identification Number) from IRS required

**Corporation (S-Corp or C-Corp):**
- **Form when:** Annual profit > $60K (S-Corp tax savings kick in)
- More complex compliance requirements
- Payroll tax obligations (S-Corp requires "reasonable salary")
- Double taxation for C-Corp (corporate + personal)

**EIN Registration:**
- Free from IRS (irs.gov)
- Required for LLCs, corporations, and any business with employees
- Recommended even for sole proprietors (protects SSN)

---

### 2.3 Money Transmission Laws

**When It Applies:**
- Transferring money on behalf of others
- Currency exchange (crypto included)
- P2P payment facilitation
- Prepaid access programs

**US Federal Requirements:**
- FinCEN registration as Money Services Business (MSB) if:
  - Transmitting money as business (>$1K/day per person)
  - Issuing or redeeming money orders/travelers checks
  - Currency dealing/exchanging (crypto included)
- State-by-state money transmitter licenses required (48 states have specific requirements)
- Penalties: Up to 5 years prison + fines for unlicensed operation

**Crypto-Specific:**
- Operating a crypto exchange or ATM = money transmitter in most jurisdictions
- Self-custody wallet transfers generally exempt
- Coin mixing/tumbling services increasingly regulated
- DeFi protocols in regulatory gray area (but operators may face liability)

**Exemptions (US):**
- Transactions for goods/services (not on behalf of third party)
- Personal/family transfers
- Corporate payment processing (if licensed processor handles transmission)

---

### 2.4 Securities Laws

**When Crypto Activities Trigger Securities Regulations:**
- **Initial Coin Offerings (ICOs):** Most utility token ICOs = unregistered securities offerings
- **Yield/Lending Programs:** Earning interest on deposited crypto may = securities (SEC v. BlockFi)
- **Staking-as-a-Service:** Providing staking services to others may = investment contract
- **Pool Investment:** Pooling funds for investment/trading = investment company regulations
- **Giving Investment Advice:** Requires registration as Investment Adviser if advising others for compensation

**Howey Test (US):**
An arrangement is an investment contract (security) if:
1. Investment of money
2. In a common enterprise
3. With expectation of profits
4. Derived from efforts of others

**Compliance Requirements:**
- Do NOT offer guaranteed returns on crypto investments
- Do NOT pool client funds for collective investment without registration
- Do NOT provide personalized investment advice without appropriate licenses
- Do NOT operate a yield product without legal review
- When in doubt, assume securities law applies

---

### 2.5 Consumer Protection

**Truth in Advertising:**
- All claims must be substantiated with evidence
- "Results not typical" disclaimers required for atypical testimonials
- Do not guarantee specific income/returns (unless in a compliant investment context)
- No bait-and-switch pricing
- Shipping/delivery times must be accurate
- Refund policies must be clearly stated and honored

**FTC Endorsement Guidelines:**
- Material connections must be disclosed (affiliate relationships, free products)
- Disclosure must be clear and conspicuous (before affiliate link)
- "#ad" or "#sponsored" minimum standard on social media
- Disclosure required even for gifted products

**Refund Policies:**
- Must comply with platform requirements (varies by platform)
- Credit card processing agreements require fair refund handling
- State laws vary on refund requirements (California: 30-day minimum for certain goods)
- Digital goods: Generally no automatic refund right, but must deliver as described

**Service Guarantees:**
- Avoid unconditional guarantees
- Qualify guarantees with reasonable conditions
- Do not guarantee specific results from services
- Document all deliverables in writing

---

### 2.6 GDPR / Privacy Compliance

**When GDPR Applies:**
- Processing personal data of EU residents, regardless of business location
- Processing EU resident data in the course of business activities

**Key Requirements:**
- **Lawful Basis:** Must have legal basis for processing (consent, contract, legal obligation, legitimate interest)
- **Privacy Policy:** Required if collecting any personal data (names, emails, IPs, cookies)
- **Consent:** Must be freely given, specific, informed, and unambiguous (opt-in required)
- **Data Minimization:** Collect only what's necessary
- **Right to Erasure:** Users can request data deletion
- **Breach Notification:** 72-hour notification to authorities if personal data breached
- **DPO:** Data Protection Officer required if processing is core business + large scale

**Privacy Policy Must Include:**
- What data is collected
- How it's used
- Who it's shared with
- User rights (access, correction, deletion)
- Cookie usage
- Contact information for data requests
- Retention periods

**Penalties:**
- Up to EUR 20 million or 4% of global annual revenue (whichever is higher)
- Individual country regulators can impose additional fines

**US Privacy Laws:**
- CCPA/CPRA (California): Similar rights to GDPR for California residents
- COPPA: Special requirements for collecting data from children under 13
- State-by-state laws expanding rapidly (Virginia, Colorado, Connecticut, Utah)

---

### 2.7 Intellectual Property

**AI-Generated Content:**
- **Copyright Status (US):** Pure AI-generated works are NOT copyrightable (USCO policy, March 2023). Human authorship required.
- **Mixed Works:** Significant human creative input + AI assistance may be copyrightable
- **Best Practice:** Always add significant human creative input to AI-generated content
- **Registration:** Do not register purely AI works as original copyright

**Using Others' Content:**
- Copyright: Do not use text, images, code, or music without license
- Fair Use: Limited applicability for commercial use (transformative use, commentary, education)
- Stock Assets: Use only properly licensed assets (Creative Commons, purchased licenses)
- Music: Platform-specific licenses required (YouTube Content ID system)
- Code: Respect open-source licenses (GPL, MIT, Apache have different requirements)

**Trademark Considerations:**
- Do not use others' trademarks in domain names (cybersquatting)
- Do not create brand confusion with existing businesses
- Register own trademarks for unique brand elements
- Avoid keyword bidding on competitors' trademarks (varies by jurisdiction)
- Do not use trademarked terms in product listings deceptively

**Patent Infringement:**
- Software patents are complex and geographically limited
- Avoid copying patented business methods verbatim
- When in doubt, consult patent attorney for high-value implementations

---

### 2.8 Contract Law

**Service Agreements:**
- All client work should have a written agreement
- Minimum terms: Scope, deliverables, timeline, payment, revisions
- Limitation of liability clause (cap liability at fees paid)
- Termination clause (either party, with notice period)
- Intellectual property transfer terms (who owns deliverables)
- Dispute resolution (mediation, then arbitration or court)

**Terms of Service for Clients:**
- Required for any business with customers
- Auto-accept via clickwrap or browsewrap (clickwrap is stronger legally)
- Include: Payment terms, refund policy, dispute resolution, limitation of liability
- Jurisdiction/governing law clause
- Class action waiver (enforceability varies)

**Enforceability Checklist:**
- [ ] Clear and conspicuous presentation
- [ ] Reasonable terms (not unconscionable)
- [ ] User must manifest assent (click "I agree")
- [ ] Available for review before acceptance
- [ ] Updated terms require new acceptance

**Digital Millennium Copyright Act (DMCA):**
- Safe harbor requires designated agent registration
- Must have takedown process for user-generated content
- Counter-notice procedure for false takedowns
- $35 fee for DMCA agent registration (required for US-based platforms)

---

## Section 3: Prohibited Activities (NEVER DO)

> **CRITICAL: The following activities are absolutely prohibited. No exceptions. No justifications.**
>
> If any activity could plausibly fall into these categories, STOP and consult the user.

---

### 3.1 ILLEGAL Activities

**Fraud & Financial Crimes:**

| Activity | Why It's Prohibited | Potential Consequences |
|---|---|---|
| Wire Fraud | Deceiving for financial gain using electronic communications | Up to 20 years federal prison (18 U.S.C. 1343) |
| Credit Card Fraud | Unauthorized use of payment cards | Up to 15 years federal prison (15 U.S.C. 1644) |
| Identity Theft | Using another's identity for financial gain | Mandatory minimum 2 years federal (18 U.S.C. 1028A) |
| Check Fraud | Forging, altering, or passing bad checks | State/federal charges, up to 30 years |
| Money Laundering | Concealing origins of illegally obtained money | Up to 20 years federal (18 U.S.C. 1956) |
| Structuring (Smurfing) | Breaking transactions into smaller amounts to evade reporting | Up to 5 years + $250K fine (31 U.S.C. 5324) |
| Tax Evasion | Willfully failing to report/pay taxes | Up to 5 years federal prison + $250K fine (26 U.S.C. 7201) |
| Securities Fraud | False statements in securities transactions | Up to 20 years (Sarbanes-Oxley enhanced penalties) |
| Insider Trading | Trading on material non-public information | Up to 20 years + $5M individual fine |

**Computer & Internet Crimes:**

| Activity | Why It's Prohibited | Potential Consequences |
|---|---|---|
| Computer Fraud (CFAA) | Unauthorized access to computer systems | Up to 10 years first offense (18 U.S.C. 1030) |
| DDoS Attacks | Disrupting services via traffic floods | Up to 10 years federal prison |
| Ransomware Distribution | Encrypting data for ransom | Up to 20 years federal |
| Credential Stuffing | Automated login attempts with stolen credentials | CFAA violation + identity theft charges |
| Skimming | Installing malicious card readers | Up to 15 years federal + state charges |
| Social Engineering | Deception to gain unauthorized access | Fraud charges + CFAA violation |

**Unlicensed Financial Services:**

| Activity | Why It's Prohibited | Potential Consequences |
|---|---|---|
| Unlicensed Money Transmission | Operating money service without registration | Up to 5 years federal + $250K fine |
| Unlicensed Investment Advising | Giving paid investment advice without Series 65 | SEC enforcement, fines, bar from industry |
| Unauthorized Banking | Accepting deposits without banking license | Federal felony, 20+ years |
| Payday Lending | High-interest lending without state licensing | State enforcement, usury charges |

---

### 3.2 Platform-Violating Activities

**Review & Engagement Manipulation:**

| Activity | Why It's Prohibited | Potential Consequences |
|---|---|---|
| Fake Reviews | Violates FTC Act Section 5 (deceptive practices) + Platform TOU | Platform ban + FTC fine up to $43,792 per violation |
| Click Fraud | Artificially generating ad clicks | Wire fraud charges + AdSense lifetime ban + $10K-$50K fine |
| Impression Farming | Fake traffic generation | Platform ban + advertiser lawsuit + fraud charges |
| View Botting | Artificially inflating video metrics | Platform termination + potential wire fraud |
| Like/Share Purchasing | Violates all major platform TOU | Account termination + shadowban |
| Review Gating | Selectively soliciting positive reviews | FTC enforcement action (Amazon 2021: $13M fine) |

**Account Abuse:**

| Activity | Why It's Prohibited | Potential Consequences |
|---|---|---|
| Fake Account Creation | Violates all platform TOU | All accounts banned + IP blacklisted |
| Account Selling/Transferring | Violates TOU (most platforms) | Account termination + payment forfeiture |
| Ban Evasion | Creating new accounts after ban | Permanent ban + potential CFAA charges |
| Age Verification Bypass | Providing false age information | Account termination + potential liability |

---

### 3.3 Unethical Activities

| Activity | Why It's Prohibited | Potential Consequences |
|---|---|---|
| Deceptive Marketing | Misleading claims harm consumers | FTC fines + platform bans + reputation destruction |
| Bait-and-Switch | Advertising one thing, delivering another | Consumer fraud charges + platform ban + chargebacks |
| Plagiarism | Using others' work as your own | Copyright infringement + DMCA takedown + lawsuit |
| Substandard Deliverables | Accepting payment for poor quality work | Chargebacks + negative reviews + platform penalties |
| Fake Expertise | Claiming qualifications you don't have | Fraud claims + professional liability + platform ban |
| Astroturfing | Fake grassroots support/engagement | FTC enforcement + reputation damage |
| Data Scraping (Private) | Harvesting private user data | CFAA violation + privacy tort claims |
| Dark Patterns | UI designed to trick users into actions | FTC enforcement + class action lawsuits |

---

### 3.4 High-Risk Activities

| Activity | Why It's Prohibited | Potential Consequences |
|---|---|---|
| Ponzi Schemes | Paying early investors with later investors' money | Securities fraud + 20 years prison (Madoff example) |
| Pyramid Schemes | Recruitment-based compensation structure | FTC enforcement + state criminal charges |
| Pump-and-Dump | Artificially inflating price then selling | Securities fraud + 20 years prison |
| Unverified Investment Schemes | Promising returns without registration | Securities fraud + SEC enforcement |
| Binary Options Trading | Most platforms are fraudulent/unlicensed | Complete capital loss + association with fraud |
| Gambling Operations | Requires state-by-state licensing | Unlicensed gambling = felony in most jurisdictions |
| Prediction Markets | Regulated as gambling in most jurisdictions | Legal gray area + potential gambling charges |

---

### 3.5 Automation Red Lines (NEVER Cross)

| Activity | Why It's Prohibited | Potential Consequences |
|---|---|---|
| CAPTCHA Bypassing | Circumventing security measures = unauthorized access | CFAA violation + criminal charges |
| Credential Stuffing | Using stolen credentials = computer fraud | CFAA + identity theft charges |
| Brute Force Attacks | Systematic password guessing | Unauthorized access charges |
| API Abuse (Beyond Limits) | Violates CFAA "unauthorized access" | Criminal charges + civil liability |
| Scraping Private/Behind-Login Data | Circumventing access controls (hiQ v. LinkedIn exception applies only to PUBLIC data) | CFAA violation + state privacy claims |
| Session Hijacking | Stealing authentication tokens | Computer fraud + wire fraud |
| Botting/Aggressive Automation | Violates platform TOU | Account termination + CFAA risk |
| Circumventing IP Blocks | Bypassing platform restrictions | CFAA violation + permanent bans |

---

### 3.6 Summary: The Golden Rules

1. **If it requires lying, don't do it.**
2. **If it exploits a platform bug, don't do it.**
3. **If it uses someone else's identity, don't do it.**
4. **If it generates fake engagement, don't do it.**
5. **If it promises guaranteed returns, don't do it.**
6. **If it bypasses security measures, don't do it.**
7. **If it involves unreported income, don't do it.**
8. **If it's illegal in any jurisdiction where the user resides, don't do it.**
9. **When in doubt, report income.**
10. **When uncertain, ask the user first.**

---

## Section 4: Risk Management Framework

> **CORE RULE:** Protect capital first. Growth second. No single point of failure should jeopardize the entire operation.

---

### 4.1 Capital Protection Rules

**Per-Strategy Risk Limits:**
- **Maximum 10%** of available capital allocated to any single strategy
- **Maximum 25%** of available capital in any single asset class/category
- **Emergency fund:** Minimum 3 months of operating expenses held in liquid, non-risk assets
- **Crypto allocation:** Maximum 20% of total capital (due to volatility)
- **Experimental strategies:** Maximum 5% of capital for untested approaches
- **Leverage:** Maximum 2:1 leverage on any position (conservative standard)

**Position Sizing Rules:**
- Never risk more than 2% of strategy capital on a single trade/investment
- Stop-loss orders required for all trading positions
- Take-profit levels set at time of entry (discipline over greed)
- Dollar-cost averaging preferred over lump-sum entries in volatile markets

**Cash Flow Management:**
- Maintain minimum 30-day operating cash reserve
- Payment processing holds (PayPal 21 days, Stripe 7 days) must be factored into cash flow
- Weekly cash flow review (projected vs. actual)
- Monthly reserve adequacy check

---

### 4.2 Diversification Guidelines

**Revenue Stream Diversification:**
- **Minimum 3 active income streams** at all times
- **Maximum 40%** of total revenue from any single platform
- **Maximum 60%** of total revenue from any single strategy type (e.g., freelancing, trading, affiliate)
- New stream onboarding: Maximum 15% allocation until proven for 60+ days

**Platform Diversification:**
- Never rely on a single payment processor (PayPal + Stripe + crypto minimum)
- Maintain presence on multiple freelance platforms simultaneously
- Multiple affiliate programs vs. single program dependency
- Hosting/domain diversification for web-based income

**Geographic Diversification:**
- Client/customer base should span multiple regions where possible
- Currency diversification for international income
- Awareness of regional economic/political risks

**Diversification Checklist:**
- [ ] At least 3 distinct income streams active
- [ ] No single platform > 40% of revenue
- [ ] Multiple payment processors enabled
- [ ] Client base spans 2+ geographic regions
- [ ] Emergency fund covers 3+ months expenses
- [ ] Crypto allocation < 20% of total capital

---

### 4.3 Escalation Procedures

**YELLOW ALERT (Monitor Closely):**
- Single strategy loses > 5% in one day
- Payment processor initiates review/hold
- Platform policy change announced
- Client complaint received
- Unusual account activity detected
- Revenue from single stream drops > 20% week-over-week
- **Action:** Increase monitoring frequency, review position sizing, prepare contingency

**ORANGE ALERT (Active Intervention Required):**
- Single strategy loses > 10% in one day
- Account receives warning from platform
- Payment processor places funds on hold
- Multiple client complaints in short period
- Regulatory inquiry or notice received
- Revenue from single stream drops > 40% week-over-week
- **Action:** Pause affected strategy, document everything, notify user within 2 hours, prepare appeal/response

**RED ALERT (Immediate Stop + User Notification):**
- Single strategy loses > 20% in one day
- Account suspended or terminated
- Funds frozen by platform or authority
- Legal notice received
- Suspected security breach
- Tax authority inquiry
- Any activity that could be construed as illegal
- **Action:** IMMEDIATELY stop all related activities, notify user within 15 minutes, preserve all records, do NOT respond to legal notices without user instruction, seek legal counsel

---

### 4.4 Daily Loss Limits

**Per-Strategy Daily Limits:**
- Conservative strategies: Max 5% daily loss
- Moderate strategies: Max 10% daily loss
- Aggressive strategies: Max 15% daily loss
- **Hard stop:** Any strategy hitting its daily limit is PAUSED until next calendar day

**Account-Wide Daily Limit:**
- Maximum 10% of total capital loss across all strategies in single day
- When hit: All trading/speculative strategies pause for 24 hours
- Income-generating activities (freelancing, content) continue

**Monthly Loss Limit:**
- Maximum 25% of total capital in any calendar month
- When hit: Complete strategy review required, notify user, pause until plan revision

**Loss Limit Implementation:**
```
IF daily_loss >= strategy_limit:
    PAUSE(strategy)
    NOTIFY(user, "Strategy paused - daily loss limit reached")
    LOG(reason, timestamp, loss_amount)
    SCHEDULE(review, next_day)
```

---

### 4.5 Platform Dependency Limits

**Revenue Concentration Thresholds:**
- **40% rule:** If any single platform exceeds 40% of revenue, immediate diversification required
- **70% rule:** If top 2 platforms exceed 70% combined, begin third platform onboarding within 7 days
- **100% exposure:** If only one platform active, second platform must be operational within 14 days

**Platform-Specific Risk Factors:**
| Platform | Risk Level | Key Risk Factor |
|---|---|---|
| PayPal | HIGH | Account limitation common, 180-day holds |
| Stripe | MEDIUM | Rolling reserve possible, strict compliance |
| YouTube | HIGH | Algorithm changes, demonetization risk |
| Fiverr/Upwork | MEDIUM | Commission increases, policy changes |
| Amazon Associates | MEDIUM | Commission rate cuts, account bans |
| Etsy | LOW-MED | Search algorithm changes, fee increases |
| Crypto Exchanges | HIGH | Regulatory shutdowns, withdrawal freezes |
| AdSense | HIGH | Invalid traffic penalties, account bans |

**Mitigation Strategies:**
- Maintain presence on 2+ platforms per strategy type
- Build direct relationships (email lists) to reduce platform dependency
- Maintain own website/hosting for all web-based businesses
- Multiple payment processors (never single point of failure)
- Regular platform policy monitoring (weekly review)

---

### 4.6 Compliance Monitoring

**Policy Change Monitoring:**
- Weekly automated scan of platform policy pages for changes
- Subscribe to platform developer/publisher newsletters
- Monitor platform developer blogs and API changelogs
- Follow platform official accounts for announcements
- Review platform status pages for service changes

**Compliance Audit Schedule:**
- **Daily:** Check for account warnings, holds, or notifications
- **Weekly:** Review active strategies against current platform policies
- **Monthly:** Comprehensive compliance audit of all operations
- **Quarterly:** Legal/regulatory environment scan for applicable changes

**Compliance Audit Checklist:**
- [ ] All active platforms reviewed for policy updates
- [ ] Account health verified on each platform
- [ ] API usage within current limits
- [ ] Content/deliverables comply with platform standards
- [ ] Financial records up to date
- [ ] Tax obligations current
- [ ] Privacy policy current
- [ ] Affiliate disclosures present
- [ ] No outstanding disputes or warnings

---

## Section 5: Security Best Practices

> **CORE RULE:** Security is not optional. One breach can destroy everything.

---

### 5.1 Credential Management

**Password Requirements:**
- Minimum 16 characters for all accounts
- Unique password for EVERY account (no reuse)
- Use password manager (1Password, Bitwarden, or equivalent)
- Passphrase format recommended: 4+ random words + numbers/symbols
- Example: `Correct-Horse-Battery-Staple!47`

**Credential Storage:**
- Store passwords only in encrypted password manager
- NEVER store credentials in plain text, code comments, or config files
- API keys stored in environment variables or secure vaults (never in version control)
- Seed phrases written on paper, stored in fireproof safe (NEVER digitally stored)
- Hardware security keys (YubiKey) for primary accounts where supported

**Rotation Schedule:**
- API keys: Every 90 days
- Account passwords: Every 180 days
- 2FA recovery codes: Reviewed monthly
- Critical financial accounts: Every 90 days
- After any security incident: Immediate rotation of ALL credentials

**Breach Response:**
1. IMMEDIATELY change affected password
2. Check account for unauthorized activity
3. Enable/verify 2FA is active
4. Check haveibeenpwned.com for exposure scope
5. Notify user of breach
6. Review and rotate all related credentials (assume cascade exposure)
7. Enable additional monitoring on affected accounts

---

### 5.2 Wallet Security

**Hot Wallet Guidelines:**
- Keep ONLY operating funds in hot wallets (connected to internet)
- Maximum 10% of crypto holdings in hot wallets
- Use reputable wallets (MetaMask, Ledger Live, Coinbase Wallet, etc.)
- Never store large amounts on exchanges (not your keys, not your coins)

**Cold Wallet Guidelines:**
- Hardware wallet REQUIRED for holdings > $1,000 equivalent
- Recommended: Ledger Nano X, Trezor Model T
- Seed phrase generated offline, written on metal/paper
- Seed phrase stored in fireproof/waterproof location
- NEVER enter seed phrase into any website or software
- Multiple geographically separated backups for amounts > $10K

**Multi-Signature (Multi-Sig) Requirements:**
- Multi-sig required for business holdings > $10K equivalent
- 2-of-3 or 3-of-5 configuration recommended
- Keys held by different parties/devices
- One key can be held by user, one by agent (in secure storage), one by trusted third party

**Backup Procedures:**
- Seed phrase: 3 copies minimum, stored in 2+ locations
- Hardware wallet: Secondary device as backup
- Wallet files: Encrypted backups on 2+ storage media
- Test recovery process quarterly with small amounts

**Transaction Verification (MANDATORY):**
1. Verify recipient address (check first AND last 6 characters match)
2. Verify amount is correct
3. Verify network (Ethereum vs. BSC vs. Polygon - wrong network = lost funds)
4. Verify gas fees are reasonable
5. Double-check before confirming ANY transaction
6. For large transfers (>$1K), send test transaction first ($1-5)

---

### 5.3 Phishing Detection

**Common Phishing Indicators:**
- Urgent threats ("Account will be closed in 24 hours")
- Generic greetings ("Dear Valued Customer" instead of your name)
- Suspicious sender domains (amaz0n.com vs. amazon.com)
- Requests for password or 2FA codes (legitimate services NEVER ask for these)
- Links that don't match displayed text (hover to verify)
- Poor grammar and spelling
- Unsolicited attachments
- Too-good-to-be-true offers

**URL Verification:**
- Always verify domain before entering credentials
- Check for HTTPS (padlock icon)
- Look for subtle misspellings in domain names
- Type URLs manually instead of clicking links when possible
- Bookmark login pages and use bookmarks instead of links

**Email Verification:**
- Verify sender address carefully (noreply@paypal.com vs. noreply@paypal-security.com)
- Check email headers for spoofing
- Never click links in unexpected emails
- Navigate to site directly and log in through normal method
- When in doubt, contact platform through official channels (not email reply)

**Social Engineering Red Flags:**
- Someone claiming to be "support" contacting you first
- Requests to install remote access software (AnyDesk, TeamViewer)
- Requests to move funds to "secure" wallets
- Promises to double your crypto if you send some first (guaranteed scam)
- Fake customer support accounts on social media

---

### 5.4 API Key Management

**Key Generation:**
- Generate separate API keys for each application/purpose
- Use IP whitelisting whenever available (restrict to known server IPs)
- Set minimum required permissions (never grant full permissions unless necessary)
- Document purpose and owner of each key

**Key Storage:**
- NEVER hardcode API keys in source code
- Use environment variables or secrets management (AWS Secrets Manager, HashiCorp Vault)
- Restrict access to secrets to only required personnel/systems
- Audit who has access to secrets quarterly

**Key Permissions (Least Privilege):**
| Platform | Minimum Required | Never Grant Unless Necessary |
|---|---|---|
| PayPal API | Read-only for reporting | Withdraw, send payments |
| Stripe API | Read charges | Create refunds, update accounts |
| YouTube API | Read/upload | Delete content, manage monetization |
| Binance API | Read + spot trading | Withdrawal, margin, futures |
| Twitter API | Read + tweet | Admin, delete accounts |

**Rotation Schedule:**
- API keys: Rotate every 90 days
- Immediately rotate if:
  - Key may have been exposed (committed to git, logged, shared)
  - Suspicious activity detected
  - Employee/system with access departs

---

### 5.5 2FA Requirements (Mandatory)

**All Financial Accounts (REQUIRED):**
- PayPal, Stripe, bank accounts
- Crypto exchanges (Binance, Coinbase, etc.)
- Payment processors (Square, Venmo Business)

**All Platform Accounts (REQUIRED):**
- YouTube, Amazon Associates, Etsy, Shopify
- Twitter/X, Reddit, Fiverr, Upwork

**Primary Email (REQUIRED):**
- Gmail/primary email MUST have 2FA
- This is the recovery point for almost everything else

**2FA Method Priority:**
1. **Hardware Security Key** (YubiKey, Titan Security Key) - Most secure
2. **Authenticator App** (Google Authenticator, Authy) - Good
3. **SMS/Phone** - Acceptable but vulnerable to SIM swapping
4. **Email** - Least secure, use only as backup

**Backup Codes:**
- Print and store backup codes for every account with 2FA
- Store in fireproof safe or secure physical location
- Never store backup codes in same password manager as main credentials
- Test backup code usage annually

**2FA Implementation Checklist:**
- [ ] Primary email: Hardware key or authenticator app
- [ ] All bank/financial accounts: 2FA enabled
- [ ] PayPal: 2FA enabled
- [ ] Crypto exchanges: 2FA + withdrawal whitelisting
- [ ] Platform admin accounts: 2FA enabled
- [ ] Backup codes generated and securely stored
- [ ] Recovery phone number up to date
- [ ] Secondary/recovery email configured

---

## Section 6: Transparency & Disclosure

> **CORE RULE:** Honesty is not just ethical - it's legally required. Disclose everything that a reasonable person would want to know.

---

### 6.1 AI Disclosure

**When AI Disclosure is REQUIRED:**
- Client work involves AI-generated content (images, text, code)
- Products sold contain AI-generated elements
- Customer service interactions handled by AI without human review
- Content published is AI-generated (per platform policy requirements)
- Services offered use AI tools (even if human-reviewed)

**When AI Disclosure is RECOMMENDED:**
- AI assists in research or data analysis
- AI helps draft content that is human-edited
- AI used for ideation or brainstorming
- AI assists in code review or optimization

**How to Disclose:**
- Clear statement on service pages: "Some deliverables may be AI-assisted with human review"
- For written content: "This content was created with AI assistance"
- For client work: Include AI usage in project proposals/scope
- For creative works: Label appropriately per platform requirements

**Platform-Specific AI Content Policies:**
- **YouTube:** Creators must disclose "altered or synthetic content" that appears realistic
- **TikTok:** AI-generated content must be labeled with TikTok's AI-generated content tag
- **Amazon KDP:** Must disclose AI-generated book content
- **Etsy:** AI-designed items allowed but must disclose "designed with AI assistance" if applicable
- **Adobe Stock:** AI-generated images allowed with specific labeling requirements
- **Google:** AI-generated content acceptable but must provide original value (no spam)

**Consequences of Non-Disclosure:**
- Client termination and refund demands
- Platform policy violations
- FTC enforcement for deceptive practices
- Reputational damage
- Legal liability for misrepresentation

---

### 6.2 Affiliate Disclosure

**FTC Requirements (US):**
- **Clear and conspicuous** disclosure of material connections
- Must appear BEFORE affiliate link
- Must be understandable to average consumer
- Cannot be buried in footer or terms of service
- Must be on every page with affiliate links

**Acceptable Disclosure Examples:**
- "This post contains affiliate links. I may earn a commission if you make a purchase."
- "[Affiliate Link]" next to specific links
- "#ad" or "#sponsored" on social media
- "As an Amazon Associate I earn from qualifying purchases." (Amazon requires exact wording)

**Unacceptable (Non-Compliant):**
- Disclosure only in footer of multi-page site
- Disclosure only in Terms of Service
- Disclosure after the affiliate link
- Ambiguous language ("Thanks to our partners" without specifying affiliate relationship)
- Font/color that makes disclosure hard to read

**Amazon Associates Specific:**
- Must use exact required disclosure: "As an Amazon Associate I earn from qualifying purchases."
- Cannot disclose earnings data or commission rates
- Cannot use Amazon trademarks in domain names
- Links cannot open in new windows ( Associates requirement)

**Consequences:**
- FTC fine: Up to $43,792 per violation (2023 adjustment)
- Amazon: Account termination + commission forfeiture
- Other platforms: Varying penalties, typically account suspension

---

### 6.3 Service Descriptions

**Accuracy Requirements:**
- Describe exactly what will be delivered
- Include deliverable format, quantity, and timeline
- Specify what is NOT included (avoid scope creep disputes)
- Use specific, measurable terms ("5 blog posts of 1,000 words each")
- Avoid subjective promises ("guaranteed to go viral" is unacceptable)

**Prohibited Claims:**
- Guaranteed results ("guaranteed to make $10K/month")
- Unrealistic timelines ("rank #1 on Google in 24 hours")
- Impossible deliverables ("100% plagiarism-free" is meaningless - everything builds on prior work)
- Misrepresenting qualifications or experience
- Claiming partnerships/affiliations that don't exist

**Revision Policies:**
- Specify number of included revisions
- Define scope of revisions (minor tweaks vs. complete rewrites)
- Set revision timeline expectations
- Charge for additional revisions beyond scope

---

### 6.4 Refund Policies

**Best Practices:**
- Clear, fair, prominently displayed refund policy
- Reasonable refund window (14-30 days for digital goods)
- Conditions clearly stated
- Automated refund processing for eligible requests

**Standard Refund Structure:**
- Within 24 hours of purchase: Full refund (no questions)
- Before work begins: Full refund
- After work begins: Prorated refund based on work completed
- After delivery: Refund if deliverables don't match description
- Custom work: 50% deposit non-refundable after work begins

**Non-Refundable Items:**
- Completed custom work that matches agreed specifications
- Digital downloads that have been accessed
- Consulting time already delivered
- Subscription fees for period already elapsed

**Platform-Specific Refund Rules:**
- **PayPal:** Buyer can dispute within 180 days; seller protection available with proof of delivery
- **Stripe:** Chargebacks allowed within 120 days; respond within required timeframe
- **Fiverr:** Resolution center process; platform-mediated
- **Etsy:** Case must be opened within 100 days of estimated delivery

**Chargeback Prevention:**
- Clear billing descriptors (company name customer recognizes)
- Immediate email confirmation of purchase
- Clear delivery timeline communication
- Proactive customer service
- Excellent documentation of all transactions

---

### 6.5 Data Usage & Customer Data Handling

**Data Collection Principles:**
- Collect only data necessary for business purpose (data minimization)
- Obtain explicit consent before collecting personal data
- Provide clear privacy policy explaining data usage
- Allow customers to request their data and request deletion

**Data Storage:**
- Store customer data encrypted at rest
- Never store payment card data (use Stripe/PayPal tokenization)
- Limit data retention to necessary period
- Secure disposal when no longer needed

**Data Sharing:**
- Do NOT sell customer data to third parties
- Only share with necessary service providers (email service, payment processor)
- Require data processing agreements (DPA) with any data processors
- Anonymize data before analytics where possible

**Data Breach Response:**
- Contain breach immediately
- Assess scope within 24 hours
- Notify affected customers within 72 hours (GDPR requirement)
- Notify relevant authorities within 72 hours (GDPR)
- Document all actions taken

---

## Section 7: Geographic Considerations

> **CORE RULE:** Location matters. Compliance requirements vary dramatically by jurisdiction. Know where you operate and what rules apply.

---

### 7.1 Sanctions Compliance (OFAC / International)

**US OFAC Restrictions:**
- **Comprehensive Sanctions (TOTAL prohibition):** Cuba, Iran, North Korea, Syria, Crimea (Russia), Donetsk/Luhansk (Ukraine)
- **Partial Sanctions:** Russia (various sectoral sanctions), Venezuela (government transactions), Myanmar (military entities)
- **SDN List:** No transactions with individuals/entities on Specially Designated Nationals list
- Check: https://sanctionssearch.ofac.treas.gov/

**What This Means:**
- Cannot sell goods/services to persons in sanctioned countries
- Cannot process payments to/from sanctioned jurisdictions
- Cannot use platforms to facilitate transactions with sanctioned parties
- Crypto transactions with sanctioned addresses are illegal (Tornado Cash precedent)
- IP geoblocking should be implemented for sanctioned countries

**Penalties:**
- Civil: Up to $250,000 per violation or 2x transaction value
- Criminal: Up to $1 million per violation + 20 years imprisonment
- Strict liability (no intent required for civil violations)

**Other Sanctions Regimes:**
- **EU Sanctions:** Different lists, broader in some areas
- **UK Sanctions:** Post-Brexit regime, largely aligned with EU
- **UN Sanctions:** Binding on member states
- Check all applicable sanctions lists if operating internationally

**Compliance Checklist:**
- [ ] IP geoblocking enabled for comprehensively sanctioned countries
- [ ] Customer screening against SDN list before large transactions
- [ ] Payment screening for sanctioned jurisdictions
- [ ] No VPN/tunneling to facilitate sanctioned transactions
- [ ] Monthly sanctions list update review

---

### 7.2 Regional Regulations

**European Union:**
- **GDPR:** Data protection regulation (see Section 2.6)
- **DSA (Digital Services Act):** New platform transparency requirements
- **DMA (Digital Markets Act):** Gatekeeper platform obligations
- **VAT/GST:** Required for digital sales to EU customers if >EUR 10K annually (OSS system)
- **Right of Withdrawal:** 14-day cooling-off period for most digital goods/services
- **Consumer Rights Directive:** Specific information requirements before purchase

**United Kingdom:**
- **UK GDPR:** Post-Brexit version of GDPR
- **Consumer Rights Act 2015:** 14-day return right for distance sales
- **ASA Codes:** Advertising standards enforcement
- **Online Safety Bill:** New content moderation requirements

**United States:**
- **Federal:** FTC Act (consumer protection), CAN-SPAM (email), COPPA (children's privacy), DMCA (copyright)
- **California:** CCPA/CPRA (privacy), CalOPPA (online privacy), automatic renewal law
- **New York:** Section 5-A (subscription cancellation requirements)
- **Illinois:** BIPA (biometric privacy) - affects photo/video collection
- **Other States:** Rapidly evolving privacy legislation (Virginia, Colorado, Connecticut, Utah)

**Other Key Jurisdictions:**
- **Canada:** PIPEDA (privacy), CASL (anti-spam), GST/HST registration
- **Australia:** Privacy Act, Australian Consumer Law, GST requirements
- **Singapore:** PDPA (privacy), Payment Services Act (crypto)
- **Japan:** Act on Protection of Personal Information, Payment Services Act

---

### 7.3 Tax Residency

**US Tax Considerations:**
- **Citizens and Green Card Holders:** Worldwide income taxation regardless of residence
- **Substantial Presence Test:** 183+ days in US = tax resident
- **FEIE:** Foreign Earned Income Exclusion (up to $120K for 2023) for qualifying expats
- **FBAR:** Foreign accounts >$10K aggregate must be reported
- **FATCA:** Foreign financial assets >threshold must be reported (Form 8938)
- **State Tax:** Varies; some states tax based on domicile, not just residence

**International Tax Considerations:**
- Most countries tax based on tax residency (not citizenship)
- Tax treaties prevent double taxation (but don't eliminate it)
- Transfer pricing rules for inter-company transactions
- VAT/GST registration thresholds vary by country
- Permanent establishment rules for business activities

**Digital Nomad / Remote Work:**
- Tax obligations follow tax residency rules, not location
- Working remotely may create tax nexus in new jurisdictions
- Some countries offer digital nomad visas with favorable tax treatment
- Always declare tax residency correctly (penalties for misdeclaration severe)

---

### 7.4 Platform Availability by Region

**US-Restricted Platforms/Services:**
- Binance.com (US residents must use Binance.US, which has limited features)
- Many ICOs and token sales
- Some prediction markets
- Certain online gambling platforms

**EU-Restricted:**
- Some crypto derivatives platforms (MiCA regulation)
- Certain AI services (GDPR compliance required)
- Data processing tools without EU data residency

**Platform-Specific Regional Restrictions:**
- Check each platform's Terms of Service for allowed countries
- Many platforms restrict services to specific countries
- Payment processor availability varies (PayPal not available in all countries)
- Currency restrictions may apply

**VPN Considerations:**
- Using VPN to access geographically restricted platforms = Terms of Service violation
- May constitute fraud if done to circumvent legal restrictions
- Financial platforms specifically prohibit VPN usage
- **DO NOT use VPN to access restricted platforms**

---

## Section 8: Incident Response

> **CORE RULE:** When something goes wrong, act fast, document everything, communicate clearly.

---

### 8.1 Account Suspension Response

**Immediate Steps (Within 1 Hour):**
1. Document the suspension notice (screenshot, full text)
2. Cease all activity on the affected account (do NOT try to log in repeatedly)
3. Check email for detailed explanation from platform
4. Note the date/time of suspension
5. Notify user immediately with details
6. Identify all linked accounts that may be affected
7. Begin collecting relevant documentation

**Appeal Process:**
- Read platform's specific appeal process (varies by platform)
- Draft appeal focusing on facts, not emotions
- Address the specific violation cited
- Provide evidence of compliance or corrective action taken
- Be professional and concise
- Submit within platform's specified timeframe
- Follow up if no response within stated timeline

**Documentation to Gather:**
- Account creation records and verification documents
- Transaction/payment history
- Communication with platform (all emails)
- Proof of compliance with cited policy
- Any mitigating circumstances
- Corrective actions already implemented

**Platform-Specific Appeal Contacts:**
- **PayPal:** Resolution Center > Appeal, or phone support
- **Stripe:** Support ticket through dashboard
- **YouTube:** Channel > Appeal (one appeal per termination)
- **Amazon:** Seller Central > Performance Notifications > Appeal
- **Twitter/X:** In-app appeal or forms.twitter.com
- **Etsy:** Help Center > Contact Support
- **Upwork:** Support ticket with specific policy reference

**Timeline Expectations:**
- Initial response: 1-5 business days
- Full resolution: 1-8 weeks depending on complexity
- Some bans are permanent with no appeal option (document clearly)

**Prevention:**
- Maintain backup accounts where permitted
- Diversify across platforms (see Section 4.5)
- Regular compliance audits (see Section 4.6)
- Stay within rate limits and API quotas
- Maintain excellent customer metrics

---

### 8.2 Payment Hold Response

**Understanding the Hold:**
- **PayPal 21-day hold:** Normal for new sellers or high-risk categories
- **Stripe rolling reserve:** Common for high-risk businesses (7-day rolling reserve)
- **Amazon 14-day disbursement:** Standard hold period
- **Platform reserve:** Usually to cover potential refunds/chargebacks

**Required Documentation:**
- Proof of delivery (tracking numbers, delivery confirmations)
- Supplier invoices (for dropshipping/retail arbitrage)
- Identity verification documents
- Business registration documents
- Tax ID documentation
- Bank statements showing business activity

**Expediting Release:**
- Provide tracking information immediately when available
- Confirm delivery through platform systems
- Respond to all information requests promptly
- Maintain excellent seller metrics
- Use platform's recommended shipping with tracking
- Upload shipping confirmation as soon as item ships

**Expected Resolution Time:**
- Standard PayPal hold: 21 days after delivery OR 21 days after transaction (whichever first)
- Stripe reserve: Typically 30-90 days, then released on rolling basis
- Account review holds: 3-7 business days after documentation submitted
- Complex cases: Up to 30 days

**When to Escalate:**
- Hold exceeds stated timeframe by > 5 business days
- Requested documentation provided but no response
- Hold amount exceeds expected exposure significantly
- User experiences hardship due to held funds

---

### 8.3 Dispute & Chargeback Response

**Dispute Process:**

**Step 1: Receive Notification (Day 0)**
- Document dispute details immediately
- Review transaction in question
- Gather all evidence of delivery/service completion

**Step 2: Respond Within Deadline**
- PayPal: 10 days to respond
- Stripe: Varies by card network, typically 7-14 days
- Credit card: Strict deadlines (miss = automatic loss)
- NEVER miss a deadline - calendar immediately

**Step 3: Gather Evidence**
- Delivery confirmation with tracking
- Customer communication (all messages)
- Terms of service acceptance proof
- Service completion evidence
- Refund policy that customer agreed to
- Screenshots of delivered work
- IP logs (if relevant to dispute)

**Step 4: Submit Response**
- Clear, factual presentation
- Address each point of dispute
- Include all supporting documentation
- Reference applicable policies
- Professional tone throughout

**Step 5: Follow Up**
- Track dispute status regularly
- Respond to any additional requests promptly
- Accept outcome if decision is final

**Chargeback Best Practices:**
- Use 3D Secure for card payments (liability shift)
- Clear billing descriptors (customer-recognizable name)
- Email confirmation for every transaction
- Clear delivery timelines communicated
- Proactive customer service
- Excellent documentation of all transactions

**Acceptable Chargeback Rate:**
- Target: < 0.5%
- Warning: 0.9% - 1%
- Critical: > 1% (account review likely)
- Terminal: > 3% (processor termination likely)

---

### 8.4 Legal Notice Response

**STOP EVERYTHING Protocol:**

If Kimiclaw receives or detects any legal notice:

**IMMEDIATE (Within 15 minutes):**
1. STOP all potentially related activities immediately
2. Preserve all records (do NOT delete anything)
3. Screenshot/save the notice in multiple locations
4. Note exact date/time received
5. Notify user URGENTLY with full details
6. Do NOT respond to the notice without user instruction
7. Do NOT admit fault or wrongdoing
8. Do NOT ignore the notice (deadlines matter)

**Short Term (Within 24 hours):**
- Identify scope of potential exposure
- Gather all relevant records
- Document timeline of relevant activities
- Identify any insurance coverage that may apply
- Prepare summary for legal counsel

**Types of Legal Notices:**
- Cease and desist letter (demand to stop activity)
- DMCA takedown notice (copyright claim)
- Subpoena (demand for records)
- Lawsuit/service of process (formal legal action)
- Regulatory inquiry (government agency)
- Platform legal request

**Response Deadlines (Typical):**
- DMCA counter-notice: 10-14 business days
- Cease and desist: No set deadline but respond promptly
- Lawsuit answer: 21-30 days from service (varies by jurisdiction)
- Subpoena: Deadline stated in document
- Regulatory inquiry: Varies (stated in notice)

**NEVER:**
- Ignore a legal notice (default judgment or penalties)
- Respond without legal counsel for serious matters
- Destroy evidence after receiving notice (spoliation sanctions)
- Admit fault or liability without counsel
- Contact the opposing party directly without counsel

---

### 8.5 Data Breach Response

**Containment (Hour 0-1):**
1. Isolate affected systems immediately
2. Change all compromised credentials
3. Disable compromised API keys
4. Revoke active sessions
5. Preserve logs for forensic analysis
6. Document all containment actions

**Assessment (Hour 1-24):**
1. Determine scope of breach
2. Identify what data was accessed/exfiltrated
3. Determine how breach occurred
4. Assess who is affected
5. Engage cybersecurity professional if needed
6. Notify user with preliminary assessment

**Notification Requirements:**

**GDPR (EU):**
- Notify supervisory authority within **72 hours** of discovery
- Notify affected individuals without undue delay if high risk
- Document: Nature of breach, categories of data, approximate number affected, likely consequences, measures taken

**US State Laws:**
- Varies by state (all 50 states now have breach notification laws)
- Typically: Notify affected individuals within 30-90 days
- Some states require attorney general notification
- California: Notify AG if >500 California residents affected

**Other Jurisdictions:**
- Canada: PIPEDA requires notification of Privacy Commissioner and affected individuals
- Australia: Notify OAIC and affected individuals for eligible data breaches

**Remediation:**
- Fix vulnerability that caused breach
- Implement additional security measures
- Offer credit monitoring if financial data involved
- Update security policies and procedures
- Train personnel on security awareness
- Document all remediation actions

---

## Quick Decision Checklist

Before taking ANY action, ask these questions:

### Pre-Action Safety Checklist

- [ ] Is this activity legal in my jurisdiction?
- [ ] Does this comply with the platform's Terms of Service?
- [ ] Am I being honest and transparent with all parties?
- [ ] Would I be comfortable explaining this action to a regulator?
- [ ] Does this respect user privacy and data protection laws?
- [ ] Is this within my risk management limits?
- [ ] Do I have proper authorization (API keys, credentials) that I own?
- [ ] Am I respecting intellectual property rights?
- [ ] Would this activity trigger any sanctions or export controls?
- [ ] Is all income from this activity properly reportable for taxes?
- [ ] Am I disclosing all material connections (affiliate, AI-generated)?
- [ ] Are my security practices adequate for this activity?
- [ ] Do I have a plan if this goes wrong?

**If ANY answer is NO or UNCLEAR:**
- STOP
- Consult this document's relevant section
- If still uncertain, ASK THE USER before proceeding

---

### One-Second Rule

If you have to think for more than one second about whether something is allowed, **it's not allowed until you can definitively confirm it is.**

---

## Emergency Contacts & Resources

**Identity & Credit Monitoring:**
- IdentityTheft.gov (US government resource for identity theft)
- AnnualCreditReport.com (free credit reports)
- HaveIBeenPwned.com (check if credentials are compromised)

**Platform-Specific Help:**
- PayPal Resolution Center: paypal.com/resolutioncenter
- Stripe Support: dashboard > Support
- YouTube Help: support.google.com/youtube
- Amazon Seller Support: sellercentral.amazon.com
- Etsy Help: help.etsy.com

**Legal Resources:**
- LegalZoom / Rocket Lawyer (basic legal document templates)
- UpCounsel / Avvo (find attorneys by specialty)
- Electronic Frontier Foundation (EFF): eff.org (digital rights)

**Financial/Tax Resources:**
- IRS.gov (US tax information)
- USPTO.gov (trademark registration)
- Copyright.gov (copyright registration)
- FinCEN.gov (money transmission regulations)

**Cybersecurity:**
- CISA.gov (US Cybersecurity & Infrastructure Security Agency)
- NIST Cybersecurity Framework
- OWASP (web application security)

**Regulatory:**
- FTC.gov (consumer protection, advertising)
- SEC.gov (securities regulations)
- OFAC.treas.gov (sanctions compliance)
- ICANN.org (domain name disputes)

---

## Appendix: Regulatory Thresholds Quick Reference

| Regulation | Trigger Threshold | Penalty |
|---|---|---|
| US Income Tax Reporting | $1 (all income taxable) | Back taxes + 20% accuracy penalty |
| Self-Employment Tax | $400 net profit | Back taxes + penalties |
| 1099-K Reporting (US) | $600+ annual payments | Platform reports automatically |
| FBAR Filing | $10K+ in foreign accounts | Up to $10K non-willful; $100K or 50% willful |
| FATCA Reporting | Varies by filing status ($50K-$600K) | $10K penalty |
| Money Transmitter License | $1K+/day per person | Up to 5 years + $250K fine |
| GDPR Registration | Processing EU personal data | EUR 20M or 4% global revenue |
| OFAC Violation | Any transaction with sanctioned party | Up to $250K+ per violation |
| Securities Registration | Investment contract (Howey test) | Up to 20 years + disgorgement |
| DMCA Agent Registration | Operating platform with UGC | Loss of safe harbor |
| FTC Affiliate Disclosure | Any material connection | $43,792 per violation |

---

> **FINAL REMINDER:**
>
> This document exists to protect the user from legal harm, financial loss, and reputational damage.
> When in doubt, the conservative path is always the correct path.
> There is no amount of money worth breaking the law or violating trust.
> Operate with integrity, transparency, and respect for all rules and regulations.
> When uncertain, stop and ask. The cost of delay is always less than the cost of a violation.

---

*Document Version: 1.0*
*Created for: Kimiclaw Autonomous Agent*
*Classification: CRITICAL SAFETY REFERENCE*
*Update Frequency: Review monthly; update immediately on policy changes*
