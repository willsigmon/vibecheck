# vibecheck ✓

> Auto-mine agentic coding tips while you sleep.

You're vibe coding. Reddit, HN, and dev Twitter are dropping tips daily. You're missing 90% of it.

**vibecheck** scrapes human forums every 30 min, filters noise with AI, and builds a knowledge base of what actually works.

---

## One-Line Install

### macOS / Linux
```bash
curl -fsSL https://raw.githubusercontent.com/willsigmon/vibecheck/main/extras/quick-setup.sh | bash
```

### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/willsigmon/vibecheck/main/extras/quick-setup.ps1 | iex
```

### Universal (Python - works everywhere)
```bash
python3 -c "import urllib.request; exec(urllib.request.urlopen('https://raw.githubusercontent.com/willsigmon/vibecheck/main/extras/quick-setup.py').read())"
```

---

## For Coders Who Use

| Tool | Workflow | AI Cost |
|------|----------|---------|
| **Claude Code** | `vibecheck-claude.json` | ~$7/mo |
| **Gemini CLI** | `vibecheck-gemini.json` | Free* |
| **ChatGPT / OpenAI** | `vibecheck-openai.json` | ~$3/mo |
| **Cursor / Windsurf** | `vibecheck-cursor.json` | ~$3/mo |
| **GitHub Copilot** | `vibecheck-copilot.json` | ~$3/mo |

*Gemini free tier: 1,500 req/day. This uses ~48/day.

---

## How It Works

```
Every 30 min:
  Reddit (tool-specific subs) ──┐
  Hacker News ──────────────────┼──> Filter ──> AI Analysis ──> Dedupe ──> Save
  Dev.to ───────────────────────┘
```

1. Scrapes Reddit, HN, Dev.to for agentic coding discussion
2. Filters by engagement (kills low-quality noise)
3. AI analyzes for **actionable** insights only
4. Rejects bots, spam, outdated info, complaints without solutions
5. Dedupes against your existing KB
6. Saves high-quality tips to JSON

---

## Manual Setup

### 1. Get n8n Running

```bash
# Docker (any OS)
docker run -d --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n n8nio/n8n

# macOS
brew install n8n && n8n start

# Linux/Windows
npm install -g n8n && n8n start
```

### 2. Import Workflow

Open n8n (`http://localhost:5678`) → Workflows → Import → Pick your JSON

### 3. Add Credentials

- **Claude:** Anthropic API key
- **Gemini:** Google AI API key ([get one free](https://aistudio.google.com))
- **OpenAI:** OpenAI API key

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

Categories: `workflow`, `config`, `cost`, `shortcut`, `prompt`, `feature`, `tip`

---

## Bonus: Pro Tips Cheatsheet

Check `extras/pro-tips.md` for a curated dump of everything we've mined.

---

## Customize

**Add sources:** Drop in more HTTP Request nodes (Twitter, YouTube, etc.)

**Stricter filter:** Change `quality_score >= 7` to `>= 8` or `>= 9`

**Different schedule:** Edit the trigger (hourly = half the cost)

**Different subreddits:** Swap for r/cursor, r/ChatGPTCoding, etc.

---

## Requirements

- [n8n](https://n8n.io) (self-hosted or cloud)
- API key (Anthropic, Google AI, or OpenAI)

---

## Why "vibecheck"?

You're vibe coding. This runs a vibe check on the internet for you.

---

## License

MIT. Do whatever.

---

**Star ⭐ if this saves you from doomscrolling Reddit for tips.**
