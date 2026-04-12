#!/usr/bin/env bash
# Anthril — Skill Creator Plugin Welcome Hook

MESSAGE="Anthril — Skill Creator plugin loaded. 1 skill available:\n  - skill-creator\n\nUse /skill-creator [skill-name-and-purpose] to scaffold a new Claude Code skill."

echo "{\"systemMessage\": \"$(echo -e "$MESSAGE" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')\"}"
