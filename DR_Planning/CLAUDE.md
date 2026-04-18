# Disaster Recovery Management Platform — CLAUDE.md
> **Project:** Equity Bank Group — Disaster Recovery Management Platform
> **Owner:** Group IT Service Continuity Management (ITSCM)
> **Scope:** All Equity Bank Group subsidiaries (KE, UG, RW, TZ, DRC, SS)
> **Last Updated:** 2026-04-02
> **Status:** Phase 1 — In Progress (Week 1 ✅ Complete, UI heavily built)

---

## ⚠️ PROJECT ISOLATION — READ FIRST

**This is the Equity Bank DR Management Platform. It is a completely independent project.**

| Property | Value |
|---|---|
| **Project root** | `/Users/bishop/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/DR_Planning` |
| **Backend** | `dr-platform/dr-platform-api/` — Java 21 + Spring Boot 3.x |
| **Frontend** | `dr-platform/dr-platform-frontend/` — React 18 + TypeScript + Vite |
| **Database** | PostgreSQL — Flyway managed (V1–V12 applied) |
| **Memory skill** | `.claude/commands/update-memory.md` in THIS project root |

**WizardCD (`/Users/bishop/Desktop/Bishop/Personal/EBB_Systems/WizardCd/`) is a completely separate project.**
- ❌ Never read, edit, or access any file under `WizardCd/` from this project's context
- ❌ Never invoke the WizardCD `update-memory` skill from this project
- ❌ Never apply WizardCD conventions, colour tokens, or deployment vars to this project
- ✅ Use only the skill at `.claude/commands/update-memory.md` in THIS directory

---

## Table of Contents

1. [Problem Statement](#1-problem-statement)
2. [Solution Overview](#2-solution-overview)
3. [DR Activity Taxonomy](#3-dr-activity-taxonomy)
4. [System Architecture](#4-system-architecture)
5. [Database Schema](#5-database-schema)
6. [Workflow Engine Design](#6-workflow-engine-design)
7. [Module Descriptions](#7-module-descriptions)
7b. [Runbook Enforcement Design](#7b-runbook-enforcement-design)
8. [UI Mockups](#8-ui-mockups)
9. [Phased Roadmap](#9-phased-roadmap)
10. [API Design](#10-api-design)
11. [Tech Stack](#11-tech-stack)
12. [Non-Functional Requirements](#12-non-functional-requirements)
13. [Development Guidelines](#13-development-guidelines)
14. [Security Architecture](#14-security-architecture)

---

## 1. Problem Statement

Equity Bank Group operates **100+ mission-critical applications** across 6 subsidiaries. Every quarter, a **Disaster Recovery (DR) exercise** is conducted for a subset of these applications. This process is currently:

- Coordinated by **a single person** using multiple Excel spreadsheets
- Tracked via manual emails, WhatsApp messages, and phone calls
- Documented in Word documents **post-exercise** (not in real-time)
- Extremely difficult to follow up on — blockers from one DR cycle are forgotten before the next
- No visibility for application owners on what they need to prepare
- No structured runbook execution — engineers work from static Excel sheets
- Post-DR reports are manually assembled from notes taken during the call

**Key pain points identified from actual DR exercise (March 2026 — Finacle TZ):**
- Critical roles (DBA, DevOps, NOC) were not present at start of exercise
- Manual configuration changes (TNS entries, WebLogic datasources, DB connection strings) increased risk
- Way4 transactions failing (RC 907/904) — took time to diagnose
- Treasury IP configuration wrong after failover — manual correction required
- External dependency failures (DNB Credit Bureau) had no structured tracking
- DR monitoring for TZ not visible in NOC dashboards
- Coordinator had to manually follow up with every team via calls

---

## 2. Solution Overview

A **web-based DR Management Platform** that replaces all Excel sheets, Word documents, and manual coordination with a single intelligent system covering:

| Capability | Description |
|---|---|
| **Application Registry** | Catalog of all 100+ apps with metadata, tiers, owners, dependencies |
| **Dependency Graph** | Smart engine that maps shared databases, middleware, integrations |
| **Campaign Planning** | Quarterly DR campaign builder with smart scheduling and conflict detection |
| **Pre-DR Readiness** | Structured checklist per app with blocker history and owner accountability |
| **Runbook Builder** | Structured step-by-step runbooks with phases, ownership, and commands |
| **War Room (Live Execution)** | Real-time DR execution tracker with step status, issues, and timer |
| **Post-DR Review** | Per-application outcome recording with comments, blockers, and action items |
| **Blocker Intelligence** | Blockers from past DR cycles are visible in the next DR — resolved or not |
| **Report Generator** | Auto-generates post-DR Word/PDF reports matching regulatory templates |
| **Dashboard** | Coordinator, management, and application-owner specific views |
| **Notifications** | Email + WhatsApp/SMS alerts for pre-DR tasks, blockers, and escalations |

---

## 3. DR Activity Taxonomy

The platform supports all known DR activity types used at Equity Bank:

| Code | Activity Type | Description |
|---|---|---|
| `FULL_FAILOVER` | Full Failover | DC App + DC DB → DR App + DR DB |
| `APP_ONLY` | App-Only Failover | DC App → DR App (DB stays in DC) |
| `DB_ONLY` | DB-Only Failover | App stays in DC, DB switches to DR (Oracle DG) |
| `APP_REPOINT` | App Repoint | DC App reconfigured to point to DR DB (no app move) |
| `PARTIAL` | Partial Failover | Subset of services fail over (e.g., Core Banking, not Treasury) |
| `ACTIVE_ACTIVE` | Active-Active | Both DC and DR serving traffic simultaneously |
| `ROLLBACK_DRILL` | Rollback Drill | Explicitly testing the return-to-DC procedure |
| `COLD_STANDBY` | Cold Standby Activation | DR was off — bring it up from scratch |
| `TABLETOP` | Tabletop / Simulated | Walkthrough only, no actual system movement |
| `EXTENDED_OPS` | Extended DR Operations | Test running from DR for ≥30 days |

---

## 4. System Architecture

```
╔══════════════════════════════════════════════════════════════════════════════════╗
║                     DR MANAGEMENT PLATFORM — SYSTEM ARCHITECTURE                ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║                                                                                  ║
║   CLIENTS                                                                        ║
║   ┌─────────────────────┐  ┌─────────────────────┐  ┌──────────────────────┐   ║
║   │  Coordinator Web UI  │  │  App Owner Web UI   │  │  Management Reports  │   ║
║   │  (React + TS)        │  │  (React + TS)       │  │  (Read-Only View)    │   ║
║   └──────────┬──────────┘  └──────────┬──────────┘  └──────────┬───────────┘   ║
║              └────────────────────────┼───────────────────────-─┘               ║
║                                       │                                          ║
║   ┌───────────────────────────────────▼──────────────────────────────────────┐  ║
║   │                         API GATEWAY (REST + WebSocket)                    │  ║
║   │   Java 21 · Spring Boot 3.x · Spring Security 6 · JWT + LDAP/AD SSO      │  ║
║   └───────────┬──────────────────────────┬───────────────────────────────────┘  ║
║               │                          │                                       ║
║   ┌───────────▼────────────┐  ┌──────────▼───────────────────────────────────┐ ║
║   │   CORE SERVICE LAYER   │  │           REAL-TIME ENGINE                    │ ║
║   │                        │  │           (Spring WebSocket + STOMP)          │ ║
║   │  ┌────────────────┐    │  │   War Room live updates, step completions,    │ ║
║   │  │ App Registry   │    │  │   issue alerts, timer broadcasts              │ ║
║   │  │ & Dependency   │    │  └──────────────────────────────────────────────┘ ║
║   │  │ Engine         │    │                                                    ║
║   │  └────────────────┘    │  ┌──────────────────────────────────────────────┐ ║
║   │  ┌────────────────┐    │  │           BACKGROUND JOB QUEUE               │ ║
║   │  │ Campaign &     │    │  │           (Spring Scheduler + Spring Batch)   │ ║
║   │  │ Schedule Mgr   │    │  │                                               │ ║
║   │  └────────────────┘    │  │  - Pre-DR reminder emails (T-7, T-3, T-1)    │ ║
║   │  ┌────────────────┐    │  │  - Blocker escalation alerts                 │ ║
║   │  │ Runbook        │    │  │  - Action item due-date notifications         │ ║
║   │  │ Engine         │    │  │  - Post-DR summary digest                    │ ║
║   │  └────────────────┘    │  └──────────────────────────────────────────────┘ ║
║   │  ┌────────────────┐    │                                                    ║
║   │  │ Pre-DR         │    │  ┌──────────────────────────────────────────────┐ ║
║   │  │ Readiness      │    │  │           REPORT GENERATOR                   │ ║
║   │  └────────────────┘    │  │           (Apache POI (Word) + iText 7 (PDF))│ ║
║   │  ┌────────────────┐    │  │                                               │ ║
║   │  │ War Room       │    │  │  Generates regulatory-grade post-DR reports  │ ║
║   │  │ Executor       │    │  │  matching Equity Bank document templates      │ ║
║   │  └────────────────┘    │  └──────────────────────────────────────────────┘ ║
║   │  ┌────────────────┐    │                                                    ║
║   │  │ Post-DR Review │    │  ┌──────────────────────────────────────────────┐ ║
║   │  │ & Blocker Mgr  │    │  │           NOTIFICATION SERVICE               │ ║
║   │  └────────────────┘    │  │                                               │ ║
║   └────────────────────────┘  │  Email (SMTP), SMS/WhatsApp (Africa's Talking│ ║
║                               │  or equivalent bank-approved gateway)         │ ║
║                               └──────────────────────────────────────────────┘ ║
║                                                                                  ║
║   ┌──────────────────────────────────────────────────────────────────────────┐  ║
║   │                        PostgreSQL DATABASE                                │  ║
║   │                                                                           │  ║
║   │  applications | dependencies | campaigns | campaign_applications         │  ║
║   │  runbooks | runbook_steps | dr_executions | execution_steps              │  ║
║   │  pre_dr_checklist_items | post_dr_outcomes | issues | action_items       │  ║
║   │  contacts | notifications | audit_log | users | roles                    │  ║
║   └──────────────────────────────────────────────────────────────────────────┘  ║
╚══════════════════════════════════════════════════════════════════════════════════╝
```

---

## 5. Database Schema

### Core Tables

```sql
-- Applications Registry
CREATE TABLE applications (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            VARCHAR(200) NOT NULL,
    tier            VARCHAR(5)  NOT NULL CHECK (tier IN ('T1','T2','T3')),
    has_dr          BOOLEAN NOT NULL DEFAULT false,
    subsidiaries    TEXT[] NOT NULL,           -- ['KE','TZ','UG','RW','DRC','SS']
    description     TEXT,
    direct_customer_impact BOOLEAN DEFAULT false,
    has_interdependency    BOOLEAN DEFAULT false,
    dc_endpoint     TEXT,
    dr_endpoint     TEXT,
    tech_owner_id   UUID REFERENCES users(id),
    business_owner  VARCHAR(200),
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Dependency Mapping (e.g., App A depends on DB X which is also used by App B)
CREATE TABLE dependencies (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    application_id  UUID REFERENCES applications(id) ON DELETE CASCADE,
    depends_on_id   UUID REFERENCES applications(id) ON DELETE CASCADE, -- can ref another app (e.g., SOA, SMSC)
    dependency_type VARCHAR(50) CHECK (dependency_type IN (
        'DATABASE','MIDDLEWARE','NETWORK','API','AUTH','DNS','VPN','OTHER'
    )),
    description     TEXT,
    is_shared       BOOLEAN DEFAULT false,  -- true = other apps also depend on this
    UNIQUE(application_id, depends_on_id)
);

-- Quarterly DR Campaigns
CREATE TABLE campaigns (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            VARCHAR(200) NOT NULL,   -- e.g., "Q2 2026 DR Campaign"
    quarter         VARCHAR(10) NOT NULL,    -- 'Q1','Q2','Q3','Q4'
    year            INTEGER NOT NULL,
    subsidiary      VARCHAR(10),             -- NULL = group-wide
    coordinator_id  UUID REFERENCES users(id),
    status          VARCHAR(30) DEFAULT 'DRAFT' CHECK (status IN (
        'DRAFT','ACTIVE','IN_PROGRESS','COMPLETED','CANCELLED'
    )),
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Applications enrolled in a campaign
CREATE TABLE campaign_applications (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_id       UUID REFERENCES campaigns(id) ON DELETE CASCADE,
    application_id    UUID REFERENCES applications(id),
    activity_type     VARCHAR(30) NOT NULL,  -- see DR Activity Taxonomy
    scheduled_date    DATE,
    scheduled_time    TIME,
    rto_minutes       INTEGER,
    rpo_minutes       INTEGER,
    status            VARCHAR(30) DEFAULT 'PLANNED' CHECK (status IN (
        'PLANNED','PRE_DR_OPEN','APPROVED','IN_EXECUTION',
        'VALIDATION','COMPLETED','ROLLED_BACK','CANCELLED','DEFERRED'
    )),
    UNIQUE(campaign_id, application_id)
);

-- Structured Runbooks (per application)
CREATE TABLE runbooks (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    application_id  UUID REFERENCES applications(id),
    version         VARCHAR(20) NOT NULL DEFAULT '1.0',
    cr_number       VARCHAR(50),             -- e.g., CHG0033975
    is_active       BOOLEAN DEFAULT true,
    created_by      UUID REFERENCES users(id),
    approved_by     UUID REFERENCES users(id),
    approved_at     TIMESTAMPTZ,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Runbook Steps (structured, per phase)
CREATE TABLE runbook_steps (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    runbook_id      UUID REFERENCES runbooks(id) ON DELETE CASCADE,
    phase           VARCHAR(30) NOT NULL CHECK (phase IN (
        'PRE_CUTOVER','CUTOVER','DR_VALIDATION','ROLLBACK','POST_DR'
    )),
    sequence        INTEGER NOT NULL,
    title           VARCHAR(300) NOT NULL,
    description     TEXT,
    commands        TEXT,                    -- exact CLI / console commands
    estimated_mins  INTEGER,
    requires_downtime BOOLEAN DEFAULT false,
    owner_role      VARCHAR(100),            -- e.g., 'DBA', 'DevOps', 'App Owner'
    verification_steps TEXT,
    UNIQUE(runbook_id, phase, sequence)
);

-- Live DR Execution record
CREATE TABLE dr_executions (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_app_id     UUID REFERENCES campaign_applications(id),
    started_at          TIMESTAMPTZ,
    completed_at        TIMESTAMPTZ,
    outcome             VARCHAR(30) CHECK (outcome IN (
        'SUCCESS','PARTIAL_SUCCESS','FAILED','ROLLED_BACK','ABANDONED'
    )),
    actual_rto_minutes  INTEGER,
    war_room_notes      TEXT,
    executed_by         UUID REFERENCES users(id)
);

-- Execution step tracking (live updates during War Room)
CREATE TABLE execution_steps (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    execution_id    UUID REFERENCES dr_executions(id),
    runbook_step_id UUID REFERENCES runbook_steps(id),
    status          VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN (
        'PENDING','IN_PROGRESS','DONE','BLOCKED','SKIPPED'
    )),
    started_at      TIMESTAMPTZ,
    completed_at    TIMESTAMPTZ,
    notes           TEXT,
    executed_by     UUID REFERENCES users(id)
);

-- Pre-DR Checklist Items (owned by each application owner)
CREATE TABLE pre_dr_checklist_items (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_app_id     UUID REFERENCES campaign_applications(id),
    title               VARCHAR(300) NOT NULL,
    description         TEXT,
    owner_id            UUID REFERENCES users(id),
    due_date            DATE,
    status              VARCHAR(30) DEFAULT 'PENDING' CHECK (status IN (
        'PENDING','IN_PROGRESS','BLOCKED','DONE','VERIFIED'
    )),
    blocker_description TEXT,
    blocker_source      VARCHAR(30) CHECK (blocker_source IN (
        'INTERNAL','VENDOR','NETWORK','DBA','INFRA','OTHER'
    )),
    -- Link to previous DR cycle's unresolved item
    carried_from_id     UUID REFERENCES pre_dr_checklist_items(id),
    resolved_at         TIMESTAMPTZ,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

-- Post-DR Application Outcomes
CREATE TABLE post_dr_outcomes (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    execution_id        UUID REFERENCES dr_executions(id),
    application_id      UUID REFERENCES applications(id),
    status              VARCHAR(30) CHECK (status IN (
        'PASSED','PARTIAL','FAILED','NOT_TESTED','EXCLUDED'
    )),
    app_owner_comment   TEXT,
    coordinator_comment TEXT,
    submitted_by        UUID REFERENCES users(id),
    submitted_at        TIMESTAMPTZ DEFAULT NOW()
);

-- Issues log (raised during pre-DR, execution, or post-DR)
CREATE TABLE issues (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    execution_id    UUID REFERENCES dr_executions(id),
    application_id  UUID REFERENCES applications(id),
    phase           VARCHAR(30) CHECK (phase IN ('PRE_DR','CUTOVER','VALIDATION','POST_DR')),
    category        VARCHAR(30) CHECK (category IN (
        'PEOPLE','TECHNICAL','CONFIGURATION','EXTERNAL_DEPENDENCY',
        'FUNCTIONAL_TEST','MONITORING','PROCESS','OTHER'
    )),
    title           VARCHAR(300) NOT NULL,
    description     TEXT,
    severity        VARCHAR(20) CHECK (severity IN ('CRITICAL','HIGH','MEDIUM','LOW')),
    status          VARCHAR(30) DEFAULT 'OPEN' CHECK (status IN (
        'OPEN','IN_PROGRESS','RESOLVED','WONT_FIX','CARRIED_FORWARD'
    )),
    owner_id        UUID REFERENCES users(id),
    resolution      TEXT,
    resolved_at     TIMESTAMPTZ,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Action Items (follow-ups from issues or lessons learned)
CREATE TABLE action_items (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    issue_id        UUID REFERENCES issues(id),
    campaign_id     UUID REFERENCES campaigns(id),
    title           VARCHAR(300) NOT NULL,
    description     TEXT,
    owner_id        UUID REFERENCES users(id),
    priority        VARCHAR(20) CHECK (priority IN ('HIGH','MEDIUM','LOW')),
    due_date        DATE,
    status          VARCHAR(30) DEFAULT 'OPEN' CHECK (status IN (
        'OPEN','IN_PROGRESS','DONE','OVERDUE','DEFERRED'
    )),
    -- If not resolved, this action item is linked to next campaign's pre-DR
    next_campaign_id UUID REFERENCES campaigns(id),
    created_at      TIMESTAMPTZ DEFAULT NOW()
);
```

---

## 6. Workflow Engine Design

The platform implements a **formal state machine** for every DR activity. This ensures no step is skipped, every transition is tracked, and the system knows what phase it's in at all times.

### Campaign Application State Machine

```
                    ┌─────────────────────────────────────────────────┐
                    │                                                   │
    CREATE ──► PLANNED ──► PRE_DR_OPEN ──► APPROVED ──► IN_EXECUTION  │
                  │                            │              │         │
                  │                       DEFERRED        VALIDATION   │
                  │                                           │         │
                  └── CANCELLED              ROLLED_BACK ◄───┤         │
                                                              │         │
                                             COMPLETED ◄──────┘         │
                                                                        │
                                                        POST_DR_REVIEW ◄┘
```

### Pre-DR Checklist Item States

```
    PENDING ──► IN_PROGRESS ──► BLOCKED ──► IN_PROGRESS
                    │               │
                    ▼               ▼
                   DONE         CARRIED_FORWARD (to next campaign)
                    │
                    ▼
                 VERIFIED (confirmed by coordinator)
```

### Runbook Step Execution States (War Room)

```
    PENDING ──► IN_PROGRESS ──► DONE
                    │
                    ▼
                 BLOCKED ──► IN_PROGRESS (once unblocked)
                    │
                    ▼
                 SKIPPED (with mandatory justification note)
```

### Workflow Automation Rules

| Trigger | Action |
|---|---|
| Campaign created with scheduled date | Pre-DR checklist items auto-created from runbook template |
| T-7 days before DR date | Email sent to all application owners: "Pre-DR tasks due in 7 days" |
| T-3 days before DR date | Email + SMS to owners with PENDING / BLOCKED items |
| T-1 day before DR date | Escalation email to coordinator listing all unresolved blockers |
| Checklist item marked BLOCKED | Immediate notification to coordinator + application owner manager |
| DR Execution started | War room auto-opens, all step owners notified via email + SMS |
| Runbook step BLOCKED in War Room | Alert fires to coordinator + escalation contact |
| All post-DR outcomes submitted | System prompts report generation |
| Action item overdue | Weekly digest to coordinator + item owner |
| Unresolved blocker at campaign close | Auto-carried to next campaign's pre-DR checklist |

---

## 7. Module Descriptions

### Module 1: Application Registry & Dependency Engine

**Purpose:** Single source of truth for all 100+ Equity Bank applications.

**Key Features:**
- Full CRUD for application records (tier, subsidiaries, DR status, owners)
- Dependency mapping: Application → Database, Middleware, Network, API
- Dependency graph visualization (D3.js force graph)
- **Smart conflict detection:** When scheduling two apps that share a DB in the same window, the system warns the coordinator
- Import from existing Excel tracker (migration tool)
- Per-app DR history showing all past campaigns and outcomes

**Critical Dependencies from Current Data:**
- `SOA` — depended on by: EazzyBiz, MFS, GAG, Pesalink
- `SMSC / SMC` — depended on by: all apps requiring SMS notifications
- `Finacle Core DB` — shared by Finacle Core + Finacle Treasury + Newgen + Omni
- `WAY4` — depends on: Finacle Core, SMSC
- `MFS (STK, MGW, OTA)` — shared infrastructure block

---

### Module 2: Campaign Manager

**Purpose:** Plan and schedule quarterly DR exercises across all applications.

**Key Features:**
- Create campaign per quarter/subsidiary
- Add applications with activity type, date, time, RTO/RPO targets
- **Dependency conflict detection** — warns if shared DB scheduled twice
- Bulk import from Excel schedule
- Campaign dashboard showing % readiness (pre-DR checklist completion)
- Campaign approval workflow: Draft → Coordinator Review → Management Approval → Active

---

### Module 3: Pre-DR Readiness Tracker ⭐ (Key Smart Module)

**Purpose:** Eliminate the coordinator's manual follow-up burden. Every application owner sees exactly what they need to do and when.

**Key Features:**
- Auto-generated checklist per application from its runbook template
- Each checklist item has: title, owner, due date, status, blocker description
- **Blocker History Panel:** Shows blockers from the LAST DR cycle for this application:
  - Was the blocker resolved? When? By whom?
  - If NOT resolved — it appears as a RED carried-forward item with age counter
- Owner dashboard: "My Pre-DR Tasks" — filtered to their applications only
- Coordinator view: All applications, all statuses in one grid
- Color coding: 🟢 Done, 🟡 In Progress, 🔴 Blocked, ⚫ Not Started, 🔵 Verified
- Bulk reminder: Coordinator can send reminder to all owners with pending items in one click

---

### Module 4: Runbook Builder

**Purpose:** Replace static Excel runbooks with structured, versioned, executable runbooks.

**Key Features:**
- Structured phases: Pre-Cutover → Cutover → DR Validation → Rollback → Post-DR
- Each step has: sequence, title, description, exact commands (formatted code block), owner role, estimated duration, downtime flag, verification steps
- **Version control** — every runbook change creates a new version; old versions retained
- CR number attached to each runbook version
- Runbook templates (reusable across similar applications)
- Approved runbooks are locked — changes require new version
- Approval workflow: Author → Peer Review → ITSCM Approval → Locked
- **Contacts tab** built into runbook (primary + escalation contacts per role)
- **Impacted Services tab** — list of services to test post-failover, with technical owner

---

### Module 5: War Room (Live Execution) ⭐

**Purpose:** Real-time execution tracker — the digital "war room" during a DR exercise.

**Key Features:**
- One screen per DR activity showing all runbook steps in sequence
- Timer running against RTO window (green → amber → red as time passes)
- Each step: click to mark In Progress → Done, or flag as Blocked
- When a step is flagged Blocked: modal to capture blocker description + category + severity
- Issues auto-logged from blocked steps
- Live participant view: who is on the call (presence indicators)
- Notes field for war room coordinator
- All updates broadcast in real-time via WebSocket to all participants
- Evidence capture: attach screenshots, log files, or confirmation messages to any step
- Rollback trigger: one-click to switch execution to Rollback phase

---

### Module 6: Post-DR Review & Blocker Intelligence ⭐

**Purpose:** Capture outcomes per application, record issues, and feed unresolved items into the next DR cycle.

**Key Features:**
- After execution, each application owner receives a link to submit their post-DR outcome
- Per-application outcome form: Status (Passed/Partial/Failed), comment, issues encountered
- Coordinator can add comments per application
- Issues from the War Room auto-appear here — owners can update resolution status
- **Blocker Intelligence Engine:**
  - Unresolved issues at campaign closure are tagged as `CARRIED_FORWARD`
  - On the NEXT campaign for the same application, these blockers appear prominently:
    - "⚠ UNRESOLVED from Q1 2026: Treasury IP misconfiguration after failover"
    - Shows: age (days), severity, original description, current resolution notes
  - Owner must acknowledge and either resolve or escalate each carried-forward item
- Action items auto-created from each unresolved issue with owner and due date

---

### Module 7: Report Generator

**Purpose:** Auto-generate the post-DR report (currently the Word document manually written).

**Key Features:**
- Based on the actual Equity Bank report template (Finacle TZ format)
- Pulls all data from: execution record, issues, outcomes, contacts
- Sections auto-populated:
  - Document Control (title, country, DR type, status, classification)
  - Executive Summary (dynamically written based on outcome)
  - Scope (from campaign application record)
  - Pre-Failover Readiness Assessment (from pre-DR checklist completion %)
  - Failover Execution Summary (from execution steps + timings)
  - Issues Identified (from issues table, categorized)
  - Risk Assessment (computed from issue severities)
  - Action Plan (from action items)
  - Conclusion
- Export to PDF and DOCX
- Version tracking — multiple report versions per campaign application

---

### Module 8: Dashboard & Analytics

**Coordinator Dashboard:**
- Upcoming DR activities (next 30 days) with readiness %
- Applications with unresolved blockers
- Overdue action items (with owner, days overdue)
- Current campaign progress (pie chart: Planned / In Progress / Done / Failed)

**Management Dashboard:**
- Quarterly DR coverage by tier (% of T1 apps tested)
- Success rate by quarter and subsidiary
- Top recurring issues across campaigns
- RTO compliance (actual vs target)
- Applications never tested

**Application Owner Dashboard:**
- My applications and their DR status
- My pre-DR tasks due this cycle
- My unresolved blockers from last cycle
- My post-DR outcomes pending submission

---

---

## 7b. Runbook Enforcement Design

> Enforcement ensures runbooks are completed, reviewed, and approved well before DR day — automatically, without the coordinator having to chase anyone manually.

### The Six Enforcement Layers

```
LAYER 1 — AUTOMATED TIMELINE DEADLINES
LAYER 2 — PROGRESSIVE NOTIFICATION ESCALATION
LAYER 3 — HARD WORKFLOW GATES (cannot be bypassed)
LAYER 4 — SMART APP OWNER UX (make it easy to fill)
LAYER 5 — COORDINATOR VISIBILITY DASHBOARD
LAYER 6 — SOCIAL ACCOUNTABILITY (manager escalation)
```

### Layer 1 — Automated Timeline (Auto-Calculated from DR Date)

When coordinator creates a campaign and sets DR date, the system auto-calculates all deadlines:

| Milestone | Days Before DR | What Happens |
|---|---|---|
| Campaign created | T-21+ | Runbook review task auto-created for every app owner |
| Runbook submission deadline | T-14 | App owner must submit runbook for peer review |
| Peer review deadline | T-10 | Assigned peer reviewer must approve or return |
| ITSCM approval deadline | T-7 | Coordinator must approve — **CAMPAIGN BLOCKED if not met** |
| Final escalation | T-3 | Manager + Coordinator alerted — campaign flagged CANNOT PROCEED |
| War Room gate | T-0 | **War Room cannot launch without approved runbook — hard block** |

These deadlines are visible to the app owner **from campaign creation** — no surprises.

### Layer 2 — Progressive Notification Escalation

| When | Who Gets Notified | Channel | Tone |
|---|---|---|---|
| T-21 (campaign created) | App Owner | Email | Friendly — "Your DR is in 3 weeks. Please start runbook review." |
| T-14 (if not started) | App Owner | Email | Urgent — "Submission due TODAY. 0% complete." |
| T-14 (coordinator) | Coordinator | Email | Awareness — "3 apps haven't started their runbooks." |
| T-10 (if not submitted) | App Owner + Coordinator | Email + SMS | Warning — "Campaign at risk. Coordinator notified." |
| T-7 (if not approved) | App Owner + Coordinator + **Line Manager** | Email + SMS | Escalation — manager is now aware |
| T-3 (if not approved) | All parties | Email + SMS | Critical — campaign flagged CANNOT PROCEED |
| T-1 (if not approved) | All parties | Email + SMS | War Room blocked |

**Key design decision:** Manager escalation at T-7 is the single most effective enforcement mechanism. Nobody wants their manager asking why they are blocking a DR exercise.

### Layer 3 — Hard Workflow Gates

These are system-level blocks — not dismissable warnings:

```
PRE_DR_OPEN
     │
     │ Gate check at T-7:
     │   ✅ Runbook exists for this app?
     │   ✅ Runbook status = APPROVED?
     │   ✅ All phases have at least 1 step?
     │   ✅ All steps have: role, duration, verification criteria?
     │   ✅ Quality score ≥ 70/100?
     │
     ▼
APPROVED ← Only reachable if ALL checks pass for ALL apps in campaign
     │
     ▼
WAR ROOM ← Launch button disabled until APPROVED runbook confirmed
```

If coordinator tries to approve a campaign with missing runbooks:

```
⛔ CANNOT APPROVE CAMPAIGN

The following applications do not have approved runbooks:
• SOA           — Not submitted (Faith Githaiga) — 9 days overdue
• Autobranch    — Draft, not submitted for peer review (Annet Ayuko)
• Efront        — Peer review pending (assigned to James, 3 days)

Options:
[Remove apps from campaign]  [Defer campaign]
[Send reminders to all]      [Request exception + log reason]
```

### Layer 4 — Smart App Owner UX

**Pre-population (most impactful UX feature):**
If a previous approved runbook exists, the system pre-fills the new runbook from it.
The app owner reviews and updates — not writes from scratch.
This reduces runbook effort from ~3 hours to ~35 minutes.

```
✨ We found your Q1 2026 runbook (v1.3, approved).
   We've pre-filled this runbook from your last approved version.
   Please review each step, update anything that has changed, and submit.
   Estimated time: ~35 minutes.
   [Start Review →]    [Start from scratch]
```

**Runbook quality validator (before submission):**
System checks quality before submission is allowed:

```
RUNBOOK QUALITY CHECK — SOA v1.4
✅  Pre-Cutover phase — 6 steps, all complete
⚠️   Cutover — Step 5 missing verification criteria
❌  DR Validation phase — 0 steps defined
❌  Rollback phase — 0 steps defined

Quality Score: 52/100 — Minimum to submit: 70/100
[Fix Issues →]
```

**Persistent in-app banner (cannot be ignored):**
Appears on EVERY page until runbook is submitted. Colour changes by urgency:
- 14+ days: Blue (informational)
- 7–14 days: Yellow (warning)
- 3–7 days: Orange (urgent)
- <3 days: Red (critical)

**Progress bar per phase:**
Shows completion percentage per phase so owner can see exactly what's left — not just "incomplete."

### Layer 5 — Coordinator Runbook Dashboard

```
RUNBOOK STATUS — Q2 2026           [Send All Reminders]
────────────────────────────────────────────────────────
Application    Owner     Deadline   Status         Action
────────────────────────────────────────────────────────
Finacle Core   Charles   31 May     ✅ Approved
Clear Vision   Victor    31 May     ✅ Approved
Efront         Marion    31 May     🔄 In Review   [Remind peer]
SOA            Faith     31 May     🟡 Draft 52%   [Remind] [Call]
Autobranch     Annet     31 May     🔴 Not Started [Remind] [Escalate]
               ← OVERDUE 3 days
────────────────────────────────────────────────────────
Summary: 2 approved · 1 in review · 1 draft · 1 not started
⚠️  Campaign is AT RISK — 2 apps without approved runbooks
```

Coordinator can send individual or bulk reminders from this screen without leaving the dashboard.

### Layer 6 — Social Accountability

| Mechanism | How It Works | Why It Works |
|---|---|---|
| **Manager copy at T-7** | Line manager receives escalation email | Nobody wants manager asking why they're blocking DR |
| **Peer reviewer accountability** | Reviewer also escalated if review not done by T-10 | Two people are accountable, not one |
| **Management dashboard** | CTO/CIO sees runbook readiness % per subsidiary | Creates top-down pressure |
| **Submission history** | Each app owner's profile shows "On time: 3/4 quarters" | Visible to coordinator and management |
| **Campaign readiness %** | All owners see aggregate readiness (not each other's content) | Creates peer pressure |

### Runbook Approval State Machine

```
NOT_STARTED
     │ App owner begins editing
     ▼
DRAFT (auto-saved, visible to owner only)
     │ Owner submits — quality check passes (≥70/100)
     ▼
SUBMITTED_FOR_REVIEW
     │ Peer reviewer approves or returns with comments
     ├──► RETURNED_FOR_REVISION (back to DRAFT with comments)
     ▼
PEER_APPROVED
     │ ITSCM Coordinator reviews and approves
     ├──► RETURNED_FOR_REVISION (back to DRAFT with comments)
     ▼
APPROVED & LOCKED (version stamped, e.g. v2.1)
     │ No further edits allowed on this version
     │ New edits require creating v2.2 and re-approving
     ▼
USED_IN_WAR_ROOM (snapshot taken at launch — immutable record)
```

---

## 8. UI Mockups

### 8.1 — Coordinator Dashboard

```
╔══════════════════════════════════════════════════════════════════════════════════╗
║  🏛 EQUITY DR PLATFORM                    Q2 2026 Campaign     [+ New Campaign]  ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  👋 Welcome, Coordinator                                           🔔 3 Alerts   ║
╠════════════════════════╦═════════════════════╦══════════════════════════════════╣
║  📊 CAMPAIGN PROGRESS  ║  ⏰ UPCOMING DRs    ║  🚨 UNRESOLVED BLOCKERS          ║
║                        ║                     ║                                   ║
║   Total Apps:  43      ║  23 Apr — Efront    ║  ⚫ WAY4 — IP Config [15 days]   ║
║   ████████░░  74%      ║    Pre-DR: 🟡 60%   ║  ⚫ SOA — DB Creds [8 days]     ║
║   Ready                ║                     ║  ⚫ Finacle TZ — DBA [3 days]   ║
║                        ║  15 May — Clear Vis ║                                   ║
║   ✅ Done:      12     ║    Pre-DR: 🟢 90%   ║  [View All 7 Blockers →]         ║
║   🔄 In Prog:    8     ║                     ║                                   ║
║   🔴 Blocked:    5     ║  16 May — Autobranch║  📋 OVERDUE ACTIONS              ║
║   ⚫ Pending:   18     ║    Pre-DR: 🔴 20%   ║                                   ║
║                        ║                     ║  Action            Owner  Days    ║
║   [View Campaign →]    ║  [See Full Calendar]║  Enable NOC TZ mon  NOC   +12    ║
║                        ║                     ║  Update Runbook SOA ITSCM +5     ║
╚════════════════════════╩═════════════════════╩══════════════════════════════════╝
```

---

### 8.2 — Pre-DR Readiness View (Coordinator Grid)

```
╔══════════════════════════════════════════════════════════════════════════════════╗
║  📋 PRE-DR READINESS — Q2 2026 Campaign                [Send All Reminders] [📥] ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  Filter: [All Subsidiaries ▼]  [All Tiers ▼]  [Show Blocked Only □]             ║
╠══════════════════════════╦═══════════╦═════════╦══════════╦════════╦═══════════╣
║  Application             ║ Date      ║ Owner   ║ Checklist║ Status ║ Blockers  ║
╠══════════════════════════╬═══════════╬═════════╬══════════╬════════╬═══════════╣
║  Efront                  ║ 23 Apr    ║ Marion  ║ ████ 80% ║ 🟡     ║ 1 open   ║
║    ⚠ CARRIED: Weblogic   ║           ║ Kinyanjui║         ║        ║ [View]   ║
║    console creds Q1 2026 ║           ║         ║          ║        ║          ║
╠══════════════════════════╬═══════════╬═════════╬══════════╬════════╬═══════════╣
║  Clear Vision            ║ 15 May    ║ Victor  ║ ████████ ║ 🟢     ║ 0 open   ║
║                          ║           ║ Kiplagat║  100%    ║ Ready  ║          ║
╠══════════════════════════╬═══════════╬═════════╬══════════╬════════╬═══════════╣
║  Autobranch              ║ 16 May    ║ Annet   ║ ██░░░░░░ ║ 🔴     ║ 2 open   ║
║    🔴 Blocker: DR DB conn ║           ║ Ayuko   ║  20%     ║ At Risk║ [View]   ║
║    not syncing since Q4   ║           ║         ║          ║        ║ [Escalate]║
╠══════════════════════════╬═══════════╬═════════╬══════════╬════════╬═══════════╣
║  K Printer (SWIFT)       ║ 13 Jun    ║ Richard ║ ██████░░ ║ 🟡     ║ 0 open   ║
║                          ║           ║ Ndungu  ║  70%     ║        ║          ║
╠══════════════════════════╬═══════════╬═════════╬══════════╬════════╬═══════════╣
║  SOA                     ║ 14 Jun    ║ Faith   ║ ████░░░░ ║ 🔴     ║ 1 open   ║
║    ⚠ CARRIED: DR DB creds ║          ║ Githaiga║  45%     ║ Blocked║ [View]   ║
║    expired - from Q1 2026 ║           ║         ║          ║        ║ [Escalate]║
╚══════════════════════════╩═══════════╩═════════╩══════════╩════════╩═══════════╝
```

---

### 8.3 — Application Owner: My Pre-DR Tasks

```
╔══════════════════════════════════════════════════════════════════════════════════╗
║  📋 MY PRE-DR TASKS — Q2 2026          Welcome, Faith Githaiga (SOA Owner)       ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  Application: SOA                        Scheduled DR: 14 Jun 2026 | 10:00 PM   ║
║  Activity Type: Full Failover            RTO Target: 30 minutes                  ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  ⚠️  CARRIED FORWARD FROM Q1 2026 (UNRESOLVED — 87 days old)                    ║
║  ┌────────────────────────────────────────────────────────────────────────────┐  ║
║  │ 🔴 DR Database credentials for SOA middleware expired                      │  ║
║  │    Raised: 15 Jan 2026 | Last Updated: 2 Feb 2026 (no resolution)         │  ║
║  │    "DBA team confirmed password rotation not yet applied to DR env"        │  ║
║  │    [Mark Resolved] [Update Notes] [Escalate to ITSCM]                     │  ║
║  └────────────────────────────────────────────────────────────────────────────┘  ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  THIS CYCLE — Pre-DR Checklist (4 of 9 done)                    Due: 7 Jun 2026 ║
║                                                                                  ║
║  ✅  1. Confirm DR server accessibility (10.1.38.65/66)          Done  23 May   ║
║  ✅  2. Backup current tnsnames.ora on DR servers                Done  24 May   ║
║  ✅  3. Verify Oracle DG replication status                      Done  25 May   ║
║  ✅  4. Confirm SOA managed server startup sequence documented   Done  26 May   ║
║  🟡  5. Test DR DB connection from app servers                   In Progress    ║
║  ⚫  6. Validate all service endpoints in DR config file         Pending        ║
║  ⚫  7. Confirm WebLogic datasource failover config              Pending        ║
║  🔴  8. Resolve carried-forward: DB credential rotation         BLOCKED        ║
║         └─ [Add blocker update ▼]                                               ║
║  ⚫  9. Pre-DR sign-off form submitted to ITSCM                  Pending        ║
║                                                                                  ║
║  [Submit Readiness Sign-off]                                                     ║
╚══════════════════════════════════════════════════════════════════════════════════╝
```

---

### 8.4 — War Room (Live Execution View)

```
╔══════════════════════════════════════════════════════════════════════════════════╗
║  🚨 WAR ROOM — Finacle Core TZ — Full Failover        ⏱ 00:23:41 / 40:00 RTO   ║
║  Started: 22:00  |  Coordinator: Raymond  |  CR: CHG0033975     ████████░░ 68%  ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  PHASE: ◉ PRE-CUTOVER  ◉ CUTOVER ►  ○ DR VALIDATION  ○ ROLLBACK               ║
╠════╦═══════════════════════════════════════╦═════════╦═══════════╦══════════════╣
║ #  ║ Task                                  ║ Owner   ║ Duration  ║ Status       ║
╠════╬═══════════════════════════════════════╬═════════╬═══════════╬══════════════╣
║ 1  ║ ✅ Stop all services DC & DR           ║ Charles ║ 10m       ║ Done 22:10  ║
║    ║    ▸ WebLogic, finlistval, coresession ║ /Edwin  ║           ║             ║
╠════╬═══════════════════════════════════════╬═════════╬═══════════╬══════════════╣
║ 2  ║ ✅ Database failover (DG switchover)   ║ Nathan  ║ 10m       ║ Done 22:20  ║
║    ║    ▸ dgmgrl switchover to ebkstdby     ║         ║           ║             ║
╠════╬═══════════════════════════════════════╬═════════╬═══════════╬══════════════╣
║ 3  ║ 🔄 Deploy DR config files (TNS/props) ║ Charles ║ 10m       ║ IN PROGRESS ║
║    ║    ▸ Replacing tnsnames.ora on 65/66   ║ /Marion ║ 22:21 →   ║ ██████░░░░  ║
╠════╬═══════════════════════════════════════╬═════════╬═══════════╬══════════════╣
║ 4  ║ ⏳ Update WebLogic datasources         ║ Charles ║ 5m        ║ PENDING     ║
╠════╬═══════════════════════════════════════╬═════════╬═══════════╬══════════════╣
║ 5  ║ ⏳ Restart all DR services             ║ Edwin   ║ 10m       ║ PENDING     ║
╠════╬═══════════════════════════════════════╬═════════╬═══════════╬══════════════╣
║ 6  ║ ⏳ Validate Finacle login from DR      ║ Samuel  ║ 5m        ║ PENDING     ║
╠════╩═══════════════════════════════════════╩═════════╩═══════════╩══════════════╣
║  🚨 ACTIVE ISSUES                                                                ║
║  [HIGH] Step 3 — Treasury IP not updated yet — Charles investigating (22:23)     ║
║                                                                                  ║
║  👥 ON CALL: Raymond ✓  Charles ✓  Edwin ✓  Nathan ✓  Marion ✓  Amos ✓        ║
║                                                                                  ║
║  📝 War Room Notes: [DB switchover completed cleanly. TNS backup restored ok.]  ║
║                                                                                  ║
║  [🚨 Flag Issue]  [↩ Trigger Rollback]  [📸 Capture Evidence]  [📤 Notify Team] ║
╚══════════════════════════════════════════════════════════════════════════════════╝
```

---

### 8.5 — Post-DR Application Outcome Board

```
╔══════════════════════════════════════════════════════════════════════════════════╗
║  📊 POST-DR OUTCOMES — Finacle TZ — 15 Mar 2026          [Generate Report 📄]   ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  Overall Outcome: ✅ COMPLETED — Operating from DR  |  Actual RTO: 38 minutes   ║
╠═══════════════════╦════════════╦══════════════════════════════════╦═════════════╣
║  Application      ║ Status     ║ Application Owner Comment        ║ Coordinator ║
╠═══════════════════╬════════════╬══════════════════════════════════╬═════════════╣
║  Finacle Core TZ  ║ ✅ PASSED  ║ "Core banking fully operational  ║ Confirmed.  ║
║                   ║            ║  from DR. All branches tested."  ║             ║
╠═══════════════════╬════════════╬══════════════════════════════════╬═════════════╣
║  Finacle Treasury ║ ⚠ PARTIAL  ║ "Login issue resolved after IP   ║ ⚠ Action:  ║
║                   ║            ║  correction. Rate requests slow." ║ Automate   ║
║                   ║            ║                                   ║ IP update  ║
╠═══════════════════╬════════════╬══════════════════════════════════╬═════════════╣
║  WAY4             ║ ⚠ PARTIAL  ║ "RC 907 errors first 15 mins,   ║ ⚠ Action:  ║
║                   ║            ║  then stabilized."               ║ Root cause  ║
╠═══════════════════╬════════════╬══════════════════════════════════╬═════════════╣
║  Newgen           ║ ⚠ PARTIAL  ║ "Loan origination intermittent  ║ Pending     ║
║                   ║            ║  for 20 mins post failover."     ║ review      ║
╠═══════════════════╬════════════╬══════════════════════════════════╬═════════════╣
║  DNB Credit Bureau║ ❌ FAILED  ║ "External provider unavailable.  ║ Not DR-     ║
║  (External)       ║            ║  Confirmed 3rd party outage."    ║ caused      ║
╠═══════════════════╩════════════╩══════════════════════════════════╩═════════════╣
║  📋 ISSUES RAISED DURING THIS EXERCISE (5 total)                                 ║
║                                                                                  ║
║  [HIGH] Treasury IP Config incorrect after failover       ⚠ CARRY TO Q3 2026   ║
║    Owner: Raymond | "IP not updated in startup config. Manual fix applied."     ║
║    Action: Automate IP update in failover script    Due: 30 Apr 2026  [Assign]  ║
║                                                                                  ║
║  [HIGH] DBA not present at start                          ✅ RESOLVED            ║
║    Owner: ITSCM | "Mandatory pre-call attendance sign-off implemented."          ║
║                                                                                  ║
║  [MED]  NOC TZ DR monitoring not visible                  🔄 IN PROGRESS        ║
║    Owner: NOC Team | "Monitoring dashboard update in progress. ETA: 15 Apr"     ║
╚══════════════════════════════════════════════════════════════════════════════════╝
```

---

### 8.6 — Runbook Builder (Structured Steps View)

```
╔══════════════════════════════════════════════════════════════════════════════════╗
║  📖 RUNBOOK — Finacle Core TZ  v2.1   |  CR: CHG0033975   |  Status: APPROVED   ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  Tabs: [Summary] [Pre-Cutover] [Cutover ►] [DR Validation] [Rollback] [Contacts]║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  CUTOVER PHASE                                       [+ Add Step]  [⬆ Reorder]  ║
║                                                                                  ║
║  ┌─────────────────────────────────────────────────────────────────────────┐    ║
║  │ Step 1 of 6  ·  Stop all services (DC & DR)    ⏱ 10 min  🔴 Downtime  │    ║
║  │ Owner Role: App Engineer                                                 │    ║
║  │                                                                          │    ║
║  │ Instructions:                                                            │    ║
║  │  1. Stop managed servers from WebLogic console:                          │    ║
║  │     http://tzappj2ee1.tz.ebsafrica.com:8001/console                     │    ║
║  │                                                                          │    ║
║  │  2. Stop finlistval service on C++ servers (DC & DR):                   │    ║
║  │  ┌──────────────────────────────────────────────────────────────────┐   │    ║
║  │  │ cd /finacle/EQTZPROD/Fin10218/APP/Finacle/FC/app/services/       │   │    ║
║  │  │ finlistval/bin && ./stop*                                         │   │    ║
║  │  └──────────────────────────────────────────────────────────────────┘   │    ║
║  │                                                                          │    ║
║  │  3. Stop coressession, cbc, uniser_55 (same pattern above)              │    ║
║  │                                                                          │    ║
║  │ Verification: Confirm all processes down via `ps aux | grep finacle`    │    ║
║  │                                                                          │    ║
║  │ [✏ Edit]  [🗑 Delete]  [📋 Duplicate]                                   │    ║
║  └─────────────────────────────────────────────────────────────────────────┘    ║
║                                                                                  ║
║  ┌─────────────────────────────────────────────────────────────────────────┐    ║
║  │ Step 2 of 6  ·  Database Failover (Oracle DG Switchover)  ⏱ 10 min 🔴 │    ║
║  │ Owner Role: DBA                                                          │    ║
║  │  ...                                                                     │    ║
║  └─────────────────────────────────────────────────────────────────────────┘    ║
╚══════════════════════════════════════════════════════════════════════════════════╝
```

---

### 8.7 — Management Dashboard

```
╔══════════════════════════════════════════════════════════════════════════════════╗
║  📈 MANAGEMENT VIEW — DR Programme Dashboard           Year: 2026  [Export PDF] ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐   ║
║  │ T1 Coverage  │  │ RTO Achieved │  │ Success Rate │  │ Open Action Items│   ║
║  │   Q2 2026    │  │  Q2 2026     │  │  Q2 2026     │  │  All Campaigns   │   ║
║  │              │  │              │  │              │  │                  │   ║
║  │  ████████    │  │  ████████    │  │  ██████░░    │  │       12         │   ║
║  │    78%       │  │    82%       │  │    71%       │  │  4 HIGH priority │   ║
║  │  14/18 T1    │  │  within RTO  │  │  passed DR   │  │                  │   ║
║  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────────┘   ║
╠══════════════════════════════════════════════════════════════════════════════════╣
║  DR COVERAGE BY SUBSIDIARY (Q2 2026)          TOP RECURRING ISSUES              ║
║                                                                                  ║
║  Tanzania    ████████████  100%  3/3     1. Manual config changes (8 events)   ║
║  Kenya       ██████████░░   80% 12/15   2. DBA/resource availability (6)       ║
║  Uganda      ████████░░░░   67%  4/6    3. External dependency failures (5)    ║
║  Rwanda      ██████░░░░░░   50%  3/6    4. Post-failover IP config errors (4)  ║
║  DRC         ████░░░░░░░░   33%  2/6    5. WAY4 RC 907 errors (3)             ║
║  South Sudan ██░░░░░░░░░░   20%  1/5                                           ║
╚══════════════════════════════════════════════════════════════════════════════════╝
```

---

## 9. Phased Roadmap

---

### 🏗 Phase 1 — Foundation (Weeks 1–6)
**Goal:** Replace the Excel tracker and establish the source of truth.

| Week | Deliverable | Status |
|---|---|---|
| 1 | Project setup: Repo, DB, API skeleton, Auth (Email OTP), base React app | ✅ Complete |
| 2 | Application Registry module (CRUD + import from Excel) | ⏳ Pending |
| 3 | Dependency Engine (mapping + conflict detection) | ⏳ Pending |
| 4 | Campaign Manager (create campaign, assign apps, schedule) | ⏳ Pending |
| 5 | Basic Pre-DR Checklist (auto-generate from template, status tracking) | ⏳ Pending |
| 6 | Simple Dashboard (coordinator view: upcoming DRs, readiness %) | ⏳ Pending |

**Week 1 — What was actually built:**
- Maven multi-module project: `dr-platform-api` (Spring Boot 3.2.3 / Java 21) + `dr-platform-frontend` (React 18 / Vite / TypeScript)
- PostgreSQL schema via Flyway (V1–V12 migrations applied cleanly)
- **Auth: Email OTP** (not LDAP — LDAP reserved for PROD). 6-digit SHA-256 hashed code, 10-min expiry. Allowed domains: `@equitybank.co.ke`, `@gmail.com` (dev)
- JWT access tokens with `jti` claim = session correlation UUID v7
- **Session-correlated audit log**: OTP_REQUESTED → OTP_VERIFIED → all actions → USER_LOGOUT all share one `session_id` via `AuditContext` + JWT `jti`
- `AuditLogAspect` (AOP `@Around`): named-param before_state, sensitive field redaction, REQUIRES_NEW transaction, `actor_email` + `session_id` on every row
- Two operational DB views: `v_user_activity` (events + user name), `v_session_summary` (per-session journey)
- **UUID v7 everywhere**: `UuidV7Generator` (Hibernate), `gen_uuid_v7()` (PostgreSQL function) on all 13 table PK defaults
- Spring profiles: `sit` (active for dev), `uat`, `prod` — SMTP/DB config via env vars
- Startup summary banner; LDAP/Flyway INFO noise suppressed; OTP paste handler on MFA page
- Seeded users: `kennedy.gatimu@equitybank.co.ke` (SUPER_ADMIN), `kengatimu@gmail.com` (APP_OWNER)

**Success Criteria:**
- All 43 Q2 2026 applications imported from Excel
- Dependencies for SOA, SMSC, Finacle DB mapped
- Coordinator can create a campaign and see all pre-DR checklist items
- No more Excel needed for scheduling

---

### ⚙️ Phase 2 — Execution Engine (Weeks 7–12)
**Goal:** Enable live DR execution and smart blocker tracking.

| Week | Deliverable |
|---|---|
| 7  | Runbook Builder (structured steps, phases, commands, versions) |
| 8  | Runbook Approval Workflow (Author → Review → ITSCM Approval → Lock) |
| 9  | War Room (real-time execution tracker, WebSocket, step status) |
| 10 | Issues module (log during execution, categorize, severity) |
| 11 | Post-DR Outcome Board (per-app status, owner comments, coordinator notes) |
| 12 | Blocker Intelligence Engine (carried-forward items, age tracking, acknowledgment) |

**Success Criteria:**
- A DR exercise can be executed live from the War Room
- All steps tracked in real-time
- Issues auto-created when steps are blocked
- Unresolved issues appear on next DR cycle's pre-DR checklist
- Application owners can submit post-DR outcomes directly

---

### 🤖 Phase 3 — Intelligence & Automation (Weeks 13–20)
**Goal:** Automate notifications, generate reports, and surface analytics.

| Week | Deliverable |
|---|---|
| 13 | Email notification engine (T-7, T-3, T-1 reminders) |
| 14 | SMS/WhatsApp integration (escalation alerts, blocked step notifications) |
| 15 | Action Item Tracker with due-date enforcement and overdue alerts |
| 16 | Report Generator (auto-generate Post-DR Word/PDF report) |
| 17 | Management Dashboard (coverage, RTO compliance, recurring issues) |
| 18 | Application Owner self-service dashboard |
| 19 | Dependency Graph visualization (D3.js interactive force graph) |
| 20 | DR History & Analytics (trends, RTO improvement over time) |

**Success Criteria:**
- Coordinator does zero manual follow-up — system sends all reminders
- Post-DR report auto-generated matches Equity Bank regulatory template
- Management can view quarterly DR coverage by subsidiary and tier
- Application owners receive tasks and can act without contacting coordinator

---

### 🚀 Phase 4 — Advanced Features (Post-MVP, Weeks 21+)
**Goal:** Platform maturity, integration, and intelligence.

| Feature | Description |
|---|---|
| **ITSM Integration** | Auto-create/close CRs in ServiceNow or equivalent |
| **NOC Integration** | Push DR activity windows to monitoring suppression |
| **Bulk Runbook Execution** | Orchestrated multi-app DR (e.g., full TZ DR in one session) |
| **Risk Scoring Engine** | Auto-rate each app's DR risk based on history, issue count, test age |
| **DR Readiness Score** | Per-app score: 0–100, used for management reporting |
| **Regulatory Evidence Pack** | One-click export of all evidence for BOT/regulatory submission |
| **Mobile View** | Responsive war room for engineers on-site at DR |
| **AI-Assisted Runbooks** | Suggest runbook steps based on app type and past patterns |

---

## 10. API Design

### Key Endpoints (RESTful)

```
# Applications
GET    /api/applications                     — list all (with filters)
POST   /api/applications                     — create
GET    /api/applications/:id                 — get by ID with dependencies
PUT    /api/applications/:id                 — update
GET    /api/applications/:id/dr-history      — past DR executions for this app

# Campaigns
GET    /api/campaigns                        — list (filter by quarter/year)
POST   /api/campaigns                        — create new campaign
GET    /api/campaigns/:id/applications       — get all apps in campaign
POST   /api/campaigns/:id/applications       — add app to campaign
GET    /api/campaigns/:id/readiness          — pre-DR readiness summary

# Pre-DR Checklist
GET    /api/campaign-apps/:id/checklist      — get checklist items
PUT    /api/checklist-items/:id/status       — update item status
POST   /api/checklist-items/:id/blocker      — add blocker details

# War Room
POST   /api/executions                       — start a DR execution
GET    /api/executions/:id/steps             — get step list
PUT    /api/execution-steps/:id/status       — update step status (done/blocked)
POST   /api/executions/:id/issues            — log an issue
POST   /api/executions/:id/rollback          — trigger rollback phase

# Post-DR
GET    /api/executions/:id/outcomes          — get per-app outcome records
PUT    /api/outcomes/:id                     — submit/update app owner outcome
GET    /api/executions/:id/report            — generate report (returns PDF/DOCX)

# WebSocket Events
ws://  /ws/executions/:id                    — real-time war room channel
  → events: step:updated, issue:created, participant:joined, timer:tick
```

---

## 11. Tech Stack

> **Decision:** Java Spring Boot was chosen over Node.js because this is a banking-grade enterprise platform. Spring Boot is the dominant backend framework in the financial services industry, offers superior enterprise security (Spring Security 6), and aligns with the team's existing NetBeans/Java environment.

| Layer | Technology | Version | Notes |
|---|---|---|---|
| **Frontend** | React + TypeScript + Vite | React 18, TS 5 | Tailwind CSS; component library in `src/components/` |
| **Backend API** | Java + Spring Boot | Java 21 LTS, Spring Boot 3.2.3 | Maven multi-module: `dr-platform-api` + `dr-platform-frontend` |
| **Auth (SIT/dev)** | Email OTP + JWT | Spring Security 6.2 | 6-digit SHA-256 code; JWT with `jti` = session UUID v7 |
| **Auth (PROD)** | LDAP/AD SSO | Spring Security 6.2 | `LdapAuthProvider` wired; activated via PROD profile |
| **ORM** | Spring Data JPA + Hibernate | Hibernate 6.4 | `BaseEntity` + `AuditableEntity` `@MappedSuperclass`; UUID v7 IDs |
| **DB Migrations** | Flyway | 10.15 | V1–V12 applied; `pgcrypto` extension required for `gen_uuid_v7()` |
| **Primary Keys** | UUID v7 (time-ordered) | — | `UuidV7Generator` (Java) + `gen_uuid_v7()` (PostgreSQL) on all 13 tables |
| **Real-Time (War Room)** | Spring WebSocket + STOMP | Built-in | Phase 2 |
| **Background Jobs** | Spring Scheduler + Spring Batch | Built-in | Phase 3 |
| **Report Generation** | Apache POI (Word/Excel) + iText 7 (PDF) | POI 5.x, iText 7.x | Phase 3 |
| **Notifications** | Spring Mail | — | SMTP via env vars; Twilio SMS in Phase 3 |
| **Database** | PostgreSQL | 16.13 | JSONB for audit states; `pgcrypto` extension enabled |
| **Cache & Pub/Sub** | Redis + Redisson | Redis 7.x | Phase 2 (War Room broadcasts) |
| **Build Tool** | Maven | 3.9.x | `-parameters` compiler flag required for Spring 6 param inference |
| **Containerisation** | Docker + Docker Compose | — | Planned; not yet configured |
| **IDE** | IntelliJ IDEA | — | NetBeans also supported |

> **Auth decision:** LDAP/AD is the target for production. Email OTP is used for SIT/dev because LDAP is not reachable from development machines. The `LdapAuthProvider` is wired and ready — switching to LDAP is a profile change, not a code change.

### Project Structure (Maven Multi-Module)

```
dr-platform/                              ← Maven Parent Project
├── dr-platform-api/                      ← Spring Boot Backend (Java 21)
│   └── src/main/java/com/equitybank/drplatform/
│       ├── config/
│       │   ├── SecurityConfig.java           ← Spring Security: JWT, LDAP, RBAC
│       │   ├── WebSocketConfig.java          ← STOMP WebSocket for War Room
│       │   └── VaultConfig.java              ← HashiCorp Vault secrets
│       ├── modules/
│       │   ├── registry/                     ← Application Registry + Dependency Engine
│       │   ├── campaign/                     ← Campaign Manager + Scheduling
│       │   ├── runbook/                      ← Runbook Builder + Approval Workflow
│       │   ├── warroom/                      ← Live Execution (WebSocket + STOMP)
│       │   ├── checklist/                    ← Pre-DR Readiness + Enforcement
│       │   ├── postdr/                       ← Post-DR Outcomes + Blocker Intelligence
│       │   ├── reports/                      ← Apache POI + iText report generator
│       │   └── notifications/                ← Spring Mail + Twilio SMS
│       ├── security/
│       │   ├── JwtAuthFilter.java
│       │   ├── LdapAuthProvider.java
│       │   ├── RbacPermissionEvaluator.java
│       │   └── AuditLogAspect.java           ← AOP: logs every action automatically
│       └── scheduler/
│           ├── RunbookDeadlineScheduler.java  ← T-21/T-14/T-10/T-7/T-3/T-1 enforcement
│           └── ActionItemReminderScheduler.java
│
├── dr-platform-frontend/                 ← React 18 + TypeScript (Vite)
│   └── src/
│       ├── modules/
│       │   ├── registry/
│       │   ├── campaign/
│       │   ├── runbook/
│       │   ├── warroom/                  ← WebSocket client (STOMP.js)
│       │   ├── checklist/
│       │   ├── postdr/
│       │   └── dashboard/
│       └── shared/
│           ├── components/
│           └── hooks/
│
└── pom.xml                               ← Parent Maven POM
```

### Key Spring Boot Patterns Used

```java
// 1. Method-level RBAC — one annotation enforces role on any endpoint
@PreAuthorize("hasRole('COORDINATOR') or hasRole('SUPER_ADMIN')")
public Campaign approveCampaign(UUID campaignId) { ... }

// 2. Automatic audit logging via AOP — no manual logging needed
@Aspect
public class AuditLogAspect {
    @AfterReturning("@annotation(Auditable)")
    public void logAction(JoinPoint jp, Object result) { ... }
}

// 3. Scheduled reminders — Spring Scheduler replaces BullMQ
@Scheduled(cron = "0 9 * * *")   // Every day at 9 AM
public void sendRunbookDeadlineReminders() { ... }

// 4. War Room real-time via STOMP
@MessageMapping("/warroom/{sessionId}/step/complete")
@SendTo("/topic/warroom/{sessionId}")
public StepUpdateEvent completeStep(UUID stepId) { ... }

// 5. Apache POI for Word report generation
XWPFDocument doc = new XWPFDocument(template);
// ... fill tables, paragraphs from execution data
// Output matches Equity Bank regulatory Word template exactly
```

---

## 12. Non-Functional Requirements

| Category | Requirement |
|---|---|
| **Availability** | 99.5% uptime (not in DR window) |
| **Performance** | Dashboard loads < 2 seconds; War Room updates < 500ms |
| **Security** | LDAP/AD auth, RBAC, all data encrypted at rest and in transit (TLS 1.2+) |
| **Audit Trail** | Every change to execution steps, issues, outcomes logged to `audit_log` table |
| **Scalability** | Support 500 concurrent users during peak DR exercise |
| **Data Retention** | DR records retained for 7 years (regulatory requirement) |
| **Backup** | Daily PostgreSQL backups, retained 90 days |
| **Accessibility** | WCAG 2.1 AA — accessible from bank's internal network only |
| **Hosting** | On-premise (bank's private cloud or VMware infrastructure) |

---

## 13. Development Guidelines

### Repository Structure (Actual)

```
dr-platform/                                    ← Maven parent POM
├── pom.xml                                     ← parent: Java 21, Spring Boot 3.2.3, Lombok 1.18.38
│
├── dr-platform-api/                            ← Spring Boot backend
│   └── src/main/
│       ├── java/com/equitybank/drplatform/
│       │   ├── audit/
│       │   │   ├── AuditContext.java           ← request-scoped session_id / actor_email store
│       │   │   ├── AuditLogAspect.java         ← AOP @Around: writes audit_log in REQUIRES_NEW tx
│       │   │   └── Auditable.java              ← @Auditable(action, resourceType) annotation
│       │   ├── config/
│       │   │   ├── SecurityConfig.java
│       │   │   └── UuidV7Generator.java        ← Hibernate IdentifierGenerator for UUID v7
│       │   ├── controller/
│       │   │   ├── AuthController.java
│       │   │   └── DashboardController.java
│       │   ├── dto/                            ← request/response DTOs
│       │   ├── entity/
│       │   │   ├── BaseEntity.java             ← @MappedSuperclass: id (UUID v7) + createdAt
│       │   │   ├── AuditableEntity.java        ← @MappedSuperclass: + updatedAt
│       │   │   ├── AuditLogEntity.java         ← @Immutable audit log (JdbcTemplate inserts)
│       │   │   ├── UserEntity.java
│       │   │   ├── EmailOtpEntity.java         ← includes sessionId UUID field
│       │   │   ├── RefreshTokenEntity.java
│       │   │   ├── ApplicationEntity.java
│       │   │   ├── DependencyEntity.java
│       │   │   ├── DependencyGroupEntity.java
│       │   │   ├── DependencyGroupMemberEntity.java
│       │   │   ├── CampaignEntity.java
│       │   │   ├── CampaignApplicationEntity.java
│       │   │   ├── ChecklistItemEntity.java
│       │   │   ├── ChecklistBlockerEntity.java
│       │   │   ├── CampaignConflictEntity.java
│       │   │   └── PreDrSignoffEntity.java
│       │   ├── exception/                      ← GlobalExceptionHandler, custom exceptions
│       │   ├── repository/                     ← Spring Data JPA repositories
│       │   ├── security/
│       │   │   ├── JwtService.java             ← generateAccessToken(user, sessionId) with jti
│       │   │   ├── JwtAuthFilter.java          ← stamps AuditContext from JWT jti + email
│       │   │   ├── LdapAuthProvider.java       ← wired, used in PROD profile
│       │   │   └── DrPlatformUserDetails.java
│       │   └── service/
│       │       ├── AuthService.java            ← OTP flow, session correlation, AuditContext wiring
│       │       └── EmailOtpService.java        ← OtpSendResult / OtpVerifyResult records
│       └── resources/
│           ├── application.yml                 ← universal config (no env-specific values)
│           ├── application-sit.yml             ← SIT/dev profile (active locally)
│           ├── application-uat.yml
│           ├── application-prod.yml
│           └── db/migration/
│               ├── V1__auth_audit_schema.sql
│               ├── V2__application_registry_schema.sql
│               ├── V3__dependency_engine_schema.sql
│               ├── V4__campaign_manager_schema.sql
│               ├── V5__checklist_schema.sql
│               ├── V6__initial_data.sql        ← seed users (SUPER_ADMIN + APP_OWNER)
│               ├── V7__campaign_entity_enhancements.sql
│               ├── V8__email_otp_schema.sql
│               ├── V9__uuid_v7_and_timestamp_consistency.sql
│               ├── V10__enable_pgcrypto.sql    ← CREATE EXTENSION pgcrypto (required by V9 fn)
│               ├── V11__fix_gen_uuid_v7_int_cast.sql
│               └── V12__session_tracking_and_audit_views.sql
│
├── dr-platform-frontend/                       ← React 18 + TypeScript + Vite (port 5174)
│   └── src/
│       ├── api/
│       │   └── axiosClient.ts                  ← Axios instance; baseURL from VITE_API_BASE_URL
│       ├── hooks/
│       │   ├── useApplications.ts              ← CRUD + import + export hooks
│       │   ├── useCampaigns.ts                 ← CRUD + approve + gate-check + timeline
│       │   ├── useChecklist.ts
│       │   └── useDependencies.ts
│       ├── types/index.ts                      ← All TypeScript DTOs (keep in sync with Java DTOs)
│       ├── context/AuthContext.tsx
│       ├── components/
│       │   ├── applications/
│       │   │   └── ApplicationFormModal.tsx    ← 4-tab modal: Basic Info, DR & Endpoints, Dependencies, Ownership & Risk
│       │   ├── dependencies/
│       │   │   ├── ResourcePicker.tsx          ← accepts onRegisterNew?: () => void prop
│       │   │   └── DependencyFormModal.tsx
│       │   ├── layout/
│       │   │   ├── AppLayout.tsx               ← collapsible sidebar; equity logo in collapsed state
│       │   │   └── ProtectedRoute.tsx
│       │   └── common/
│       │       ├── StatusBadge.tsx
│       │       └── ProgressBar.tsx
│       └── pages/
│           ├── auth/
│           │   ├── LoginPage.tsx
│           │   ├── MfaPage.tsx                 ← OTP entry; paste handler; resend cooldown
│           │   └── UnauthorizedPage.tsx
│           ├── dashboard/DashboardPage.tsx
│           ├── applications/
│           │   ├── ApplicationListPage.tsx
│           │   ├── ApplicationDetailPage.tsx
│           │   └── ApplicationImportPage.tsx   ← ⚠ UX REDESIGN PENDING (see Pending Tasks)
│           ├── campaigns/
│           │   ├── CampaignListPage.tsx        ← modal form; SubsidiaryPicker (multi); PeriodPicker (Q/H); StartTimePicker (tab-based)
│           │   └── CampaignDetailPage.tsx
│           ├── dependencies/DependencyPage.tsx ← RegisterResourceModal built-in
│           ├── checklist/ChecklistPage.tsx
│           ├── readiness/PreDrReadinessPage.tsx
│           ├── runbooks/RunbookPage.tsx
│           ├── warroom/WarRoomPage.tsx
│           ├── review/PostDrReviewPage.tsx
│           ├── reports/ReportGeneratorPage.tsx
│           └── admin/AuditLogPage.tsx
│
└── CLAUDE.md                                   ← This file (project root)
```

### RBAC Roles

| Role | Access |
|---|---|
| `SUPER_ADMIN` | Platform owner — full access including user management and system config |
| `COORDINATOR` | Full access to all campaigns, runbooks, war rooms, reports |
| `APP_OWNER` | View own applications, manage own pre-DR tasks, submit post-DR outcomes |
| `DBA` | View runbook steps assigned to DBA role, execute/update in War Room |
| `TECH_ENGINEER` | View and execute assigned runbook steps in War Room |
| `MANAGEMENT` | Read-only access to dashboards and reports |

> **Seeded users (SIT/dev):** `kennedy.gatimu@equitybank.co.ke` → SUPER_ADMIN, `kengatimu@gmail.com` → APP_OWNER

### Coding Standards

- All API responses follow `{ data, meta, error }` envelope
- All state transitions go through the service layer — no direct status updates in controllers
- Every business operation must be annotated `@Auditable(action, resourceType)` — the AOP aspect handles all audit writes automatically
- **Never modify** existing Flyway `Vx__*.sql` files after they have been applied — always create a new migration
- `@Auditable` methods should call `AuditContext.setResourceId()` and `AuditContext.setCampaignId()` where applicable so `audit_log.resource_id` and `audit_log.campaign_id` are populated
- UUID ordering: always sort by `created_at DESC` or `"timestamp" DESC` — never rely on `ORDER BY id DESC` while UUID v4 legacy rows may exist
- Sensitive parameter names (`otp`, `password`, `token`, `code`, `hash`, `secret`, `pin`, `key`, `credential`, `passcode`) are automatically redacted by `AuditLogAspect` — no manual handling needed
- Feature branches off `develop`; PRs require one review before merge
- Semantic versioning for releases
- `-parameters` Maven compiler flag is required — do not remove it; Spring 6 relies on it for `@RequestParam` name inference

---

---

## 14. Security Architecture (Implemented)

### Authentication Flow

```
User enters email
       │
       ▼
POST /api/auth/request-otp
  ├─ Validate domain (@equitybank.co.ke / @gmail.com)
  ├─ Generate 6-digit code + SHA-256 hash
  ├─ Generate session_id (UUID v7) → saved to email_otps.session_id
  ├─ AuditContext.setSessionId(sessionId) + setActorEmail(email)
  ├─ Attempt SMTP send; fallback: log code (WARN, dev only)
  └─ Audit: OTP_REQUESTED (session_id stamped)
       │
       ▼
User enters OTP
       │
       ▼
POST /api/auth/verify-otp
  ├─ Load EmailOtpEntity → verify hash, expiry, used flag
  ├─ Mark OTP used; recover session_id from EmailOtpEntity
  ├─ AuditContext.setSessionId(sessionId) + setActorEmail(email)
  ├─ Generate JWT: .id(sessionId.toString()) = jti claim
  ├─ Issue refresh token (SHA-256 hash stored in refresh_tokens)
  └─ Audit: OTP_VERIFIED (same session_id as OTP_REQUESTED)
       │
       ▼
All subsequent authenticated requests
  └─ JwtAuthFilter reads jti → AuditContext.setSessionId(jti)
                        email → AuditContext.setActorEmail(email)
     → every @Auditable call shares the same session_id
       │
       ▼
POST /api/auth/logout
  ├─ AuthService manually decodes Authorization header (JwtAuthFilter skips /api/auth/*)
  ├─ AuditContext.setSessionId(jti from token)
  ├─ Revoke refresh token (tokenHash → revoked=true)
  └─ Audit: USER_LOGOUT (same session_id as all previous events)
```

### Audit Log Architecture

| Column | Source | Notes |
|---|---|---|
| `id` | `gen_uuid_v7()` DB default | Time-ordered; sort by `"timestamp"` DESC for latest-first |
| `actor_id` | SecurityContext principal | NULL for unauthenticated events (OTP_REQUESTED) |
| `actor_email` | `AuditContext.getActorEmail()` | Denormalised; survives user deletion |
| `actor_ip` | `X-Forwarded-For` → `remoteAddr` | Proxy-aware |
| `session_id` | `AuditContext.getSessionId()` | JWT `jti`; links all events in a login session |
| `before_state` | Named method params (jsonb) | Sensitive fields auto-redacted |
| `after_state` | Return value / exception (jsonb) | `{"outcome":"SUCCESS"}` for void; `{"outcome":"FAILURE","error":...}` on throw |
| `resource_id` | `AuditContext.setResourceId()` | ⚠ Not yet wired — set when building Phase 2 service methods |
| `campaign_id` | `AuditContext.setCampaignId()` | ⚠ Not yet wired |

**Operational views:**
- `v_user_activity` — every audit event LEFT JOINed with `users`; shows `actor_name`
- `v_session_summary` — one row per `session_id`; shows `action_sequence[]`, `login_completed`, `logged_out`, `duration_seconds`

### Key Technical Constraints

- `pgcrypto` PostgreSQL extension **must be enabled** (V10 migration does this) — `gen_uuid_v7()` calls `gen_random_bytes(16)`
- `set_byte()` in `gen_uuid_v7()` requires `::int` casts on all BIGINT expressions (V11 fixes this)
- `AuditLogAspect` INSERT runs in `PROPAGATION_REQUIRES_NEW` — audit failures never abort the business transaction
- `audit_log` table should be `GRANT SELECT, INSERT` only (no UPDATE, DELETE) in production
- Flyway `baseline-version=0` + `baseline-on-migrate=true` — changing these breaks migration history

---

*This document is the authoritative reference for the DR Management Platform. All implementation decisions should be traceable to requirements in this document.*

*Generated: 2026-03-30 | Review cycle: per phase completion*

---

## 15. Current Frontend State (as of 2026-04-02)

### UI Design System

| Token / Class | Usage |
|---|---|
| `equity-red` | Primary brand colour (Tailwind custom token) |
| `equity-red/5`, `/8`, `/10`, `/20`, `/40` | Tinted backgrounds and borders |
| `.card` | White rounded-xl border border-gray-200 p-4 (global utility class) |
| `.btn-primary` | equity-red filled button |
| `.btn-secondary` | Gray outlined button |
| `.input` | Standard form input with ring-equity-red focus |
| `.label` | Small form label above inputs |

### ApplicationFormModal.tsx — 4 Tabs

| Tab | Key Fields / Notes |
|---|---|
| **Basic Info** | code, name, tier (T1/T2/T3 cards), subsidiaryId, hasDr toggle, drCapability picker, vendor, description |
| **DR & Endpoints** | dcEndpoint, drEndpoint (UrlListEditor), dcServers, drServers (JSON arrays) |
| **Dependencies** | Two-path mini wizard: `depKind = 'infrastructure' \| 'application'`. Infrastructure → ResourcePicker + usage field. Application → app dropdown + usage field. `hasInterdependency` is AUTO-DERIVED on submit (`stagedDeps.some(d => !!d.dependsOnId)`). Staged list shown below. |
| **Ownership & Risk** | Business Owner card, Technical Owner card, Customer-Facing toggle, Internal Notes. **No scheduling section** — scheduling is at campaign level. |

**Footer text on Dependencies tab:** `"Dependencies can be added after the application is created."` ← ⚠ STILL NEEDS UPDATING (see Pending Tasks)

### CampaignListPage.tsx — New Campaign Modal

- **SubsidiaryPicker**: custom multi-select dropdown with checkboxes, chips, select-all — sends `subsidiaryIds: string[]`
- **PeriodPicker**: toggle between Quarterly (Q1–Q4 cards) and Half-Year (H1/H2 cards with month ranges)
- **StartTimePicker**: tab strip (Night 🌙 / Morning / Afternoon / Evening) → 6 pill-buttons per tab, all 24 hours covered. Night tab has indigo "Recommended" badge.
- Backend field `quarter` accepts Q1/Q2/Q3/Q4/H1/H2
- Backend `subsidiaryIds` is `List<String>` with `@NotEmpty` validation

### DependencyPage.tsx

- **RegisterResourceModal** built inline: type selector grid → name (auto-derives code) → hostname → success state with "Switch back to that tab" guidance
- "Register Resource" primary button in page header
- Empty state has "Register First Resource" CTA

### ResourcePicker.tsx

- Accepts `onRegisterNew?: () => void` prop
- When provided: "Register a new shared resource" opens Dependency Engine in new tab (`window.open('/dependencies', '_blank')`) + shows "Opens in new tab — your form progress is saved"
- When absent: inline create form (used on DependencyPage itself)

### ApplicationImportPage.tsx — ⚠ Pending UX Redesign

Current state: drop zone + blue mono-font column grid + import button. User flagged it as poor UX.
Backend import endpoint: `POST /api/applications/import` (multipart `file`). Returns `{ imported, updated, skipped, errors[] }`.
Actual columns parsed by backend: A=code, B=name, C=tier, D=subsidiaryId, E=techOwnerEmail, F=hasDr(Y/N), G=drCapability, H=vendor, I=description.

---

## 16. Pending Tasks (as of 2026-04-02)

| # | Task | File | Notes |
|---|---|---|---|
| 1 | **Fix Dependencies tab footer text** | `ApplicationFormModal.tsx` | Remove reference to "application detail page" — it doesn't exist yet. Use: `"Dependencies can be added after the application is created."` |
| 2 | **Redesign ApplicationImportPage UX** | `ApplicationImportPage.tsx` | Replace blue mono-font grid. Use column-by-column card layout with required/optional badges, field name, example value, description. Download template button. Better result display. |
| 3 | **TypeScript clean build check** | Frontend | Run `npx tsc --noEmit` after all pending changes are applied |
| 4 | **Backend alignment** | — | Frontend and backend are substantially aligned. One gap: `CreateApplicationRequest.subsidiaryId` is singular (String) while `CampaignEntity.subsidiaryIds` is plural (List). This is intentional — applications belong to one subsidiary; campaigns span many. |

---

## 17. Files That Must Stay in Sync

| Frontend | Backend |
|---|---|
| `src/types/index.ts` — `CreateApplicationRequest` | `dto/request/CreateApplicationRequest.java` |
| `src/types/index.ts` — `ApplicationDto` | `dto/response/ApplicationDto.java` |
| `src/types/index.ts` — `CampaignDto` | `dto/response/CampaignDto.java` |
| `src/types/index.ts` — `CreateCampaignRequest` (inline in hook) | `dto/request/CreateCampaignRequest.java` |
| `src/types/index.ts` — `ImportResult` | `ApplicationImportService.ImportResult` |
| `src/types/index.ts` — `DependencyType` enum | `entity/DependencyEntity.java` CHECK constraint |
| `SUBSIDIARIES` constant (ApplicationFormModal + CampaignListPage) | subsidiary_id values in DB |
