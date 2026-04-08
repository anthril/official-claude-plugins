#!/usr/bin/env bash
# AI Cookbook — SessionStart hook
# Displays skill count and quality warnings on session start

set -euo pipefail

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/../.." && pwd)}"
SKILLS_DIR="$PLUGIN_ROOT/skills"

# Count skills (nested under category directories)
SKILL_COUNT=0
OVER_LIMIT=""

if [ -d "$SKILLS_DIR" ]; then
  for skill_file in "$SKILLS_DIR"/*/*/skill.md "$SKILLS_DIR"/*/*/SKILL.md; do
    [ -f "$skill_file" ] || continue
    SKILL_COUNT=$((SKILL_COUNT + 1))

    # Check line count
    LINES=$(wc -l < "$skill_file" 2>/dev/null || echo "0")
    if [ "$LINES" -gt 500 ]; then
      SKILL_NAME=$(basename "$(dirname "$skill_file")")
      OVER_LIMIT="${OVER_LIMIT}  - ${SKILL_NAME} (${LINES} lines)\n"
    fi
  done
fi

# Count categories
CATEGORY_COUNT=0
if [ -d "$SKILLS_DIR" ]; then
  for category_dir in "$SKILLS_DIR"/*/; do
    [ -d "$category_dir" ] || continue
    CATEGORY_COUNT=$((CATEGORY_COUNT + 1))
  done
fi

# Build output message
MSG="AI Cookbook loaded: ${SKILL_COUNT} skills across ${CATEGORY_COUNT} categories."

if [ -n "$OVER_LIMIT" ]; then
  MSG="${MSG}\n⚠ Skills exceeding 500-line limit:\n${OVER_LIMIT}Consider extracting reference material to reference.md."
fi

# Output as JSON for systemMessage
cat <<EOF
{
  "systemMessage": "$(echo -e "$MSG")"
}
EOF

exit 0
