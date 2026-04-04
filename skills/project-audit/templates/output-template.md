## Project Audit Report

- **Project:** [project name]
- **Date:** [audit date]
- **Overall Status:** PASS / FAIL / PASS WITH WARNINGS
- **Tasks Complete:** X/Y (Z%)
- **Production Readiness Score:** {{0-100}} / 100

---

## Phase Results

### Phase 1: Task Completion — [PASS/FAIL]

| # | Task / Requirement | Status | Notes |
|---|-------------------|--------|-------|
| 1 | {{task_description}} | Done / Partial / Missing | {{details}} |
| 2 | {{task_description}} | Done / Partial / Missing | {{details}} |

- **Source:** {{where requirements were found — TODO.md, PLAN.md, issues, etc.}}
- **Completion Rate:** {{X}}/{{Y}} ({{Z}}%)
- **Unfinished Items:** {{list or "None"}}

---

### Phase 2: Type Safety — [PASS/FAIL]

- **Type check command:** `{{e.g. npx tsc --noEmit}}`
- **Result:** {{X}} errors, {{Y}} warnings
- **Lint command:** `{{e.g. npx eslint .}}`
- **Result:** {{X}} errors, {{Y}} warnings

| # | File | Line | Issue | Severity |
|---|------|------|-------|----------|
| 1 | {{file_path}} | {{line}} | {{description}} | Error / Warning |

---

### Phase 3: Bug Audit — [PASS/FAIL/WARNINGS]

| # | File:Line | Issue | Severity | Category |
|---|-----------|-------|----------|----------|
| 1 | `{{file}}:{{line}}` | {{description of bug or logic issue}} | Critical / Warning / Minor | Logic / Race Condition / Null Safety / Edge Case |

<!-- Every finding includes a specific file path and line number. -->
<!-- Distinguish: Critical (must fix), Warning (should fix), Minor (improvement). -->

---

### Phase 4: Code Structure — [PASS/WARNINGS]

| # | Area | Finding | Recommendation |
|---|------|---------|---------------|
| 1 | {{e.g. Duplication}} | {{specific finding with file references}} | {{what to do}} |
| 2 | {{e.g. File size}} | {{specific finding}} | {{what to do}} |

- **Architectural patterns:** {{what patterns are used, any inconsistencies}}
- **Code duplication:** {{significant duplications found}}
- **File organisation:** {{any structural issues}}

---

### Phase 5: Failsafes — [PASS/FAIL]

| # | Area | Missing Guardrail | Risk | Recommendation |
|---|------|------------------|------|---------------|
| 1 | {{e.g. API calls}} | {{e.g. No timeout on fetch requests}} | {{impact}} | {{fix}} |
| 2 | {{e.g. User input}} | {{e.g. Missing input validation}} | {{impact}} | {{fix}} |

- **Error boundaries:** {{present / missing / incomplete}}
- **Fallback states:** {{loading, error, empty states assessed}}
- **Rate limiting:** {{present / missing where needed}}

---

### Phase 6: Security — [PASS/FAIL/CRITICAL]

| # | File:Line | Vulnerability | Severity | Category |
|---|-----------|-------------|----------|----------|
| 1 | `{{file}}:{{line}}` | {{description}} | Critical / High / Medium / Low | {{e.g. XSS, SQL injection, auth bypass, secrets exposure}} |

- **Authentication:** {{assessment}}
- **Authorization / RLS:** {{assessment}}
- **Secrets management:** {{any exposed credentials or API keys}}
- **Dependency vulnerabilities:** `{{npm audit / pip audit result summary}}`

---

### Phase 7: Feature Hardening — [PASS/WARNINGS]

For each major feature:

**Feature: {{feature_name}}**
- **Happy path:** {{working / broken}}
- **Edge cases tested:**
  - [ ] Empty state
  - [ ] Maximum input
  - [ ] Invalid input
  - [ ] Network failure
  - [ ] Concurrent access
- **Unhardened areas:** {{specific gaps found}}

---

### Phase 8: Deprecated Cleanup — [PASS/FAIL]

| # | Type | File/Item | Action Needed |
|---|------|----------|--------------|
| 1 | Dead code | `{{file_path}}` | {{remove / review}} |
| 2 | Orphaned file | `{{file_path}}` | {{remove}} |
| 3 | Stale dependency | `{{package_name}}` | {{remove / update}} |
| 4 | TODO/FIXME/HACK | `{{file}}:{{line}}` | {{resolve or document}} |

---

### Phase 9: Build Verification — [PASS/FAIL]

- **Build command:** `{{e.g. npm run build}}`
- **Build result:** Success / Failed
- **Build output:** {{summary — warnings, bundle size, etc.}}
- **Type check (clean build):** {{result}}
- **Test suite:** `{{test command}}` — {{X}} passed, {{Y}} failed, {{Z}} skipped

---

## Issues Found (by Severity)

### Critical Issues (must fix before deploy)

1. **{{issue_title}}** — `{{file}}:{{line}}`
   {{description and recommended fix}}

### Recommended Improvements (should fix)

1. **{{issue_title}}** — `{{file}}:{{line}}`
   {{description and recommended fix}}

### Minor Suggestions (nice to have)

1. **{{issue_title}}**
   {{description}}

---

## Production Readiness Score

| Category | Weight | Score | Weighted |
|----------|--------|-------|----------|
| Task Completion | 20% | {{0-100}} | {{weighted}} |
| Type Safety | 10% | {{0-100}} | {{weighted}} |
| Bug Freedom | 20% | {{0-100}} | {{weighted}} |
| Code Structure | 10% | {{0-100}} | {{weighted}} |
| Failsafes | 10% | {{0-100}} | {{weighted}} |
| Security | 20% | {{0-100}} | {{weighted}} |
| Build Health | 10% | {{0-100}} | {{weighted}} |
| **Total** | **100%** | | **{{total}}/100** |

**Verdict:** {{READY FOR PRODUCTION / NEEDS WORK / NOT READY}}
