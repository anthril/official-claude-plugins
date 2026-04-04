#!/usr/bin/env bash
# Pre-audit check: verify prerequisites before running a project audit.
# Checks git repo status, plan/todo files, and tech stack indicators.
#
# Usage:
#     bash pre-audit-check.sh [project_directory]

set -euo pipefail

PROJECT_DIR="${1:-.}"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Directory not found: $PROJECT_DIR" >&2
    exit 1
fi

cd "$PROJECT_DIR"

echo "============================================="
echo "  PRE-AUDIT CHECK"
echo "  Directory: $(pwd)"
echo "============================================="
echo ""

# --- Git repository check ---
echo "## Git Status"
if [ -d ".git" ]; then
    echo "  Git repo: YES"
    echo "  Branch:   $(git branch --show-current 2>/dev/null || echo 'unknown')"
    UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    echo "  Uncommitted changes: $UNCOMMITTED"
    LAST_COMMIT=$(git log -1 --format='%h %s (%cr)' 2>/dev/null || echo 'none')
    echo "  Last commit: $LAST_COMMIT"
else
    echo "  Git repo: NO -- project is not under version control"
fi
echo ""

# --- Plan / todo files ---
echo "## Planning Artifacts"
FOUND_PLANS=0
for PATTERN in "TODO*" "todo*" "PLAN*" "plan*" "ROADMAP*" "CHANGELOG*" ".todo" "tasks*"; do
    MATCHES=$(find . -maxdepth 2 -name "$PATTERN" -not -path './.git/*' 2>/dev/null || true)
    if [ -n "$MATCHES" ]; then
        while IFS= read -r f; do
            echo "  Found: $f"
            FOUND_PLANS=$((FOUND_PLANS + 1))
        done <<< "$MATCHES"
    fi
done
if [ "$FOUND_PLANS" -eq 0 ]; then
    echo "  No planning files found (TODO, PLAN, ROADMAP, CHANGELOG)"
fi
echo ""

# --- Tech stack detection ---
echo "## Tech Stack"
declare -A STACK_FILES=(
    ["package.json"]="Node.js / JavaScript"
    ["requirements.txt"]="Python (pip)"
    ["pyproject.toml"]="Python (modern)"
    ["Cargo.toml"]="Rust"
    ["go.mod"]="Go"
    ["Gemfile"]="Ruby"
    ["pom.xml"]="Java (Maven)"
    ["build.gradle"]="Java/Kotlin (Gradle)"
    ["composer.json"]="PHP"
    ["Dockerfile"]="Docker"
    ["docker-compose.yml"]="Docker Compose"
    ["docker-compose.yaml"]="Docker Compose"
    [".env.example"]="Environment config"
    ["wrangler.toml"]="Cloudflare Workers"
    ["next.config.js"]="Next.js"
    ["next.config.mjs"]="Next.js"
    ["next.config.ts"]="Next.js"
    ["nuxt.config.ts"]="Nuxt"
    ["tsconfig.json"]="TypeScript"
)

DETECTED=0
for FILE in "${!STACK_FILES[@]}"; do
    if [ -f "$FILE" ]; then
        echo "  ${STACK_FILES[$FILE]} ($FILE)"
        DETECTED=$((DETECTED + 1))
    fi
done
if [ "$DETECTED" -eq 0 ]; then
    echo "  No recognized tech stack files found"
fi
echo ""

# --- Summary ---
echo "============================================="
echo "  SUMMARY"
echo "============================================="
ISSUES=0
if [ ! -d ".git" ]; then
    echo "  [WARN] No git repository -- version history unavailable"
    ISSUES=$((ISSUES + 1))
fi
if [ "$FOUND_PLANS" -eq 0 ]; then
    echo "  [INFO] No planning artifacts to cross-reference"
fi
if [ "$DETECTED" -eq 0 ]; then
    echo "  [WARN] Could not detect tech stack"
    ISSUES=$((ISSUES + 1))
fi
if [ "$ISSUES" -eq 0 ]; then
    echo "  All prerequisites met. Ready for audit."
fi
echo ""
