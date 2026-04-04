# AI Cookbook

A curated library of Claude Code skills for data analysis, entity modelling, and business operations — packaged as a Claude Code plugin.

Maintained by [@solanticai](https://github.com/solanticai).

## Quick Start

### Install as Plugin (all skills)

```bash
# Add the marketplace
/plugin marketplace add solanticai/ai-cookbook

# Install the plugin
/plugin install ai-cookbook@ai-cookbook
```

### Install a Single Skill

```bash
# Copy one skill to your personal skills directory
cp -r skills/knowledge-graph-builder ~/.claude/skills/
```

### Test Locally

```bash
# Load the full plugin for development
claude --plugin-dir .

# List available skills
/skills

# Run a skill
/ai-cookbook:knowledge-graph-builder Build a knowledge graph for a consulting firm
```

## Skills

13 production-ready skills across four categories:

### Data Analysis & Intelligence

| Skill | Description |
|-------|-------------|
| [`anomaly-detection-rule-builder`](skills/anomaly-detection-rule-builder/) | Build rule-based and statistical anomaly detection systems for business metrics — revenue drops, traffic spikes, churn increases, cost overruns |
| [`cohort-analysis-builder`](skills/cohort-analysis-builder/) | Design cohort analysis frameworks with SQL queries, visualisation specs, and interpretation guides for retention, revenue, and churn analysis |
| [`data-pipeline-architecture`](skills/data-pipeline-architecture/) | Design ETL/ELT pipeline architectures with data flow diagrams, transformation specs, orchestration, and error handling for Supabase and BigQuery |
| [`data-dictionary-generator`](skills/data-dictionary-generator/) | Auto-generate comprehensive data dictionaries from database schemas, CSV files, or API responses with column definitions and Mermaid ERD |
| [`dataset-profiling-quality-audit`](skills/dataset-profiling-quality-audit/) | Profile datasets and audit data quality — assess completeness, validity, consistency, uniqueness, timeliness, and accuracy |

### Structured Data & Entity Modelling

| Skill | Description |
|-------|-------------|
| [`entity-disambiguation`](skills/entity-disambiguation/) | Resolve entity ambiguity across data sources — produce canonical records, merge decisions, and sameAs link mappings |
| [`entity-relationship-mapper`](skills/entity-relationship-mapper/) | Map business domains to entity-relationship models with Schema.org types, JSON-LD @graph output, and sameAs connections |
| [`knowledge-graph-builder`](skills/knowledge-graph-builder/) | Construct knowledge graph specifications for Neo4j, JSON-LD, or Supabase/PostgreSQL JSONB implementation |

### Business Operations & Revenue

| Skill | Description |
|-------|-------------|
| [`unit-economics-calculator`](skills/unit-economics-calculator/) | Calculate CAC, LTV, payback period, contribution margin with scenario analysis for service, SaaS, and hybrid businesses |
| [`market-sizing-tam-estimator`](skills/market-sizing-tam-estimator/) | Estimate TAM, SAM, and SOM using top-down and bottom-up methods with sensitivity analysis, calibrated for Australian markets |

### Cross-Cutting

| Skill | Description |
|-------|-------------|
| [`business-data-model-designer`](skills/business-data-model-designer/) | Design complete Supabase/PostgreSQL data models with ERD, SQL migrations, RLS policies, indexes, and triggers |
| [`project-audit`](skills/project-audit/) | Comprehensive multi-phase project audit covering task completion, code quality, bugs, security, performance, and build verification |
| [`skill-creator`](skills/skill-creator/) | Create new Claude Code skills with proper frontmatter, directory structure, templates, examples, and supporting files |

## Skill Features

Every skill in this library includes:

- **YAML frontmatter** — `name`, `description`, `argument-hint`, `allowed-tools`
- **`$ARGUMENTS`** — Accept user input directly (e.g., `/ai-cookbook:skill-name my business description`)
- **`ultrathink`** — Extended thinking enabled for complex analytical skills
- **Output templates** — Structured output format with section headers
- **Example outputs** — Realistic completed examples with Australian business context
- **Utility scripts** — Python/Bash helpers for common operations

Select skills also include:

- **`context: fork`** — Research-heavy skills run in isolated subagent context
- **`reference.md`** — Dense reference material (SQL templates, scoring rubrics, lookup tables) extracted to keep SKILL.md under 500 lines
- **Dynamic context injection** — Shell commands that inject project state before the skill runs

## Skill Directory Structure

Each skill follows a consistent layout:

```
skills/<skill-name>/
├── skill.md              # Main skill instructions (under 500 lines)
├── reference.md          # Detailed reference material (where needed)
├── LICENSE.txt           # MIT license
├── templates/
│   └── output-template.md    # Output format skeleton
├── examples/
│   └── example-output.md     # Realistic completed example
└── scripts/
    └── helper.py             # Utility script (where relevant)
```

## Repository Structure

```
ai-cookbook/
├── .claude/
│   └── CLAUDE.md                 # Project instructions for contributors
├── .claude-plugin/
│   ├── plugin.json               # Plugin manifest (v1.0.0)
│   └── marketplace.json          # Marketplace catalog
├── hooks/
│   ├── hooks.json                # Plugin hooks configuration
│   └── scripts/                  # Hook scripts
├── skills/                       # All 13 skills
│   ├── anomaly-detection-rule-builder/
│   ├── business-data-model-designer/
│   ├── cohort-analysis-builder/
│   ├── data-dictionary-generator/
│   ├── data-pipeline-architecture/
│   ├── dataset-profiling-quality-audit/
│   ├── entity-disambiguation/
│   ├── entity-relationship-mapper/
│   ├── knowledge-graph-builder/
│   ├── market-sizing-tam-estimator/
│   ├── project-audit/
│   ├── skill-creator/
│   └── unit-economics-calculator/
├── settings.json                 # Plugin settings
├── LICENSE                       # MIT
└── README.md
```

## Creating New Skills

Use the built-in skill creator:

```bash
/ai-cookbook:skill-creator customer-churn-predictor — predict churn risk from behavioural signals
```

Or follow the conventions in [`.claude/CLAUDE.md`](.claude/CLAUDE.md) to create skills manually.

### Skill Development Checklist

- [ ] SKILL.md has valid YAML frontmatter with `name` and `description`
- [ ] SKILL.md is under 500 lines
- [ ] Uses `$ARGUMENTS` for user input
- [ ] Description is under 250 characters, front-loaded with key use case
- [ ] `templates/` directory has at least one output template
- [ ] `examples/` directory has at least one example output
- [ ] Dense reference material is in `reference.md`, not SKILL.md
- [ ] Tested locally with `claude --plugin-dir .`

## Contributing

1. Fork the repository
2. Create a new skill using `/ai-cookbook:skill-creator`
3. Test locally with `claude --plugin-dir .`
4. Submit a pull request

See [`.claude/CLAUDE.md`](.claude/CLAUDE.md) for detailed development standards.

## Sponsors

This project is maintained by [Solantic AI](https://github.com/solanticai) and funded by our sponsors.

[Become a sponsor](https://github.com/sponsors/solanticai)

### Featured Sponsors

<!-- readme-sponsors-featured --><!-- readme-sponsors-featured -->

### All Sponsors

<!-- readme-sponsors-all --><!-- readme-sponsors-all -->

## License

MIT
