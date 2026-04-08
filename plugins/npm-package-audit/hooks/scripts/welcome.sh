#!/bin/bash
# Solantic AI — npm Package Audit Plugin Welcome Hook

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/../.." && pwd)}"

# Check npm availability
NPM_VERSION=$(npm --version 2>/dev/null)
NODE_VERSION=$(node --version 2>/dev/null)

if [ -n "$NPM_VERSION" ] && [ -n "$NODE_VERSION" ]; then
  ENV_INFO="Environment: Node ${NODE_VERSION}, npm ${NPM_VERSION}"
else
  ENV_INFO="⚠ Warning: npm or Node.js not detected. Some audit features require npm to be installed."
fi

MESSAGE="Solantic AI — npm Package Audit plugin loaded. 1 skill available:\n  - npm-package-audit\n\n${ENV_INFO}"

echo "{\"systemMessage\": \"$(echo -e "$MESSAGE" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')\"}"
