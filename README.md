# Anthril Official Claude Plugins

A curated library of Claude Code plugins for data analysis, entity modelling, business operations, and developer tooling — packaged as a Claude Code marketplace with standalone plugins.

Maintained by [@Anthril](https://github.com/anthril).

## Quick Start

### Install as Plugin

```bash
# Add the marketplace
/plugin marketplace add anthril/official-claude-plugins

# Install individual plugins
/plugin install data-analysis@anthril-claude-plugins
/plugin install knowledge-engineering@anthril-claude-plugins
/plugin install business-economics@anthril-claude-plugins
/plugin install npm-package-audit@anthril-claude-plugins
/plugin install plan-completion-audit@anthril-claude-plugins
/plugin install skill-creator@anthril-claude-plugins
/plugin install brand-manager@anthril-claude-plugins
/plugin install software-development@anthril-claude-plugins
```

### Install a Single Skill

```bash
# Copy one skill to your personal skills directory
cp -r plugins/data-analysis/skills/knowledge-graph-builder ~/.claude/skills/
```

### Test Locally

```bash
# Load the full marketplace for development
claude --plugin-dir .

# Load a single plugin
claude --plugin-dir ./plugins/data-analysis

# List available skills
/skills

# Run a skill
/knowledge-graph-builder Build a knowledge graph for a consulting firm
```

## Plugins

25 production-ready skills across eight standalone plugins:

### Data Analysis & Intelligence (`data-analysis`)

| Skill | Description |
|-------|-------------|
| [`anomaly-detection-rule-builder`](plugins/data-analysis/skills/anomaly-detection-rule-builder/) | Build rule-based and statistical anomaly detection systems for business metrics — revenue drops, traffic spikes, churn increases, cost overruns |
| [`cohort-analysis-builder`](plugins/data-analysis/skills/cohort-analysis-builder/) | Design cohort analysis frameworks with SQL queries, visualisation specs, and interpretation guides for retention, revenue, and churn analysis |
| [`data-pipeline-architecture`](plugins/data-analysis/skills/data-pipeline-architecture/) | Design ETL/ELT pipeline architectures with data flow diagrams, transformation specs, orchestration, and error handling for Supabase and BigQuery |
| [`data-dictionary-generator`](plugins/data-analysis/skills/data-dictionary-generator/) | Auto-generate comprehensive data dictionaries from database schemas, CSV files, or API responses with column definitions and Mermaid ERD |
| [`dataset-profiling-quality-audit`](plugins/data-analysis/skills/dataset-profiling-quality-audit/) | Profile datasets and audit data quality — assess completeness, validity, consistency, uniqueness, timeliness, and accuracy |

### Knowledge Engineering (`knowledge-engineering`)

| Skill | Description |
|-------|-------------|
| [`business-data-model-designer`](plugins/knowledge-engineering/skills/business-data-model-designer/) | Design complete Supabase/PostgreSQL data models with ERD, SQL migrations, RLS policies, indexes, and triggers |
| [`entity-disambiguation`](plugins/knowledge-engineering/skills/entity-disambiguation/) | Resolve entity ambiguity across data sources — produce canonical records, merge decisions, and sameAs link mappings |
| [`entity-relationship-mapper`](plugins/knowledge-engineering/skills/entity-relationship-mapper/) | Map business domains to entity-relationship models with Schema.org types, JSON-LD @graph output, and sameAs connections |
| [`knowledge-graph-builder`](plugins/knowledge-engineering/skills/knowledge-graph-builder/) | Construct knowledge graph specifications for Neo4j, JSON-LD, or Supabase/PostgreSQL JSONB implementation |

### Business Economics (`business-economics`)

| Skill | Description |
|-------|-------------|
| [`unit-economics-calculator`](plugins/business-economics/skills/unit-economics-calculator/) | Calculate CAC, LTV, payback period, contribution margin with scenario analysis for service, SaaS, and hybrid businesses |
| [`market-sizing-tam-estimator`](plugins/business-economics/skills/market-sizing-tam-estimator/) | Estimate TAM, SAM, and SOM using top-down and bottom-up methods with sensitivity analysis, calibrated for Australian markets |

### npm Package Audit (`npm-package-audit`)

| Skill | Description |
|-------|-------------|
| [`npm-package-audit`](plugins/npm-package-audit/skills/npm-package-audit/) | Audit npm packages for publishing quality, cross-OS compatibility, type declarations, build config, security, and CI/CD — produces a scored report with actionable fixes |

### Plan Completion Audit (`plan-completion-audit`)

| Skill | Description |
|-------|-------------|
| [`plan-completion-audit`](plugins/plan-completion-audit/skills/plan-completion-audit/) | Full-stack audit of a project plan versus actual implementation — verifies plan vs code, types, bugs, security, Supabase schema, RLS, and frontend-backend alignment |

### Skill Creator (`skill-creator`)

| Skill | Description |
|-------|-------------|
| [`skill-creator`](plugins/skill-creator/skills/skill-creator/) | Create new Claude Code skills with proper frontmatter, directory structure, templates, examples, and supporting files |

### Brand Manager (`brand-manager`)

| Skill | Description |
|-------|-------------|
| [`brand-identity`](plugins/brand-manager/skills/brand-identity/) | Define brand purpose, values, personality, voice, and positioning statement |
| [`brand-guidelines`](plugins/brand-manager/skills/brand-guidelines/) | Create comprehensive brand guidelines covering typography, colour, imagery, and tone of voice |
| [`audience-personas`](plugins/brand-manager/skills/audience-personas/) | Build detailed audience personas with demographics, psychographics, and journey maps |
| [`competitor-analysis`](plugins/brand-manager/skills/competitor-analysis/) | Analyse competitors across positioning, messaging, visual identity, and market gaps |
| [`logo-brief`](plugins/brand-manager/skills/logo-brief/) | Write a logo design brief with concept direction, usage rules, and file format specs |
| [`colour-palette`](plugins/brand-manager/skills/colour-palette/) | Design a brand colour palette with primary, secondary, accent, and semantic colours |
| [`design-tokens`](plugins/brand-manager/skills/design-tokens/) | Generate design tokens for typography, colour, spacing, and elevation in JSON/CSS format |
| [`legal-disclaimers`](plugins/brand-manager/skills/legal-disclaimers/) | Draft legal disclaimers, terms, and compliance notices for Australian businesses |
| [`website-copy`](plugins/brand-manager/skills/website-copy/) | Write website copy for landing pages, about sections, and CTAs aligned to brand voice |

### Software Development (`software-development`)

| Skill | Description |
|-------|-------------|
| [`dead-code-audit`](plugins/software-development/skills/dead-code-audit/) | Detect dead code across 9 languages — JS/TS, Python, Go, Rust, Java, PHP, Ruby, C# — with actionable removal plan |
| [`write-path-mapper`](plugins/software-development/skills/write-path-mapper/) | Map end-to-end write paths from UI to database with framework and database introspection |

## Skill Features

Every skill in this library includes:

- **YAML frontmatter** — `name`, `description`, `argument-hint`, `allowed-tools`, `effort`
- **`$ARGUMENTS`** — Accept user input directly (e.g., `/skill-name my business description`)
- **`ultrathink`** — Extended thinking enabled for complex analytical skills
- **Output templates** — Structured output format with section headers
- **Example outputs** — Realistic completed examples with Australian business context
- **Utility scripts** — Python/Bash helpers for common operations

Select skills also include:

- **`context: fork`** — Research-heavy skills run in isolated subagent context
- **`paths`** — Auto-activation when working with matching file patterns
- **`reference.md`** — Dense reference material (SQL templates, scoring rubrics, lookup tables) extracted to keep SKILL.md under 500 lines
- **Dynamic context injection** — Shell commands that inject project state before the skill runs

## Plugin Directory Structure

Each plugin follows a consistent layout:

```
plugins/<plugin-name>/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest (name, version, author, keywords)
├── skills/
│   └── <skill-name>/
│       ├── SKILL.md              # Main skill instructions (under 500 lines)
│       ├── reference.md          # Detailed reference material (where needed)
│       ├── LICENSE.txt           # License
│       ├── templates/
│       │   └── output-template.md    # Output format skeleton
│       ├── examples/
│       │   └── example-output.md     # Realistic completed example
│       └── scripts/
│           └── helper.py             # Utility script (where relevant)
├── hooks/
│   ├── hooks.json                # Plugin hooks configuration
│   └── scripts/                  # Hook scripts
└── settings.json                 # Plugin settings
```

## Repository Structure

```
official-claude-plugins/
├── .claude/
│   └── CLAUDE.md                          # Project instructions for contributors
├── .claude-plugin/
│   └── marketplace.json                   # Marketplace catalog (8 plugins)
├── plugins/
│   ├── data-analysis/                     # Data Analysis & Intelligence (5 skills)
│   ├── knowledge-engineering/             # Knowledge Engineering (4 skills)
│   ├── business-economics/                # Business Economics (2 skills)
│   ├── npm-package-audit/                 # npm Package Audit (1 skill)
│   ├── plan-completion-audit/             # Plan Completion Audit (1 skill)
│   ├── skill-creator/                     # Skill Creator (1 skill)
│   ├── brand-manager/                     # Brand Manager (9 skills)
│   └── software-development/              # Software Development (2 skills)
├── settings.json                          # Root plugin settings
├── CHANGELOG.md                           # Version history
├── LICENSE                                # MIT
└── README.md
```

## Creating New Skills

Use the built-in skill creator:

```bash
/skill-creator customer-churn-predictor — predict churn risk from behavioural signals
```

Or follow the conventions in [`.claude/CLAUDE.md`](.claude/CLAUDE.md) to create skills manually.

### Skill Development Checklist

- [ ] SKILL.md has valid YAML frontmatter with `name`, `description`, `effort`
- [ ] SKILL.md is under 500 lines
- [ ] Uses `$ARGUMENTS` for user input
- [ ] Description is under 250 characters, front-loaded with key use case
- [ ] `effort` field set appropriately (`medium`, `high`, or `max`)
- [ ] `paths` field set if skill should auto-activate on file patterns
- [ ] `templates/` directory has at least one output template
- [ ] `examples/` directory has at least one example output
- [ ] Dense reference material is in `reference.md`, not SKILL.md
- [ ] Tested locally with `claude --plugin-dir .`

## Contributing

1. Fork the repository
2. Create a new skill using `/skill-creator`
3. Place it in the appropriate plugin directory under `plugins/`
4. Test locally with `claude --plugin-dir .`
5. Submit a pull request

See [`.claude/CLAUDE.md`](.claude/CLAUDE.md) for detailed development standards.

## Sponsors

This project is maintained by [Anthril](https://github.com/anthril) and funded by our sponsors.

[Become a sponsor](https://github.com/sponsors/anthril)

### Featured Sponsors

<!-- readme-sponsors-featured --><!-- readme-sponsors-featured -->

### All Sponsors

<!-- readme-sponsors-all --><!-- readme-sponsors-all -->

## License

MIT
