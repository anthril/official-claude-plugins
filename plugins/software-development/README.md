# Software Development — Anthril Plugin

Three skills for software teams: two deep-audit skills for pre-refactor and pre-launch reviews, and one multi-agent plan orchestrator for Claude Code Plan Mode. The audit skills run in `ultrathink` mode and produce evidence-backed, confidence-scored reports. The orchestrator fans out specialist sub-agents in parallel and compiles their findings into a single ordered plan with full coverage verification.

---

## Skills

| # | Skill | Purpose |
|---|---|---|
| 1 | `dead-code-audit` | Find unused exports, orphaned files, dead dependencies, unreachable branches, abandoned feature flags, and unused CSS — across JS/TS, Python, Go, Rust, Java/Kotlin, PHP, Ruby, and C#. Ships with `knip` and `vulture` integration. |
| 2 | `write-path-mapping` | Map every place data enters the system and is persisted or mutated — HTTP/RPC/CLI/webhook/queue entry points, validation, auth, transactions, cache writes, file uploads, event emissions. Produces four Mermaid diagrams + JSON sidecar. |
| 3 | `plan-orchestrator` | Take a bullet list of tasks/issues/bugs/notes, fan out specialist sub-agents (frontend, backend, database, infrastructure, testing, security, documentation) in parallel against the codebase, verify every bullet is addressed, and compile a single ordered plan. Designed for Plan Mode. |

The two audit skills are interview-driven (Phase 1 is always "locate the target and check the stack") and fail loud when prerequisites are missing — they never fabricate findings. The orchestrator is bullet-driven — it parses your input list, dispatches a dynamic number of agents (one per non-empty domain, capped at 8), and refuses to silently drop any bullet from the final plan.

---

## Installation

### Local development

```bash
claude --plugin-dir ./software-development
```

After Claude Code starts, run `/reload-plugins` to discover the skills.

### Marketplace install

```bash
/plugin install software-development@anthril-claude-plugins
```

---

## Invocation

Skills are namespaced under `software-development`:

```
/software-development:dead-code-audit       ./apps/web
/software-development:write-path-mapping    ./services/orders
/software-development:plan-orchestrator
* Add a sign-out button to the user menu
- Fix the 500 on /api/orders when cart is empty
1. Migrate the orders table to add a `currency` column
```

The audit skills take a target directory as the argument. The orchestrator takes a bullet list pasted on the lines after the slash command — `*`, `-`, and numbered (`1.` / `1)`) bullets are all accepted. An optional `target: <path>` line at the top scopes the run to a sub-tree.

If no target directory is provided to the audit skills, each asks for one before running. The orchestrator defaults to the working directory.

---

## Prerequisites per skill

### `dead-code-audit`

- **JS/TS:** `knip` on PATH (optional but highly recommended — the skill falls back to regex heuristics without it, at lower confidence).
- **Python:** `vulture` on PATH (optional).
- **Any language:** `rg` (ripgrep) strongly recommended for evidence gathering.

The `scripts/check-tools.sh` helper runs at the start of each audit and tells you exactly which tools are missing.

### `write-path-mapping`

- **Database access** (optional but recommended): `supabase` CLI, `psql`, or direct DB URL for live schema + RLS policy probes.
- **Framework detection** is automatic for: Next.js, Express, Fastify, Hono, NestJS, Django, Rails, Laravel, FastAPI, Go net/http, Supabase Edge Functions.
- **ORMs supported:** Prisma, Drizzle, TypeORM, SQLAlchemy, raw SQL.

Works offline with reduced confidence if the database is unreachable.

### `plan-orchestrator`

- **Plan Mode** in Claude Code is the intended runtime. The skill works outside Plan Mode but the final output is then a printed plan rather than the argument to `ExitPlanMode`.
- **`python3`** on `PATH` — every script except `detect-stack.sh` and `stop-hook.sh` is Python 3 (no third-party deps, only stdlib).
- **`bash`** on `PATH` — used for stack detection and the optional Stop hook.
- **MCPs** are inherited from the Claude Code session. Each specialist agent's prompt nudges it toward the MCPs relevant to its domain (Supabase for `database-investigator`, Stripe/Cloudflare/Sentry/Vercel for `backend-` and `infrastructure-investigator`, Figma for `frontend-investigator`, etc.). With no MCPs connected, agents fall back to filesystem-only investigation.
- **No external tools required** beyond `python3` and `bash`. The skill does not invoke `npm`, `pip`, `cargo`, etc., for its own operation — sub-agents may run read-only language tools as part of their investigation, but nothing is required.

---

## Output formats

### `dead-code-audit`

- Markdown report with a confidence-scored findings table
- JSON sidecar following `templates/findings-schema.json`
- Ignore file template (`deadcode-ignore.example`) for known-unused-but-keeping-it exports

### `write-path-mapping`

- Markdown report with an executive summary + per-endpoint deep dives
- Four Mermaid diagrams: system flowchart, per-endpoint sequence, data-domain map, DB trigger graph
- JSON sidecar following `templates/paths-schema.json`
- Risk register following `templates/risk-register-template.md`

### `plan-orchestrator`

- A single consolidated markdown plan, structured per `templates/plan-template.md`:
  - Run header (timestamp, target, task count, coverage %)
  - Task coverage table (every input bullet with 🟢 / 🟡 / 🔴 / ⚪ status)
  - Per-task plan blocks in input order — each with original bullet, contributing agents, evidence, proposed steps, risks, verification
  - Aggregated change set by file (alphabetical, deduplicated)
  - Cross-cutting concerns
  - Suggested execution order (database → infra → security → backend → frontend → testing → documentation)
  - Unresolved items (only present when sweep rounds couldn't address every bullet)
- The plan is emitted to the assistant's response. In Plan Mode it becomes the argument to `ExitPlanMode`. Outside Plan Mode it's printed inline.

All outputs are markdown-first and copy-pasteable into issue trackers, PR descriptions, or architecture docs.

---

## Skill structure

The two audit skills follow the original layout:

```
skills/<skill-name>/
├── SKILL.md                       # Main interview-driven workflow
├── reference.md                   # Framework/tool lookup tables
├── LICENSE.txt                    # Apache 2.0
├── templates/                     # Schemas + output skeletons
│   ├── output-template.md
│   ├── findings-schema.json (or paths-schema.json)
│   └── ...
└── scripts/                       # CLI helpers
    ├── check-tools.sh
    ├── detect-stack.sh
    └── ...
```

The `plan-orchestrator` skill follows the same shape but adds an `examples/` directory and uses plugin-level `agents/` and `hooks/` directories shared across the plugin:

```
plugins/software-development/
├── agents/                        # Plugin-level sub-agent definitions
│   ├── frontend-investigator.md
│   ├── backend-investigator.md
│   ├── database-investigator.md
│   ├── infrastructure-investigator.md
│   ├── testing-investigator.md
│   ├── security-investigator.md
│   ├── documentation-investigator.md
│   └── coverage-sweeper.md
├── hooks/
│   └── hooks.json                 # Stop hook for orphaned-state detection
└── skills/plan-orchestrator/
    ├── SKILL.md                   # 6-phase orchestration workflow
    ├── reference.md               # Domain taxonomy, classifier rules, schemas
    ├── LICENSE.txt
    ├── examples/example-output.md # End-to-end worked example
    ├── scripts/
    │   ├── parse-bullets.py       # $ARGUMENTS → JSON task list
    │   ├── classify-tasks.py      # Heuristic domain tagger + routing
    │   ├── detect-stack.sh        # Stack hints for sub-agent prompts
    │   ├── verify-coverage.py     # Confirms every input bullet was addressed
    │   ├── compile-plan.py        # Merges agent reports into one plan
    │   └── stop-hook.sh           # Advisory orphan-marker detector
    └── templates/
        ├── plan-template.md       # Final plan skeleton (mirrored by compile-plan.py)
        ├── agent-report-template.md  # Per-task block shape every sub-agent fills in
        ├── tasks-schema.json
        └── plan-schema.json
```

`SKILL.md` files are kept under 500 lines. Dense reference material lives in `reference.md`. Sub-agent definitions are plugin-level (under `agents/`) so they could be reused by future skills without duplication.

---

## What these skills will NOT do

- **Auto-fix anything.** All three skills are read-only. They produce reports and plans; humans apply the fixes.
- **Delete or modify code.** No `rm -rf`, no edits to the target. Findings come with file paths and line numbers; you apply the changes yourself.
- **Run destructive commands.** No `git commit`, no `git push`, no DDL, no DB writes, no deploys. Sub-agents in `plan-orchestrator` are explicitly constrained to read-only tool use.
- **Make framework-agnostic assumptions.** If a skill can't detect the stack reliably, it says so and asks (audits) or adds `low confidence` to the affected task (orchestrator).
- **Fabricate findings.** Every finding includes evidence — file path, line number, tool output, or MCP query result. If the skill can't verify it, it reports low confidence rather than guessing. The orchestrator's coverage verifier catches sub-agents that invent task IDs not in the input list.
- **Silently drop anything.** The orchestrator's Phase 4 enforces that every input bullet is addressed in the final plan — gaps surface as `UNRESOLVED — investigate manually`, never as omissions.

---

## Conventions

- **Australian English** in narrative
- **Markdown-first** outputs
- **Evidence-backed findings** with file:line references

---

## License

MIT — see `.claude-plugin/plugin.json`. Per-skill `LICENSE.txt` files are Apache 2.0 boilerplate.

---

## Author

[Anthril](https://github.com/anthril) — `john@anthril.com`
