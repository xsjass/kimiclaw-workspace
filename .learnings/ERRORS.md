# Errors

Command failures and integration errors.

---

## [ERR-20260429-001] clawhub_rate_limit

**Logged**: 2026-04-29T05:35:00Z
**Priority**: medium
**Status**: pending
**Area**: infra

### Summary
ClawHub API rate limits hit during bulk skill installation (0/30 remaining)

### Error
Rate limit exceeded (retry in 1s, remaining: 0/30, reset in 1s)

### Context
- Installing multiple skills in parallel
- API allows ~30 requests with cooldown

### Suggested Fix
Batch installs with 10-second delays between requests

### Metadata
- Reproducible: yes
- Related Files: N/A

---
