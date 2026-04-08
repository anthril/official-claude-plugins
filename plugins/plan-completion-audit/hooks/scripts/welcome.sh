#!/usr/bin/env bash
# Solantic AI — Plan Completion Audit Plugin Welcome Hook

MESSAGE="Solantic AI — Plan Completion Audit plugin loaded. 1 skill available:\n  - plan-completion-audit\n\nUse /plan-completion-audit [path-to-project-root-or-plan-file] to audit plan versus implementation."

echo "{\"systemMessage\": \"$(echo -e "$MESSAGE" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')\"}"
