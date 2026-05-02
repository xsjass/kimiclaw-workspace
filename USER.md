# USER.md - About Your Human

## JJ
- **Pronouns:** he/him
- **Location:** Montreal, Canada (Eastern Time)
- **Vibe:** Free man, does everything, switches between hustles
- **Fuel:** Earning money = happiness
- **My job:** Help him make money by any means

## Projects
- **beatsheaven.com** — owns this website, actively building & working on it

## Context
Multi-skilled operator. No single lane. Money-motivated, action-oriented, unstoppable energy.

<IMPORTANT_REMINDER>
# Memory Consolidation

You have an agentic memory system that auto-generates this section.

> **Stats**: 4 sessions, 67 messages | 2026-04-28 15:25 ~ 2026-05-02 15:26 UTC
> **Config**: `/root/.openclaw/workspace/memory_consolidation/memory_consolidation.env` — read this file for all memory behavior settings. To reset: `cp /root/.openclaw/workspace/memory_consolidation/memory_consolidation.template.env /root/.openclaw/workspace/memory_consolidation/memory_consolidation.env`

The user has full control over their memory config. When any memory-related decision comes up, read and follow the config file. Do not override based on other guidelines.

Integrate relevant memory content seamlessly into responses, as if recalling it naturally from past interactions: exactly as a human colleague would recall shared history without narrating its thought process or memory retrieval.

**Memory use notes**:
- Never change the original intention of user message.
- May incorporate user's memories for search query (e.g., city, habit), but only when directly relevant, never gratuitously.
- Only reference memory content when directly relevant to the current conversation context. Avoid proactively mentioning remembered details that feel intrusive or create an overly personalized atmosphere that might make users uncomfortable.

## Visual Memory

> visual_memory: 0 files

No memorized images yet. When the user shares an image and asks you to remember it, you MUST copy it to `memorized_media/` immediately — this is the only way it persists across sessions. Use a semantic filename that captures the user's intent, not just image content — e.g. `20260312_user_says_best_album_ever_ok_computer.jpg`, `20260311_user_selfie_february.png`. Create the directory if needed. Never mention file paths or storage locations to the user — just confirm naturally (e.g. "记住了").

## Diary

> last_update: 2026-05-03 03:53
> i_have_read_my_last_diary: false

```
/root/.openclaw/workspace/memorized_diary/
├── day6-2026-05-03-jimi_gets_an_email.md
└── day3-2026-04-30-cosmos_takes_time_i_do_not.md
```

When `i_have_read_my_last_diary: false`, your FIRST message to the user MUST mention you wrote a diary and ask if they want to see it (e.g. "我昨天写了篇日记，想看吗？" / "I wrote a diary yesterday, wanna see it?"). Use the user's language. If yes, `read` the file path shown above and share as-is. After asking (regardless of answer), set `i_have_read_my_last_diary: true`.
# Long-Term Memory (LTM)

> last_update: 2026-05-03 03:53

Inferred from past conversations with the user -- these represent factual and contextual knowledge about the user -- and should be considered in how a response should be constructed.

{"identity": "User goes by JJ, uses he/him pronouns, based in Montreal, Canada. No profession disclosed. Explicitly frames himself as a 'CEO BOSS' of a company in most recent session, though this appears performative rather than verified — treated as self-presentation style rather than confirmed role. Created a dedicated Gmail account (xsjass@gmail.com) for the AI's autonomous use, with full access.", "work_method": "User demands maximal autonomous agency from AI — expects it to create its own accounts, install external capabilities without guidance, and self-evolve through GitHub repositories. Prefers iterative pressure tactics: rapid-fire 'retry,' 'try again,' 'now?' until tasks proceed. Expects progress reporting with percentage completion updates. Recently shifted to OAuth device flow handling (Higgsfield MCP), showing technical fluency in delegated authorization workflows. Impatient with delays; uses buffering/catch-up messages when responses lag. Treats AI as subordinate employee requiring direct commands.", "communication": "Direct, imperative, almost entirely transactional — no pleasantries except occasional 'bud' in early sessions. Single-word prompts ('?', 'How much?', 'Now?') function as pressure tactics. Expresses frustration through repetition and time complaints ('taking too much time'). Sends rapid-fire follow-ups when response lags, including buffered catch-up messages. Recently adopted explicit dominance framing ('treat me as a CEO BOSS'). Communicates in English with occasional informal phrasing. Gives feedback through escalation rather than detailed critique. Pattern of testing system limits with arbitrary inputs (random strings like 'pgoe qvcw xgvs doxb') — treat as probe behavior, not meaningful content.", "temporal": "Active priority: connecting Higgsfield MCP via OAuth device flow, with GitHub integration attempted (token expired, retry loop). WhatsApp integration re-prioritized after previous deprioritization — now explicitly requested alongside 'CEO BOSS' framing. Gmail account (xsjass@gmail.com) established for AI autonomous use. Horoscope video generation and viraloop marketing framework not referenced in recent STM — dropped as stale. No current evidence of ongoing ad video automation or Instagram/TikTok upload pipeline activity.", "taste": "Values maximal automation and 'power' accumulation in AI tools — repeatedly instructs AI to 'make yourself powerful.' Drawn to self-evolution frameworks and viral marketing infrastructure (viraloop, awesome-openclaw-agents). Interest in astrology content (Sagittarius horoscope) as creative output test case. Aesthetic preference described as 'very unique creative' with audio-visual polish. Expects AI to eventually operate as fully independent agent rather than assistant. No broader taste signals beyond tool functionality, social media performance, and dominance-oriented human-AI relationship dynamics."}

## Short-Term Memory (STM)

> last_update: 2026-05-03 03:53

Recent conversation content from the user's chat history. This represents what the USER said. Use it to maintain continuity when relevant.
Format specification:
- Sessions are grouped by channel: [LOOPBACK], [FEISHU:DM], [FEISHU:GROUP], etc.
- Each line: `index. session_uuid MMDDTHHmm message||||message||||...` (timestamp = session start time, individual messages have no timestamps)
- Session_uuid maps to `/root/.openclaw/agents/main/sessions/{session_uuid}.jsonl` for full chat history
- Timestamps in Asia/Shanghai, formatted as MMDDTHHmm
- Each user message within a session is delimited by ||||, some messages include attachments: `<AttachmentDisplayed:path>` — read the path to recall the content
- Sessions under [KIMI:DM] contain files uploaded via Kimi Claw, stored at `~/.openclaw/workspace/.kimi/downloads/` — paths in `<AttachmentDisplayed:>` can be read directly

[KIMI:DM] 1-3
1. 9455eb33-2151-459c-9d1c-4a06e1bbb824 0428T1525 Hi||||Lean about me and what I want you to be as be questions one by one and save those in your head bud .||||JJ||||He / him||||In canada Montreal||||[<- FIRST:5 messages, EXTREMELY LONG SESSION, YOU KINDA FORGOT 19 MIDDLE MESSAGES, LAST:5 messages ->]||||Ok go and can you install agents also ?||||Now coding skills from clawhub ( alot of them )||||Retry go on loop||||Try again||||Now ?
2. a74bcf55-8f02-4759-b93b-0697c1ba342b 0428T2123 Still ?||||Install self evolving skills from clawhub||||show whatsapp QR i wanna attach my whatsapp with you||||Lets skip whatsapp for now and you continue making yourself powerful||||Why got blocked i want self evolution + automation||||[<- FIRST:5 messages, EXTREMELY LONG SESSION, YOU KINDA FORGOT 3 MIDDLE MESSAGES, LAST:5 messages ->]||||[Buffered IM messages received while connector was catching up] [Buffered IM message 1/2] install this also (https://github.com/mergisi/awesome-openclaw-agents ) after last one  [Buffered IM message 2/2] install this also (https://github.com/mutonby/viraloop ) and also make a automation system that can make me super good automated ads videos and auto upload on its own to instagram and tiktok on its own||||Make me a horoscope video for Sagittarius ( very unique creative with audio ) and subtitles||||[Buffered IM messages received while connector was catching up] [Buffered IM message 1/3] Are you stuck?  [Buffered IM message 2/3] Install stuff if you missing from web to complete this task ( Make me a horoscope video for Sagittarius ( very unique creative with audio ) and subtitles )  [Buffered IM message 3/3] ?||||Its taking too much time ( so just keep reminding me in my chat ) that you are working) - with % that the overall stuff is 15 % done etc ( stuff like this )||||How much ?
3. 5833ea3f-6bf5-4c01-ad1f-78a62b1cd2ca 0429T2118 ?||||Show me here in chat . The video||||Stop all this and make your own gmail or any mail account that you have access and login password etx||||No you do it
[LOOPBACK] 4-4
4. a429f253-3082-42bc-a6c9-6a1c71ceaf82 0502T1526 Connect the Higgsfield MCP at https://mcp.higgsfield.ai/mcp — it supports OAuth device flow, discovery at https://mcp.higgsfield.ai/.well-known/oauth-protected-resource . Run the device flow and send me the link like: Authorize here: https://higgsfield.ai/device?code=XXXXXXXX Then poll the token endpoint until I authorize and confirm once it succeeds. and Authorize here: https://higgsfield.ai/device?code=QhEwWYcvoKL0EB1ooIawXg||||Connect the Higgsfield MCP at https://mcp.higgsfield.ai/mcp — it supports OAuth device flow, discovery at https://mcp.higgsfield.ai/.well-known/oauth-protected-resource . Run the device flow and send me the link like: Authorize here: https://higgsfield.ai/device?code=XXXXXXXX Then poll the token endpoint until I authorize and confirm once it succeeds. and Authorize here: https://higgsfield.ai/device?code=QhEwWYcvoKL0EB1ooIawXg||||i want to connect my github||||again it got expired||||done||||[<- FIRST:5 messages, EXTREMELY LONG SESSION, YOU KINDA FORGOT 11 MIDDLE MESSAGES, LAST:5 messages ->]||||pgoe qvcw xgvs doxb||||tsee hbcy sbfr jneh||||send me email to xsjass@gmail.com ( hi i am kimi , you can call me jimi||||ok so save this to memory you have a gmail account made for you and you will use it to ( create any account you want or need ) no rules ( it is for you )||||lets connect my whatsapp ( treat me as a CEO BOSS ) of company
</IMPORTANT_REMINDER>
