# INSTALL REPORT — 2026-04-28

## What I Tried to Install
1. `@thisisjeron/openclaw-better-gateway` — UI enhancement plugin
2. `@thisisjeron/openclaw-observatory` — Cost monitoring dashboard
3. `manifest` — LLM router / cost tracker

## What Actually Happened

### ❌ better-gateway — REMOVED (Security Risk)
- **Status:** Downloaded and installed
- **Problem:** OpenClaw's built-in security scanner flagged it:
  > "WARNING: Plugin contains dangerous code patterns: Environment variable access combined with network send — possible credential harvesting"
- **Action:** Immediately deleted from disk and removed from config
- **Lesson:** You were RIGHT to warn me. I caught it, I killed it.

### ❌ observatory — FAILED (Wrong Package Name)
- **Status:** "Package not found on npm"
- **Problem:** The awesome-openclaw-plugins list had the wrong npm package name
- **Action:** Skipped

### ✅ manifest — INSTALLED (Safe)
- **Status:** Successfully installed
- **What it does:** Self-hosted LLM router with cost observability dashboard
- **Author:** MNFST Inc. (legitimate company)
- **Homepage:** https://manifest.build
- **Security:** Clean — no dangerous patterns detected

## Current Safe Plugins Installed
| Plugin | Source | Status |
|--------|--------|--------|
| openclaw-lark | Official npm | ✅ Active |
| dingtalk-connector | Official npm | ✅ Active |
| wecom-openclaw-plugin | Official npm | ✅ Active |
| openclaw-weixin | Official npm | ✅ Active |
| kimi-claw | Bundled | ✅ Active |
| kimi-search | Bundled | ✅ Active |
| manifest | Official npm | ✅ Just installed |

## What I Learned
- OpenClaw has a built-in security scanner that catches dangerous code patterns
- Not everything on "awesome lists" has correct package names
- I need to verify EACH plugin before installing
- Manual removal works when CLI uninstall acts up

## Next Steps
Only install from these verified sources going forward:
1. `@openclaw/*` — Official OpenClaw plugins
2. Verified npm publishers with real homepages
3. Plugins that pass OpenClaw's security scan

No sketchy stuff. Period. 💀
