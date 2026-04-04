# Project Audit: BookLocal -- Next.js + Supabase Web Application

**Project:** BookLocal -- Online booking platform for local service providers
**Stack:** Next.js 14 (App Router), Supabase (Auth, Database, Storage), Tailwind CSS, Stripe
**Audit Date:** 2026-04-04
**Auditor:** AI Project Audit Skill v2.1

---

## 1. Executive Summary

| Metric | Result |
|---|---|
| **Production Readiness Score** | **62 / 100** |
| Critical Issues | 3 |
| High Severity Issues | 7 |
| Medium Severity Issues | 12 |
| Low Severity Issues | 9 |
| Total Issues | 31 |
| Files Analysed | 247 |
| Test Coverage (estimated) | 34% |

**Verdict:** The application has solid core functionality but is **not production-ready** in its current state. Three critical security issues must be resolved before any public deployment. Auth flows and database access patterns need immediate hardening.

---

## 2. Phase Results

### Phase 1: Architecture and Structure

**Score: 71 / 100**

| Check | Status | Detail |
|---|---|---|
| App Router structure | PASS | Clean route grouping with (public), (auth), (dashboard) |
| Component organisation | PASS | Shared components in /components, page-specific colocated |
| Server/Client boundary | WARN | 14 components marked "use client" unnecessarily |
| Environment variables | FAIL | SUPABASE_SERVICE_ROLE_KEY present in .env.local but also referenced in 2 client components |
| Dependency hygiene | WARN | 3 unused packages in package.json (lodash, moment, classnames) |
| Bundle analysis | WARN | Client bundle is 847KB gzipped -- lodash and moment account for ~180KB |

**Issues Found:**

| ID | Severity | Description |
|---|---|---|
| ARCH-001 | **CRITICAL** | Service role key exposed to client bundle via `process.env.SUPABASE_SERVICE_ROLE_KEY` in `src/lib/supabase-client.ts` line 12. This grants full database bypass of RLS. |
| ARCH-002 | Medium | 14 components use "use client" but contain no hooks, event handlers, or browser APIs. Convert to Server Components to reduce bundle size. |
| ARCH-003 | Low | Unused dependencies (lodash, moment, classnames) inflating node_modules and bundle. |

---

### Phase 2: Security and Authentication

**Score: 48 / 100**

| Check | Status | Detail |
|---|---|---|
| Supabase Auth configuration | PASS | Email + Google OAuth configured correctly |
| Row Level Security (RLS) | FAIL | 4 of 11 tables have RLS disabled |
| Auth middleware | WARN | Middleware exists but does not protect /api/admin/* routes |
| CSRF protection | PASS | Next.js Server Actions handle CSRF automatically |
| Input sanitisation | FAIL | User-supplied HTML rendered with dangerouslySetInnerHTML in 2 locations |
| Rate limiting | FAIL | No rate limiting on /api/auth/login or /api/bookings endpoints |

**Issues Found:**

| ID | Severity | Description |
|---|---|---|
| SEC-001 | **CRITICAL** | RLS disabled on `bookings`, `payments`, `provider_settings`, `audit_log` tables. Any authenticated user can read/write all rows via Supabase client. |
| SEC-002 | **CRITICAL** | `/api/admin/users` and `/api/admin/analytics` endpoints have no auth check. Currently accessible to unauthenticated requests. |
| SEC-003 | High | `dangerouslySetInnerHTML` used in `ReviewCard.tsx` (line 34) and `ProviderBio.tsx` (line 22) with unsanitised user content. XSS vector. |
| SEC-004 | High | No rate limiting on authentication or booking creation endpoints. Vulnerable to brute force and resource exhaustion. |
| SEC-005 | Medium | Session timeout set to 7 days with no refresh rotation. Recommend 1-hour access token with silent refresh. |

---

### Phase 3: Database and Data Layer

**Score: 65 / 100**

| Check | Status | Detail |
|---|---|---|
| Schema design | PASS | Normalised schema, appropriate foreign keys |
| Migrations | WARN | 23 migrations, but 3 are empty "placeholder" files |
| Indexes | FAIL | Missing index on `bookings.provider_id` (used in 6 queries) |
| N+1 queries | FAIL | Provider listing page makes 1 query per provider for reviews (N+1 pattern) |
| Connection handling | PASS | Using Supabase client with automatic connection pooling |
| Soft deletes | WARN | Only `users` table has soft delete -- `bookings` and `reviews` use hard delete |

**Issues Found:**

| ID | Severity | Description |
|---|---|---|
| DB-001 | High | Missing index on `bookings.provider_id`. EXPLAIN shows sequential scan on 45K+ row table. Expected 10-50x improvement with B-tree index. |
| DB-002 | High | N+1 query pattern in `getProviders()` -- fetches reviews individually per provider. Refactor to single query with aggregate join. |
| DB-003 | Medium | 3 empty migration files (20260201_placeholder, 20260215_placeholder, 20260301_placeholder) polluting migration history. |
| DB-004 | Medium | Hard deletes on `bookings` table loses audit trail. Implement soft delete with `deleted_at` column. |

---

### Phase 4: Testing and Quality

**Score: 42 / 100**

| Check | Status | Detail |
|---|---|---|
| Unit tests | FAIL | 18 test files covering only utility functions and 2 components. 34% coverage. |
| Integration tests | FAIL | No API route tests found |
| E2E tests | WARN | 3 Playwright tests exist but 2 are skipped |
| Type safety | WARN | 11 instances of `any` type, 4 `@ts-ignore` comments |
| Linting | PASS | ESLint configured with Next.js recommended rules, 0 errors |
| Error handling | FAIL | 8 API routes use bare try/catch with generic 500 response, no logging |

**Issues Found:**

| ID | Severity | Description |
|---|---|---|
| TEST-001 | High | No integration tests for API routes. Booking creation, payment processing, and auth flows are untested. |
| TEST-002 | High | Error handling in API routes swallows exceptions with `catch (e) { return NextResponse.json({ error: "Server error" }, { status: 500 }) }`. No error logging or monitoring. |
| TEST-003 | Medium | 11 uses of `any` type bypass TypeScript safety. Concentrated in Stripe webhook handler and Supabase query results. |
| TEST-004 | Medium | 2 of 3 Playwright E2E tests are skipped with `test.skip("flaky")`. |
| TEST-005 | Low | No test for Stripe webhook signature verification. |

---

### Phase 5: Performance and Deployment

**Score: 68 / 100**

| Check | Status | Detail |
|---|---|---|
| Image optimisation | PASS | Using next/image with proper sizing |
| Caching strategy | WARN | No explicit cache headers on API routes. Relying solely on Next.js defaults. |
| Loading states | PASS | Suspense boundaries with skeleton loaders on key pages |
| Error boundaries | FAIL | No error boundary components. Runtime errors crash the page. |
| SEO | PASS | Metadata API used correctly on all public pages |
| Hosting config | PASS | Vercel deployment with proper environment variable separation |

**Issues Found:**

| ID | Severity | Description |
|---|---|---|
| PERF-001 | High | No React Error Boundary components. Any unhandled runtime error in a client component crashes the entire page with no recovery. |
| PERF-002 | Medium | API routes return full database rows including internal fields (`created_at`, `updated_at`, `internal_notes`). Implement DTOs/response shaping. |
| PERF-003 | Medium | No Cache-Control headers on public provider listing API. Will not cache at CDN edge. |
| PERF-004 | Low | Largest Contentful Paint on homepage measured at 3.2s. Hero image (1.8MB) should use priority loading and WebP format. |

---

## 3. Issue Summary by Severity

| Severity | Count | Must Fix Before Launch |
|---|---|---|
| Critical | 3 | Yes -- security vulnerabilities |
| High | 7 | Yes -- data integrity and reliability risks |
| Medium | 12 | Recommended -- quality and maintainability |
| Low | 9 | Optional -- polish and optimisation |

---

## 4. Priority Remediation Plan

| Priority | Issue IDs | Effort | Impact |
|---|---|---|---|
| 1 (Immediate) | ARCH-001, SEC-001, SEC-002 | 2-4 hours | Closes critical security holes |
| 2 (This week) | SEC-003, SEC-004, DB-001, DB-002, TEST-002, PERF-001 | 8-12 hours | Hardens data layer and error handling |
| 3 (Before launch) | ARCH-002, SEC-005, DB-004, TEST-001, TEST-003, PERF-002, PERF-003 | 16-24 hours | Production-grade quality |
| 4 (Post-launch) | ARCH-003, DB-003, TEST-004, TEST-005, PERF-004, remaining Low items | 8-12 hours | Optimisation and cleanup |

---

## 5. Production Readiness Scorecard

| Category | Weight | Score | Weighted |
|---|---|---|---|
| Architecture | 20% | 71 | 14.2 |
| Security | 30% | 48 | 14.4 |
| Database | 20% | 65 | 13.0 |
| Testing | 15% | 42 | 6.3 |
| Performance | 15% | 68 | 10.2 |
| **Overall** | **100%** | | **62 / 100** |

**Minimum threshold for production: 75/100.** Current gap: 13 points. Completing Priority 1 and 2 items is projected to bring the score to approximately 78/100.
