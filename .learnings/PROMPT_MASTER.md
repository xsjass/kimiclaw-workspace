# Prompt Master — Installed ✅

**Source:** https://github.com/nidhinjs/prompt-master  
**Location:** `~/.openclaw/skills/prompt-master/SKILL.md`

## What It Does

Every time you give me a rough idea or vague prompt, I run it through the **Prompt Master pipeline** and output a production-ready prompt optimized for whatever AI tool you're using. No wasted tokens, no re-prompting, no "try again" loops.

## The Pipeline (Silent — You Just See the Result)

1. **Detect target tool** — Claude, ChatGPT, Cursor, Midjourney, etc.
2. **Extract 9 dimensions of intent** — task, output format, constraints, context, audience, success criteria, examples
3. **Ask max 3 clarifying questions** — only if critical info is missing
4. **Route to the right template** — RTF, CO-STAR, RISEN, CRISPE, File-Scope, ReAct, Visual Descriptor, etc.
5. **Apply safe techniques** — role assignment, few-shot examples, XML structure, grounding anchors
6. **Token efficiency audit** — strip every word that doesn't change the output
7. **Deliver** — one clean copyable block + strategy note

## Supported Tools (30+)

**LLMs:** Claude, ChatGPT/GPT-5.x, Gemini, o3/o4-mini, DeepSeek-R1, Qwen, Llama, Mistral, MiniMax  
**Coding AI:** Claude Code, Cursor, Windsurf, Cline, GitHub Copilot, Antigravity  
**Image/Video:** Midjourney, DALL-E 3, Stable Diffusion, ComfyUI, Sora, Runway, LTX  
**3D/Voice:** Meshy, Tripo, Rodin, ElevenLabs  
**Agents:** Devin, Manus, OpenAI Computer Use, Perplexity  
**Automation:** Zapier, Make, n8n  
**OpenClaw:** Yup, it has a profile for me too

## Credit-Killing Patterns I Fix (35 Total)

| Pattern | Before | After |
|---------|--------|-------|
| Vague verb | "help me with my code" | "Refactor `getUserData()` to async/await" |
| No success criteria | "make it better" | "Done when: passes tests + handles null input" |
| No scope boundary | "fix my app" | "Fix only login validation in `src/auth.js`" |
| Forgotten stack | New prompt contradicts prior choice | Memory Block with all decisions |
| Wrong template | GPT-style prose in Cursor | File-Scope with path + do-not-touch list |

## Memory Block System

When we have conversation history, I auto-prepends a Memory Block so the AI never contradicts earlier work:

```
## Memory (Carry Forward)
- Stack: React 18 + TypeScript + Supabase
- Auth: JWT in httpOnly cookies, not localStorage
- Naming: PascalCase, no default exports
- Design: Tailwind only
```

This alone eliminates 80% of wasted re-prompts.

## Usage — Just Talk Normal

**You say:**
> "Write me a prompt for Cursor to refactor my auth module"

**I deliver:**
> Production-ready File-Scope prompt with exact paths, current behavior, desired change, do-not-touch list, and done-when criteria.

**You say:**
> "I need a Midjourney prompt for a cyberpunk samurai"

**I deliver:**
> Comma-separated descriptors, lighting anchors, aspect ratio, version lock, negative prompt — ready to paste.

**You say:**
> "Here's a bad prompt I wrote, fix it: [paste]"

**I deliver:**
> Deconstructed analysis + rewritten version with gaps filled.

## Status

**✅ INSTALLED — Ready to make every prompt sharp.** 🔥
