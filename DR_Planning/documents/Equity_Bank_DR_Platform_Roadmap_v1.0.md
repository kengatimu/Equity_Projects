# Disaster Recovery Management Platform — Product Roadmap
> **Project:** Equity Bank Group — Disaster Recovery Management Platform
> **Prepared By:** Group IT Service Continuity Management (ITSCM)
> **Scope:** All Equity Bank Group Subsidiaries — KE · UG · RW · TZ · DRC · SS
> **Date:** 2026-03-30
> **Version:** 1.0
> **Last Build Update:** 2026-04-01

---

## Build Status

> This section tracks actual implementation progress against the planned roadmap.
> Updated as each week / phase is completed.

| Phase | Week | Description | Status |
|---|---|---|---|
| **Phase 1** | Week 1 | Project Scaffold, Authentication & Audit Foundation | ✅ **Complete** (2026-04-01) |
| **Phase 1** | Week 2 | Application Registry | ⏳ Pending |
| **Phase 1** | Week 3 | Dependency Engine | ⏳ Pending |
| **Phase 1** | Week 4 | Campaign Manager | ⏳ Pending |
| **Phase 1** | Week 5 | Pre-DR Readiness & Checklist Engine | ⏳ Pending |
| **Phase 1** | Week 6 | Pre-DR Sign-Off & Notifications | ⏳ Pending |
| **Phase 2** | Weeks 7–10 | Runbook Builder + War Room | ⏳ Pending |
| **Phase 3** | Weeks 11–14 | Post-DR Review, Reporting, Analytics | ⏳ Pending |
| **Phase 4** | Weeks 15–18 | Integrations & Advanced Features | ⏳ Pending |

### Week 1 — Actual vs. Planned Deviations

The roadmap planned **LDAP/AD authentication + TOTP MFA** for Week 1. The actual implementation uses **Email OTP** for the SIT/development environment. LDAP integration is deferred to a later sprint once the SIT environment has AD connectivity. All other Week 1 goals were met or exceeded.

| Component | Planned | Actual (SIT) | Notes |
|---|---|---|---|
| Authentication | LDAP/AD bind | Email OTP | LDAP deferred — no AD in SIT. OTP is production-equivalent for audit coverage. |
| MFA | TOTP (Google Authenticator) | Email OTP (same flow) | OTP IS the MFA step in this implementation |
| Primary Key Strategy | UUID v4 (`gen_random_uuid()`) | **UUID v7** (`gen_uuid_v7()`) | Time-ordered UUIDs — better index locality, timestamp-sortable |
| JWT session claim | None specified | `jti` = session_id (UUID v7) | Enables full OTP_REQUESTED → OTP_VERIFIED → USER_LOGOUT session correlation |
| Audit log columns | `actor_id, actor_ip, actor_role, action, resource_type, resource_id, campaign_id, subsidiary_id, before_state, after_state, session_id, user_agent, timestamp` | Same + **`actor_email`** added | Denormalised email — audit records survive user deletion |
| Audit log wiring | `@Auditable` aspect + JDBC INSERT | **Implemented** — `PROPAGATION_REQUIRES_NEW`, never blocks main operation | Working |
| Session correlation | Not specified | `session_id` (UUID v7) threads across all auth events | `email_otps.session_id` → JWT `jti` → `AuditContext` → `audit_log.session_id` |
| DB views | Not specified | `v_user_activity`, `v_session_summary` | Security/ops views for session timeline and user activity |
| Flyway migrations | Implied | **V1–V12 applied** | Includes pgcrypto (V10), UUID v7 INT cast fix (V11), session tracking + views (V12) |

### Key Files Produced — Week 1

| File | Package / Path | Purpose |
|---|---|---|
| `SecurityConfig.java` | `config` | Spring Security 6, JWT filter chain, CORS, CSRF, endpoint rules |
| `JwtService.java` | `security` | `generateAccessToken(user, sessionId)`, `jti` claim, `extractSessionId()`, `extractEmail()` |
| `JwtAuthFilter.java` | `security` | Validates JWT, stamps `AuditContext` (session_id + actor_email) on every authenticated request |
| `AuthService.java` | `service` | `requestOtp()`, `verifyOtp()`, `refreshToken()`, `logout()` — all wire `AuditContext` |
| `EmailOtpService.java` | `service` | `sendOtp()` → `OtpSendResult(delivered, sessionId)`, `verifyAndConsumeOtp()` → `OtpVerifyResult(user, sessionId)` |
| `AuditContext.java` | `audit` | Request-scoped static helper (RequestContextHolder) — no parameter threading |
| `AuditLogAspect.java` | `audit` | `@Around @Auditable` — 9-column INSERT, `PROPAGATION_REQUIRES_NEW`, never throws |
| `UuidV7Generator.java` | `config` | Custom Hibernate generator for time-ordered UUID v7 PKs |
| `AuditLogEntity.java` | `entity` | Hibernate entity — includes `actorEmail`, `sessionId` |
| `EmailOtpEntity.java` | `entity` | Includes `sessionId UUID` for session correlation |
| `V10__enable_pgcrypto.sql` | `db/migration` | `CREATE EXTENSION IF NOT EXISTS pgcrypto` |
| `V11__fix_gen_uuid_v7_int_cast.sql` | `db/migration` | Re-creates `gen_uuid_v7()` with `::int` casts on all BIGINT bitshift expressions |
| `V12__session_tracking_and_audit_views.sql` | `db/migration` | `actor_email` + `session_id` columns, indexes, `v_user_activity`, `v_session_summary` |

---

## The Problem We Are Solving

Equity Bank Group runs **100+ mission-critical applications** across 6 subsidiaries. Every quarter, a Disaster Recovery (DR) exercise is conducted. Today this process is:

- Managed by **one person** using multiple Excel spreadsheets
- Coordinated through manual emails, WhatsApp messages, and phone calls
- Documented in Word documents **after the fact**, not in real-time
- Impossible to track properly — blockers from one DR cycle are lost before the next
- Application owners have **no visibility** on what they need to prepare
- Post-DR reports are manually assembled from scattered notes

**Evidence from the Finacle TZ DR Exercise (15 March 2026):**

| Issue Observed | Root Cause |
|---|---|
| DBA, DevOps, NOC not present at start | No mandatory attendance enforcement |
| Treasury IP config wrong after failover | Manual config step with no automation |
| WAY4 RC 907/904 errors post-failover | No structured post-failover validation |
| Oracle DG TNS entries not updated in time | Manual file editing across multiple servers |
| NOC TZ DR monitoring not visible | DR environment not integrated into dashboards |
| External dependency (DNB) failure untracked | No third-party dependency mapping |

---

## The Solution

A **web-based DR Management Platform** that replaces all Excel, Word, and manual coordination with one intelligent system. The platform has **9 core modules** working together:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     DR MANAGEMENT PLATFORM                               │
│                                                                          │
│  1. Application Registry    — 100+ apps, tiers, owners, subsidiaries    │
│  2. Dependency Engine       — Shared DBs, middleware, conflict detection │
│  3. Campaign Manager        — Quarterly DR planning and scheduling       │
│  4. Pre-DR Readiness        — Checklists, blocker history, owner alerts  │
│  5. Runbook Builder         — Structured steps, versions, approvals      │
│  6. War Room                — Live execution tracker (real-time)         │
│  7. Post-DR Review          — Outcomes, comments, carried-forward issues │
│  8. Report Generator        — Auto-generate regulatory Word/PDF reports  │
│  9. Dashboard & Analytics   — Coordinator, Management, App Owner views   │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## System Architecture Overview

```
╔═══════════════════════════════════════════════════════════════════════╗
║                    PLATFORM ARCHITECTURE                               ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║   USERS                                                                ║
║   ┌──────────────────┐  ┌──────────────────┐  ┌─────────────────┐   ║
║   │  Coordinator     │  │  App Owners      │  │  Management     │   ║
║   │  Web UI          │  │  Web UI          │  │  Reports View   │   ║
║   └────────┬─────────┘  └────────┬─────────┘  └────────┬────────┘   ║
║            └────────────────────-┼─────────────────────-┘            ║
║                                  │                                     ║
║   ┌───────────────────────────── ▼──────────────────────────────────┐ ║
║   │         REST API + WebSocket Gateway                             │ ║
║   │         Java 21 · Spring Boot 3.x · Spring Security 6           │ ║
║   │         JWT Auth · LDAP/AD SSO · Spring WebSocket + STOMP       │ ║
║   └──────────┬───────────────────────────────┬──────────────────────┘ ║
║              │                               │                         ║
║   ┌──────────▼───────────┐      ┌────────────▼────────────────────┐  ║
║   │   CORE SERVICES      │      │   SUPPORTING SERVICES           │  ║
║   │   (Spring Beans)     │      │   (Spring Components)           │  ║
║   │                      │      │                                  │  ║
║   │  • App Registry      │      │  • War Room Engine               │  ║
║   │  • Campaign Manager  │      │    (Spring WebSocket + STOMP)    │  ║
║   │  • Runbook Engine    │      │  • Background Jobs               │  ║
║   │  • Blocker Intel     │      │    (Spring Scheduler + Batch)    │  ║
║   │  • Post-DR Review    │      │  • Notification Service          │  ║
║   │                      │      │    (Spring Mail + Twilio SMS)    │  ║
║   │  Spring Data JPA     │      │  • Report Generator              │  ║
║   │  + Hibernate ORM     │      │    (Apache POI + iText 7)        │  ║
║   └──────────────────────┘      └──────────────────────────────────┘  ║
║                                                                        ║
║   ┌────────────────────────────────────────────────────────────────┐  ║
║   │                  PostgreSQL Database                            │  ║
║   │  applications | campaigns | runbooks | executions | issues     │  ║
║   │  checklist_items | outcomes | action_items | audit_log         │  ║
║   └────────────────────────────────────────────────────────────────┘  ║
╚═══════════════════════════════════════════════════════════════════════╝
```

**Tech Stack:**

| Layer | Technology | Rationale |
|---|---|---|
| **Frontend** | React 18 + TypeScript + Vite | Modern, type-safe UI — component-based, fast |
| **Backend API** | Java 21 (LTS) + Spring Boot 3.x | Enterprise-grade, banking industry standard, native IDE support in NetBeans |
| **Security** | Spring Security 6 | LDAP/AD integration, JWT, RBAC, MFA, method-level security |
| **ORM / Database Access** | Spring Data JPA + Hibernate | Type-safe queries, transactional integrity, audit entity support |
| **Real-Time (War Room)** | Spring WebSocket + STOMP | Native WebSocket support — no external library needed |
| **Background Jobs** | Spring Scheduler + Spring Batch | Built-in — T-7/T-3/T-1 reminders, digest emails, carry-forward engine |
| **Report Generation** | Apache POI (Word/Excel) + iText 7 (PDF) | Java-native document generation, full control over formatting |
| **Notifications** | Spring Mail + Twilio SDK (SMS) | Email via corporate SMTP; SMS via Twilio |
| **Primary Database** | PostgreSQL 16 | Relational integrity, JSONB for flexible metadata, row-level security |
| **Cache & Pub/Sub** | Redis 7 + Redisson (Java client) | Session cache, War Room event broadcasting, rate limiting |
| **Secrets Management** | HashiCorp Vault + Spring Cloud Vault | No secrets in code or config files |
| **Build Tool** | Maven | Standard in NetBeans, excellent Spring Boot support |
| **Containerisation** | Docker + Docker Compose | Consistent environments across dev/staging/production |
| **IDE** | NetBeans / IntelliJ IDEA | Both support Spring Boot — NetBeans is your current environment |

---

## DR Activity Types Supported

| Code | Name | Description |
|---|---|---|
| `FULL_FAILOVER` | Full Failover | DC App + DC DB → DR App + DR DB |
| `APP_ONLY` | App-Only Failover | DC App → DR App (DB stays in DC) |
| `DB_ONLY` | DB-Only Failover | App stays in DC, DB switches to DR (Oracle DG) |
| `APP_REPOINT` | App Repoint | DC App reconfigured to point to DR DB |
| `PARTIAL` | Partial Failover | Subset of services fail over |
| `ACTIVE_ACTIVE` | Active-Active | Both DC and DR serving traffic |
| `ROLLBACK_DRILL` | Rollback Drill | Testing the return-to-DC procedure |
| `COLD_STANDBY` | Cold Standby Activation | DR was off — bring it up from scratch |
| `TABLETOP` | Tabletop / Simulated | Walkthrough only, no system movement |
| `EXTENDED_OPS` | Extended DR Operations | Running from DR for ≥ 30 days |

---

## Workflow Design

Every DR activity follows a **formal state machine** — no stage can be skipped, every transition is recorded.

### Campaign Application Lifecycle

```
  CREATE
    │
    ▼
  PLANNED ──────────────────────────────────────────► CANCELLED
    │
    ▼
  PRE_DR_OPEN  ←── Coordinator opens pre-DR checklist
    │                for all application owners
    ▼
  APPROVED ──────────────────────────────────────────► DEFERRED
    │
    ▼
  IN_EXECUTION  ←── War Room opened, RTO timer starts
    │
    ▼
  VALIDATION  ←── All steps done, business testing in progress
    │                │
    ▼                ▼
  COMPLETED      ROLLED_BACK
    │
    ▼
  POST_DR_REVIEW  ←── Outcomes submitted, report generated
```

### Pre-DR Checklist Item Lifecycle

```
  PENDING → IN_PROGRESS → BLOCKED → IN_PROGRESS → DONE → VERIFIED
                                │
                                └──► CARRIED_FORWARD (to next campaign)
```

### Automated Workflow Triggers

| When | What Happens Automatically |
|---|---|
| Campaign created | Pre-DR checklist items auto-generated from runbook template |
| T-7 days to DR | Email sent to all application owners |
| T-3 days to DR | Email + SMS to owners with PENDING or BLOCKED items |
| T-1 day to DR | Escalation email to coordinator — all unresolved blockers listed |
| Item marked BLOCKED | Immediate alert to coordinator + manager |
| DR Execution started | War Room opens, all step owners notified |
| Step BLOCKED in War Room | Alert fires to coordinator + escalation contact |
| Campaign closes with open issues | Issues auto-tagged CARRIED_FORWARD to next campaign |
| Action item overdue | Weekly digest to coordinator + item owner |

---

## UI Screens — What the System Looks Like

---

### Screen 1 — Coordinator Dashboard

```
╔══════════════════════════════════════════════════════════════════════╗
║  🏛 EQUITY DR PLATFORM              Q2 2026 Campaign  [+ New Campaign]║
╠══════════════════════════════════════════════════════════════════════╣
║  👋 Welcome, Coordinator                                  🔔 3 Alerts ║
╠════════════════════════╦═════════════════════╦═════════════════════  ╣
║  📊 CAMPAIGN PROGRESS  ║  ⏰ UPCOMING DRs    ║  🚨 UNRESOLVED BLOCKERS║
║                        ║                     ║                        ║
║  Total Apps: 43        ║  23 Apr — Efront    ║  WAY4 IP Config (15d) ║
║  ████████░░  74%       ║    Pre-DR: 🟡 60%   ║  SOA DB Creds (8d)    ║
║  Ready                 ║                     ║  Finacle TZ DBA (3d)  ║
║                        ║  15 May — Clear Vis ║                        ║
║  ✅ Done:       12     ║    Pre-DR: 🟢 90%   ║  [View All 7 →]       ║
║  🔄 In Progress: 8     ║                     ║                        ║
║  🔴 Blocked:     5     ║  16 May — Autobranch║  📋 OVERDUE ACTIONS   ║
║  ⚫ Pending:    18     ║    Pre-DR: 🔴 20%   ║  NOC TZ mon  NOC +12d ║
║                        ║                     ║  Update SOA  ITSCM +5d║
║  [View Full Campaign →]║  [Full Calendar →]  ║                        ║
╚════════════════════════╩═════════════════════╩════════════════════════╝
```

---

### Screen 2 — Pre-DR Readiness Grid (Coordinator View)

The coordinator sees ALL applications and ALL owners in one grid. Blockers from the previous DR cycle appear inline — colour-coded by age and severity.

```
╔══════════════════════════════════════════════════════════════════════════╗
║  📋 PRE-DR READINESS — Q2 2026             [Send All Reminders] [Export]║
╠══════════════════════════════════════════════════════════════════════════╣
║  Filter: [All Subsidiaries ▼]  [All Tiers ▼]  [Blocked Only □]          ║
╠════════════════════════╦══════════╦══════════╦══════════╦══════════════╣
║  Application           ║ Date     ║ Owner    ║ Checklist║ Blockers     ║
╠════════════════════════╬══════════╬══════════╬══════════╬══════════════╣
║  Efront                ║ 23 Apr   ║ Marion   ║ ████ 80% ║ 1 open       ║
║  ⚠ CARRIED Q1: WebLogic║          ║ Kinyanjui║ 🟡       ║ [View]       ║
║  console creds expired ║          ║          ║          ║              ║
╠════════════════════════╬══════════╬══════════╬══════════╬══════════════╣
║  Clear Vision          ║ 15 May   ║ Victor   ║ ████████ ║ 0 open       ║
║                        ║          ║ Kiplagat ║ 🟢 Ready ║              ║
╠════════════════════════╬══════════╬══════════╬══════════╬══════════════╣
║  Autobranch            ║ 16 May   ║ Annet    ║ ██░░░░░░ ║ 2 open       ║
║  🔴 DR DB not syncing  ║          ║ Ayuko    ║ 🔴 20%   ║ [View]       ║
║  since Q4 2025         ║          ║          ║ At Risk  ║ [Escalate]   ║
╠════════════════════════╬══════════╬══════════╬══════════╬══════════════╣
║  SOA                   ║ 14 Jun   ║ Faith    ║ ████░░░░ ║ 1 open       ║
║  ⚠ CARRIED Q1: DR DB   ║          ║ Githaiga ║ 🔴 45%   ║ [View]       ║
║  credentials expired   ║          ║          ║ Blocked  ║ [Escalate]   ║
╠════════════════════════╬══════════╬══════════╬══════════╬══════════════╣
║  K Printer (SWIFT)     ║ 13 Jun   ║ Richard  ║ ██████░░ ║ 0 open       ║
║                        ║          ║ Ndungu   ║ 🟡 70%   ║              ║
╚════════════════════════╩══════════╩══════════╩══════════╩══════════════╝
```

---

### Screen 3 — Application Owner: My Pre-DR Tasks

Each application owner sees only their own tasks. Unresolved blockers from the last DR cycle appear at the top as a prominent warning — the owner must acknowledge or resolve them.

```
╔══════════════════════════════════════════════════════════════════════════╗
║  📋 MY PRE-DR TASKS — Q2 2026        Welcome, Faith Githaiga (SOA Owner)║
╠══════════════════════════════════════════════════════════════════════════╣
║  Application: SOA              Scheduled DR: 14 Jun 2026 | 10:00 PM     ║
║  Activity Type: Full Failover  RTO Target: 30 minutes                   ║
╠══════════════════════════════════════════════════════════════════════════╣
║  ⚠️  CARRIED FORWARD FROM Q1 2026 — UNRESOLVED (87 days old)            ║
║  ┌──────────────────────────────────────────────────────────────────┐   ║
║  │ 🔴 DR Database credentials for SOA middleware expired            │   ║
║  │    Raised: 15 Jan 2026  |  Last Update: 2 Feb 2026 (no fix)     │   ║
║  │    "DBA team confirmed password rotation not applied to DR env"  │   ║
║  │    [Mark Resolved]  [Update Notes]  [Escalate to ITSCM]         │   ║
║  └──────────────────────────────────────────────────────────────────┘   ║
╠══════════════════════════════════════════════════════════════════════════╣
║  THIS CYCLE — Pre-DR Checklist (4 of 9 complete)     Due: 7 Jun 2026   ║
║                                                                          ║
║  ✅  1. Confirm DR server accessibility (10.1.38.65/66)  Done  23 May  ║
║  ✅  2. Backup current tnsnames.ora on DR servers         Done  24 May  ║
║  ✅  3. Verify Oracle DG replication status               Done  25 May  ║
║  ✅  4. Confirm SOA managed server startup sequence       Done  26 May  ║
║  🟡  5. Test DR DB connection from app servers            In Progress   ║
║  ⚫  6. Validate all service endpoints in DR config       Pending       ║
║  ⚫  7. Confirm WebLogic datasource failover config       Pending       ║
║  🔴  8. Resolve carried-forward: DB credential rotation   BLOCKED       ║
║         └─ [Add Update ▼]                                               ║
║  ⚫  9. Pre-DR sign-off submitted to ITSCM                Pending       ║
║                                                                          ║
║  [Submit Readiness Sign-off]                                             ║
╚══════════════════════════════════════════════════════════════════════════╝
```

---

### Screen 4 — War Room (Live Execution)

This is the digital command centre during a DR exercise. Every step is tracked in real-time. A countdown timer runs against the RTO. Issues are logged inline. All participants see updates instantly.

```
╔══════════════════════════════════════════════════════════════════════════╗
║  🚨 WAR ROOM — Finacle Core TZ — Full Failover   ⏱ 00:23:41 / 40:00   ║
║  Started: 22:00  |  Coordinator: Raymond  |  CR: CHG0033975  ████░░ 68%║
╠══════════════════════════════════════════════════════════════════════════╣
║  PHASE: ◉ PRE-CUTOVER  ◉ CUTOVER ►  ○ DR VALIDATION  ○ ROLLBACK       ║
╠════╦══════════════════════════════════════╦═════════╦════╦══════════════╣
║ #  ║ Task                                 ║ Owner   ║ ⏱  ║ Status       ║
╠════╬══════════════════════════════════════╬═════════╬════╬══════════════╣
║ 1  ║ ✅ Stop all services DC & DR          ║ Charles ║ 10m║ Done 22:10  ║
║    ║    WebLogic + finlistval + coresession║ /Edwin  ║    ║             ║
╠════╬══════════════════════════════════════╬═════════╬════╬══════════════╣
║ 2  ║ ✅ Database failover (DG switchover)  ║ Nathan  ║ 10m║ Done 22:20  ║
║    ║    dgmgrl switchover to ebkstdby      ║         ║    ║             ║
╠════╬══════════════════════════════════════╬═════════╬════╬══════════════╣
║ 3  ║ 🔄 Deploy DR config files (TNS/props)║ Charles ║ 10m║ IN PROGRESS ║
║    ║    Replacing tnsnames.ora on 65/66    ║ /Marion ║    ║ ██████░░░░  ║
╠════╬══════════════════════════════════════╬═════════╬════╬══════════════╣
║ 4  ║ ⏳ Update WebLogic datasources        ║ Charles ║  5m║ Pending     ║
╠════╬══════════════════════════════════════╬═════════╬════╬══════════════╣
║ 5  ║ ⏳ Restart all DR services            ║ Edwin   ║ 10m║ Pending     ║
╠════╬══════════════════════════════════════╬═════════╬════╬══════════════╣
║ 6  ║ ⏳ Validate Finacle login from DR     ║ Samuel  ║  5m║ Pending     ║
╠════╩══════════════════════════════════════╩═════════╩════╩══════════════╣
║  🚨 ACTIVE ISSUE                                                         ║
║  [HIGH] Step 3 — Treasury IP not updated — Charles investigating (22:23)║
║                                                                          ║
║  👥 ON CALL: Raymond ✓  Charles ✓  Edwin ✓  Nathan ✓  Marion ✓  Amos ✓║
║                                                                          ║
║  📝 Notes: [DB switchover clean. TNS backup restored ok.]               ║
║                                                                          ║
║  [🚨 Flag Issue]  [↩ Rollback]  [📸 Evidence]  [📤 Notify Team]        ║
╚══════════════════════════════════════════════════════════════════════════╝
```

---

### Screen 5 — Post-DR Outcome Board

After execution, each application owner submits their outcome. The coordinator adds comments. Unresolved issues are flagged for carry-forward to the next campaign.

```
╔══════════════════════════════════════════════════════════════════════════╗
║  📊 POST-DR OUTCOMES — Finacle TZ — 15 Mar 2026    [Generate Report 📄] ║
╠══════════════════════════════════════════════════════════════════════════╣
║  Overall: ✅ COMPLETED — Operating from DR  |  Actual RTO: 38 minutes  ║
╠══════════════════╦═══════════╦═══════════════════════════════╦══════════╣
║  Application     ║ Status    ║ App Owner Comment             ║ Coord.   ║
╠══════════════════╬═══════════╬═══════════════════════════════╬══════════╣
║  Finacle Core TZ ║ ✅ PASSED ║ "Core banking fully           ║ Confirmed║
║                  ║           ║  operational from DR."        ║          ║
╠══════════════════╬═══════════╬═══════════════════════════════╬══════════╣
║  Finacle Treasury║ ⚠ PARTIAL ║ "Login issue resolved after   ║ ⚠ Action:║
║                  ║           ║  IP correction. Rates slow."  ║ Automate ║
║                  ║           ║                               ║ IP update║
╠══════════════════╬═══════════╬═══════════════════════════════╬══════════╣
║  WAY4            ║ ⚠ PARTIAL ║ "RC 907 errors first 15 mins, ║ ⚠ Action:║
║                  ║           ║  then stabilized."            ║ Root cause║
╠══════════════════╬═══════════╬═══════════════════════════════╬══════════╣
║  DNB Credit Bur. ║ ❌ FAILED ║ "External provider down.      ║ Not DR-  ║
║  (External)      ║           ║  Confirmed 3rd party outage." ║ caused   ║
╠══════════════════╩═══════════╩═══════════════════════════════╩══════════╣
║  📋 ISSUES — 5 raised during this exercise                               ║
║                                                                          ║
║  [HIGH] Treasury IP Config incorrect       ⚠️  CARRY TO Q3 2026        ║
║    "IP not updated in startup config. Manual fix applied."               ║
║    Action: Automate IP update in failover script   Due: 30 Apr  [Assign]║
║                                                                          ║
║  [HIGH] DBA not present at start           ✅ RESOLVED                  ║
║    "Mandatory pre-call attendance sign-off form implemented."            ║
║                                                                          ║
║  [MED]  NOC TZ DR monitoring not visible   🔄 IN PROGRESS              ║
║    "Dashboard update in progress. ETA: 15 Apr 2026"                     ║
╚══════════════════════════════════════════════════════════════════════════╝
```

---

### Screen 6 — Runbook Builder

Runbooks are structured, versioned, and approved — not static Excel files. Each phase has sequential steps with exact commands, owner roles, estimated durations, and verification instructions.

```
╔══════════════════════════════════════════════════════════════════════════╗
║  📖 RUNBOOK — Finacle Core TZ  v2.1  |  CR: CHG0033975  |  APPROVED    ║
╠══════════════════════════════════════════════════════════════════════════╣
║  [Summary] [Pre-Cutover] [Cutover ►] [DR Validation] [Rollback]         ║
║  [Contacts] [Impacted Services]                                          ║
╠══════════════════════════════════════════════════════════════════════════╣
║  CUTOVER PHASE                              [+ Add Step]  [⬆ Reorder]  ║
║                                                                          ║
║  ┌────────────────────────────────────────────────────────────────────┐ ║
║  │ Step 1 · Stop all services (DC & DR)    ⏱ 10 min   🔴 Downtime   │ ║
║  │ Owner Role: App Engineer                                            │ ║
║  │                                                                     │ ║
║  │ 1. Stop managed servers — WebLogic console:                        │ ║
║  │    http://tzappj2ee1.tz.ebsafrica.com:8001/console                 │ ║
║  │                                                                     │ ║
║  │ 2. Stop finlistval on C++ servers (DC & DR):                       │ ║
║  │  ┌─────────────────────────────────────────────────────────────┐  │ ║
║  │  │ cd /finacle/EQTZPROD/Fin10218/APP/Finacle/FC/app/services/  │  │ ║
║  │  │ finlistval/bin && ./stop*                                    │  │ ║
║  │  └─────────────────────────────────────────────────────────────┘  │ ║
║  │                                                                     │ ║
║  │ 3. Stop coressession, cbc, uniser_55 (same pattern)               │ ║
║  │                                                                     │ ║
║  │ Verify: ps aux | grep finacle  (must show no running processes)    │ ║
║  │                                                                     │ ║
║  │ [✏ Edit]  [🗑 Delete]  [📋 Duplicate]                              │ ║
║  └────────────────────────────────────────────────────────────────────┘ ║
║                                                                          ║
║  ┌────────────────────────────────────────────────────────────────────┐ ║
║  │ Step 2 · Database Failover (Oracle DG Switchover)   ⏱ 10m  🔴    │ ║
║  │ Owner Role: DBA                                                     │ ║
║  │  dgmgrl → connect sys/<pw>@EQBLCDB                                 │ ║
║  │  DGMGRL> switchover to ebkstdby                                    │ ║
║  │  DGMGRL> show configuration (verify)                               │ ║
║  └────────────────────────────────────────────────────────────────────┘ ║
╚══════════════════════════════════════════════════════════════════════════╝
```

---

### Screen 7 — Management Dashboard

```
╔══════════════════════════════════════════════════════════════════════════╗
║  📈 MANAGEMENT VIEW — DR Programme        Year: 2026      [Export PDF]  ║
╠══════════════════════════════════════════════════════════════════════════╣
║  ┌─────────────┐  ┌──────────────┐  ┌──────────────┐  ┌─────────────┐ ║
║  │ T1 Coverage │  │ RTO Achieved │  │ Success Rate │  │ Open Actions│ ║
║  │  Q2 2026    │  │   Q2 2026    │  │   Q2 2026    │  │  All Cycles │ ║
║  │  ████████   │  │   ████████   │  │   ██████░░   │  │     12      │ ║
║  │    78%      │  │     82%      │  │     71%      │  │ 4 HIGH prio │ ║
║  └─────────────┘  └──────────────┘  └──────────────┘  └─────────────┘ ║
╠══════════════════════════════════════════════════════════════════════════╣
║  COVERAGE BY SUBSIDIARY (Q2 2026)      TOP RECURRING ISSUES             ║
║                                                                          ║
║  Tanzania    ████████████  100%  3/3   1. Manual config changes (8)    ║
║  Kenya       ██████████░░   80% 12/15  2. DBA/resource availability (6)║
║  Uganda      ████████░░░░   67%  4/6   3. External dependency failures  ║
║  Rwanda      ██████░░░░░░   50%  3/6   4. Post-failover IP errors (4)  ║
║  DRC         ████░░░░░░░░   33%  2/6   5. WAY4 RC 907 errors (3)      ║
║  South Sudan ██░░░░░░░░░░   20%  1/5                                    ║
╚══════════════════════════════════════════════════════════════════════════╝
```

---

## Runbook Enforcement Design

> The single biggest risk in DR coordination is an application owner who hasn't prepared their runbook on time. The platform enforces this through six layers — making preparation easy, visible, and unavoidable.

### Enforcement Timeline (Auto-Calculated from DR Date)

| Milestone | Trigger | Automated Action |
|---|---|---|
| **T-21 days** | Campaign created | Runbook review task opened for every app owner. Email sent: friendly reminder. Pre-populated from last approved runbook if it exists. |
| **T-14 days** | Deadline check | If not submitted: Email (urgent) to app owner + silent awareness email to coordinator. |
| **T-10 days** | Deadline check | If not submitted: Email + SMS to app owner + coordinator flagged. Peer reviewer reminded if review pending. |
| **T-7 days** | **HARD GATE** | If not approved: Campaign blocked from APPROVED state. Email + SMS to app owner, coordinator, and **app owner's line manager**. Campaign flagged AT RISK on all dashboards. |
| **T-3 days** | Deadline check | If not approved: Campaign status → CANNOT PROCEED. Coordinator must DEFER or log exception reason (audit-recorded). |
| **T-1 day** | **WAR ROOM GATE** | War Room launch button disabled. Cannot be bypassed without a documented exception. |

### Six Enforcement Layers

| Layer | Mechanism | Impact |
|---|---|---|
| **1. Auto-Timeline** | Deadlines calculated from DR date, visible from campaign creation | No surprises for app owners |
| **2. Progressive Notifications** | T-21 friendly → T-14 urgent → T-10 warning → T-7 manager escalation → T-3 critical | Pressure increases with time |
| **3. Hard Workflow Gates** | Campaign cannot reach APPROVED; War Room cannot launch without approved runbook | System enforces, not coordinator |
| **4. Smart UX** | Pre-population from last runbook (35 min review vs 3 hr write), quality validator, persistent in-app banner | Removes excuse of "it takes too long" |
| **5. Coordinator Dashboard** | Live runbook status grid for all campaign apps — one-click remind/escalate | Zero manual chasing |
| **6. Social Accountability** | Manager escalation at T-7, peer reviewer on hook, management dashboard shows readiness % | Most powerful — no one wants to be the blocker |

### Runbook Quality Gate (Before Submission)

Before an app owner can submit for peer review, the system validates:

```
✅  All phases present: Pre-Cutover, Cutover, DR Validation, Rollback
✅  Each phase has at least 1 step
✅  Each step has: description, owner role, estimated duration, verification criteria
✅  No empty command fields on steps marked as requiring commands
✅  Quality score ≥ 70/100

If score < 70: submission is blocked. App owner must fix issues first.
```

### Runbook States

```
NOT_STARTED → DRAFT → SUBMITTED_FOR_REVIEW → PEER_APPROVED → APPROVED & LOCKED
                   ↑___________________________|
                        (returned for revision)
                   ↑___________________________|
                        (returned by ITSCM)
```

Once APPROVED & LOCKED: no edits. New changes require a new version + full re-approval cycle.
War Room launch takes an immutable snapshot of the approved version.

---

## End-to-End Platform Flow — Three Real-World Examples

> Three scenarios demonstrate the complete platform lifecycle — from campaign creation to report generation — covering different dependency types and DR activity types.

---

### Overview: The Complete Platform Lifecycle

Every DR activity — regardless of complexity — follows this lifecycle:

```
PHASE 0 — CAMPAIGN SETUP
    Coordinator creates quarterly campaign
    Applications added + dependency scan run
    Activity type assigned per application
    Deadlines auto-calculated
          │
          ▼
PHASE 1 — RUNBOOK ENFORCEMENT (T-21 to T-7)
    App owners review/update runbooks
    Progressive reminders + hard gates
    Peer review + ITSCM approval
          │
          ▼
PHASE 2 — PRE-DR READINESS (T-14 to T-1)
    Per-app checklists auto-generated
    Carried-forward blockers surfaced
    App owners complete and sign off
          │
          ▼
PHASE 3 — CAMPAIGN APPROVAL (T-7)
    Coordinator reviews all runbooks + checklists
    Dependency conflicts resolved
    Campaign moves to APPROVED
          │
          ▼
PHASE 4 — WAR ROOM (DR Day)
    War Room launched — steps auto-loaded from approved runbook
    Real-time execution with RTO timer
    Issues logged inline
    Rollback available at any phase
          │
          ▼
PHASE 5 — POST-DR REVIEW (DR Day + 1 to +3)
    App owners submit outcomes + comments
    Coordinator reviews and adds notes
    Unresolved issues flagged for carry-forward
          │
          ▼
PHASE 6 — REPORT & CARRY-FORWARD
    Report auto-generated (Word + PDF)
    Unresolved issues auto-carry to next campaign
    Action items tracked to closure
```

---

### Example 1 — Clear Vision (No Dependencies, APP_ONLY Failover)

**Application Profile:**
```
Application:      Clear Vision
Tier:             T2
Owner:            Victor Kiplagat
Subsidiary:       Kenya (KE)
Dependencies:     NONE — fully standalone application
DR Activity:      APP_ONLY — DC App → DR App (database stays in DC)
RTO Target:       20 minutes
Runbook Version:  v1.4 (approved from Q1 2026)
```

**Why APP_ONLY?**
Clear Vision's database is too large for replication to DR and is not customer-critical enough to warrant full failover. The app is failed over to DR and reconfigured to still point to the DC database over the site-to-site WAN link. This tests the application's ability to run from DR infrastructure.

**Dependency Scan Result:**
```
╔══════════════════════════════════════════════╗
║  DEPENDENCY SCAN — Clear Vision              ║
║  ✅ No dependencies found.                   ║
║  This application can be scheduled and       ║
║  executed independently.                     ║
╚══════════════════════════════════════════════╝
```

No conflict warnings. No sequencing requirements. Simplest case.

---

**PHASE 0 — Campaign Setup**

```
ACTION: Coordinator creates Q2 2026 campaign
        Adds Clear Vision with activity type: APP_ONLY
        Sets DR date: 15 May 2026 22:00

SYSTEM AUTO-CALCULATES:
  Runbook submission deadline : 01 May 2026  (T-14)
  Peer review deadline        : 05 May 2026  (T-10)
  ITSCM approval deadline     : 08 May 2026  (T-7)
  Pre-DR checklist due        : 12 May 2026  (T-3)

NOTIFICATION SENT TO: Victor Kiplagat
  "Clear Vision has been added to Q2 2026 DR campaign.
   DR Date: 15 May 2026. Your runbook review is due by 01 May.
   We've pre-filled your runbook from Q1 2026 (v1.4).
   Estimated review time: ~35 minutes. [Start Review →]"
```

---

**PHASE 1 — Runbook Review (APP_ONLY type shapes the runbook)**

Because the activity type is APP_ONLY, the system guides Victor through the correct phases for this activity type:

```
RUNBOOK TEMPLATE — APP_ONLY
  Phase 1: PRE-CUTOVER
    [System suggests steps based on APP_ONLY type:]
    → Verify DR server accessibility (ping, SSH)
    → Confirm DR application binaries are deployed and up to date
    → Verify DR application config files are correct (endpoints, DB connection = DC DB)
    → Test DB connectivity from DR servers to DC database (WAN link)
    → Confirm load balancer/DNS DR entry exists
    → Confirm NOC has DR monitoring configured

  Phase 2: CUTOVER
    [System suggests steps:]
    → Gracefully stop DC application (drain active sessions)
    → Update load balancer to route traffic to DR app servers
    → Start application on DR servers
    → Verify application started without errors (check logs)

  Phase 3: DR VALIDATION
    [System suggests steps:]
    → Login test from DR URL
    → Functional smoke test (key transactions)
    → Confirm DB connection is still pointing to DC database (critical check)
    → Confirm no session data loss
    → NOC confirms DR monitoring active

  Phase 4: ROLLBACK
    [System suggests steps:]
    → Stop DR application
    → Update load balancer back to DC
    → Start DC application
    → Confirm all traffic back on DC
    → Notify stakeholders

NOTE: APP_ONLY runbooks do NOT include DBA steps.
      No Oracle DG switchover. No tnsnames.ora changes.
      This keeps the runbook lean and appropriate for the activity type.
```

Victor reviews the pre-populated runbook, updates DC/DR server IPs and paths specific to Clear Vision, and submits for peer review.

**Peer review → ITSCM approval → Runbook APPROVED v1.5**

---

**PHASE 2 — Pre-DR Checklist (Auto-Generated)**

The system auto-generates checklist items from the runbook's Pre-Cutover phase steps:

```
PRE-DR CHECKLIST — Clear Vision — Q2 2026      Due: 12 May

✅  1. Verify DR server accessibility (10.5.22.11/12)    Done  02 May
✅  2. Confirm DR binaries deployed (v4.2.1)             Done  03 May
✅  3. Verify DR config file (DB endpoint = DC prod)     Done  03 May
🟡  4. Test DB connectivity from DR to DC (WAN link)     In Progress
⚫  5. Confirm load balancer DR entry configured         Pending
⚫  6. NOC: confirm DR monitoring enabled for Clear Vision  Pending
⚫  7. Pre-DR sign-off submitted to ITSCM               Pending

No carried-forward blockers from Q1 2026. ✅
```

No blockers. Victor completes items progressively. At T-1, he submits sign-off.

---

**PHASE 3 — Campaign Approval**

```
CAMPAIGN APPROVAL CHECK — Clear Vision
  ✅ Approved runbook: v1.5
  ✅ Pre-DR checklist: 100% complete
  ✅ No unresolved blockers
  ✅ No dependency conflicts

  STATUS: READY ✅ — Campaign approved.
```

---

**PHASE 4 — War Room Execution (APP_ONLY)**

```
WAR ROOM — Clear Vision KE — APP_ONLY Failover
Started: 22:00  |  Coordinator: [Name]  |  RTO: 20 min
────────────────────────────────────────────────────────
PHASE: ◉ PRE-CUTOVER  ► CUTOVER  ○ VALIDATION  ○ ROLLBACK
────────────────────────────────────────────────────────
#   Task                                    Owner    ⏱   Status
────────────────────────────────────────────────────────
    ── PRE-CUTOVER ──
1   Verify DR server connectivity           Victor   2m  ✅ Done 22:02
2   Confirm application binaries on DR      Victor   3m  ✅ Done 22:05

    ── CUTOVER ──
3   Drain active sessions on DC app         Victor   3m  ✅ Done 22:10
4   Update load balancer → DR servers       NetOps   2m  ✅ Done 22:12
5   Start Clear Vision on DR servers        Victor   2m  ✅ Done 22:14

    ── DR VALIDATION ──
6   Login test from DR URL                  Victor   2m  ✅ Done 22:16
7   Functional smoke test                   Victor   3m  ✅ Done 22:19
8   Confirm DB still pointing to DC DB      Victor   1m  ✅ Done 22:20
9   NOC confirms DR monitoring live         NOC      2m  ✅ Done 22:22
────────────────────────────────────────────────────────
No issues raised.
Actual RTO: 22 minutes ✅ (Target: 20 min — 2 min over, acceptable)
[Close War Room]  [Generate Report]
```

Notice: No DBA steps. No Oracle DG. Lean and focused.

---

**PHASE 5 & 6 — Post-DR + Report**

```
POST-DR OUTCOME — Clear Vision
  Status:           ✅ PASSED
  Actual RTO:       22 minutes (Target: 20 min)
  Issues raised:    0

  Victor's comment: "Application fully operational from DR. DB
                     connectivity over WAN was stable throughout.
                     Minor: 2 minutes over RTO due to load balancer
                     cache delay. Will pre-flush cache next cycle."

  Action created:   Pre-flush LB cache as part of pre-cutover steps
  Carry-forward:    None

  Report: Auto-generated ✅
```

---

### Example 2 — Efront (Direct Database Dependency, FULL_FAILOVER)

**Application Profile:**
```
Application:      Efront (Investment & Portfolio Management)
Tier:             T1
Owner:            Marion Kinyanjui
Subsidiary:       Kenya (KE)
Dependencies:     → Efront_DB (Oracle 19c — dedicated, not shared)
                  → SOA Middleware (for transaction routing)
DR Activity:      FULL_FAILOVER — DC App + DC DB → DR App + DR DB
RTO Target:       40 minutes
DBA Required:     YES (Oracle DG switchover)
```

**Why FULL_FAILOVER?**
Efront manages investment portfolios. Running it against the DC database from DR risks data inconsistency if the WAN link degrades. Both app and database must fail over together.

**Dependency Scan Result:**
```
╔══════════════════════════════════════════════════════════════════╗
║  DEPENDENCY SCAN — Efront                                        ║
║                                                                  ║
║  DEPENDENCY 1: Efront_DB (Oracle 19c)                           ║
║    Type: DATABASE (dedicated — not shared with other apps) ✅    ║
║    DR Sync Status: ✅ Oracle DG active, lag < 2 min              ║
║    DBA Required: YES — Oracle DG switchover                      ║
║    ⚠ Action: Ensure DBA is on call for this DR window            ║
║                                                                  ║
║  DEPENDENCY 2: SOA Middleware                                    ║
║    Type: MIDDLEWARE (integration dependency)                     ║
║    SOA in this campaign: YES ✅                                  ║
║    ⚠ SEQUENCING ADVISORY: Efront depends on SOA.                ║
║      Recommended: run SOA DR before or concurrent with Efront.  ║
║      If SOA fails over after Efront, transaction routing        ║
║      may be disrupted for up to 15 minutes.                     ║
║                                                                  ║
║  Recommended DR order: SOA → then Efront (or concurrent)        ║
╚══════════════════════════════════════════════════════════════════╝
```

The system does not BLOCK — it advises. Coordinator decides the sequencing.

---

**PHASE 0 — Campaign Setup**

```
ACTION: Efront added to Q2 2026 campaign
        Activity type: FULL_FAILOVER
        System detects SOA dependency
        Coordinator sequences: SOA at 20:00, Efront at 22:00 (same night)

NOTIFICATIONS SENT:
  → Marion Kinyanjui (Efront owner): Runbook review due T-14
  → Pre-populated from Q1 approved runbook v2.0
  → DBA team notified: "DBA required for Efront DR on 23 Apr 2026 at 22:00"
```

---

**PHASE 1 — Runbook (FULL_FAILOVER shapes the runbook)**

Because activity type is FULL_FAILOVER, the system adds DB-specific phases and suggests DBA steps:

```
RUNBOOK TEMPLATE — FULL_FAILOVER
  Phase 1: PRE-CUTOVER
    → Verify Oracle DG sync status (DBA) — lag must be < 5 min before proceeding
    → Verify DR application servers (App Engineer)
    → Verify DR config files — all connection strings ready
    → Verify SOA DR endpoint is reachable from DR app servers
    → DBA: confirm DR standby database is in MOUNT/OPEN READ-ONLY state
    → NOC: pre-position for DR monitoring switch

  Phase 2: CUTOVER
    → Stop all Efront application services DC (App Engineer)
    → Stop all Efront application services DR (App Engineer)
    → DBA: execute Oracle DG switchover:
        dgmgrl> connect sys/<pw>@EFRONT_PRIMARY
        dgmgrl> switchover to efront_standby
        dgmgrl> show configuration  (verify success)
    → DBA: verify new primary is open READ WRITE
    → Update tnsnames.ora on DR app servers (App Engineer)
    → Update WebLogic datasource to point to new primary DB (App Engineer)
    → Update SOA endpoint in Efront config to DR SOA URL (App Engineer)
    → Start Efront application services on DR (App Engineer)

  Phase 3: DR VALIDATION
    → Login test from DR URL
    → Create a test portfolio transaction (functional test)
    → Verify transaction reached DB (DBA checks)
    → Verify SOA transaction routing from DR Efront
    → Confirm Oracle DG reverse sync running (old primary now standby)
    → NOC confirms DR monitoring active

  Phase 4: ROLLBACK
    → Stop DR application services
    → DBA: switchover back to original primary
    → Revert tnsnames.ora to DC config
    → Revert WebLogic datasource to DC DB
    → Start DC application
    → Confirm DC is operational
```

**Key difference from APP_ONLY:** DBA is a named participant. Oracle DG steps are explicit. Rollback includes DB switchback.

Marion also has a **CARRIED-FORWARD blocker** from Q1 2026:

```
⚠ CARRIED FORWARD FROM Q1 2026 (87 days old)
┌─────────────────────────────────────────────────────┐
│ WebLogic console credentials expired on DR server   │
│ Raised: 15 Jan 2026 | Last update: 2 Feb (no fix)   │
│ "Credentials rotation not applied to DR WebLogic"   │
│ [Mark Resolved] [Update Notes] [Escalate to ITSCM]  │
└─────────────────────────────────────────────────────┘
Marion must acknowledge this before checklist can be signed off.
```

---

**PHASE 4 — War Room Execution (FULL_FAILOVER)**

```
WAR ROOM — Efront KE — FULL_FAILOVER
Started: 22:00  |  RTO: 40 min  |  DBA: Nathan  |  App: Marion
────────────────────────────────────────────────────────────
#   Task                                    Owner       ⏱   Status
────────────────────────────────────────────────────────────
    ── PRE-CUTOVER ──
1   Verify Oracle DG sync lag < 5 min       Nathan      5m  ✅ Done 22:05
    Result: lag = 45 seconds ✅
2   Verify DR app servers accessible        Marion      3m  ✅ Done 22:08
3   Verify DR config files ready            Marion      2m  ✅ Done 22:10
4   Confirm SOA DR endpoint reachable       Marion      2m  ✅ Done 22:12

    ── CUTOVER ──
5   Stop Efront services on DC              Marion      3m  ✅ Done 22:15
6   Stop Efront services on DR              Marion      2m  ✅ Done 22:17
7   Oracle DG switchover                    Nathan     10m  ✅ Done 22:27
    dgmgrl> switchover to efront_standby
    Configuration: SUCCESS ✅
8   Update tnsnames.ora on DR servers       Marion      3m  ✅ Done 22:30
9   Update WebLogic datasource → new DB     Marion      3m  ✅ Done 22:33
10  Update SOA endpoint → DR SOA URL        Marion      2m  🔄 In Progress
11  Start Efront on DR servers              Marion      5m  ⏳ Pending

    ── DR VALIDATION ──
12  Login test from DR URL                  Marion      2m  ⏳ Pending
13  Portfolio transaction test              Marion      3m  ⏳ Pending
14  DBA verifies transaction in DB          Nathan      2m  ⏳ Pending
15  Verify Oracle DG reverse sync           Nathan      3m  ⏳ Pending
────────────────────────────────────────────────────────────
⏱ 00:33:00 elapsed / 40:00 RTO  |  Progress: 67%  |  🟡 On track
No active issues.
ON CALL: Coordinator ✓  Marion ✓  Nathan ✓  NetOps ✓
```

**Actual RTO: 38 minutes** — just within the 40-minute target.

---

**PHASE 5 & 6 — Post-DR + Carry-Forward**

```
POST-DR OUTCOME — Efront
  Status:           ✅ PASSED
  Actual RTO:       38 minutes (Target: 40 min) ✅

  Marion's comment: "Full failover successful. DG switchover was clean.
                     WebLogic console creds issue from Q1 was resolved
                     (credentials rotated on 10 Apr). SOA DR integration
                     confirmed working. One minor: step 10 took 4 min
                     instead of 2 — SOA endpoint URL had changed.
                     Will update runbook."

  Actions created:
    → Update SOA DR endpoint in runbook (Marion, due 30 Apr)
    → Add SOA endpoint verification to Pre-Cutover checklist

  Carry-forward:    None — Q1 blocker RESOLVED ✅
```

---

### Example 3 — Finacle Core + Finacle Treasury (Shared Database Dependency, FULL_FAILOVER)

**Application Profiles:**
```
Application 1:    Finacle Core TZ (Core Banking)
Tier:             T1
Owner:            Charles Mwangi
Subsidiary:       Tanzania (TZ)

Application 2:    Finacle Treasury TZ (Treasury Management)
Tier:             T1
Owner:            Edwin Kamau
Subsidiary:       Tanzania (TZ)

SHARED DEPENDENCY: Oracle Database EQBLCDB (Oracle 19c RAC)
                   Both apps read/write to the SAME database

DR Activity:      FULL_FAILOVER for both (must be coordinated)
RTO Target:       40 minutes (both apps must be operational within 40 min)
DBA Required:     YES — ONE Oracle DG switchover affects BOTH apps
```

**This is the most complex scenario.** Two Tier-1 applications sharing a database. You cannot fail over one without the other being disrupted.

---

**PHASE 0 — Dependency Scan (Critical Warning)**

```
╔══════════════════════════════════════════════════════════════════════╗
║  DEPENDENCY SCAN — Q2 2026 Campaign — TZ Applications               ║
╠══════════════════════════════════════════════════════════════════════╣
║                                                                      ║
║  🚨 SHARED DEPENDENCY DETECTED                                       ║
║                                                                      ║
║  Finacle Core TZ  ──────┐                                           ║
║                          ├──► EQBLCDB (Oracle 19c RAC)              ║
║  Finacle Treasury TZ ───┘    ← SHARED BY BOTH APPLICATIONS          ║
║                                                                      ║
║  RISK: If these applications are scheduled in separate War Room      ║
║  sessions, a DB failover for one will break the other.              ║
║                                                                      ║
║  PLATFORM RECOMMENDATION:                                            ║
║  ✅  Option A (Recommended): Group both apps in ONE War Room session ║
║      One DG switchover. Both apps failed over together.             ║
║      Coordinator runs one coordinated exercise.                     ║
║                                                                      ║
║  ⚠️   Option B (Advanced): Sequential — Core first, then Treasury    ║
║      Core completely failed over, then Treasury uses new primary.   ║
║      Risk: Treasury is down for ~20 min longer than Core.           ║
║                                                                      ║
║  ❌  Option C (Blocked): Separate War Rooms with separate DG         ║
║      switchovers. SYSTEM WILL NOT ALLOW — one DB cannot switch      ║
║      twice. This would cause data corruption risk.                  ║
║                                                                      ║
║  Coordinator selects: [Option A — Group in ONE War Room ✅]          ║
╚══════════════════════════════════════════════════════════════════════╝
```

This is the dependency engine's most important job — preventing dangerous conflicts.

---

**PHASE 1 — Runbooks (Two Separate Runbooks, One Shared Step)**

Both Charles and Finacle Core, and Edwin for Finacle Treasury, each have their OWN runbook. However, the system recognises the shared DB step and marks it as a SHARED STEP:

```
RUNBOOK — Finacle Core TZ
  Pre-Cutover:   (Core-specific steps)
  Cutover:
    Step 1: Stop all Finacle Core services (Charles)
    Step 2: [SHARED STEP] Oracle DG switchover EQBLCDB (DBA Nathan)
            ← This step also appears in Finacle Treasury's runbook
            ← Only ONE person executes it, but both apps see it
    Step 3: Update Core tnsnames.ora + WebLogic (Charles)
    Step 4: Start Finacle Core on DR (Charles)
  Validation:    (Core-specific tests)
  Rollback:      (Core-specific + shared DB switchback)

RUNBOOK — Finacle Treasury TZ
  Pre-Cutover:   (Treasury-specific steps)
  Cutover:
    Step 1: Stop all Treasury services (Edwin)
    Step 2: [SHARED STEP — WAIT] Oracle DG switchover EQBLCDB (DBA Nathan)
            ← Waits for Core's Step 2 to complete. SAME action.
            ← Treasury's Step 2 is locked until Core's DG step is DONE
    Step 3: Update Treasury tnsnames.ora + WebLogic (Edwin)
    Step 4: Start Treasury on DR (Edwin)
  Validation:    (Treasury-specific tests)
  Rollback:      (Treasury-specific + shared DB switchback)
```

**The shared step design principle:** The DBA does the Oracle DG switchover ONCE. Both runbooks reference the same step. The second runbook's shared step is in WAITING state until the first completes it.

---

**PHASE 2 — Pre-DR Checklist — Two Owners, Coordinated**

```
PRE-DR READINESS SUMMARY — Finacle TZ Group (Core + Treasury)
Coordinator can see both apps together because they share a DB group:
─────────────────────────────────────────────────────────────────
Application         Owner    Checklist   Blockers   DB Sync
─────────────────────────────────────────────────────────────────
Finacle Core TZ     Charles  ████ 85%    0 open     EQBLCDB ✅
Finacle Treasury    Edwin    ████ 90%    1 open ⚠️  EQBLCDB ✅
─────────────────────────────────────────────────────────────────
⚠ CARRIED FORWARD — Edwin: "Treasury IP config not automated (87 days)"
  Owner must resolve before sign-off is accepted.

SHARED DB STATUS (live):
  EQBLCDB — Oracle DG sync lag: 1m 23s ✅
  DR standby: MOUNT state ✅ (ready for switchover)
  DBA confirmed on call: Nathan Mwenda ✅
```

---

**PHASE 4 — War Room Execution (Shared Dependency Group)**

This is a SINGLE War Room session with BOTH applications shown:

```
╔═══════════════════════════════════════════════════════════════════════╗
║  WAR ROOM — Finacle TZ Group (Core + Treasury) — FULL_FAILOVER       ║
║  Started: 22:00  |  Coordinator: Raymond  |  RTO: 40 min  |  CR: CHG0033975
║  ⏱ 00:27:14 / 40:00  ████████████░░░░ 68%                            ║
╠═════════════════════════════════════════════════════════════════════╣
║  PHASE: ◉ PRE-CUTOVER  ◉ CUTOVER ►  ○ VALIDATION  ○ ROLLBACK       ║
╠═══╦═══════════════════════════════════╦══════════╦════╦═════════════╣
║ # ║ Task                              ║ Owner    ║ ⏱  ║ Status       ║
╠═══╬═══════════════════════════════════╬══════════╬════╬═════════════╣
║   ║ ── FINACLE CORE (Pre-Cutover) ──  ║          ║    ║             ║
║ 1 ║ Verify Core services on DC        ║ Charles  ║ 3m ║ ✅ 22:05    ║
║ 2 ║ Verify DR Core servers            ║ Charles  ║ 3m ║ ✅ 22:08    ║
╠═══╬═══════════════════════════════════╬══════════╬════╬═════════════╣
║   ║ ── FINACLE TREASURY (Pre-Cutover)─║          ║    ║             ║
║ 3 ║ Verify Treasury services on DC    ║ Edwin    ║ 3m ║ ✅ 22:06    ║
║ 4 ║ Verify DR Treasury servers        ║ Edwin    ║ 3m ║ ✅ 22:09    ║
╠═══╬═══════════════════════════════════╬══════════╬════╬═════════════╣
║   ║ ── CUTOVER (BOTH APPS) ──         ║          ║    ║             ║
║ 5 ║ Stop ALL Finacle Core services DC ║ Charles  ║ 5m ║ ✅ 22:15    ║
║ 6 ║ Stop ALL Treasury services DC     ║ Edwin    ║ 5m ║ ✅ 22:16    ║
║   ║ ← Both stopped before DG switch   ║          ║    ║             ║
╠═══╬═══════════════════════════════════╬══════════╬════╬═════════════╣
║ 7 ║ 🔗 SHARED: Oracle DG Switchover   ║ Nathan   ║10m ║ ✅ 22:26    ║
║   ║  EQBLCDB → DR standby            ║  (DBA)   ║    ║             ║
║   ║  dgmgrl> switchover to ebkstdby  ║          ║    ║             ║
║   ║  ← Affects BOTH Core & Treasury  ║          ║    ║             ║
╠═══╬═══════════════════════════════════╬══════════╬════╬═════════════╣
║ 8 ║ Update Core tnsnames.ora + WL     ║ Charles  ║ 5m ║ 🔄 In Prog  ║
║ 9 ║ Update Treasury tnsnames.ora + WL ║ Edwin    ║ 5m ║ 🔄 In Prog  ║
║   ║ ← Steps 8 & 9 run in parallel    ║          ║    ║             ║
╠═══╬═══════════════════════════════════╬══════════╬════╬═════════════╣
║10 ║ Start Finacle Core on DR          ║ Charles  ║ 5m ║ ⏳ Pending  ║
║11 ║ Start Treasury on DR              ║ Edwin    ║ 5m ║ ⏳ Pending  ║
╠═══╬═══════════════════════════════════╬══════════╬════╬═════════════╣
║   ║ ── DR VALIDATION ──               ║          ║    ║             ║
║12 ║ Core: Login + transaction test    ║ Charles  ║ 5m ║ ⏳ Pending  ║
║13 ║ Treasury: Login + rates test      ║ Edwin    ║ 5m ║ ⏳ Pending  ║
║14 ║ Cross-app test: Treasury → Core   ║ Both     ║ 3m ║ ⏳ Pending  ║
║   ║ (Treasury posting to Core ledger) ║          ║    ║             ║
║15 ║ Nathan: DG reverse sync running?  ║ Nathan   ║ 2m ║ ⏳ Pending  ║
╠═══╩═══════════════════════════════════╩══════════╩════╩═════════════╣
║  🚨 ACTIVE ISSUE                                                     ║
║  [HIGH] Step 11 — Treasury IP config still manual — Edwin on it     ║
║  (Carried-forward issue — not yet automated)                        ║
║                                                                      ║
║  ON CALL: Raymond ✓  Charles ✓  Edwin ✓  Nathan ✓  Marion ✓        ║
╚══════════════════════════════════════════════════════════════════════╝
```

**Key design elements in this War Room:**
- Both applications shown in ONE session — coordinator sees everything
- Shared DG step is ONE step, owned by Nathan, referenced by both
- Steps 8 & 9 run in parallel (system allows this — independent steps)
- Steps 5 and 6 must BOTH complete before Step 7 can start (system enforces ordering)
- The cross-app validation test (Step 14) confirms the shared DB integration works end-to-end

---

**PHASE 5 & 6 — Post-DR + Carry-Forward (Shared Group)**

```
POST-DR OUTCOMES — Finacle TZ Group

Finacle Core TZ:
  Status:  ✅ PASSED  |  RTO contribution: 38 min
  Charles: "Core banking operational from DR. DG switchover clean.
            TNS update took longer than estimated — manual process."
  Action:  Automate TNS update (carry to Q3) — assigned to Charles

Finacle Treasury TZ:
  Status:  ⚠ PARTIAL  |  RTO: 38 min (within target, but IP issue)
  Edwin:   "Treasury operational but IP config required manual
            intervention — same issue as Q1 2026. Now 2 quarters
            unresolved. Escalating to DevOps for automation."
  Issue:   [HIGH] Treasury IP not automated — CARRY FORWARD TO Q3 2026
  Action:  Automate IP update script — DevOps team — due 15 May 2026

SHARED DEPENDENCY OUTCOME:
  EQBLCDB DG switchover: ✅ SUCCESS
  DG reverse sync (DC now standby): ✅ Confirmed
  Both apps served from same new primary: ✅ Confirmed
  Cross-app Treasury → Core transaction: ✅ Verified

CARRY-FORWARD TO Q3 2026:
  Both app owners will see this on their Q3 Pre-DR checklist:
  "⚠ CARRIED FORWARD (87+ days) — Treasury IP config not automated"
  Edwin must acknowledge or resolve before Q3 campaign is approved.
```

---

### Comparison: The Three Scenarios

| Factor | Clear Vision (No Dep) | Efront (Direct Dep) | Finacle TZ (Shared Dep) |
|---|---|---|---|
| **Activity Type** | APP_ONLY | FULL_FAILOVER | FULL_FAILOVER (grouped) |
| **Dependency scan** | No warnings | Advisory: sequence SOA first | Conflict: must group in one War Room |
| **DBA required** | No | Yes (own DB) | Yes (shared DB — one switchover for both) |
| **Runbook complexity** | Simple (4 phases, ~15 steps) | Medium (4 phases, ~20 steps) | High (4 phases, ~30 steps across 2 apps) |
| **War Room sessions** | 1 session, 1 app | 1 session, 1 app + SOA | 1 session, 2 apps together |
| **Shared steps** | None | None | 1 shared DG step (affects both) |
| **RTO risk** | Low | Medium | High (if one app delayed, both delayed) |
| **Carry-forward risk** | Low | Medium (SOA endpoint) | High (Treasury IP ongoing) |
| **Report sections** | Single app | Single app + dependency note | Group report covering both apps |

---

### Dependency Engine — How It Decides

The dependency engine runs automatically when an application is added to a campaign. Here is its decision logic:

```
FOR EACH app added to campaign:
  1. Fetch all registered dependencies from dependency table
  2. Check: Is this dependency (DB/middleware) used by any OTHER app in this campaign?

     IF no → no warning needed (independent scheduling)

     IF yes → classify the conflict:

       SAME dependency type + BOTH apps doing FULL_FAILOVER
         → SHARED DEPENDENCY CONFLICT
         → Recommend grouping in one War Room
         → Block separate DG switchovers

       INTEGRATION dependency (App A calls App B's API/service)
         → SEQUENCING ADVISORY
         → Recommend running App B's DR first
         → System suggests scheduling gap (e.g., 2 hours between)

       NETWORK/DNS dependency
         → INFORMATIONAL NOTICE
         → NetOps team notified
         → No forced grouping

  3. Present findings to coordinator before campaign is approved
  4. Coordinator makes final decision — system records the decision + rationale
  5. Decision and rationale visible in audit log and final report
```

This engine is why the platform fundamentally changes DR coordination — dependency conflicts that were previously discovered at 11 PM on DR night are now caught and resolved weeks in advance.

---


## Phased Roadmap

---

### 🏗 Phase 1 — Foundation (Weeks 1–6)
**Goal:** Replace the Excel tracker entirely. Establish the single source of truth for all 100+ applications, their dependencies, and quarterly DR campaigns. By end of Week 6, the coordinator can run an entire pre-DR planning cycle without touching Excel.

---

#### Week 1 — Project Scaffold, Authentication & Audit Foundation ✅ Complete (2026-04-01)

**What Gets Built:** The skeleton of the entire platform. Authentication via Email OTP (SIT environment — LDAP/AD deferred until AD connectivity available), JWT session management with `jti`-based session correlation, role-based access control, UUID v7 primary keys, and an immutable audit log that records every action from day one. Session correlation threads `session_id` (UUID v7) from `OTP_REQUESTED` through `OTP_VERIFIED` and `USER_LOGOUT` so every audit row in a session is traceable to a single key.

> **SIT Note:** LDAP authentication is replaced by Email OTP for the SIT/development environment. The auth flow, JWT issuance, audit coverage, and session correlation are identical to what LDAP will use in production — only the credential-verification step differs. LDAP integration will be dropped in as a swap on `AuthService` without touching any other layer.

##### Backend — Java / Spring Boot

**Entities:**
```java
// users table
@Entity @Table(name = "users")
public class UserEntity {
    @Id UUID id;
    String ldapDn;           // e.g. CN=charles.mwangi,OU=IT,DC=equitybank,DC=com
    String email;            // unique
    String displayName;
    @Enumerated UserRole role; // SUPER_ADMIN | COORDINATOR | GROUP_COORDINATOR |
                               // APP_OWNER | DR_PARTICIPANT | MANAGEMENT | AUDITOR | EXTERNAL_PARTICIPANT
    String subsidiaryId;     // KE | TZ | UG | RW | DRC | SS | GROUP
    String lineManagerEmail; // used for T-7 escalation
    boolean isActive;
    Instant lastLogin;
    Instant createdAt;
}

// refresh_tokens table
@Entity @Table(name = "refresh_tokens")
public class RefreshTokenEntity {
    @Id UUID id;
    UUID userId;
    String tokenHash;        // SHA-256 of the actual token — never store raw
    Instant expiresAt;       // 8 hours
    boolean revoked;
    String deviceInfo;
}

// audit_log table — WRITE ONLY — no UPDATE or DELETE ever granted
@Entity @Table(name = "audit_log")
public class AuditLogEntity {
    @Id UUID id;
    UUID actorId;
    String actorIp;
    String actorRole;
    String action;           // e.g. WAR_ROOM_STEP_COMPLETED, RUNBOOK_APPROVED
    String resourceType;     // e.g. runbook_step, campaign
    UUID resourceId;
    UUID campaignId;
    String subsidiaryId;
    @Column(columnDefinition = "jsonb") String beforeState;
    @Column(columnDefinition = "jsonb") String afterState;
    String sessionId;
    String userAgent;
    Instant timestamp;       // NOT NULL — always recorded
}
```

**Configuration Classes:**
```java
@Configuration @EnableWebSecurity
public class SecurityConfig {
    // - Configure LDAP authentication provider
    // - Configure JWT filter chain
    // - Enforce HTTPS only
    // - Set CORS allowlist (internal domains only)
    // - Configure CSRF (disabled for stateless API, CSRF token for UI)
    // - Set security headers: HSTS, X-Frame-Options, CSP, X-Content-Type-Options
    // - Configure session: STATELESS (JWT only)
    // - Endpoint rules: /api/auth/** = permit, everything else = authenticated
}

public class JwtAuthFilter extends OncePerRequestFilter {
    // - Extract Bearer token from Authorization header
    // - Validate signature and expiry via JwtService
    // - Load user details and set SecurityContextHolder
    // - On failure: return 401 (never expose reason in response)
}

public class LdapAuthProvider implements AuthenticationProvider {
    // - Bind to Equity Bank LDAP with provided credentials
    // - Load user groups/roles from AD
    // - Map AD groups to platform roles
    // - Return authenticated token
}

@Aspect @Component
public class AuditLogAspect {
    // - @Around("@annotation(Auditable)")
    // - Captures: actor from SecurityContext, before/after state as JSON
    // - Writes to audit_log table via direct JDBC (bypasses JPA to avoid interception)
    // - Never throws — audit failure must not block the actual operation
}
```

**Services:**
- `AuthService`: `login(email, password)` → triggers LDAP bind + MFA challenge, `verifyMfa(userId, totpCode)` → validates TOTP, issues JWT pair, `refreshToken(token)` → rotate refresh token, `logout(sessionId)` → revoke refresh token, `lockAccount(userId)` → after 5 failures
- `JwtService`: `generateAccessToken(user)` → 15-min expiry, `generateRefreshToken(user)` → 8-hr expiry + rotate on use, `validateToken(token)` → signature + expiry + revocation check, `extractClaims(token)`
- `UserService`: `createUser(dto)`, `updateRole(userId, role)`, `deactivateUser(userId)`, `getUserByEmail(email)`, `syncFromLdap(ldapDn)` — pulls latest display name and manager from AD

**Repositories:**
```java
public interface UserRepository extends JpaRepository<UserEntity, UUID> {
    Optional<UserEntity> findByEmail(String email);
    Optional<UserEntity> findByLdapDn(String ldapDn);
    List<UserEntity> findBySubsidiaryIdAndRole(String subsidiaryId, UserRole role);
}

public interface AuditLogRepository extends JpaRepository<AuditLogEntity, UUID> {
    // Read-only queries only — no save/delete exposed
    Page<AuditLogEntity> findByActorIdOrderByTimestampDesc(UUID actorId, Pageable p);
    Page<AuditLogEntity> findByCampaignIdOrderByTimestampDesc(UUID campaignId, Pageable p);
    Page<AuditLogEntity> findByResourceTypeAndResourceId(String type, UUID id, Pageable p);
}
```

**Controllers:**
```
POST   /api/auth/login              → AuthController.login()
POST   /api/auth/mfa/verify         → AuthController.verifyMfa()
POST   /api/auth/refresh            → AuthController.refresh()
POST   /api/auth/logout             → AuthController.logout()
GET    /api/auth/me                 → AuthController.getCurrentUser()
GET    /api/users                   → UserController.listUsers()          [SUPER_ADMIN]
POST   /api/users                   → UserController.createUser()         [SUPER_ADMIN]
PATCH  /api/users/{id}/role         → UserController.updateRole()         [SUPER_ADMIN]
DELETE /api/users/{id}              → UserController.deactivateUser()     [SUPER_ADMIN]
GET    /api/audit-log               → AuditLogController.getAuditLog()   [AUDITOR, SUPER_ADMIN]
```

##### Database — New Tables This Week
```sql
CREATE TABLE users (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ldap_dn             VARCHAR(500),
    email               VARCHAR(200) UNIQUE NOT NULL,
    display_name        VARCHAR(200) NOT NULL,
    role                VARCHAR(50) NOT NULL,
    subsidiary_id       VARCHAR(10) NOT NULL,
    line_manager_email  VARCHAR(200),
    is_active           BOOLEAN DEFAULT true,
    last_login          TIMESTAMPTZ,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE refresh_tokens (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash   VARCHAR(64) NOT NULL,
    expires_at   TIMESTAMPTZ NOT NULL,
    revoked      BOOLEAN DEFAULT false,
    device_info  TEXT,
    created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- CRITICAL: GRANT INSERT, SELECT ONLY — no UPDATE, no DELETE
CREATE TABLE audit_log (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    actor_id         UUID,
    actor_ip         VARCHAR(45),
    actor_role       VARCHAR(50),
    action           VARCHAR(100) NOT NULL,
    resource_type    VARCHAR(100),
    resource_id      UUID,
    campaign_id      UUID,
    subsidiary_id    VARCHAR(10),
    before_state     JSONB,
    after_state      JSONB,
    session_id       VARCHAR(100),
    user_agent       TEXT,
    timestamp        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_audit_log_actor    ON audit_log(actor_id, timestamp DESC);
CREATE INDEX idx_audit_log_campaign ON audit_log(campaign_id, timestamp DESC);
CREATE INDEX idx_audit_log_resource ON audit_log(resource_type, resource_id);
```

##### Frontend — React / TypeScript
- `LoginPage.tsx` — LDAP credentials form, error handling, redirect to MFA
- `MfaPage.tsx` — TOTP code entry (6-digit), resend, timeout countdown
- `AuthContext.tsx` — JWT storage in memory (not localStorage), auto-refresh 1 min before expiry, logout on 401
- `ProtectedRoute.tsx` — checks role against allowed roles, redirects to `/unauthorized`
- `AppLayout.tsx` — sidebar navigation (role-aware menu items), header with user avatar + notification bell, subsidiary badge
- `UnauthorizedPage.tsx` — clear message, back button

##### End of Week 1 — What Works ✅ (Actual — SIT Environment)
- **Email OTP login** — user requests OTP to their registered email, enters the code, receives JWT access + refresh token pair
- **Session correlation** — every login session gets a UUID v7 `session_id`; the same ID appears on `OTP_REQUESTED`, `OTP_VERIFIED`, and `USER_LOGOUT` audit rows, and in the JWT `jti` claim
- **JWT authentication** — `JwtAuthFilter` validates Bearer tokens on all protected endpoints; stamps `AuditContext` with `session_id` and `actor_email` before the request reaches any controller
- **Role-based access control** — `SUPER_ADMIN`, `COORDINATOR`, `GROUP_COORDINATOR`, `APP_OWNER`, `DR_PARTICIPANT`, `MANAGEMENT`, `AUDITOR`, `EXTERNAL_PARTICIPANT` roles enforced via Spring Security
- **Immutable audit log** — `@Auditable` on any service method auto-captures `actor_id`, `actor_email`, `actor_ip`, `actor_role`, `session_id`, `before_state`, `after_state` — written in its own transaction so audit never blocks the business operation
- **UUID v7 primary keys** — all tables use time-ordered UUIDs (timestamp-sortable, index-friendly)
- **Database views** — `v_user_activity` (per-event with actor name) and `v_session_summary` (per-session timeline with action sequence, login/logout flags, duration)
- **Seeded test users** — admin, coordinator, app_owner, auditor accounts ready in SIT
- **Super Admin** can create and manage user accounts via `/api/users`
- **Token refresh and logout** fully audit-logged with correct session correlation

---

#### Week 2 — Application Registry

**What Gets Built:** The master catalog of all 100+ Equity Bank Group applications. Bulk import from the current Excel tracker. Application owners assigned. Tier, DR capability, subsidiaries, and server details captured.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "applications")
public class ApplicationEntity {
    @Id UUID id;
    String code;             // unique short code e.g. FINACLE_CORE_TZ
    String name;             // e.g. Finacle Core Tanzania
    String tier;             // T1 | T2 | T3
    String subsidiaryId;     // KE | TZ | UG | RW | DRC | SS
    boolean hasDr;
    String dcEndpoint;       // primary DC URL
    String drEndpoint;       // DR URL
    @Column(columnDefinition = "jsonb")
    String dcServers;        // [{ip, hostname, role: APP|DB|WEB}]
    @Column(columnDefinition = "jsonb")
    String drServers;
    UUID techOwnerId;        // FK → users
    String businessOwner;    // name (may not be a platform user)
    String description;
    boolean directCustomerImpact;
    boolean hasDependency;   // updated by dependency engine
    String drCapability;     // FULL_FAILOVER | APP_ONLY | DB_ONLY | etc.
    String vendor;           // e.g. Infosys, Oracle, in-house
    String notes;
    boolean isActive;
    Instant createdAt;
    Instant updatedAt;
}
```

**Services:**
- `ApplicationService`: `createApplication(dto)`, `updateApplication(id, dto)`, `deactivateApplication(id)`, `getById(id)`, `search(filter, pageable)` — filter by tier/subsidiary/owner, `listByOwner(userId)`, `listBySubsidiary(subsidiaryId)`, `getApplicationsForCampaign(campaignId)`
- `ApplicationImportService`: `parseExcel(MultipartFile)` via Apache POI — reads the existing DR Failover schedule Excel format, `validateRow(row)` — checks required fields, `importBatch(validRows)` — upsert by code, `generateImportReport()` — returns {imported, updated, skipped, errors[]}

**Repositories:**
```java
public interface ApplicationRepository extends JpaRepository<ApplicationEntity, UUID> {
    List<ApplicationEntity> findBySubsidiaryIdAndIsActive(String subsidiaryId, boolean active);
    List<ApplicationEntity> findByTechOwnerIdAndIsActive(UUID ownerId, boolean active);
    List<ApplicationEntity> findByTierAndSubsidiaryId(String tier, String subsidiaryId);
    Page<ApplicationEntity> searchByNameContainingIgnoreCase(String name, Pageable p);
    List<ApplicationEntity> findByTierAndHasDrTrue(String tier);
}
```

**Controllers:**
```
GET    /api/applications                 → list + search (filter: tier, subsidiary, owner)
GET    /api/applications/{id}            → single application detail
POST   /api/applications                 → create [COORDINATOR, SUPER_ADMIN]
PUT    /api/applications/{id}            → update [COORDINATOR, SUPER_ADMIN]
DELETE /api/applications/{id}            → deactivate [SUPER_ADMIN]
POST   /api/applications/import          → Excel upload [COORDINATOR, SUPER_ADMIN]
GET    /api/applications/export          → download current registry as Excel
GET    /api/applications/my              → apps owned by current user [APP_OWNER]
```

##### Database — New Tables This Week
```sql
CREATE TABLE applications (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code                    VARCHAR(100) UNIQUE NOT NULL,
    name                    VARCHAR(200) NOT NULL,
    tier                    VARCHAR(5) NOT NULL CHECK (tier IN ('T1','T2','T3')),
    subsidiary_id           VARCHAR(10) NOT NULL,
    has_dr                  BOOLEAN DEFAULT false,
    dc_endpoint             TEXT,
    dr_endpoint             TEXT,
    dc_servers              JSONB,
    dr_servers              JSONB,
    tech_owner_id           UUID REFERENCES users(id),
    business_owner          VARCHAR(200),
    description             TEXT,
    direct_customer_impact  BOOLEAN DEFAULT false,
    has_dependency          BOOLEAN DEFAULT false,
    dr_capability           VARCHAR(50),
    vendor                  VARCHAR(100),
    notes                   TEXT,
    is_active               BOOLEAN DEFAULT true,
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    updated_at              TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX idx_apps_subsidiary ON applications(subsidiary_id, is_active);
CREATE INDEX idx_apps_tier       ON applications(tier, is_active);
CREATE INDEX idx_apps_owner      ON applications(tech_owner_id);
```

##### Frontend — React / TypeScript
- `ApplicationListPage.tsx` — searchable table: columns = Name, Code, Tier, Subsidiary, Owner, DR Capability, Status. Filters: tier dropdown, subsidiary dropdown, has DR toggle. Paginated with React Query.
- `ApplicationDetailPage.tsx` — full metadata, server list, edit button (role-gated), dependency tab (populated in Week 3), DR history tab (populated in Phase 3)
- `ApplicationFormModal.tsx` — create/edit modal with validation (required: name, tier, subsidiary, owner). Server IP list (add/remove rows).
- `ApplicationImportPage.tsx` — drag-drop Excel upload → preview table showing what will be imported/updated → confirm → progress bar → import report showing created/updated/skipped/errors
- `useApplications.ts` — React Query custom hook: `useApplicationList(filters)`, `useApplication(id)`, `useMyApplications()`

##### End of Week 2 — What Works
- All 43 Q2 2026 applications imported from existing Excel in under 10 minutes
- Application owners can log in and see their assigned applications
- Coordinator can search and filter all 100+ applications in one screen
- No more Excel for application metadata

---

#### Week 3 — Dependency Engine

**What Gets Built:** The intelligence layer that maps relationships between applications, detects shared databases and middleware, and warns the coordinator of scheduling conflicts before DR day.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "dependencies")
public class DependencyEntity {
    @Id UUID id;
    UUID applicationId;      // the app that HAS the dependency
    UUID dependsOnId;        // the thing it depends on (another app, DB, service)
    String dependencyType;   // DATABASE | MIDDLEWARE | NETWORK | API | AUTH | DNS | VPN | OTHER
    boolean isShared;        // true = other apps also depend on this same resource
    String resourceName;     // e.g. EQBLCDB, SOA_TZ, SMSC_GATEWAY
    String description;
    Instant createdAt;
}

@Entity @Table(name = "dependency_groups")
public class DependencyGroupEntity {
    @Id UUID id;
    String name;             // e.g. EQBLCDB Shared Group
    String sharedResourceName;
    String sharedResourceType;
    Instant createdAt;
}

@Entity @Table(name = "dependency_group_members")
public class DependencyGroupMemberEntity {
    UUID groupId;
    UUID applicationId;
}

@Entity @Table(name = "campaign_conflicts")
public class CampaignConflictEntity {
    @Id UUID id;
    UUID campaignId;
    String conflictType;     // SHARED_DEPENDENCY_CONFLICT | SEQUENCING_ADVISORY | INFORMATIONAL
    UUID[] applicationIds;   // ARRAY of affected app IDs
    String description;
    String recommendation;
    String resolution;       // GROUP_IN_ONE_WAR_ROOM | SEQUENCE_A_BEFORE_B | ACKNOWLEDGED
    String resolutionReason;
    UUID resolvedById;
    Instant resolvedAt;
}
```

**Services:**
- `DependencyEngineService`:
  - `registerDependency(appId, dependsOnId, type, isShared, resourceName)`
  - `scanCampaignConflicts(campaignId)` → iterates all campaign apps, finds shared dependencies → returns List\<CampaignConflict\>
  - `classifyConflict(dep1, dep2)` → SHARED_DEPENDENCY_CONFLICT if both doing FULL_FAILOVER/DB_ONLY on same DB; SEQUENCING_ADVISORY if integration dependency; INFORMATIONAL otherwise
  - `detectSharedDependencies(List<UUID> appIds)` → finds all pairs that share a resource
  - `buildDependencyGraph(subsidiaryId)` → returns GraphDto {nodes[], edges[]} for D3.js (built in Phase 3)
  - `suggestWarRoomGrouping(campaignId)` → returns suggested groups based on shared dependencies
- `ConflictResolutionService`:
  - `resolveConflict(conflictId, resolution, reason, coordinatorId)` — records decision in audit log
  - `getUnresolvedConflicts(campaignId)` — used in campaign approval gate

**Repositories:**
```java
public interface DependencyRepository extends JpaRepository<DependencyEntity, UUID> {
    List<DependencyEntity> findByApplicationId(UUID appId);
    List<DependencyEntity> findByDependsOnId(UUID resourceId);
    List<DependencyEntity> findByResourceNameAndIsSharedTrue(String resourceName);
    // Finds all apps sharing the same named resource:
    @Query("SELECT d FROM DependencyEntity d WHERE d.resourceName = :name AND d.isShared = true")
    List<DependencyEntity> findSharedDependents(@Param("name") String resourceName);
}
```

**Controllers:**
```
GET    /api/applications/{id}/dependencies      → list deps for an app
POST   /api/applications/{id}/dependencies      → add dependency [COORDINATOR]
DELETE /api/dependencies/{id}                   → remove [COORDINATOR]
GET    /api/campaigns/{id}/conflicts            → list all conflicts for campaign
POST   /api/campaigns/{id}/conflicts/{cid}/resolve → record resolution [COORDINATOR]
GET    /api/dependency-groups                   → list all shared resource groups
POST   /api/dependency-groups                   → create group [COORDINATOR]
```

##### Database — New Tables This Week
```sql
CREATE TABLE dependencies (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    application_id    UUID NOT NULL REFERENCES applications(id),
    depends_on_id     UUID REFERENCES applications(id),
    dependency_type   VARCHAR(50) NOT NULL,
    is_shared         BOOLEAN DEFAULT false,
    resource_name     VARCHAR(200),
    description       TEXT,
    created_at        TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(application_id, resource_name)
);

CREATE TABLE dependency_groups (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                  VARCHAR(200) NOT NULL,
    shared_resource_name  VARCHAR(200) NOT NULL,
    shared_resource_type  VARCHAR(50) NOT NULL,
    created_at            TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE dependency_group_members (
    group_id        UUID NOT NULL REFERENCES dependency_groups(id),
    application_id  UUID NOT NULL REFERENCES applications(id),
    PRIMARY KEY (group_id, application_id)
);

CREATE TABLE campaign_conflicts (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_id       UUID NOT NULL,
    conflict_type     VARCHAR(50) NOT NULL,
    application_ids   UUID[] NOT NULL,
    description       TEXT NOT NULL,
    recommendation    TEXT,
    resolution        VARCHAR(50),
    resolution_reason TEXT,
    resolved_by_id    UUID REFERENCES users(id),
    resolved_at       TIMESTAMPTZ,
    created_at        TIMESTAMPTZ DEFAULT NOW()
);
```

##### Frontend — React / TypeScript
- `DependencyTab.tsx` (inside ApplicationDetailPage) — list of dependencies with type badge, add/remove buttons
- `AddDependencyModal.tsx` — search for app/resource, select type, mark as shared
- `ConflictWarningPanel.tsx` — shown on campaign detail when conflicts exist. Color-coded by type. Each conflict has a "Resolve" button.
- `ConflictResolutionModal.tsx` — coordinator selects resolution option (Group / Sequence / Acknowledge) and enters reason

##### End of Week 3 — What Works
- Coordinator maps that Finacle Core TZ and Finacle Treasury TZ share EQBLCDB
- When both are added to Q2 campaign, system immediately raises SHARED_DEPENDENCY_CONFLICT
- Coordinator resolves: Group in one War Room — recorded in audit trail
- SOA → Efront dependency raises SEQUENCING_ADVISORY

---

#### Week 4 — Campaign Manager

**What Gets Built:** The quarterly DR campaign — creating it, adding applications with their DR activity types, scheduling dates/times, and seeing all deadlines auto-calculated from the DR date.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "campaigns")
public class CampaignEntity {
    @Id UUID id;
    String name;             // e.g. Q2 2026 DR Campaign — Tanzania
    String quarter;          // Q1 | Q2 | Q3 | Q4
    int year;
    String subsidiaryId;
    UUID coordinatorId;
    String status;           // DRAFT | PRE_DR_OPEN | APPROVED | IN_PROGRESS | COMPLETED | CANCELLED
    Instant createdAt;
    Instant updatedAt;
}

@Entity @Table(name = "campaign_applications")
public class CampaignApplicationEntity {
    @Id UUID id;
    UUID campaignId;
    UUID applicationId;
    String drActivityType;   // FULL_FAILOVER | APP_ONLY | DB_ONLY | APP_REPOINT |
                             // PARTIAL | ACTIVE_ACTIVE | ROLLBACK_DRILL | COLD_STANDBY |
                             // TABLETOP | EXTENDED_OPS
    LocalDate scheduledDate;
    LocalTime scheduledTime;
    int rtoTargetMinutes;
    UUID warRoomGroupId;     // set when grouped with shared dependency sibling
    String status;           // PLANNED | PRE_DR_OPEN | APPROVED | IN_EXECUTION |
                             // VALIDATION | COMPLETED | ROLLED_BACK | DEFERRED | CANCELLED
    // Auto-calculated deadlines:
    LocalDate runbookDeadline;         // T-14
    LocalDate peerReviewDeadline;      // T-10
    LocalDate itscmApprovalDeadline;   // T-7
    LocalDate checklistDeadline;       // T-3
    Instant createdAt;
}
```

**Services:**
- `CampaignService`:
  - `createCampaign(dto)` — creates campaign, sets status=DRAFT
  - `addApplication(campaignId, appId, drActivityType, scheduledDate, rtoMinutes)` — adds app, auto-calculates deadlines, triggers dependency scan
  - `removeApplication(campaignId, appId)` — only if status=PLANNED
  - `openPreDr(campaignId)` — status: DRAFT → PRE_DR_OPEN; triggers T-21 notifications for all apps
  - `approveCampaign(campaignId)` — runs approval gate check first
  - `checkApprovalGate(campaignId)` → GateCheckResult{passed, blockers[]} — checks: all runbooks approved, all checklists signed off, all conflicts resolved
  - `deferApplication(campaignApplicationId, reason)` — moves single app to DEFERRED
  - `getCampaignProgress(campaignId)` → CampaignProgressDto{total, approved, inProgress, blocked, pending}
- `DeadlineCalculatorService`:
  - `calculateDeadlines(LocalDate drDate)` → DeadlineSet{runbook=T-14, peerReview=T-10, itscm=T-7, checklist=T-3}
  - Skips weekends — if T-14 falls on Sunday, moves to Friday T-16

**Repositories:**
```java
public interface CampaignApplicationRepository extends JpaRepository<CampaignApplicationEntity, UUID> {
    List<CampaignApplicationEntity> findByCampaignId(UUID campaignId);
    List<CampaignApplicationEntity> findByApplicationIdOrderByScheduledDateDesc(UUID appId);
    // Find apps whose runbook ITSCM deadline has passed but runbook is not approved:
    @Query("SELECT ca FROM CampaignApplicationEntity ca " +
           "WHERE ca.itscmApprovalDeadline < CURRENT_DATE " +
           "AND ca.status = 'PRE_DR_OPEN'")
    List<CampaignApplicationEntity> findOverdueItscmApprovals();
}
```

**Controllers:**
```
GET    /api/campaigns                          → list campaigns (filter: subsidiary, quarter, year)
GET    /api/campaigns/{id}                     → campaign detail with all applications
POST   /api/campaigns                          → create [COORDINATOR]
PATCH  /api/campaigns/{id}/open-pre-dr         → open pre-DR phase [COORDINATOR]
PATCH  /api/campaigns/{id}/approve             → approve campaign [COORDINATOR]
POST   /api/campaigns/{id}/applications        → add application to campaign [COORDINATOR]
DELETE /api/campaigns/{id}/applications/{appId} → remove application [COORDINATOR]
PATCH  /api/campaigns/{id}/applications/{appId}/defer → defer single app [COORDINATOR]
GET    /api/campaigns/{id}/gate-check          → check approval gate status
GET    /api/campaigns/{id}/progress            → campaign progress summary
```

##### Database — New Tables This Week
```sql
CREATE TABLE campaigns (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            VARCHAR(200) NOT NULL,
    quarter         VARCHAR(5)  NOT NULL CHECK (quarter IN ('Q1','Q2','Q3','Q4')),
    year            INT NOT NULL,
    subsidiary_id   VARCHAR(10),
    coordinator_id  UUID REFERENCES users(id),
    status          VARCHAR(30) DEFAULT 'DRAFT',
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE campaign_applications (
    id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_id               UUID NOT NULL REFERENCES campaigns(id),
    application_id            UUID NOT NULL REFERENCES applications(id),
    dr_activity_type          VARCHAR(50) NOT NULL,
    scheduled_date            DATE NOT NULL,
    scheduled_time            TIME,
    rto_target_minutes        INT NOT NULL,
    war_room_group_id         UUID,
    status                    VARCHAR(30) DEFAULT 'PLANNED',
    runbook_deadline          DATE,
    peer_review_deadline      DATE,
    itscm_approval_deadline   DATE,
    checklist_deadline        DATE,
    created_at                TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(campaign_id, application_id)
);
CREATE INDEX idx_ca_campaign   ON campaign_applications(campaign_id);
CREATE INDEX idx_ca_app        ON campaign_applications(application_id);
CREATE INDEX idx_ca_deadlines  ON campaign_applications(itscm_approval_deadline, status);
```

##### Frontend — React / TypeScript
- `CampaignListPage.tsx` — cards per campaign: name, quarter, progress bar, status badge, subsidiary. Create button top right.
- `CampaignDetailPage.tsx` — tabs: Overview | Applications | Conflicts | Runbook Status | Checklist Status
- `CampaignCreateModal.tsx` — name, quarter, year, subsidiary, coordinator
- `AddApplicationToCampaignModal.tsx` — search/select app, choose DR activity type (dropdown), date picker, time picker, RTO input. On add: shows auto-calculated deadlines before confirming.
- `CampaignApplicationRow.tsx` — per-app row showing: app name, activity type badge, scheduled date/time, RTO, runbook status icon, checklist %, status chip, action menu
- `CampaignGateCheckPanel.tsx` — shown before approval: green/red checks for each gate condition
- `DeadlineCalendarWidget.tsx` — mini calendar showing all DR dates in the campaign

##### End of Week 4 — What Works
- Coordinator creates Q2 2026 campaign, adds all 43 applications in one session
- Each app shows its exact runbook deadline, peer review deadline, ITSCM approval deadline
- Clicking "Open Pre-DR" immediately notifies all application owners (via Week 13's notification system — placeholder email in Week 4, real integration in Week 13)

---

#### Week 5 — Pre-DR Readiness & Checklist Engine

**What Gets Built:** Per-application checklists auto-generated from runbook phases. Carried-forward blockers from previous DR cycles surfaced prominently. App owners update status; coordinator sees all in one grid.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "checklist_items")
public class ChecklistItemEntity {
    @Id UUID id;
    UUID campaignApplicationId;
    String title;
    String description;
    UUID ownerUserId;
    LocalDate dueDate;
    String status;           // PENDING | IN_PROGRESS | DONE | BLOCKED | CARRIED_FORWARD | VERIFIED
    String notes;
    String blockerDescription;
    UUID carriedForwardFromId; // self-reference — links to item in previous campaign
    boolean isAutoGenerated;   // true = generated from runbook; false = manually added
    int sortOrder;
    Instant createdAt;
    Instant updatedAt;
}

@Entity @Table(name = "checklist_blockers")
public class ChecklistBlockerEntity {
    @Id UUID id;
    UUID checklistItemId;
    String description;
    UUID raisedById;
    UUID resolvedById;
    Instant resolvedAt;
    String resolvedNotes;
    Instant createdAt;
}

@Entity @Table(name = "pre_dr_signoffs")
public class PreDrSignoffEntity {
    @Id UUID id;
    UUID campaignApplicationId;
    UUID submittedById;
    Instant submittedAt;
    Instant coordinatorAcknowledgedAt;
    UUID coordinatorId;
    String notes;
}
```

**Services:**
- `ChecklistService`:
  - `generateFromRunbookTemplate(campaignApplicationId)` — creates checklist items from the Pre-Cutover phase steps of the application's last approved runbook. Each step → one checklist item. Falls back to activity-type template if no runbook yet.
  - `getChecklistForOwner(campaignApplicationId, userId)` → includes carried-forward items at top
  - `getChecklistGridForCoordinator(campaignId)` → all apps, all owners, summary status per app
  - `updateItemStatus(itemId, status, notes, userId)` — validates status transition
  - `blockItem(itemId, reason, userId)` — creates ChecklistBlocker, alerts coordinator
  - `resolveBlocker(itemId, notes, userId)` — marks blocker resolved
  - `submitSignOff(campaignApplicationId, userId)` — validates all non-blocked items DONE, creates PreDrSignoff record
  - `getSignOffStatus(campaignApplicationId)` → {submitted, acknowledged, submittedBy, submittedAt}
- `CarryForwardService`:
  - `carryForwardBlockers(fromCampaignAppId, toCampaignAppId)` — run when new campaign includes same app; copies UNRESOLVED blocked items to new checklist as CARRIED_FORWARD items with link to original
  - `getCarriedForwardItems(campaignApplicationId)` → items with original raise date and age in days
  - `acknowledgeCarriedItem(itemId, userId)` — owner must acknowledge before sign-off allowed
  - `getCarriedForwardAge(ChecklistItemEntity item)` → days since original issue was raised

**Repositories:**
```java
public interface ChecklistItemRepository extends JpaRepository<ChecklistItemEntity, UUID> {
    List<ChecklistItemEntity> findByCampaignApplicationIdOrderBySortOrder(UUID campaignAppId);
    List<ChecklistItemEntity> findByCampaignApplicationIdAndStatus(UUID id, String status);
    // For coordinator summary:
    @Query("SELECT ci.campaignApplicationId, COUNT(ci), " +
           "SUM(CASE WHEN ci.status='DONE' THEN 1 ELSE 0 END) as done " +
           "FROM ChecklistItemEntity ci WHERE ci.campaignApplicationId IN :ids GROUP BY ci.campaignApplicationId")
    List<Object[]> getChecklistSummary(@Param("ids") List<UUID> campaignAppIds);
}
```

**Controllers:**
```
GET    /api/campaigns/{id}/applications/{appId}/checklist     → owner view
GET    /api/campaigns/{id}/checklist-summary                  → coordinator grid view
POST   /api/checklist-items                                   → add manual item [COORDINATOR]
PATCH  /api/checklist-items/{id}/status                       → update status [APP_OWNER]
POST   /api/checklist-items/{id}/block                        → raise blocker [APP_OWNER]
POST   /api/checklist-items/{id}/resolve-blocker              → resolve blocker [APP_OWNER]
POST   /api/campaigns/{id}/applications/{appId}/signoff       → submit sign-off [APP_OWNER]
PATCH  /api/campaigns/{id}/applications/{appId}/signoff/acknowledge → coordinator ack
GET    /api/checklist-items/{id}/history                      → carry-forward history
```

##### Database — New Tables This Week
```sql
CREATE TABLE checklist_items (
    id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_application_id   UUID NOT NULL REFERENCES campaign_applications(id),
    title                     VARCHAR(300) NOT NULL,
    description               TEXT,
    owner_user_id             UUID REFERENCES users(id),
    due_date                  DATE,
    status                    VARCHAR(30) DEFAULT 'PENDING',
    notes                     TEXT,
    blocker_description       TEXT,
    carried_forward_from_id   UUID REFERENCES checklist_items(id),
    is_auto_generated         BOOLEAN DEFAULT false,
    sort_order                INT DEFAULT 0,
    created_at                TIMESTAMPTZ DEFAULT NOW(),
    updated_at                TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE checklist_blockers (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    checklist_item_id UUID NOT NULL REFERENCES checklist_items(id),
    description       TEXT NOT NULL,
    raised_by_id      UUID REFERENCES users(id),
    resolved_by_id    UUID REFERENCES users(id),
    resolved_at       TIMESTAMPTZ,
    resolved_notes    TEXT,
    created_at        TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE pre_dr_signoffs (
    id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_application_id   UUID UNIQUE REFERENCES campaign_applications(id),
    submitted_by_id           UUID REFERENCES users(id),
    submitted_at              TIMESTAMPTZ,
    coordinator_acknowledged_at TIMESTAMPTZ,
    coordinator_id            UUID REFERENCES users(id),
    notes                     TEXT
);
```

##### Frontend — React / TypeScript
- `ChecklistPage.tsx` — app owner view. Top section: carried-forward banner (red if unacknowledged). Below: checklist items grouped by status. Progress bar at top. Sign-off button (disabled until all items resolved).
- `CarriedForwardBanner.tsx` — displays each carried-forward blocker with original date, age badge (e.g. "87 days"), description, and three buttons: Mark Resolved / Update Notes / Escalate to ITSCM.
- `ChecklistItemRow.tsx` — status chip (click to cycle: PENDING→IN_PROGRESS→DONE), blocker flag icon, expand for notes.
- `BlockerModal.tsx` — raise blocker: description text area + severity. Triggers immediate coordinator alert.
- `CoordinatorChecklistGridPage.tsx` — table with columns: App, Owner, Due Date, Progress %, Status, Blockers, Sign-off. Click row → drill into app checklist.
- `SignOffModal.tsx` — confirmation dialog showing checklist summary; warns if any items PENDING.

##### End of Week 5 — What Works
- Faith Githaiga (SOA owner) logs in and sees her pre-DR checklist with the 87-day carried-forward DB credentials issue highlighted at the top
- She can update status on each item, raise blockers, and submit sign-off
- Coordinator sees all 43 apps in one grid with real-time completion %
- Carried-forward items surface automatically — no manual copy from last quarter's report

---

#### Week 6 — Coordinator Dashboard & Phase 1 Completion

**What Gets Built:** The coordinator's command centre — a single screen showing campaign progress, upcoming DR dates, unresolved blockers, overdue actions, and runbook statuses across all campaign applications.

##### Backend — Java / Spring Boot

**Services:**
- `DashboardService`:
  - `getCoordinatorDashboard(coordinatorId)` → DashboardDto containing:
    - Active campaign progress: total apps, % ready, breakdown by status
    - Upcoming DR events (next 30 days): app name, date, pre-DR readiness %
    - Unresolved blockers: app name, blocker description, age in days
    - Runbook status summary: approved/in-review/draft/not-started counts
    - Overdue action items count
  - `getCampaignTimeline(campaignId)` → ordered list of all DR events in campaign
  - `getRunbookStatusGrid(campaignId)` → per-app runbook status for coordinator view

**Controllers:**
```
GET  /api/dashboard/coordinator        → full coordinator dashboard data
GET  /api/dashboard/campaign-timeline  → upcoming DR calendar
GET  /api/dashboard/runbook-status     → runbook status grid per campaign
```

##### Frontend — React / TypeScript
- `CoordinatorDashboardPage.tsx` — three-column layout matching the Screen 1 mockup. Uses React Query with 60-second auto-refresh.
- `CampaignProgressCard.tsx` — donut chart (recharts) + status breakdown list
- `UpcomingDrList.tsx` — sorted list of next 5 DR events with pre-DR readiness mini-bar
- `UnresolvedBlockersList.tsx` — age-sorted blockers with one-click escalate
- `RunbookStatusSummaryCard.tsx` — counts by status with color coding
- `OverdueActionsCard.tsx` — overdue items with owner name and days overdue

##### End of Phase 1 — Complete When:
- All 43 Q2 2026 applications imported from Excel with tiers, owners, subsidiaries ✅
- SOA, Finacle Core/Treasury shared DB dependency mapped ✅
- Coordinator creates Q2 2026 campaign and adds all apps in one session ✅
- Each app shows exact runbook and checklist deadlines ✅
- Faith Githaiga sees her carried-forward blocker on first login ✅
- Coordinator dashboard shows live campaign readiness — zero Excel needed ✅

### ⚙️ Phase 2 — Execution Engine (Weeks 7–12)
**Goal:** Enable live DR execution through structured runbooks and a real-time War Room. Introduce blocker intelligence so no issue is ever forgotten between DR cycles. By end of Week 12, a full DR exercise — from runbook approval to post-DR report — can be run entirely within the platform.

---

#### Week 7 — Runbook Builder

**What Gets Built:** Structured, versioned runbooks replacing the current Excel-based runbook. Each runbook has four phases, sequential steps with exact commands, owner roles, durations, and verification criteria. Activity type shapes the template automatically.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "runbooks")
public class RunbookEntity {
    @Id UUID id;
    UUID applicationId;
    UUID campaignApplicationId;
    String version;          // e.g. v2.1
    String status;           // NOT_STARTED | DRAFT | SUBMITTED_FOR_REVIEW |
                             // RETURNED_FOR_REVISION | PEER_APPROVED | APPROVED | USED_IN_WAR_ROOM
    String title;
    String drActivityType;
    UUID authorId;
    int qualityScore;        // 0–100, calculated on demand
    String crNumber;
    String notes;
    Instant createdAt;
    Instant updatedAt;
}

@Entity @Table(name = "runbook_phases")
public class RunbookPhaseEntity {
    @Id UUID id;
    UUID runbookId;
    String phaseType;        // PRE_CUTOVER | CUTOVER | DR_VALIDATION | ROLLBACK
    int sequenceOrder;       // 1, 2, 3, 4
    String description;
    boolean isRequired;      // ROLLBACK always required even if not executed
}

@Entity @Table(name = "runbook_steps")
public class RunbookStepEntity {
    @Id UUID id;
    UUID phaseId;
    int sequenceOrder;
    String title;
    String description;
    @Convert(converter = EncryptedStringConverter.class)
    String commands;         // AES-256 encrypted — contains exact shell commands
    String ownerRole;        // DBA | APP_ENGINEER | NOC | NETWORK | COORDINATOR
    int estimatedMinutes;
    String verificationCriteria;
    boolean causeDowntime;
    boolean isSharedStep;    // true = shared with sibling app in same dependency group
    UUID sharedDependencyGroupId;
    UUID dependsOnStepId;    // null = starts immediately; UUID = waits for this step
    boolean isParallel;      // can run concurrently with previous step
}

@Entity @Table(name = "runbook_versions")
public class RunbookVersionEntity {
    @Id UUID id;
    UUID runbookId;
    String version;
    @Column(columnDefinition = "jsonb")
    String snapshotData;     // complete runbook JSON snapshot at approval time
    UUID createdById;
    Instant createdAt;
}
```

**Services:**
- `RunbookService`:
  - `createRunbook(campaignApplicationId)` — creates empty runbook with 4 phase shells based on DR activity type
  - `createFromPreviousApproved(campaignApplicationId)` — finds last approved runbook for this application, deep-copies all phases/steps as new DRAFT version. Pre-population flow.
  - `addPhase(runbookId, dto)`, `updatePhase(phaseId, dto)`, `deletePhase(phaseId)`
  - `addStep(phaseId, dto)`, `updateStep(stepId, dto)`, `deleteStep(stepId)`, `reorderSteps(phaseId, List<UUID> orderedStepIds)`
  - `calculateQualityScore(runbookId)` → checks: all 4 phases present, each phase ≥1 step, all steps have title/role/duration/verification, no empty commands on non-narrative steps. Returns 0–100.
  - `getRunbookForCampaignApp(campaignApplicationId)` — returns current version
- `RunbookTemplateService`:
  - `getTemplateStepsForActivityType(drActivityType)` → returns suggested phases and steps per type. E.g., APP_ONLY has no DBA steps; FULL_FAILOVER includes Oracle DG switchover step in CUTOVER phase; COLD_STANDBY has additional infrastructure startup steps.
  - `applyTemplate(runbookId, drActivityType)` — populates suggested steps as draft steps

**Repositories:**
```java
public interface RunbookRepository extends JpaRepository<RunbookEntity, UUID> {
    Optional<RunbookEntity> findByCampaignApplicationIdAndStatus(UUID id, String status);
    // Find last approved runbook for this application across all campaigns:
    @Query("SELECT r FROM RunbookEntity r WHERE r.applicationId = :appId " +
           "AND r.status = 'APPROVED' ORDER BY r.updatedAt DESC")
    Optional<RunbookEntity> findLastApprovedByApplicationId(@Param("appId") UUID appId);
    List<RunbookEntity> findByApplicationIdOrderByCreatedAtDesc(UUID appId);
}

public interface RunbookStepRepository extends JpaRepository<RunbookStepEntity, UUID> {
    List<RunbookStepEntity> findByPhaseIdOrderBySequenceOrder(UUID phaseId);
    List<RunbookStepEntity> findByIsSharedStepTrueAndSharedDependencyGroupId(UUID groupId);
}
```

**Controllers:**
```
GET    /api/runbooks?campaignApplicationId=    → get runbook for campaign app
GET    /api/runbooks/{id}                      → full runbook detail
POST   /api/runbooks                           → create new runbook
POST   /api/runbooks/from-previous/{campAppId} → pre-populate from last approved
PUT    /api/runbooks/{id}                      → update header info
POST   /api/runbooks/{id}/phases               → add phase
PUT    /api/runbooks/{id}/phases/{phaseId}     → update phase
POST   /api/runbooks/{id}/phases/{phaseId}/steps        → add step
PUT    /api/runbooks/{id}/phases/{phaseId}/steps/{id}   → update step
DELETE /api/runbooks/{id}/phases/{phaseId}/steps/{id}   → delete step
PATCH  /api/runbooks/{id}/phases/{phaseId}/steps/reorder → reorder
GET    /api/runbooks/{id}/quality-score        → get quality score + breakdown
GET    /api/applications/{id}/runbook-history  → list all runbook versions for app
GET    /api/runbook-templates?drActivityType=  → suggested template steps
```

##### Database — New Tables This Week
```sql
CREATE TABLE runbooks (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    application_id          UUID NOT NULL REFERENCES applications(id),
    campaign_application_id UUID REFERENCES campaign_applications(id),
    version                 VARCHAR(20) DEFAULT 'v1.0',
    status                  VARCHAR(50) DEFAULT 'DRAFT',
    title                   VARCHAR(300),
    dr_activity_type        VARCHAR(50),
    author_id               UUID REFERENCES users(id),
    quality_score           INT DEFAULT 0,
    cr_number               VARCHAR(50),
    notes                   TEXT,
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    updated_at              TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE runbook_phases (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    runbook_id     UUID NOT NULL REFERENCES runbooks(id) ON DELETE CASCADE,
    phase_type     VARCHAR(30) NOT NULL CHECK (phase_type IN ('PRE_CUTOVER','CUTOVER','DR_VALIDATION','ROLLBACK')),
    sequence_order INT NOT NULL,
    description    TEXT,
    is_required    BOOLEAN DEFAULT true
);

CREATE TABLE runbook_steps (
    id                          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    phase_id                    UUID NOT NULL REFERENCES runbook_phases(id) ON DELETE CASCADE,
    sequence_order              INT NOT NULL,
    title                       VARCHAR(300) NOT NULL,
    description                 TEXT,
    commands                    TEXT,           -- encrypted by application
    owner_role                  VARCHAR(50),
    estimated_minutes           INT,
    verification_criteria       TEXT,
    cause_downtime              BOOLEAN DEFAULT false,
    is_shared_step              BOOLEAN DEFAULT false,
    shared_dependency_group_id  UUID,
    depends_on_step_id          UUID REFERENCES runbook_steps(id),
    is_parallel                 BOOLEAN DEFAULT false
);

CREATE TABLE runbook_versions (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    runbook_id    UUID NOT NULL REFERENCES runbooks(id),
    version       VARCHAR(20) NOT NULL,
    snapshot_data JSONB NOT NULL,     -- full runbook snapshot at lock time
    created_by_id UUID REFERENCES users(id),
    created_at    TIMESTAMPTZ DEFAULT NOW()
);
```

##### Frontend — React / TypeScript
- `RunbookBuilderPage.tsx` — tabs for each phase (Pre-Cutover / Cutover / DR Validation / Rollback). Each tab shows ordered step cards. Drag-to-reorder via react-beautiful-dnd. Quality score widget fixed in top-right corner, updates in real-time as steps are added.
- `RunbookPhaseTab.tsx` — list of RunbookStepCard components. "Add Step" button at bottom.
- `RunbookStepCard.tsx` — shows title, role badge, duration, downtime badge, commands (masked with toggle to reveal for authorised roles), verify criteria. Edit / Delete / Duplicate buttons.
- `RunbookStepFormModal.tsx` — form: title, description, owner role dropdown, estimated minutes, cause downtime toggle, commands text area (monospace), verification criteria, parallel/depends-on settings.
- `QualityScoreWidget.tsx` — circular progress 0–100. Below: checklist of what's missing (e.g., "Rollback phase has 0 steps — add at least 1").
- `RunbookPrePopulateModal.tsx` — shown when creating new runbook if previous approved version exists. Shows version number and approval date. "Use this as starting point" button.
- `ActivityTypeStepSuggestions.tsx` — sidebar panel showing suggested steps for the selected DR activity type. Drag a suggestion into the phase to add it.

##### End of Week 7 — What Works
- Charles Mwangi opens Finacle Core TZ runbook — pre-populated from Q1 approved v2.0
- He sees the 4 phases, all existing steps, and a quality score of 78 (pre-populated)
- He updates the Oracle DG commands with the new DR server hostnames
- Saves as DRAFT — ready for peer review next week

---

#### Week 8 — Runbook Approval Workflow & Deadline Enforcement

**What Gets Built:** The full approval chain (Author → Peer → ITSCM) with hard quality gates. The automated deadline enforcement scheduler — T-21 through T-1 reminders, manager escalation at T-7, and campaign block at T-3.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "runbook_approvals")
public class RunbookApprovalEntity {
    @Id UUID id;
    UUID runbookId;
    UUID approverId;
    String approvalType;     // PEER_REVIEW | ITSCM_APPROVAL
    String status;           // PENDING | APPROVED | RETURNED
    String comments;
    Instant timestamp;
}
```

**Services:**
- `RunbookApprovalService`:
  - `submitForReview(runbookId, authorId)` — validates quality score ≥ 70, transitions status to SUBMITTED_FOR_REVIEW, notifies assigned peer reviewer
  - `assignPeerReviewer(runbookId, reviewerId, coordinatorId)` — coordinator assigns reviewer
  - `approveByPeer(runbookId, reviewerId, comments)` → status: PEER_APPROVED; notifies coordinator for ITSCM approval
  - `returnByPeer(runbookId, reviewerId, comments)` → status: RETURNED_FOR_REVISION; notifies author with comments
  - `approveByItscm(runbookId, coordinatorId)` → status: APPROVED; calls `lockRunbook(runbookId)`
  - `returnByItscm(runbookId, coordinatorId, comments)` → status: RETURNED_FOR_REVISION
  - `lockRunbook(runbookId)` — creates RunbookVersion snapshot (full JSONB), increments version number, status: APPROVED. After this no edits allowed on this version — new changes require new version.
- `RunbookEnforcementService`:
  - `checkDeadlineStatus(campaignApplicationId)` → returns DeadlineStatus{currentMilestone, isOverdue, daysPastDeadline}
  - `sendDeadlineReminder(userId, campApp, milestoneType)` — queues notification
  - `escalateToManager(userId, campApp)` — sends email to user.lineManagerEmail
  - `blockCampaignApplication(campaignApplicationId, reason)` — sets status=BLOCKED_ENFORCEMENT; coordinator must take action
  - `getRunbookStatusForCoordinator(campaignId)` → per-app status with deadline traffic lights

**Schedulers:**
```java
@Component
public class RunbookDeadlineScheduler {

    // Runs every day at 08:00
    @Scheduled(cron = "0 0 8 * * *")
    public void checkAllRunbookDeadlines() {
        // Query all campaign_applications in status PRE_DR_OPEN
        // For each: compute which T-milestone today represents
        // T-21: send friendly reminder if runbook NOT_STARTED
        // T-14: send urgent reminder if status != SUBMITTED_FOR_REVIEW or beyond
        // T-10: send warning + SMS if status != PEER_APPROVED or beyond
        // T-7:  if status != APPROVED → escalate to manager + flag campaign AT_RISK
        // T-3:  if status != APPROVED → block campaign, notify coordinator for action
        // T-1:  if status != APPROVED → disable War Room launch (checked at runtime)
    }

    @Scheduled(cron = "0 0 8 * * *")
    public void checkPeerReviewDeadlines() {
        // Find runbooks in SUBMITTED_FOR_REVIEW past their peer_review_deadline
        // Send reminder to assigned peer reviewer
        // If 2+ days past: escalate to coordinator
    }
}
```

**Controllers:**
```
POST   /api/runbooks/{id}/submit-for-review           → [APP_OWNER, COORDINATOR]
POST   /api/runbooks/{id}/assign-peer-reviewer        → [COORDINATOR]
POST   /api/runbooks/{id}/peer-approve                → [DR_PARTICIPANT with reviewer assignment]
POST   /api/runbooks/{id}/peer-return                 → [DR_PARTICIPANT with reviewer assignment]
POST   /api/runbooks/{id}/itscm-approve               → [COORDINATOR, SUPER_ADMIN]
POST   /api/runbooks/{id}/itscm-return                → [COORDINATOR, SUPER_ADMIN]
GET    /api/runbooks/{id}/approval-history            → full approval event timeline
GET    /api/runbooks/{id}/versions                    → list of locked versions
GET    /api/runbooks/{id}/versions/{version}          → specific version snapshot
GET    /api/campaigns/{id}/runbook-enforcement-status → per-app status for coordinator
```

##### Database — New Tables This Week
```sql
CREATE TABLE runbook_approvals (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    runbook_id    UUID NOT NULL REFERENCES runbooks(id),
    approver_id   UUID NOT NULL REFERENCES users(id),
    approval_type VARCHAR(30) NOT NULL,
    status        VARCHAR(20) NOT NULL,
    comments      TEXT,
    timestamp     TIMESTAMPTZ DEFAULT NOW()
);

-- Add enforcement columns to campaign_applications:
ALTER TABLE campaign_applications ADD COLUMN enforcement_status VARCHAR(30) DEFAULT 'ON_TRACK';
-- Values: ON_TRACK | AT_RISK | BLOCKED_ENFORCEMENT | MANAGER_ESCALATED
ALTER TABLE campaign_applications ADD COLUMN enforcement_last_checked TIMESTAMPTZ;
ALTER TABLE campaign_applications ADD COLUMN peer_reviewer_id UUID REFERENCES users(id);
```

##### Frontend — React / TypeScript
- `RunbookApprovalPanel.tsx` — shown in RunbookBuilderPage sidebar. Displays current status in a vertical stepper: Author Draft → Submitted → Peer Review → ITSCM Approval → Approved & Locked. Each step shows who, when, and any comments.
- `PeerReviewPage.tsx` — dedicated page for reviewers. Shows full runbook read-only. Comment box per step. Approve / Return with required comments.
- `ItscmApprovalPage.tsx` — coordinator view. Summary of peer review comments. Final approve/return.
- `RunbookVersionHistoryModal.tsx` — list of locked versions with date, approver, diff button.
- `InAppDeadlineBanner.tsx` — persistent coloured banner at top of every page for app owners. Blue→Yellow→Orange→Red based on urgency. Cannot be dismissed.
- `EnforcementStatusChip.tsx` — shown in coordinator grid: ON TRACK (green) / AT RISK (amber) / BLOCKED (red) / MANAGER ESCALATED (red+icon).

##### End of Week 8 — What Works
- Full approval chain enforced — runbook cannot skip from Draft to Approved
- Quality score gate prevents partial runbooks being submitted
- Every morning at 8 AM, the scheduler automatically sends the right reminder to the right person
- At T-7, if Faith's SOA runbook isn't approved, her manager receives an escalation email — automatically

---

#### Week 9 — War Room: Real-Time Execution Engine

**What Gets Built:** The live DR execution command centre. Steps auto-loaded from the approved runbook. Real-time updates via Spring WebSocket (STOMP). RTO countdown timer. All participants see every update instantly.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "war_room_sessions")
public class WarRoomSessionEntity {
    @Id UUID id;
    UUID campaignApplicationId;
    UUID warRoomGroupId;         // set for grouped (shared dependency) sessions
    UUID runbookVersionId;       // FK to runbook_versions — immutable snapshot
    String status;               // PREPARING | ACTIVE | VALIDATION | COMPLETED |
                                 // ROLLED_BACK | ABANDONED
    Instant startedAt;
    Instant completedAt;
    UUID coordinatorId;
    int actualRtoMinutes;        // set on close
    String currentPhase;         // PRE_CUTOVER | CUTOVER | DR_VALIDATION | ROLLBACK
    String crNumber;
    String closingNotes;
}

@Entity @Table(name = "execution_steps")
public class ExecutionStepEntity {
    @Id UUID id;
    UUID sessionId;
    UUID runbookStepId;          // reference to original step (for metadata)
    // Copied from runbook at launch (snapshot — independent of runbook changes):
    String title;
    String ownerRole;
    int estimatedMinutes;
    String verificationCriteria;
    boolean isSharedStep;
    // Execution state:
    String status;               // PENDING | WAITING | IN_PROGRESS | DONE | BLOCKED | SKIPPED
    UUID assignedUserId;         // resolved from role → actual person at War Room launch
    Instant startedAt;
    Instant completedAt;
    int actualMinutes;
    String notes;
    @Column(columnDefinition = "jsonb")
    String evidence;             // [{filename, storagePath, uploadedAt, uploadedById}]
    boolean isUnplanned;
    String blockReason;
    int sequenceOrder;
    String phaseType;
}

@Entity @Table(name = "war_room_participants")
public class WarRoomParticipantEntity {
    @Id UUID id;
    UUID sessionId;
    UUID userId;
    String role;                 // COORDINATOR | APP_ENGINEER | DBA | NOC | OBSERVER | EXTERNAL
    Instant joinedAt;
    Instant leftAt;
    boolean isActive;
}
```

**WebSocket STOMP Message Flows:**
```
Client → Server (via @MessageMapping):
  /app/warroom/{id}/step/start         → marks step IN_PROGRESS
  /app/warroom/{id}/step/complete      → marks step DONE + records actual time
  /app/warroom/{id}/step/block         → marks step BLOCKED + logs reason
  /app/warroom/{id}/participant/join   → registers participant as active
  /app/warroom/{id}/participant/leave  → marks participant inactive

Server → Client (via @SendTo or SimpMessagingTemplate):
  /topic/warroom/{id}                  → all session events (step updates, issue alerts, etc.)
  /topic/warroom/{id}/rto              → RTO tick every second {elapsed, remaining, percentage}
  /topic/warroom/{id}/participants     → participant list updates
```

**Services:**
- `WarRoomService`:
  - `launchWarRoom(campaignApplicationId, coordinatorId)` — requires re-authentication (validated via header token), checks approved runbook exists, creates WarRoomSession, snapshots runbook steps into ExecutionStep records (role → actual person mapping from campaign participants), notifies all participants, starts RTO timer
  - `loadRunbookSnapshot(sessionId)` — creates ExecutionStep for every RunbookStep in approved version; assigns users by matching step ownerRole to War Room participants list
  - `startStep(sessionId, stepId, userId)` — validates user is assigned to step, sets IN_PROGRESS, broadcasts via STOMP
  - `completeStep(sessionId, stepId, notes, userId)` — sets DONE, timestamps, calculates actual minutes, checks if next step's dependency is met and auto-unblocks WAITING steps, broadcasts
  - `blockStep(sessionId, stepId, reason, userId)` — sets BLOCKED, broadcasts high-priority alert to coordinator and all participants
  - `addUnplannedStep(sessionId, dto, coordinatorId)` — adds ad-hoc ExecutionStep flagged as isUnplanned=true; creates a "runbook gap" action item for post-DR
  - `triggerRollback(sessionId, reason, coordinatorId)` — requires re-auth, changes currentPhase to ROLLBACK, activates rollback steps
  - `closeWarRoom(sessionId, outcome, coordinatorId)` — sets COMPLETED/ROLLED_BACK, calculates actual RTO, triggers post-DR outcome creation prompt
  - `getWarRoomState(sessionId)` → full current state snapshot for reconnecting clients
- `RtoTimerService`:
  - `startTimer(sessionId, rtoMinutes)` — stores start time in Redis with TTL
  - `getRemainingSeconds(sessionId)` → computed from Redis stored start time; returned in STOMP tick
  - `getTimerStatus(sessionId)` → GREEN (>50% remaining) | AMBER (20–50%) | RED (<20%)
  - Timer tick scheduled at 1-second intervals via Spring's task scheduler

**Configuration:**
```java
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/topic");   // in-memory for Phase 2;
                                                  // replace with Redis pub/sub in Phase 4
        registry.setApplicationDestinationPrefixes("/app");
    }
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws")
                .setAllowedOrigins("https://drplatform.equitybank.internal")
                .withSockJS();
    }
}
```

**Controllers:**
```
POST   /api/war-rooms/launch                     → launch [COORDINATOR] — re-auth required
GET    /api/war-rooms/{id}                       → session detail
GET    /api/war-rooms/{id}/state                 → full state for reconnect
PATCH  /api/war-rooms/{id}/steps/{sid}/start     → [assigned user]
PATCH  /api/war-rooms/{id}/steps/{sid}/complete  → [assigned user]
PATCH  /api/war-rooms/{id}/steps/{sid}/block     → [any participant]
POST   /api/war-rooms/{id}/steps                 → add unplanned step [COORDINATOR]
POST   /api/war-rooms/{id}/rollback              → [COORDINATOR] — re-auth required
POST   /api/war-rooms/{id}/close                 → [COORDINATOR]
POST   /api/war-rooms/{id}/participants/join     → register as participant
POST   /api/war-rooms/{id}/evidence/{sid}        → upload evidence file (multipart)
GET    /api/campaigns/{id}/war-room-history      → past sessions for campaign
```

##### Database — New Tables This Week
```sql
CREATE TABLE war_room_sessions (
    id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_application_id   UUID NOT NULL REFERENCES campaign_applications(id),
    war_room_group_id         UUID,
    runbook_version_id        UUID NOT NULL REFERENCES runbook_versions(id),
    status                    VARCHAR(30) DEFAULT 'PREPARING',
    started_at                TIMESTAMPTZ,
    completed_at              TIMESTAMPTZ,
    coordinator_id            UUID REFERENCES users(id),
    actual_rto_minutes        INT,
    current_phase             VARCHAR(30),
    cr_number                 VARCHAR(50),
    closing_notes             TEXT
);

CREATE TABLE execution_steps (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id          UUID NOT NULL REFERENCES war_room_sessions(id),
    runbook_step_id     UUID,
    title               VARCHAR(300) NOT NULL,
    owner_role          VARCHAR(50),
    estimated_minutes   INT,
    verification_criteria TEXT,
    is_shared_step      BOOLEAN DEFAULT false,
    status              VARCHAR(30) DEFAULT 'PENDING',
    assigned_user_id    UUID REFERENCES users(id),
    started_at          TIMESTAMPTZ,
    completed_at        TIMESTAMPTZ,
    actual_minutes      INT,
    notes               TEXT,
    evidence            JSONB,
    is_unplanned        BOOLEAN DEFAULT false,
    block_reason        TEXT,
    sequence_order      INT,
    phase_type          VARCHAR(30)
);

CREATE TABLE war_room_participants (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id  UUID NOT NULL REFERENCES war_room_sessions(id),
    user_id     UUID NOT NULL REFERENCES users(id),
    role        VARCHAR(30),
    joined_at   TIMESTAMPTZ DEFAULT NOW(),
    left_at     TIMESTAMPTZ,
    is_active   BOOLEAN DEFAULT true
);
-- Add to Redis: warroom:{sessionId}:timer → {startedAt, rtoSeconds}
-- Add to Redis: warroom:{sessionId}:state → serialized state cache (60s TTL)
```

##### Frontend — React / TypeScript
- `WarRoomPage.tsx` — full-screen layout. Left 75%: execution steps table. Right 25%: RTO timer + participant list + issue log + action buttons.
- `RtoTimerDisplay.tsx` — large countdown HH:MM:SS. Background color: green → amber (at 50%) → red (at 20%). Progress bar showing elapsed vs total.
- `ExecutionStepsTable.tsx` — grouped by phase. Each row: step number, title, assigned user avatar, estimated time, actual time (live while in progress), status chip. Click to expand: verification criteria, notes input, evidence upload. Status buttons: Start / Complete / Block.
- `ParticipantPanel.tsx` — live list of who's joined. Green dot = active. Shows join time. Coordinator can add/remove participants.
- `IssueLogPanel.tsx` — running log of all issues raised. RED badge count in header.
- `AddUnplannedStepModal.tsx` — coordinator only. Title, owner dropdown, estimated time. Flagged as UNPLANNED visually.
- `RollbackConfirmModal.tsx` — requires current password re-entry + mandatory reason text. Double confirmation.
- `EvidenceUploadModal.tsx` — per-step file upload (drag-drop). Shows uploaded files list. Max 10MB, PDF/PNG/JPG/DOCX only.
- `useWarRoomSocket.ts` — STOMP.js hook. Connects to /ws, subscribes to /topic/warroom/{id} and /topic/warroom/{id}/rto. Handles reconnection with exponential backoff. On reconnect: fetches full state via REST then re-subscribes.
- `useRtoTimer.ts` — consumes RTO STOMP ticks, computes status, triggers color change

##### End of Week 9 — What Works
- Coordinator launches War Room for Finacle Core TZ at 22:00 — steps auto-loaded from v2.1
- Charles sees his steps, Nathan (DBA) sees the DG switchover step
- As each step completes, all participants see the update instantly — no phone call needed
- RTO timer counts down live, turns amber at 20 minutes, red at 8 minutes
- If Charles blocks a step, coordinator gets immediate alert in the UI and can log an issue

---

#### Week 10 — Issues Module

**What Gets Built:** Structured issue logging during War Room execution and pre-DR. Issues have severity, category, owner, and resolution tracking. Recurring issues across DR cycles are automatically flagged.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "issues")
public class IssueEntity {
    @Id UUID id;
    UUID sessionId;                  // nullable — may be pre-DR issue
    UUID campaignApplicationId;
    UUID stepId;                     // nullable — may not be tied to a step
    String title;
    String description;
    String severity;                 // LOW | MEDIUM | HIGH | CRITICAL
    String category;                 // PEOPLE | CONFIGURATION | INTEGRATION |
                                     // DATABASE | NETWORK | EXTERNAL_DEPENDENCY |
                                     // PROCESS | MONITORING | SECURITY
    UUID reportedById;
    UUID assignedToId;
    String status;                   // OPEN | IN_PROGRESS | RESOLVED | CARRIED_FORWARD | WONT_FIX
    Instant resolvedAt;
    String resolutionNotes;
    boolean carriedForward;
    UUID carriedForwardToId;         // FK to next campaign's checklist item
    Instant createdAt;
    Instant updatedAt;
}
```

**Services:**
- `IssueService`:
  - `logIssue(dto, reportedById)` — creates issue; if severity=HIGH/CRITICAL AND sessionId != null → broadcasts alert via STOMP to War Room topic immediately
  - `assignIssue(issueId, assignedToId, coordinatorId)`
  - `resolveIssue(issueId, notes, resolvedById)` → status: RESOLVED, sets resolvedAt
  - `flagForCarryForward(issueId)` → status: CARRIED_FORWARD; this issue will be picked up by CarryForwardEngineService when campaign closes
  - `getRecurringIssues(applicationId)` → issues appearing in ≥2 DR cycles for this app; flagged as SYSTEMIC in the management dashboard
  - `getIssueSummaryByCampaign(campaignId)` → grouped by category and severity; used in report generation
  - `getIssuesByCampaignApplication(campaignApplicationId)` → all issues for post-DR review

**Controllers:**
```
POST   /api/issues                              → log issue [any War Room participant]
GET    /api/war-rooms/{id}/issues               → issues during this session
GET    /api/campaigns/{id}/issues               → all issues for campaign
GET    /api/campaigns/{id}/applications/{aid}/issues → app-level issues
PATCH  /api/issues/{id}/assign                  → [COORDINATOR]
PATCH  /api/issues/{id}/resolve                 → [COORDINATOR, APP_OWNER]
PATCH  /api/issues/{id}/carry-forward           → [COORDINATOR]
GET    /api/applications/{id}/recurring-issues  → systemic issues [COORDINATOR, MANAGEMENT]
```

##### Database — New Tables This Week
```sql
CREATE TABLE issues (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id              UUID REFERENCES war_room_sessions(id),
    campaign_application_id UUID REFERENCES campaign_applications(id),
    step_id                 UUID REFERENCES execution_steps(id),
    title                   VARCHAR(300) NOT NULL,
    description             TEXT,
    severity                VARCHAR(20) NOT NULL DEFAULT 'MEDIUM',
    category                VARCHAR(50),
    reported_by_id          UUID REFERENCES users(id),
    assigned_to_id          UUID REFERENCES users(id),
    status                  VARCHAR(30) DEFAULT 'OPEN',
    resolved_at             TIMESTAMPTZ,
    resolution_notes        TEXT,
    carried_forward         BOOLEAN DEFAULT false,
    carried_forward_to_id   UUID,
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    updated_at              TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX idx_issues_session    ON issues(session_id);
CREATE INDEX idx_issues_campaign   ON issues(campaign_application_id);
CREATE INDEX idx_issues_status     ON issues(status, carried_forward);
```

---

#### Week 11 — Post-DR Outcome Board

**What Gets Built:** After the War Room closes, each application owner submits their outcome. Coordinator reviews all outcomes in one board. Unresolved issues flagged for carry-forward.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "post_dr_outcomes")
public class PostDrOutcomeEntity {
    @Id UUID id;
    UUID campaignApplicationId;
    UUID sessionId;
    String overallStatus;            // PASSED | PARTIAL | FAILED | ROLLED_BACK
    int actualRtoMinutes;
    boolean rtoAchieved;             // actualRtoMinutes <= rtoTargetMinutes
    String appOwnerComment;
    String coordinatorComment;
    String coordinatorNotes;         // internal notes not shown to app owner
    boolean isExternalCause;         // true = failure caused by external provider
    String externalCauseDetails;
    UUID submittedById;
    Instant submittedAt;
    Instant coordinatorAcknowledgedAt;
    UUID coordinatorId;
}
```

**Services:**
- `PostDrService`:
  - `submitOutcome(dto, appOwnerId)` — validates session is COMPLETED/ROLLED_BACK, creates outcome, notifies coordinator
  - `coordinatorAcknowledge(outcomeId, notes, coordinatorId)` — marks acknowledged, adds coordinator comment
  - `getOutcomeBoard(campaignId)` → OutcomeBoardDto: all applications with status, RTO compliance, comments, issue count
  - `getRtoComplianceSummary(campaignId)` → {compliant, nonCompliant, percentage} per tier
  - `triggerCarryForwardScan(campaignId)` — called after all outcomes submitted; triggers CarryForwardEngineService

**Controllers:**
```
POST   /api/campaigns/{id}/applications/{aid}/outcome   → submit [APP_OWNER]
PATCH  /api/outcomes/{id}/acknowledge                   → [COORDINATOR]
GET    /api/campaigns/{id}/outcome-board                → [COORDINATOR, MANAGEMENT]
GET    /api/campaigns/{id}/rto-compliance               → RTO summary
GET    /api/applications/{id}/outcome-history           → past DR outcomes
```

##### Database — New Tables This Week
```sql
CREATE TABLE post_dr_outcomes (
    id                          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_application_id     UUID UNIQUE NOT NULL REFERENCES campaign_applications(id),
    session_id                  UUID REFERENCES war_room_sessions(id),
    overall_status              VARCHAR(20) NOT NULL,
    actual_rto_minutes          INT,
    rto_achieved                BOOLEAN,
    app_owner_comment           TEXT,
    coordinator_comment         TEXT,
    coordinator_notes           TEXT,
    is_external_cause           BOOLEAN DEFAULT false,
    external_cause_details      TEXT,
    submitted_by_id             UUID REFERENCES users(id),
    submitted_at                TIMESTAMPTZ,
    coordinator_acknowledged_at TIMESTAMPTZ,
    coordinator_id              UUID REFERENCES users(id)
);
```

##### Frontend — React / TypeScript
- `OutcomeBoardPage.tsx` — coordinator view. Table: App | Status badge | Actual RTO vs target | App owner comment (truncated, expand) | Coordinator comment (editable) | Issues count | Action.
- `OutcomeSubmitPage.tsx` — app owner form. Read-only: session summary, steps completed, issues raised. Writable: overall status dropdown, actual RTO (pre-filled from War Room timer), comment text area, external cause toggle.
- `RtoComplianceSummary.tsx` — visual: gauge chart showing overall compliance %. Breakdown by tier. Used on coordinator dashboard and in report.
- `OutcomeHistoryChart.tsx` — app's last 6 DR outcomes as timeline (PASSED/PARTIAL/FAILED). Used in application detail page.

---

#### Week 12 — Blocker Intelligence Engine

**What Gets Built:** The long-term memory of the platform. When a campaign closes, all unresolved issues and blocked checklist items are automatically carried forward to the next campaign. Age is tracked. Recurring patterns are detected.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "carry_forward_links")
public class CarryForwardLinkEntity {
    @Id UUID id;
    UUID sourceCampaignApplicationId;
    UUID targetCampaignApplicationId;   // null if next campaign not yet created
    UUID sourceItemId;
    String sourceItemType;              // CHECKLIST_ITEM | ISSUE
    UUID acknowledgedById;
    Instant acknowledgedAt;
    Instant createdAt;
}
```

**Services:**
- `BlockerIntelligenceService`:
  - `processClosedCampaign(campaignId)` — entry point: called when campaign moves to COMPLETED. Scans all campaign applications for: unresolved issues + blocked/unresolved checklist items.
  - `identifyCarryForwardCandidates(campaignId)` → List\<CarryForwardCandidate\>{sourceId, type, description, severity, applicationId}
  - `createCarryForwardLinks(candidates, nextCampaignApplicationId)` — creates CarryForwardLink records; creates corresponding ChecklistItem in next campaign (if known) flagged as CARRIED_FORWARD
  - `getCarriedForwardHistory(applicationId)` → full chain: issue raised in Q1 → still open Q2 → resolved Q3. Shows evolution across all DR cycles.
  - `detectRecurringPatterns(applicationId)` → issues with same category appearing in ≥2 consecutive cycles → flagged as SYSTEMIC_RISK; appears in management dashboard as a pattern requiring architectural fix, not just a one-time action
  - `getAgeInDays(CarryForwardLinkEntity link)` → days from original source item creation to now
- `CarryForwardEngineService` (Spring Batch):
  - Triggered when campaign status transitions to COMPLETED
  - `ItemReader`: reads all campaign_applications for closed campaign
  - `ItemProcessor`: calls BlockerIntelligenceService.identifyCarryForwardCandidates per app
  - `ItemWriter`: persists CarryForwardLinks, creates next-cycle checklist items

**Controllers:**
```
GET  /api/campaigns/{id}/carry-forward-summary   → what will be/was carried forward
GET  /api/applications/{id}/blocker-history      → full cross-campaign issue chain
GET  /api/campaigns/{id}/systemic-risks          → recurring pattern issues [COORDINATOR, MANAGEMENT]
POST /api/carry-forward/{id}/acknowledge         → app owner acknowledges the item
```

##### Database — New Tables This Week
```sql
CREATE TABLE carry_forward_links (
    id                              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_campaign_application_id  UUID NOT NULL REFERENCES campaign_applications(id),
    target_campaign_application_id  UUID REFERENCES campaign_applications(id),
    source_item_id                  UUID NOT NULL,
    source_item_type                VARCHAR(30) NOT NULL,
    acknowledged_by_id              UUID REFERENCES users(id),
    acknowledged_at                 TIMESTAMPTZ,
    created_at                      TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX idx_cf_target ON carry_forward_links(target_campaign_application_id);
CREATE INDEX idx_cf_source ON carry_forward_links(source_campaign_application_id);
```

##### End of Phase 2 — Complete When:
- Full DR exercise can be run end-to-end in the War Room — no Excel, no manual notes ✅
- War Room steps auto-loaded from approved runbook — no manual entry on DR night ✅
- All step updates visible to all participants in real-time ✅
- Issues logged during War Room auto-create carry-forward candidates ✅
- After Finacle TZ exercise closes, Treasury IP issue automatically appears on Q3 pre-DR checklist for Edwin — 87 days old, unresolved, must acknowledge before sign-off ✅
- Application owners submit post-DR outcomes from their portal without calling the coordinator ✅

---

### 🤖 Phase 3 — Intelligence & Automation (Weeks 13–20)
**Goal:** The coordinator sends zero manual reminders. Post-DR reports are auto-generated in minutes. Management has real-time visibility. Application owners are fully self-sufficient.

---

#### Week 13 — Email Notification Engine

**What Gets Built:** Automated email notifications for every platform event — T-21 through T-1 runbook reminders, blocker alerts, campaign readiness digests. Thymeleaf HTML templates. All notifications logged for audit.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "notifications")
public class NotificationEntity {
    @Id UUID id;
    UUID recipientId;
    String type;             // RUNBOOK_REMINDER_T21 | RUNBOOK_REMINDER_T14 |
                             // RUNBOOK_REMINDER_T10 | RUNBOOK_REMINDER_T7 |
                             // MANAGER_ESCALATION_T7 | RUNBOOK_BLOCKED_T3 |
                             // BLOCKER_ALERT | CHECKLIST_REMINDER | WAR_ROOM_STEP_ASSIGNED |
                             // STEP_BLOCKED_ALERT | POST_DR_OUTCOME_DUE | ACTION_ITEM_OVERDUE |
                             // CAMPAIGN_READINESS_DIGEST
    String channel;          // EMAIL | SMS
    String subject;
    String bodyHtml;
    String bodyText;         // plain text fallback
    String status;           // QUEUED | SENT | FAILED | BOUNCED
    Instant sentAt;
    String errorMessage;
    UUID relatedEntityId;
    String relatedEntityType;
    UUID campaignApplicationId;
    Instant createdAt;
}

@Entity @Table(name = "notification_templates")
public class NotificationTemplateEntity {
    @Id UUID id;
    String templateKey;      // unique e.g. "RUNBOOK_REMINDER_T14"
    String subject;          // e.g. "Action Required: {{appName}} Runbook Due Today"
    String bodyHtml;         // Thymeleaf template with {{variables}}
    String bodyText;
    @Column(columnDefinition = "jsonb")
    String variables;        // ["appName", "drDate", "ownerName", "deadlineDate"]
    Instant updatedAt;
}
```

**Services:**
- `NotificationService`:
  - `queue(recipientId, type, relatedId, campaignAppId)` — creates QUEUED notification record; async processing picks it up
  - `sendImmediate(notification)` — bypasses queue; used for HIGH/CRITICAL issue alerts
  - `sendBulkReminder(campaignId, type)` — coordinator triggers manual bulk reminder from dashboard
  - `getNotificationsForUser(userId, pageable)` — for notification bell/drawer in UI
  - `markRead(notificationId, userId)`
- `EmailService`:
  - `send(to, subject, bodyHtml, bodyText)` via Spring's `JavaMailSender`
  - `renderTemplate(templateKey, Map<String,Object> variables)` via Thymeleaf `TemplateEngine`
  - SMTP config: uses Equity Bank's internal relay server (configurable via application.yml)
  - Retry: 3 attempts with 5-min backoff; after 3 failures → status=FAILED + alert to SUPER_ADMIN
- `NotificationDispatcher`:
  - `dispatch(notification)` — routes to EmailService or SmsService based on channel
  - Called by `@Async` Spring component every 30 seconds — processes all QUEUED notifications

**Scheduler (enhanced from Week 8):**
```java
@Scheduled(cron = "0 0 8 * * *")
public void dispatchDailyDigest() {
    // Find all coordinators with active campaigns
    // For each: build readiness digest showing runbook + checklist status per app
    // Send CAMPAIGN_READINESS_DIGEST email with summary table
}

@Scheduled(cron = "0 30 8 * * MON")
public void sendWeeklyCoordinatorDigest() {
    // Open action items by owner, overdue items, upcoming DR dates next 14 days
}
```

**Controllers:**
```
GET    /api/notifications/my                    → current user's notification feed
PATCH  /api/notifications/{id}/read             → mark as read
GET    /api/notifications/unread-count          → for bell badge
POST   /api/campaigns/{id}/send-bulk-reminder   → manual bulk send [COORDINATOR]
GET    /api/notification-templates              → [SUPER_ADMIN]
PUT    /api/notification-templates/{id}         → edit template [SUPER_ADMIN]
```

##### Database — New Tables This Week
```sql
CREATE TABLE notifications (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    recipient_id            UUID NOT NULL REFERENCES users(id),
    type                    VARCHAR(80) NOT NULL,
    channel                 VARCHAR(10) DEFAULT 'EMAIL',
    subject                 VARCHAR(300),
    body_html               TEXT,
    body_text               TEXT,
    status                  VARCHAR(20) DEFAULT 'QUEUED',
    sent_at                 TIMESTAMPTZ,
    error_message           TEXT,
    related_entity_id       UUID,
    related_entity_type     VARCHAR(50),
    campaign_application_id UUID REFERENCES campaign_applications(id),
    is_read                 BOOLEAN DEFAULT false,
    created_at              TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX idx_notif_recipient ON notifications(recipient_id, is_read, created_at DESC);

CREATE TABLE notification_templates (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    template_key VARCHAR(80) UNIQUE NOT NULL,
    subject      VARCHAR(300),
    body_html    TEXT,
    body_text    TEXT,
    variables    JSONB,
    updated_at   TIMESTAMPTZ DEFAULT NOW()
);
```

---

#### Week 14 — SMS Integration & Notification Polish

**What Gets Built:** SMS via Twilio for HIGH urgency notifications (T-7 escalations, T-3 campaign block, War Room step BLOCKED alerts). Notification preferences per user.

##### Backend — Java / Spring Boot

**Services:**
- `SmsService`:
  - `send(phoneNumber, message)` via Twilio REST API (Twilio Java SDK)
  - `sendWhatsApp(whatsappNumber, message)` via Twilio WhatsApp-enabled number
  - Message length enforced ≤160 chars; longer messages truncated with "...see platform for full details"
  - Phone numbers sourced from UserEntity.phoneNumber (new column added this week)
- `NotificationPreferenceService`:
  - `getUserPreferences(userId)` → NotificationPreferences{emailEnabled, smsEnabled, whatsappEnabled, quietHours}
  - `updatePreferences(userId, dto)` — user can opt out of SMS but NOT email (email is mandatory for compliance)

**Database changes:**
```sql
ALTER TABLE users ADD COLUMN phone_number VARCHAR(20);
ALTER TABLE users ADD COLUMN whatsapp_number VARCHAR(20);

CREATE TABLE notification_preferences (
    user_id           UUID PRIMARY KEY REFERENCES users(id),
    email_enabled     BOOLEAN DEFAULT true,
    sms_enabled       BOOLEAN DEFAULT true,
    whatsapp_enabled  BOOLEAN DEFAULT false,
    quiet_hours_start TIME,    -- no SMS during quiet hours
    quiet_hours_end   TIME,
    updated_at        TIMESTAMPTZ DEFAULT NOW()
);
```

---

#### Week 15 — Action Item Tracker

**What Gets Built:** Every issue resolved in post-DR creates an action item with owner, due date, and tracking. Overdue items escalate automatically. Weekly digest to coordinator.

##### Backend — Java / Spring Boot

**Entities:**
```java
@Entity @Table(name = "action_items")
public class ActionItemEntity {
    @Id UUID id;
    String title;
    String description;
    UUID issueId;                    // nullable — may be standalone
    UUID campaignApplicationId;
    UUID assignedToId;
    UUID assignedById;
    LocalDate dueDate;
    String status;                   // OPEN | IN_PROGRESS | COMPLETED | OVERDUE | CANCELLED
    String priority;                 // LOW | MEDIUM | HIGH | CRITICAL
    Instant completedAt;
    String completionNotes;
    Instant createdAt;
    Instant updatedAt;
}
```

**Services:**
- `ActionItemService`:
  - `createFromIssue(issueId, assignedToId, dueDate)` — auto-called when issue flagged for carry-forward
  - `create(dto, createdById)` — manual creation by coordinator
  - `updateStatus(id, status, notes, userId)`
  - `getMyItems(userId)` — for app owner self-service dashboard
  - `getOverdueItems(coordinatorId)` — for coordinator dashboard widget
  - `getItemsByCampaign(campaignId)`
  - `generateWeeklyDigest(coordinatorId)` → WeeklyDigestDto{overdue[], dueThisWeek[], justCompleted[]}
- `ActionItemReminderScheduler`:
  - `@Scheduled(cron = "0 0 8 * * *")` checkOverdue() — marks OPEN items past dueDate as OVERDUE, sends alert
  - `@Scheduled(cron = "0 0 8 * * MON")` sendWeeklyDigest() — sends digest email to all coordinators and item owners

**Controllers:**
```
GET    /api/action-items?campaignId=&assignedTo=&status=    → filtered list
GET    /api/action-items/my                                  → current user's items
POST   /api/action-items                                     → create [COORDINATOR]
PATCH  /api/action-items/{id}                               → update status/notes
DELETE /api/action-items/{id}                               → cancel [COORDINATOR]
GET    /api/action-items/overdue                            → overdue list [COORDINATOR]
```

##### Database
```sql
CREATE TABLE action_items (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title                   VARCHAR(300) NOT NULL,
    description             TEXT,
    issue_id                UUID REFERENCES issues(id),
    campaign_application_id UUID REFERENCES campaign_applications(id),
    assigned_to_id          UUID NOT NULL REFERENCES users(id),
    assigned_by_id          UUID REFERENCES users(id),
    due_date                DATE NOT NULL,
    status                  VARCHAR(20) DEFAULT 'OPEN',
    priority                VARCHAR(20) DEFAULT 'MEDIUM',
    completed_at            TIMESTAMPTZ,
    completion_notes        TEXT,
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    updated_at              TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX idx_action_items_assignee ON action_items(assigned_to_id, status);
CREATE INDEX idx_action_items_due      ON action_items(due_date, status);
```

---

#### Week 16 — Automated Report Generator

**What Gets Built:** One-click generation of the post-DR Word and PDF report — matching the exact format of the current manually-written Finacle TZ report. Apache POI fills the Word template; iText 7 generates the signed PDF. Reports are watermarked and digitally signed.

##### Backend — Java / Spring Boot

**Services:**
- `ReportGeneratorService`:
  - `generatePostDrReport(campaignApplicationId)` → async, returns reportId immediately; actual generation runs in background via Spring's `@Async`
  - `generateCampaignSummaryReport(campaignId)` → group-level report covering all apps
  - `getReportStatus(reportId)` → GENERATING | READY | FAILED
  - `getDownloadUrl(reportId, requestingUserId)` → creates time-limited (15 min) signed download token, logs in audit trail
- `WordReportBuilder` (Apache POI XWPFDocument):
  - `build(ReportData data)` → returns byte[]
  - `fillDocumentControl(doc, data)` — version, date, author, classification
  - `fillExecutiveSummary(doc, data)` — narrative paragraph auto-generated from execution data
  - `fillScopeAndObjectives(doc, data)`
  - `fillPreFailoverReadiness(doc, data)` — checklist summary table
  - `fillExecutionTimeline(doc, data)` — table: step, owner, started, completed, actual time. Rows colour-coded by outcome.
  - `fillIssuesTable(doc, data)` — issues grouped by severity, each with description/category/resolution/status
  - `fillRiskAssessment(doc, data)` — risk matrix table (likelihood × impact)
  - `fillActionPlan(doc, data)` — action items table with owner + due date
  - `fillLessonsLearned(doc, data)` — narrative from issues and coordinator notes
  - `addWatermark(doc, username, timestamp)` — "CONFIDENTIAL — Generated by {name} on {date}"
  - Uses the EXACT same document structure as the existing Finacle TZ DR report Word file
- `PdfReportBuilder` (iText 7):
  - `build(ReportData data)` → converts Word to PDF via LibreOffice headless conversion OR builds PDF natively
  - `addDigitalSignature(pdfBytes, signingKeystore)` → signs PDF using platform certificate (stored in Vault)

**Async processing:**
```java
@Async("reportExecutor")
public CompletableFuture<ReportEntity> generateAsync(UUID campaignApplicationId) {
    // 1. Load all data: session, steps, issues, outcomes, checklist
    // 2. Build ReportData DTO
    // 3. Generate Word → save to secure file storage
    // 4. Generate PDF → save
    // 5. Sign PDF
    // 6. Add watermark to Word
    // 7. Update report status → READY
    // 8. Notify coordinator via NotificationService
}
```

**Controllers:**
```
POST   /api/reports/generate?campaignApplicationId=   → trigger generation [COORDINATOR]
POST   /api/reports/generate?campaignId=              → group report [COORDINATOR]
GET    /api/reports/{id}/status                       → check generation status
GET    /api/reports/{id}/download?token={token}       → download file (token validated)
GET    /api/reports?campaignId=                       → list reports for campaign
```

##### Database
```sql
CREATE TABLE reports (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_id             UUID REFERENCES campaigns(id),
    campaign_application_id UUID REFERENCES campaign_applications(id),
    report_type             VARCHAR(30),    -- POST_DR_SINGLE | POST_DR_CAMPAIGN | REGULATORY_PACK
    generated_by_id         UUID REFERENCES users(id),
    generated_at            TIMESTAMPTZ,
    status                  VARCHAR(20) DEFAULT 'GENERATING',
    file_path_docx          TEXT,
    file_path_pdf           TEXT,
    file_size_bytes         BIGINT,
    download_token          VARCHAR(64),
    token_expires_at        TIMESTAMPTZ,
    is_digitally_signed     BOOLEAN DEFAULT false,
    watermark_metadata      JSONB,
    error_message           TEXT
);
```

---

#### Week 17 — Management Dashboard

**What Gets Built:** Executive-level view of the entire DR programme. Tier-1 coverage %, RTO compliance trend, top recurring issues, coverage by subsidiary. Read-only — no actions available.

##### Backend
- `ManagementDashboardService`:
  - `getQuarterlyKpis(year, quarter)` → {t1Coverage%, rtoCompliance%, successRate%, openActions}
  - `getCoverageBySubsidiary(campaignId)` → [{subsidiary, total, tested, percentage}]
  - `getRtoComplianceTrend(subsidiaryId, lastNQuarters)` → time-series for line chart
  - `getTopRecurringIssues(subsidiaryId, limit)` → [{category, count, description}]
  - `getTier1CoverageBySubsidiary(year)` → cross-subsidiary T1 coverage matrix

**Controllers:**
```
GET  /api/dashboard/management/kpis           → quarterly KPIs [MANAGEMENT, COORDINATOR]
GET  /api/dashboard/management/coverage       → subsidiary coverage [MANAGEMENT, COORDINATOR]
GET  /api/dashboard/management/rto-trend      → RTO trend data [MANAGEMENT, COORDINATOR]
GET  /api/dashboard/management/recurring-issues → top issues [MANAGEMENT, COORDINATOR]
```

##### Frontend — React / TypeScript (Recharts)
- `ManagementDashboardPage.tsx` — 2×2 KPI cards at top, two charts below, subsidiary table at bottom
- `KpiCard.tsx` — large number, label, trend arrow (up/down from last quarter)
- `SubsidiaryProgressTable.tsx` — horizontal progress bars: KE 80% ████████░░ 12/15
- `RtoComplianceTrendChart.tsx` — multi-line chart: one line per subsidiary, last 4 quarters
- `RecurringIssuesBarChart.tsx` — horizontal bar chart, issue categories sorted by frequency
- `ExportPdfButton.tsx` — exports current dashboard view as PDF [MANAGEMENT role only]

---

#### Week 18 — Application Owner Self-Service Dashboard

**What Gets Built:** App owners no longer need to ask the coordinator what's happening. They log in and see everything relevant to their applications — upcoming DRs, pending tasks, open blockers, action items, and DR history.

##### Frontend — React / TypeScript
- `AppOwnerDashboardPage.tsx` — personalized landing page on login for APP_OWNER role
- `MyUpcomingDrsWidget.tsx` — next DR date, activity type, days away, readiness %
- `MyChecklistWidget.tsx` — items due in next 7 days, blocked items highlighted
- `MyCarriedForwardBlockersWidget.tsx` — outstanding blockers across all owned apps with age
- `MyActionItemsWidget.tsx` — open/overdue action items assigned to me
- `MyDrHistoryWidget.tsx` — last 6 DR results per app (PASSED/PARTIAL/FAILED chips)
- `RunbookStatusWidget.tsx` — current runbook status for each app with deadline countdown

**Service addition:**
- `AppOwnerDashboardService`:
  - `getDashboard(userId)` → AppOwnerDashboardDto{upcomingDrs[], pendingChecklistItems[], carriedForwardBlockers[], actionItems[], drHistory[]}

---

#### Week 19 — Dependency Graph Visualization

**What Gets Built:** Interactive visual map of all application dependencies for a subsidiary. T1 applications highlighted. Shared dependencies shown as thick edges. Campaign applications highlighted in green.

##### Backend
- `DependencyGraphService`:
  - `buildGraphForSubsidiary(subsidiaryId)` → GraphDto{nodes[], edges[]}
    - Node: {id, label, tier, subsidiaryId, hasDr, isInCampaign}
    - Edge: {source, target, type, resourceName, isShared, weight}
  - `buildGraphForCampaign(campaignId)` → same but campaignApps highlighted
  - `getNodeDetails(applicationId)` → full application detail + dependency list

**Controllers:**
```
GET  /api/dependency-graph?subsidiaryId=&campaignId=   → graph data for D3.js
GET  /api/dependency-graph/node/{applicationId}        → node detail panel
```

##### Frontend — React / TypeScript (D3.js)
- `DependencyGraphPage.tsx` — full-screen layout. Sidebar with legend and filters.
- `DependencyGraph.tsx` — D3.js force-directed graph rendered in SVG via useEffect
  - Node colours: T1=red circle, T2=orange circle, T3=blue circle
  - Campaign apps: green highlight ring
  - Edge colours: DATABASE=purple, MIDDLEWARE=orange, NETWORK=gray
  - Shared edges: thicker stroke width (3px vs 1px)
  - Click node: opens ApplicationDetailPanel (slide-in right panel)
  - Hover edge: tooltip showing dependency type + resource name
  - Zoom/pan: D3 zoom behaviour
  - Filter controls: show/hide by tier, show only campaign apps, show only shared deps
- `GraphLegend.tsx` — colour key panel

---

#### Week 20 — DR History & Analytics

**What Gets Built:** Trend data across quarters. RTO improvement over time. Issue category heatmap. Runbook submission compliance rates. Application-level DR history table.

##### Backend
- `AnalyticsService`:
  - `getRtoTrend(applicationId, fromCampaignId, toCampaignId)` → [{quarter, year, targetMinutes, actualMinutes, achieved}]
  - `getSuccessRateByCampaign(campaignId)` → {passed, partial, failed, rolledBack}
  - `getIssueCategoryHeatmap(subsidiaryId, lastNQuarters)` → matrix: quarter × category → count
  - `getRunbookComplianceRate(campaignId)` → {onTime, late, notSubmitted} as percentages
  - `getApplicationDrHistory(applicationId)` → last 8 quarters: {quarter, year, activityType, status, actualRto, issueCount}

**Controllers:**
```
GET  /api/analytics/rto-trend?applicationId=&quarters=     → line chart data
GET  /api/analytics/success-rate?campaignId=               → pie/donut data
GET  /api/analytics/issue-heatmap?subsidiaryId=&quarters=  → heatmap matrix
GET  /api/analytics/runbook-compliance?campaignId=         → compliance breakdown
GET  /api/analytics/application-history?applicationId=     → application DR record
```

##### Frontend — React / TypeScript
- `AnalyticsDashboardPage.tsx` — tabbed: RTO Trends | Issue Analysis | Runbook Compliance | App History
- `RtoTrendChart.tsx` — line chart (Recharts): actual RTO line + target RTO reference line. Green zone = below target.
- `IssueCategoryHeatmap.tsx` — grid: rows=quarters, cols=categories, cell colour = issue count (white→red). Click cell → drill into issues for that quarter/category.
- `RunbookComplianceChart.tsx` — stacked bar: on-time vs late vs not-submitted per campaign
- `ApplicationHistoryTable.tsx` — sortable table with status badges, RTO columns, issue count links

##### End of Phase 3 — Complete When:
- Coordinator sends zero manual reminders — all T-21 to T-3 reminders run automatically ✅
- Manager escalation at T-7 fires automatically — no coordinator action needed ✅
- Post-DR report generated in < 2 minutes after War Room closes ✅
- Management can see Q2 2026 coverage by subsidiary and tier without asking coordinator ✅
- Victor Kiplagat (app owner) logs in to self-service portal and sees everything for his apps ✅
- Dependency graph shows Finacle Core/Treasury sharing EQBLCDB with a thick purple edge ✅

---

### 🚀 Phase 4 — Advanced Features (Weeks 21+)

**Goal:** Platform maturity, external integrations, regulatory evidence automation, and long-term operational intelligence.

---

#### Feature 4.1 — ITSM Integration (ServiceNow)

**What Gets Built:** Auto-create Change Requests in ServiceNow when a War Room is launched. Auto-close CR when War Room completes. CR number synced back to platform.

##### Backend
```java
@Service
public class ServiceNowClient {
    // Spring RestTemplate / WebClient calling ServiceNow REST API
    CreateCrResponse createChangeRequest(ServiceNowCrDto dto);
    void updateChangeRequest(String crNumber, ServiceNowUpdateDto dto);
    void closeCr(String crNumber, String closeCode, String closeNotes);
}

@Service
public class ChangeRequestService {
    // Called at: campaign_application status → IN_EXECUTION
    String createCrForWarRoom(UUID campaignApplicationId);
    // Called at: war_room_session status → COMPLETED/ROLLED_BACK
    void closeCrForWarRoom(UUID sessionId, String outcome);
}
```

**DB changes:**
```sql
ALTER TABLE campaign_applications ADD COLUMN service_now_cr_number VARCHAR(50);
ALTER TABLE campaign_applications ADD COLUMN service_now_cr_sys_id VARCHAR(50);
```

---

#### Feature 4.2 — Risk Scoring Engine

**What Gets Built:** A 0–100 risk score per application, computed from: days since last DR test, issue count (last 3 cycles), dependency complexity, runbook freshness, historical RTO compliance. Used in management dashboard and for prioritising which apps need attention.

##### Backend
```java
@Entity @Table(name = "risk_scores")
public class RiskScoreEntity {
    @Id UUID id;
    UUID applicationId;
    int score;                   // 0=lowest risk, 100=highest risk
    @Column(columnDefinition = "jsonb")
    String components;           // {testAge: 25, issueCount: 30, depComplexity: 15, ...}
    Instant calculatedAt;
}

@Service
public class RiskScoringService {
    // Scheduled weekly: @Scheduled(cron = "0 0 6 * * SUN")
    int calculateRiskScore(UUID applicationId);
    // Factors:
    // - testAge: days since last DR × 0.3 weight
    // - issueCount: issues in last 3 cycles × 0.25 weight
    // - dependencyComplexity: number of shared deps × 0.2 weight
    // - runbookFreshness: days since runbook last updated × 0.15 weight
    // - rtoCompliance: % of last 4 DRs where RTO was met × 0.1 weight
    List<RiskScoreEntity> getHighRiskApplications(String subsidiaryId, int threshold);
}
```

**New API:**
```
GET  /api/risk-scores?subsidiaryId=&tier=   → risk scores for coordinator/management
GET  /api/risk-scores/{applicationId}       → score breakdown for single app
```

---

#### Feature 4.3 — Regulatory Evidence Pack

**What Gets Built:** One-click ZIP export of all evidence required for a regulatory submission — signed reports, audit log extract, RTO compliance summary, and coordinator attestation letter.

##### Backend
```java
@Service
public class EvidencePackService {
    // Generates a ZIP file containing:
    // 01_DR_Campaign_Summary.pdf           (signed)
    // 02_Applications_Tested.xlsx          (Apache POI - tier coverage)
    // 03_Execution_Reports/                (all individual post-DR PDFs, signed)
    // 04_Issues_And_Actions.pdf            (all issues, resolutions, timelines)
    // 05_RTO_Compliance_Summary.pdf
    // 06_Audit_Log_Extract.csv             (signed, tamper-evident SHA-256 hash chain)
    // 07_Attestation_Letter.pdf            (coordinator + ITSCM head names, generated date)
    byte[] generateEvidencePack(UUID campaignId, UUID requestedById);
    // Attestation letter uses WordReportBuilder with attestation template
    // All PDFs digitally signed before inclusion
    // ZIP itself has a manifest file with SHA-256 hash of each included file
}
```

**New API:**
```
POST  /api/evidence-packs/generate?campaignId=   → [COORDINATOR, GROUP_COORDINATOR]
GET   /api/evidence-packs/{id}/download          → time-limited download (30 min token)
```

---

#### Feature 4.4 — External / Vendor Participant Access

**What Gets Built:** Temporary, application-scoped, time-limited War Room access for vendors (Infosys, Oracle Support) who need to join a DR exercise.

##### Backend
```java
@Service
public class ExternalParticipantService {
    // Creates a temporary JWT with restricted claims:
    // - role: EXTERNAL_PARTICIPANT
    // - scope: single war_room_session_id only
    // - expiry: set to DR window end + 2 hours
    ExternalAccessToken createTemporaryAccess(UUID warRoomId, String email, String name, String vendor);
    void revokeAccess(UUID participantId);
    List<WarRoomParticipantEntity> listExternalParticipants(UUID warRoomId);
}

// Spring Batch cleanup job — runs daily:
// Expires all external accounts whose war_room session closed > 24 hours ago
@Scheduled(cron = "0 0 2 * * *")
public void cleanupExpiredExternalAccess() { ... }
```

---

#### Feature 4.5 — Mobile War Room View

**What Gets Built:** Responsive Tailwind CSS War Room for engineers accessing from DR data centre on mobile/tablet. Touch-friendly step status buttons. Simplified view — just your assigned steps.

##### Frontend changes:
- `WarRoomMobileView.tsx` — conditionally rendered when screen width < 768px
- Shows only steps assigned to the current user
- Large touch targets for Start/Done/Block buttons
- RTO timer prominent at top
- Issue log accessible via floating action button
- Same WebSocket connection — full real-time sync

---

#### Feature 4.6 — NOC Integration

**What Gets Built:** Automatically suppress monitoring alerts during DR window. Restore monitoring when War Room closes. Prevents NOC from raising false incidents during planned failover.

##### Backend
```java
@Service
public class NocIntegrationService {
    // Called when War Room status → ACTIVE
    void suppressMonitoringAlerts(UUID applicationId, Instant startTime, Instant endTime);
    // Called when War Room status → COMPLETED/ROLLED_BACK
    void restoreMonitoring(UUID applicationId);
    // Queries NOC tool (Zabbix/Nagios/SolarWinds — configurable) via REST API
    MonitoringStatus getDrMonitoringStatus(UUID applicationId);
}
```

---

#### Phase 4 Summary — What's Included

| Feature | Key Classes | DB Changes | Priority |
|---|---|---|---|
| ServiceNow Integration | `ServiceNowClient`, `ChangeRequestService` | Add CR columns to campaign_applications | HIGH |
| Risk Scoring Engine | `RiskScoringService`, `RiskScoreEntity` | New: risk_scores table | MEDIUM |
| Regulatory Evidence Pack | `EvidencePackService` | New: evidence_packs table | HIGH |
| External Vendor Access | `ExternalParticipantService` | Add vendor columns to war_room_participants | MEDIUM |
| Mobile War Room | `WarRoomMobileView.tsx` | No DB changes | MEDIUM |
| NOC Integration | `NocIntegrationService` | No DB changes | HIGH |

---

## Summary: What Changes for the Coordinator

| Today (Manual) | With the Platform |
|---|---|
| Email each app owner individually | System auto-sends reminders at T-21, T-14, T-10, T-7, T-3 |
| Chase blockers by phone and WhatsApp | Blockers visible on dashboard; system escalates to manager automatically |
| Maintain Excel tracker per DR cycle | All 100+ apps, schedules, and statuses in one screen |
| Run DR from static Excel runbook | Live War Room — steps auto-loaded, real-time tracking, RTO countdown |
| Take notes on issues during the call | Issues logged inline, categorised, assigned, carried forward automatically |
| Manually write post-DR Word report | Report auto-generated from execution data in under 2 minutes |
| Forget Q1 blockers before Q3 DR | Carried-forward blockers appear prominently on next cycle — age tracked |
| One person managing everything | Application owners are accountable and fully self-sufficient |

---

*Roadmap Version 1.0 — Disaster Recovery Management Platform — Equity Bank Group*
*Build Status last updated: 2026-04-01 — Phase 1 Week 1 complete*
*For technical questions contact Group ITSCM | Full technical spec: see CLAUDE.md*
