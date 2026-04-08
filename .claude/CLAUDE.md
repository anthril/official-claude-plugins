# Solantic AI Official Claude Plugins — Project Instructions

## Overview

This repository is a curated library of Claude Code plugins for data analysis, entity modelling, business operations, and developer tooling. It is packaged as a **Claude Code marketplace** with 6 standalone plugins distributed via the `solanticai-official-claude-plugins` marketplace.

## Skill Development Standards

### Required Frontmatter (YAML)

Every `SKILL.md` must begin with YAML frontmatter:

```yaml
---
name: kebab-case-name
description: Concise trigger description (max 250 chars). Front-load the key use case.
argument-hint: [what-the-user-should-provide]
allowed-tools: Read Grep Glob Write Edit Bash Agent
effort: high
---
```

### Complete Frontmatter Field Reference

| Field | Required | Description |
|-------|----------|-------------|
| `name` | No | Display name. Lowercase letters, numbers, hyphens only (max 64 chars). Defaults to directory name. |
| `description` | Recommended | What the skill does and when to use it. Front-load the key use case. Truncated to 250 chars in listings. |
| `argument-hint` | No | Hint shown during autocomplete (e.g., `[issue-number]`, `[filename] [format]`). |
| `disable-model-invocation` | No | Set `true` to prevent Claude from auto-loading. Default: `false`. |
| `user-invocable` | No | Set `false` to hide from `/` menu. Default: `true`. |
| `allowed-tools` | No | Tools Claude can use without asking permission. Space-separated string or YAML list. |
| `model` | No | Model override for this skill. |
| `effort` | No | Effort level: `low`, `medium`, `high`, `max` (Opus 4.6 only). Inherits from session if unset. |
| `context` | No | Set `fork` to run in a forked subagent context. |
| `agent` | No | Subagent type when `context: fork` is set (e.g., `Explore`). |
| `hooks` | No | Hooks scoped to this skill's lifecycle. |
| `paths` | No | Glob patterns for auto-activation (e.g., `"**/*.sql, **/migrations/**"`). |
| `shell` | No | Shell for inline commands: `bash` (default) or `powershell`. |

**Required fields:** `name`, `description`
**Recommended fields:** `argument-hint`, `allowed-tools`, `effort`
**Optional fields:** `context`, `agent`, `model`, `disable-model-invocation`, `user-invocable`, `paths`, `shell`, `hooks`

### Effort Level Guidelines

| Effort | When to use |
|--------|-------------|
| `medium` | Generative/scaffolding skills (skill-creator) |
| `high` | Analytical skills requiring deep reasoning (most skills) |
| `max` | Research-heavy skills with `context: fork` (anomaly-detection, data-pipeline, market-sizing) |

### Skill Structure Template

```markdown
---
name: my-skill
description: What this skill does and when to use it
argument-hint: [input-description]
allowed-tools: Read Grep Glob Write Edit Bash Agent
effort: high
---

# Skill Title

ultrathink

## Context from User

$ARGUMENTS

## System Prompt

You are a [role] specialising in [domain]...

## Phase 1: [Name]
...

## Output Format
...

## Behavioural Rules
...

## Edge Cases
...
```

### Key Rules

1. **SKILL.md must be under 500 lines.** Extract detailed reference material (SQL templates, lookup tables, scoring rubrics) into `reference.md`.
2. **Always use `$ARGUMENTS`** to accept user input. Never rely solely on interactive collection.
3. **Include `ultrathink`** in skills that require deep analytical thinking (complex analysis, architecture design, financial modelling).
4. **Use `context: fork`** for research-heavy skills that benefit from running in an isolated subagent.
5. **Set `effort` explicitly** — `high` for analytical skills, `max` for fork-context research skills, `medium` for scaffolding.
6. **Use `paths`** when a skill should auto-activate on specific file patterns.
7. **Front-load the description** — it is truncated to 250 characters in skill listings.
8. **Australian market context** — where business/market skills reference geography, calibrate for Australian markets unless the user specifies otherwise.

### Plugin Organisation

Skills are organised into 6 standalone plugins:

| Plugin | Directory | Focus |
|--------|-----------|-------|
| Data Analysis | `plugins/data-analysis/` | Data analysis, profiling, pipelines, anomaly detection |
| Knowledge Engineering | `plugins/knowledge-engineering/` | Entity modelling, knowledge graphs, data models |
| Business Economics | `plugins/business-economics/` | Unit economics, market sizing |
| npm Package Audit | `plugins/npm-package-audit/` | npm package publishing quality |
| Plan Completion Audit | `plugins/plan-completion-audit/` | Full-stack plan vs implementation audit |
| Skill Creator | `plugins/skill-creator/` | Claude Code skill scaffolding |

### File Layout Per Plugin

```
plugins/<plugin-name>/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest (name, version, author, keywords)
├── skills/
│   └── <skill-name>/
│       ├── SKILL.md              # Main skill instructions (required, under 500 lines)
│       ├── reference.md          # Detailed reference material (if SKILL.md would exceed 400 lines)
│       ├── LICENSE.txt           # MIT license
│       ├── templates/
│       │   └── output-template.md    # Output format template
│       ├── examples/
│       │   └── example-output.md     # Sample completed output
│       └── scripts/
│           └── helper.py             # Utility script (where relevant)
├── hooks/
│   ├── hooks.json                # Plugin hooks configuration
│   └── scripts/                  # Hook implementation scripts
└── settings.json                 # Plugin settings
```

### Adding a New Plugin

1. Create plugin directory: `plugins/<kebab-case-name>/`
2. Create `.claude-plugin/plugin.json` with `name`, `version`, `description`, `author`, `repository`, `homepage`, `license`, `keywords`
3. Ensure `name` in plugin.json matches the corresponding marketplace.json entry name exactly
4. Add the plugin entry to `.claude-plugin/marketplace.json`
5. Create `hooks/hooks.json` and `settings.json`
6. Follow the skill steps below to add skills

### Adding a New Skill

1. Identify the target plugin directory: `plugins/<plugin-name>/`
2. Create skill directory: `plugins/<plugin-name>/skills/<kebab-case-name>/`
3. Create `SKILL.md` with required frontmatter (including `effort`)
4. Add `$ARGUMENTS` for user input
5. Add `ultrathink` if the skill requires deep analysis
6. Set `context: fork` and `agent: Explore` if it needs research capabilities
7. Set `paths` if the skill should auto-activate on file patterns
8. Create `templates/output-template.md` with the expected output structure
9. Create `examples/example-output.md` with a realistic sample
10. Add `scripts/` with helper utilities if applicable
11. Add `LICENSE.txt` (copy from existing skill)
12. Test locally: `claude --plugin-dir .` then invoke with `/<skill-name>`

### Naming Conventions

- **Directories**: `kebab-case` (e.g., `knowledge-graph-builder`)
- **SKILL.md**: Always uppercase `SKILL.md`
- **Templates**: Descriptive kebab-case (e.g., `output-template.md`)
- **Scripts**: Descriptive kebab-case (e.g., `profile-dataset.py`)

## Plugin Packaging

- Plugin manifest: `.claude-plugin/plugin.json`
- Marketplace catalog: `.claude-plugin/marketplace.json`
- Skills go in `plugins/<plugin-name>/skills/` (NOT inside `.claude-plugin/`)
- Version follows semantic versioning (MAJOR.MINOR.PATCH)
- Bump version in both `plugin.json` and `marketplace.json` on release

## Testing

```bash
# Test full marketplace locally
claude --plugin-dir .

# Test a single plugin
claude --plugin-dir ./plugins/data-analysis

# Validate plugin structure
claude plugin validate .

# List available skills
/skills

# Test a skill
/<skill-name> [arguments]
```

## Quality Checklist

Before merging any skill changes:

- [ ] SKILL.md has valid YAML frontmatter with `name`, `description`, and `effort`
- [ ] SKILL.md is under 500 lines
- [ ] Uses `$ARGUMENTS` for user input
- [ ] Description is under 250 characters and front-loads the key use case
- [ ] `effort` is set appropriately (`medium`, `high`, or `max`)
- [ ] `paths` is set if skill should auto-activate on file patterns
- [ ] `allowed-tools` uses space-separated format (not comma-separated)
- [ ] `templates/` directory has at least one output template
- [ ] `examples/` directory has at least one example output
- [ ] Dense reference material is in `reference.md`, not SKILL.md
- [ ] Tested locally with `claude --plugin-dir .`
