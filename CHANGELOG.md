# Changelog

All notable changes to the Solantic AI Official Claude Plugins marketplace will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2025-05-20

### Changed
- Reorganised all skills into 6 standalone plugins under `plugins/` directory
- Each plugin is now independently installable via marketplace
- Added `solanticai-` prefix to all plugin names for namespace clarity
- Added `.claude-plugin/plugin.json` manifest to each individual plugin
- Updated marketplace.json with `repository` and `homepage` fields for all entries

### Added
- **solanticai-all** meta-plugin — installs all 14 skills across 6 plugins
- **solanticai-data-analysis** — anomaly-detection-rule-builder, cohort-analysis-builder, data-dictionary-generator, data-pipeline-architecture, dataset-profiling-quality-audit
- **solanticai-knowledge-engineering** — business-data-model-designer, entity-disambiguation, entity-relationship-mapper, knowledge-graph-builder
- **solanticai-business-economics** — market-sizing-tam-estimator, unit-economics-calculator
- **solanticai-npm-package-audit** — npm-package-audit
- **solanticai-plan-completion-audit** — plan-completion-audit
- **solanticai-skill-creator** — skill-creator
- Per-plugin hooks (SessionStart welcome, Stop suggestions, PreToolUse/PostToolUse validation)

### Removed
- Flat `skills/` and `hooks/` directories at repository root (migrated to plugin structure)

## [1.0.0] - 2025-04-15

### Added
- Initial release as a Claude Code plugin marketplace
- 14 skills across data analysis, knowledge engineering, business economics, and developer tooling
- MIT license
- Example outputs and output templates for all skills
- Helper scripts (Python and Bash) for skill validation and computation
