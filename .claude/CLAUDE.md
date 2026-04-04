# AI Cookbook — Project Instructions

## Overview

This repository is a curated library of Claude Code skills for data analysis, entity modelling, and business operations. It is packaged as a **Claude Code plugin** and distributed via its own marketplace.

## Skill Development Standards

### Required Frontmatter (YAML)

Every `SKILL.md` must begin with YAML frontmatter:

```yaml
---
name: kebab-case-name
description: Concise trigger description (max 250 chars). Front-load the key use case.
argument-hint: [what-the-user-should-provide]
allowed-tools: Read Grep Glob Write Edit Bash Agent
---
```

**Required fields:** `name`, `description`
**Recommended fields:** `argument-hint`, `allowed-tools`
**Optional fields:** `context`, `agent`, `model`, `effort`, `disable-model-invocation`, `user-invocable`, `paths`, `shell`, `hooks`

### Skill Structure Template

```markdown
---
name: my-skill
description: What this skill does and when to use it
argument-hint: [input-description]
allowed-tools: Read Grep Glob Write Edit Bash Agent
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
5. **Front-load the description** — it is truncated to 250 characters in skill listings.
6. **Australian market context** — where business/market skills reference geography, calibrate for Australian markets unless the user specifies otherwise.

### File Layout Per Skill

```
skills/<skill-name>/
├── SKILL.md              # Main skill instructions (required, under 500 lines)
├── reference.md          # Detailed reference material (if SKILL.md would exceed 400 lines)
├── LICENSE.txt           # MIT license
├── templates/
│   └── output-template.md    # Output format template
├── examples/
│   └── example-output.md     # Sample completed output
└── scripts/
    └── helper.py             # Utility script (where relevant)
```

### Adding a New Skill

1. Create directory: `skills/<kebab-case-name>/`
2. Create `SKILL.md` with required frontmatter
3. Add `$ARGUMENTS` for user input
4. Add `ultrathink` if the skill requires deep analysis
5. Set `context: fork` and `agent: Explore` if it needs research capabilities
6. Create `templates/output-template.md` with the expected output structure
7. Create `examples/example-output.md` with a realistic sample
8. Add `scripts/` with helper utilities if applicable
9. Add `LICENSE.txt` (copy from existing skill)
10. Test locally: `claude --plugin-dir .` then invoke with `/ai-cookbook:skill-name`

### Naming Conventions

- **Directories**: `kebab-case` (e.g., `knowledge-graph-builder`)
- **SKILL.md**: Always uppercase `SKILL.md`
- **Templates**: Descriptive kebab-case (e.g., `output-template.md`)
- **Scripts**: Descriptive kebab-case (e.g., `profile-dataset.py`)

## Plugin Packaging

- Plugin manifest: `.claude-plugin/plugin.json`
- Marketplace catalog: `.claude-plugin/marketplace.json`
- Skills go in `skills/` at the repository root (NOT inside `.claude-plugin/`)
- Version follows semantic versioning (MAJOR.MINOR.PATCH)
- Bump version in both `plugin.json` and `marketplace.json` on release

## Testing

```bash
# Test locally
claude --plugin-dir .

# Validate plugin structure
claude plugin validate .

# List available skills
/skills

# Test a skill
/ai-cookbook:skill-name [arguments]
```

## Quality Checklist

Before merging any skill changes:

- [ ] SKILL.md has valid YAML frontmatter with `name` and `description`
- [ ] SKILL.md is under 500 lines
- [ ] Uses `$ARGUMENTS` for user input
- [ ] Description is under 250 characters and front-loads the key use case
- [ ] `templates/` directory has at least one output template
- [ ] `examples/` directory has at least one example output
- [ ] Dense reference material is in `reference.md`, not SKILL.md
- [ ] Tested locally with `claude --plugin-dir .`
