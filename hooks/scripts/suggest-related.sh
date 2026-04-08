#!/usr/bin/env bash
# AI Cookbook — Stop hook
# Suggests related skills after a skill completes execution

set -euo pipefail

INPUT=$(cat)

if ! command -v jq &>/dev/null; then
  exit 0
fi

# Try to detect which skill was used from the transcript
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty' 2>/dev/null)

if [ -z "$TRANSCRIPT_PATH" ] || [ ! -f "$TRANSCRIPT_PATH" ]; then
  exit 0
fi

# Look for skill invocation in recent transcript entries
SKILL_NAME=""
if command -v grep &>/dev/null; then
  SKILL_NAME=$(grep -oP 'ai-cookbook:\K[a-z-]+' "$TRANSCRIPT_PATH" 2>/dev/null | tail -1 || true)
fi

if [ -z "$SKILL_NAME" ]; then
  exit 0
fi

# Skill relationship map (organised by category)
RELATED=""
case "$SKILL_NAME" in
  # Data category
  anomaly-detection-rule-builder)
    RELATED="cohort-analysis-builder, data-pipeline-architecture";;
  cohort-analysis-builder)
    RELATED="unit-economics-calculator, dataset-profiling-quality-audit";;
  data-dictionary-generator)
    RELATED="business-data-model-designer, dataset-profiling-quality-audit";;
  data-pipeline-architecture)
    RELATED="anomaly-detection-rule-builder, dataset-profiling-quality-audit";;
  dataset-profiling-quality-audit)
    RELATED="data-dictionary-generator, cohort-analysis-builder";;
  # Development category
  npm-package-audit)
    RELATED="project-audit, plan-completion-audit";;
  plan-completion-audit)
    RELATED="project-audit, npm-package-audit";;
  project-audit)
    RELATED="plan-completion-audit, npm-package-audit";;
  skill-creator)
    RELATED="project-audit, data-dictionary-generator";;
  # Economics category
  market-sizing-tam-estimator)
    RELATED="unit-economics-calculator, cohort-analysis-builder";;
  unit-economics-calculator)
    RELATED="market-sizing-tam-estimator, cohort-analysis-builder";;
  # Knowledge Engineering category
  business-data-model-designer)
    RELATED="entity-relationship-mapper, data-dictionary-generator";;
  entity-disambiguation)
    RELATED="entity-relationship-mapper, knowledge-graph-builder";;
  entity-relationship-mapper)
    RELATED="knowledge-graph-builder, business-data-model-designer";;
  knowledge-graph-builder)
    RELATED="entity-disambiguation, entity-relationship-mapper";;
  *)
    exit 0;;
esac

if [ -n "$RELATED" ]; then
  cat <<EOF
{
  "systemMessage": "Related skills you might find useful: ${RELATED}"
}
EOF
fi

exit 0
