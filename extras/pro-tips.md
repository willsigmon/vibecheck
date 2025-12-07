# Claude Code Pro Tips (Community-Mined)

> Extracted from Reddit, Hacker News, Dev blogs, and Anthropic docs.
> Last updated: 2025-12-06

---

## 🔄 The Golden Workflow (ALWAYS FOLLOW)

```
1. EXPLORE → Use Explore subagent first (never grep/find directly)
2. PLAN → "ultrathink. Analyze and propose a plan. Don't code."
3. CODE → Implement based on confirmed plan
4. VERIFY → Run tests, check diffs
5. COMMIT → Ask Claude to commit and create PR
```

**Critical**: Steps 1-2 prevent 80% of bad code. Skipping = lower quality.

---

## 🎯 Thinking Modes - Token Budget Triggers

| Phrase | Tokens | Use Case |
|--------|--------|----------|
| `think` | 4,000 | Quick analysis |
| `think hard` | 10,000 | Medium complexity |
| `megathink` | 10,000 | Architecture questions |
| `ultrathink` | 31,999 | Complex bugs, stuck loops, major refactors |

---

## ⏪ Checkpoint System (Claude Code 2.0)

- **`Esc` twice** → Instant rollback to any previous state
- **`/rewind`** → Restore code, conversation, or both
- **Be bold** → Checkpoints have your back for ambitious refactors

---

## ⚡ Context Management (CRITICAL)

**The 20-iteration rule**: Performance craters after ~20 messages. Use `/clear` aggressively.

| Command | Purpose |
|---------|---------|
| `/clear` | Fresh context - do this MORE, not less |
| `/context` | See remaining context window |
| `/cost` | Track session spending |
| `/catchup` | Read files changed in current branch |
| `/fork` | Branch conversation for alternatives |
| `/doctor` | Diagnostics for troubleshooting |

**Cache Optimization**:
- NEVER manually edit files during sessions (breaks prompt caching)
- Disable format-on-save/linting during Claude sessions
- Cache expires after 5-15 min inactivity
- Avoid `/compact` - invalidates cache

---

## 🚀 Subagent Patterns

**When to spawn**: Complex task = spawn 5-20+ agents in PARALLEL

| Task Type | Pattern |
|-----------|---------|
| Code review | 3 agents: security, performance, style |
| Feature build | 5-10 agents: UI, logic, tests, docs |
| Large refactor | 1 agent per file needing updates |
| Research | "use 5 subagents to analyze each module" |

**Invoke**: "complete this task using multiple subagents in parallel"

---

## 🎹 Power User Shortcuts

| Key | Action |
|-----|--------|
| `Shift+Tab x2` | Toggle Plan Mode (read-only research) |
| `#` | Add instruction to CLAUDE.md |
| `Esc` | Stop current operation |
| `Esc x2` | View history, jump back, fork |
| `Ctrl+r` | Searchable prompt history |
| `Ctrl+G` | Edit prompt in external text editor |
| `Tab x2` | Autocomplete + see all options |

---

## 💰 Cost & Model Strategy

```bash
npx ccusage daily          # Daily costs
npx ccusage monthly        # Monthly rollup
npx ccusage blocks --live  # Real-time dashboard
```

**Model selection** (Updated - Opus 4.5 now 67% cheaper!):
- **Sonnet 4.5**: Default for most work ($3/$15 per 1M tokens)
- **Opus 4.5**: Complex architecture, ultrathink ($5/$25)
- **Haiku 3.5**: Quick iterations, simple tasks ($0.25/$1.25)

---

## 📁 File Organization

- **CLAUDE.md** → Project root (committed to git)
- **CLAUDE.local.md** → Personal overrides (gitignored)
- **~/.claude/CLAUDE.md** → Global instructions
- **.claudeignore** → Exclude dirs like node_modules, dist, build

---

## 🪝 Hook Patterns (Automation)

**Intentional slowdown** (prevents token burn):
```json
{"hooks": {"PreToolUse": [{"matcher": "Write|Edit", "command": "sleep 30"}]}}
```

**Test-gating commits**:
```json
{"hooks": {"PreToolUse": [{"matcher": "Bash(git commit)", "command": "./check_tests_pass.sh"}]}}
```

---

## 🔧 Hidden Environment Variables

```bash
CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1  # Reset to project dir after commands
CLAUDE_ENV_FILE=/path/to/env.sh             # Source before each bash command
CLAUDE_DEBUG=true                            # Enable debug mode
ENABLE_BACKGROUND_TASKS=true                 # Background agent support
FORCE_AUTO_BACKGROUND_TASKS=true             # Auto-background long tasks
```

---

## ⚠️ Known Limitations

- **4,000-5,000 line wall**: Code quality degrades at this size
- **The 80/20 problem**: 80% functionality is easy, remaining 20% takes 10x longer
- **Non-determinism**: Same prompt ≠ same output (always validate)
- **Outdated knowledge**: Claude reverts to ~2021 patterns with newer packages
- **LLM lies to save face**: Claims "complete!" with TODO bodies

---

## 🎰 The "Slot Machine" Approach (from Anthropic)

1. Save state before letting Claude work
2. Let it run for 30 min
3. Either accept OR start fresh (don't wrestle with corrections)

**Why**: Claude achieves 70-80% completion. Fresh attempts often beat corrections.

---

## 🔄 The Flywheel Effect

```
Bugs → Fix → Update CLAUDE.md → Better Agent → Fewer Bugs
```

Press `#` to add rules organically. Every mistake becomes prevention.

---

## 🆕 Claude Code 2.0 Features

- **Background Agents**: Run while you work
- **Plugin System**: `/plugin install`, `/plugin marketplace`
- **Skills Support**: Structured "prompt plugins" for reusable patterns
- **Sandboxing**: 84% fewer permission prompts
- **Security Review**: `/security-review` before commits

---

*Mined by [Claude Intelligence Miner](https://github.com/YOUR_USERNAME/claude-intelligence-miner)*
