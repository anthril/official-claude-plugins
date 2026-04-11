# Software Development — Solantic AI Plugin

Two deep-audit skills for pre-refactor and pre-launch reviews of real-world codebases. Both skills run in `ultrathink` mode and produce evidence-backed, confidence-scored reports that a senior engineer can act on.

---

## Skills

| # | Skill | Purpose |
|---|---|---|
| 1 | `dead-code-audit` | Find unused exports, orphaned files, dead dependencies, unreachable branches, abandoned feature flags, and unused CSS — across JS/TS, Python, Go, Rust, Java/Kotlin, PHP, Ruby, and C#. Ships with `knip` and `vulture` integration. |
| 2 | `write-path-mapping` | Map every place data enters the system and is persisted or mutated — HTTP/RPC/CLI/webhook/queue entry points, validation, auth, transactions, cache writes, file uploads, event emissions. Produces four Mermaid diagrams + JSON sidecar. |

Both skills are interview-driven (Phase 1 is always "locate the target and check the stack") and fail loud when prerequisites are missing — they never fabricate findings.

---

## Installation

### Local development

```bash
claude --plugin-dir ./software-development
```

After Claude Code starts, run `/reload-plugins` to discover the skills.

### Marketplace install

```bash
claude plugin install software-development@solanticai-official-claude-plugins
```

---

## Invocation

Skills are namespaced under `software-development`:

```
/software-development:dead-code-audit       ./apps/web
/software-development:write-path-mapping    ./services/orders
```

If no target directory is provided, each skill asks for one before running.

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

All outputs are markdown-first and copy-pasteable into issue trackers, PR descriptions, or architecture docs.

---

## Skill structure

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

`SKILL.md` files are kept under 500 lines. Dense reference material lives in `reference.md`.

---

## What these skills will NOT do

- **Auto-fix anything.** Both skills are read-only analysers. They produce reports; humans apply the fixes.
- **Delete code.** No `rm -rf`, no edits to the target. Findings come with file paths and line numbers; you apply the changes yourself.
- **Make framework-agnostic assumptions.** If the skill can't detect the stack reliably, it says so and asks.
- **Fabricate findings.** Every finding includes a confidence score and the evidence that produced it. If the skill can't verify it, it reports "low confidence" rather than guessing.

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

[Solantic AI](https://github.com/solanticai) — `john@solanticai.com`
