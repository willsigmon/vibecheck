# vibecheck ✓

> Auto-mine agentic coding tips while you sleep.

You're vibe coding. Reddit, HN, and dev Twitter are dropping tips daily. You're missing 90% of it.

**vibecheck** scrapes human forums every 30 min, filters noise with AI, and builds a knowledge base of what actually works.

---

## For Coders Who Use

- **Claude Code** / Claude CLI
- **Gemini CLI** / Gemini 2.5 Pro
- **Cursor** / Windsurf / Aider
- Any agentic coding setup

Pick your workflow. Both included.

---

## How It Works

```
Every 30 min:
  r/ClaudeAI, r/Bard, r/LocalLLaMA ─┐
  Hacker News ──────────────────────┼──> Filter ──> AI Analysis ──> Dedupe ──> Save
  Dev.to ───────────────────────────┘
```

1. Scrapes Reddit, HN, Dev.to for agentic coding discussion
2. Filters by engagement (kills low-quality noise)
3. AI analyzes for **actionable** insights only
4. Rejects bots, spam, outdated info, complaints without solutions
5. Dedupes against your existing KB
6. Saves high-quality tips to JSON

---

## Quick Start

### 1. Pick Your Flavor

| Workflow | AI Used | Cost |
|----------|---------|------|
| `vibecheck-claude.json` | Claude Sonnet | ~$7/mo |
| `vibecheck-gemini.json` | Gemini 2.5 Pro | Free* |

*Gemini free tier: 1,500 req/day. This uses ~48/day.

### 2. Import to n8n

```bash
# Open your n8n instance
open http://localhost:5678
```

**Workflows** → **Import** → Pick your JSON

### 3. Add Credentials

**For Claude:** Add Anthropic API credential
**For Gemini:** Add Google AI API key ([get one free](https://aistudio.google.com))

### 4. Activate

Toggle on. Runs every 30 min. Done.

---

## What It Finds

Real examples from the wild:

| Tip | Source |
|-----|--------|
| `Esc` twice = instant rollback (checkpoint system) | Reddit |
| Performance craters after ~20 iterations, use `/clear` | HN |
| Opus 4.5 now 67% cheaper | Anthropic |
| Never edit files manually during sessions (breaks cache) | Dev blog |
| Hidden env: `CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1` | Reddit |
| The "slot machine" approach: fresh attempts > corrections | HN |

---

## Output

Tips saved to `knowledge-base.json`:

```json
{
  "quality_score": 9,
  "category": "workflow",
  "insight": "Use Esc twice to instantly rollback via checkpoints",
  "source_url": "https://reddit.com/r/ClaudeAI/...",
  "confidence": "high"
}
```

Query by category: `workflow`, `config`, `cost`, `integration`, `feature`, `tip`

---

## Bonus: Pro Tips Cheatsheet

Check `extras/pro-tips.md` for a curated dump of everything we've mined.

---

## Customize

**Add sources:** Drop in more HTTP Request nodes (Twitter, YouTube, etc.)

**Stricter filter:** Change `quality_score >= 7` to `>= 8` or `>= 9`

**Different schedule:** Edit the trigger (hourly = half the cost)

**Different subreddits:** Swap r/ClaudeAI for r/cursor, r/ChatGPTCoding, etc.

---

## Requirements

- [n8n](https://n8n.io) (self-hosted or cloud)
- API key (Anthropic or Google AI)

---

## Install

```bash
git clone https://github.com/willsigmon/vibecheck.git
cd vibecheck
# Import workflow via n8n UI
```

---

## Why "vibecheck"?

You're vibe coding. This runs a vibe check on the internet for you.

---

## License

MIT. Do whatever.

---

**Star ⭐ if this saves you from doomscrolling Reddit for tips.**
