#!/usr/bin/env bash
# AI Cookbook — PostToolUse hook for Write|Edit
# Checks frontmatter and line count after editing skill.md files

set -euo pipefail

INPUT=$(cat)

# Check if jq is available
if ! command -v jq &>/dev/null; then
  exit 0
fi

# Extract file path
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

# Only check skill.md files
if [[ ! "${FILE_PATH,,}" =~ skill\.md$ ]]; then
  exit 0
fi

# Check file exists
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

WARNINGS=""

# Check for YAML frontmatter (file should start with ---)
FIRST_LINE=$(head -1 "$FILE_PATH" 2>/dev/null)
if [ "$FIRST_LINE" != "---" ]; then
  WARNINGS="${WARNINGS}Missing YAML frontmatter: skill.md should start with --- and include name, description fields. "
fi

# Check line count
LINES=$(wc -l < "$FILE_PATH" 2>/dev/null || echo "0")
if [ "$LINES" -gt 500 ]; then
  WARNINGS="${WARNINGS}skill.md exceeds 500 lines (${LINES} lines). Extract reference material to reference.md. "
elif [ "$LINES" -gt 450 ]; then
  WARNINGS="${WARNINGS}skill.md is approaching the 500-line limit (${LINES} lines). Consider extracting dense content to reference.md. "
fi

if [ -n "$WARNINGS" ]; then
  cat <<EOF
{
  "systemMessage": "⚠ AI Cookbook quality check: ${WARNINGS}"
}
EOF
fi

exit 0
