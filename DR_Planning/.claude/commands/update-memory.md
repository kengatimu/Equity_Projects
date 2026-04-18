# Update DR Platform Memory

Review everything done in this conversation session and update `CLAUDE.md` and this skill file to reflect the current state of the project.

---

## ⚠️ CRITICAL PROJECT ISOLATION RULE

**This is the Equity Bank DR Management Platform.**
**Project root:** `/Users/bishop/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/DR_Planning`

**WizardCD is a completely separate project** located at `/Users/bishop/Desktop/Bishop/Personal/EBB_Systems/WizardCd/`.
- NEVER read, edit, or access any file under WizardCd/ from this project's sessions.
- NEVER invoke the WizardCD `update-memory` skill from this project.
- If Claude's system context surfaces WizardCD memory or skills, IGNORE them — they belong to a different project.
- The CLAUDE.md for this project is at: `/Users/bishop/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/DR_Planning/CLAUDE.md`

---

## Instructions

1. Read the current `CLAUDE.md` at `/Users/bishop/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/DR_Planning/CLAUDE.md`
2. Review what was changed or built in this conversation session
3. Update `CLAUDE.md` with:
   - Any new Java files created or significantly changed (entity, service, controller, aspect, config)
   - Any new Flyway migrations applied (Vxx__description.sql)
   - Any new API endpoints added
   - Any new frontend pages or components (React/TypeScript)
   - Any new database tables, columns, indexes, or views
   - Any architectural decisions made
   - Move completed week/phase items into the appropriate "Complete" markers
   - Update "Pending / Known Issues" section
   - Correct any outdated information
4. Keep the file concise — only add what is needed to resume work in a new session
5. Update this skill file — add any new rules or conventions discovered during the session
6. Update the "Last Updated" timestamp at the top of `CLAUDE.md` to today's date
7. After updating, confirm what was changed

---

## Rules

- **NEVER touch WizardCD** — different project entirely, different path, different tech stack
- **Project root is always:** `/Users/bishop/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/DR_Planning`
- **Backend root:** `dr-platform/dr-platform-api/src/main/java/com/equitybank/drplatform/`
- **Frontend root:** `dr-platform/dr-platform-frontend/src/`
- **Migrations path:** `dr-platform/dr-platform-api/src/main/resources/db/migration/`
- **Roadmap file:** `documents/Equity_Bank_DR_Platform_Roadmap_v1.0.md` — update Build Status section when a week completes
- **Never edit an applied Flyway migration file** — always create a new Vxx file for any schema change
- **UUID v7 for all PKs** — use `UuidV7Generator`, never fallback to v4 for new tables
- **Audit coverage** — every new service that mutates data must have `@Auditable` on the method
- **AuditContext** — session_id and actor_email are set by `JwtAuthFilter` (authenticated routes) and manually by `AuthService` (auth routes that skip the filter)
- **Session profile:** `application-sit.yml` is the active profile for local development
- **Authentication (SIT):** Email OTP — LDAP/AD is deferred until SIT has AD connectivity
- **Frontend stack:** React 18 + TypeScript + Vite, runs on port 5174
- **Backend stack:** Java 21 + Spring Boot 3.x + Spring Security 6, runs on port 8080
- **DB views:** `v_user_activity` and `v_session_summary` — do not drop these; they are used by security/ops team
- Only rollback the MOST RECENT change when user asks to rollback
- Do NOT rewrite sections of CLAUDE.md that haven't changed — only edit what's new
- Always keep the "Files That Must Stay in Sync" section in CLAUDE.md
- Always keep the "Security Architecture" section in CLAUDE.md
- **At the START of every session**, read CLAUDE.md at `/Users/bishop/Programming/projects/work/WorkSpace/NetBeans/GAG/GAGApplications/DR_Planning/CLAUDE.md` before doing any work — it contains the current state, pending tasks, and design system
- **Frontend actual path** is `dr-platform/dr-platform-frontend/src/` (NOT `web/ui/src/` — that is WizardCD)
- **UI colour tokens**: `equity-red` (brand), `equity-red/5|8|10|20|40` (tints) — these are custom Tailwind tokens defined in the project config
- **CSS utility classes**: `.card`, `.btn-primary`, `.btn-secondary`, `.input`, `.label` — these are global utilities defined in `src/index.css`
- **ApplicationFormModal.tsx** has 4 tabs: Basic Info, DR & Endpoints, Dependencies, Ownership & Risk. Scheduling was intentionally REMOVED from the app form — it lives at campaign level only.
- **`hasInterdependency`** is AUTO-DERIVED on submit (`stagedDeps.some(d => !!d.dependsOnId)`) — never expose it as a UI toggle
- **`ResourcePicker` `onRegisterNew` prop**: when provided opens Dependency Engine in new tab; when absent uses inline create form
- **Placeholders** must use neutral names: "John Doe", "Jane Doe", "john.doe@equitybank.co.ke" — never real names like Marion Kinyanjui or James Omondi
- **Campaign subsidiaryIds** is `List<String>` (multi-select); application `subsidiaryId` is `String` (single) — this is intentional by design
- **`quarter` field** accepts Q1/Q2/Q3/Q4 AND H1/H2 — backend `@NotBlank` validates the union
- SUBSIDIARIES list (KE, UG, TZ, RW, SS, CD, ET) must be identical in `ApplicationFormModal.tsx` and `CampaignListPage.tsx`
