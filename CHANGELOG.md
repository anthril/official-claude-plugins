# Changelog

All notable changes to the Solantic AI Official Claude Plugins marketplace will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-05-20

### Added
- 6 standalone plugins with 14 production-ready skills
- **data-analysis** — anomaly-detection-rule-builder, cohort-analysis-builder, data-dictionary-generator, data-pipeline-architecture, dataset-profiling-quality-audit
- **knowledge-engineering** — business-data-model-designer, entity-disambiguation, entity-relationship-mapper, knowledge-graph-builder
- **business-economics** — market-sizing-tam-estimator, unit-economics-calculator
- **npm-package-audit** — npm-package-audit
- **plan-completion-audit** — plan-completion-audit
- **skill-creator** — skill-creator
- `.claude-plugin/plugin.json` manifest for each individual plugin with `skills` and `hooks` component paths
- Marketplace catalog at `.claude-plugin/marketplace.json` with `repository` and `homepage` fields
- Per-plugin hooks (SessionStart welcome, Stop suggestions, PreToolUse/PostToolUse validation)
- Example outputs and output templates for all skills
- Helper scripts (Python and Bash) for skill validation and computation
- MIT license
