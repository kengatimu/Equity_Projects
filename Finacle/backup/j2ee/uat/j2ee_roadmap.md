# J2EE Deployment Automation — Project Roadmap

> **Project Path:** `/Users/bishop/Programming/projects/work/WorkSpace/NetBeans/GAG/Finacle/j2ee/j2ee-scripts`
> **Author:** Kennedy Gatimu
> **Last Updated:** 2026-04-15

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Subsidiaries & Bank Groupings](#2-subsidiaries--bank-groupings)
3. [Three-Environment Architecture](#3-three-environment-architecture)
   - [SIT](#31-sit-system-integration-testing)
   - [UAT](#32-uat-finacle-preprod)
   - [PROD](#33-prod-production)
4. [Repository Structures](#4-repository-structures)
5. [Server Path Mapping](#5-server-path-mapping)
6. [Implementation Roadmap](#6-implementation-roadmap)
   - [Phase 1 — Repository & Branch Setup](#phase-1--repository--branch-setup)
   - [Phase 2 — SIT Scripts](#phase-2--sit-scripts)
   - [Phase 3 — UAT Scripts](#phase-3--uat-scripts)
   - [Phase 4 — PROD Scripts](#phase-4--prod-scripts)
   - [Phase 5 — Azure DevOps CI/CD Pipelines](#phase-5--azure-devops-cicd-pipelines)
   - [Phase 6 — Rollback Pipeline](#phase-6--rollback-pipeline-future)
   - [Phase 7 — Testing & Validation](#phase-7--testing--validation-future)
7. [CI/CD Tag Reference](#7-cicd-tag-reference)
8. [End-to-End Flow](#8-end-to-end-flow)
9. [Key Design Decisions](#9-key-design-decisions)

---

## 1. Project Overview

This project automates the **CI/CD deployment of Finacle J2EE customization scripts** for a multi-subsidiary banking group operating across East and Central Africa.

Two Finacle applications are managed:

| Application | Repo Folder | CI Artifact | Archive |
|---|---|---|---|
| Finacle CRM | `crm/customization/` | `crm_drop` | `j2ee-scripts.tar.gz` |
| Finacle Financial Core (Fincore) | `fincore/custom/` | `fincore_drop` | `j2ee-scripts.tar.gz` |

The CI process runs on **Azure DevOps YAML pipelines**. The CD process uses **Azure DevOps Classic Release Pipelines** triggered by build tags, deploying via SSH (SCP + shell script execution).

### Architecture Model

The system uses **full per-environment separation**: three independent Git branches (`sit`, `uat`, `prod`), each with its own folder structure, YAML pipelines, and shell scripts. Changes are **never promoted via git merge** — when a change is ready for a higher environment, it is separately applied to that branch.

This design was chosen over a shared-script model to:
- Eliminate conditional branching within scripts (no `if [ "$ENV" == "uat" ]` trees)
- Allow each environment's topology (bank groupings, server paths) to evolve independently
- Make scripts readable and testable in isolation

---

## 2. Subsidiaries & Bank Groupings

### Subsidiary Registry

| ID | Country | Notes |
|----|---------|-------|
| 11 | South Sudan | Group member in UAT and PROD |
| 43 | DRC | Own server in UAT; Group member in PROD (own servers arriving — logic written, commented out) |
| 50 | Rwanda | Own dedicated servers in UAT and PROD |
| 54 | Kenya | Group member in UAT and PROD |
| 55 | Tanzania | Own dedicated server in all envs; no Branch/FI split in PROD |
| 56 | Uganda | Own dedicated servers in UAT and PROD |
| 99 | Finserve | Virtual bank — shares Kenya (54) server; present in SIT and UAT; **NOT in PROD** |

### Bank Group Membership Per Environment

| Bank | SIT | UAT | PROD |
|------|-----|-----|------|
| 11 South Sudan | group | group | group |
| 43 DRC | group | individual (own server) | group (own servers coming) |
| 50 Rwanda | group | individual (own server) | individual (own servers) |
| 54 Kenya | group | group | group |
| 55 Tanzania | group | individual (own server) | individual (own server — no Branch/FI split) |
| 56 Uganda | group | individual (own server) | individual (own servers) |
| 99 Finserve | group | group | NOT PRESENT |

---

## 3. Three-Environment Architecture

### 3.1 SIT (System Integration Testing)

**Git Branch:** `sit`

**Topology:** One physical server handles all banks together.

**Bank grouping:** All banks (11, 43, 50, 54, 55, 56, 99) are in a single `group`.

**Server prefix:** `EQSIT`

**Server base path (fincore):**
```
/equity_fe/EQSIT/FrontEnd/FinacleApps/finbranch.war/custom/
```

**Routing tags emitted:** `J2EE-group` (always — one server gets all changes)

**Deploy script arguments:**
```bash
deploy-j2ee.sh --target group
```

**CD pipeline routing stages:** 1 (J2EE-group)

---

### 3.2 UAT (Finacle Preprod)

**Git Branch:** `uat`

**Topology:** One Group server shared by 11, 54, 99; four individual servers for 43, 50, 55, 56.

**Bank groupings and base paths:**

| Target | Banks | Fincore base path | CRM base path |
|--------|-------|-------------------|---------------|
| `group` | 11, 54, 99 | `/equity_fe/EQUAT/FrontEnd/FinacleApps/finbranch.war/custom/` | `/equity_fe/EQUAT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/` |
| `43`, `50`, `56` | DRC, Rwanda, Uganda | `/u01/equity_fe/FinacleApps/finbranch.war/custom/` | `/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/` |
| `55` | Tanzania | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization/` |

> **Note:** DRC (43), Rwanda (50), and Uganda (56) all share the same base path (`/u01/equity_fe/FinacleApps/...`) — they are distinguished only by their bank ID in the path and by which physical server is SSH'd into.

**Routing tags emitted:** `J2EE-group`, `J2EE-43`, `J2EE-50`, `J2EE-55`, `J2EE-56`

**Deploy script arguments:**
```bash
deploy-j2ee.sh --target group
deploy-j2ee.sh --target 43
deploy-j2ee.sh --target 50
deploy-j2ee.sh --target 55
deploy-j2ee.sh --target 56
```

**CD pipeline routing stages:** 5

**Key UAT rule — `group/global/` folder:**
Banks 11, 54, and 99 all share the same physical Group server. If each had its own `<bank_id>/global/` folder, deploying both `11/global/menu.xml` and `54/global/menu.xml` would overwrite each other (same filename, different repo folder, same server destination). To avoid this, global files for Group banks live under one shared `group/global/` folder in the repo. Only one version of each global file is maintained per shared server.

---

### 3.3 PROD (Production)

**Git Branch:** `prod`

**Topology:** Group has two physical servers (Branch and FI); Rwanda and Uganda also have Branch and FI servers; Tanzania has a single server (no Branch/FI split).

**Bank groupings and base paths:**

| Target | Banks | Branch base path (fincore) | FI base path (fincore) |
|--------|-------|---------------------------|------------------------|
| `group` | 11, 43, 54 | `/equity_fe/EQPROD/FrontEnd/FinacleApps/finbranch.war/custom/` | `/equity_fe/EQPRODFI/FrontEnd/FinacleApps/finbranch.war/custom/` |
| `50`, `56` | Rwanda, Uganda | `/u01/equity_fe/FinacleApps/finbranch.war/custom/` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/` (same path, different machine) |
| `55` | Tanzania | `/finacle/EQTZPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/` | — (single server, no split) |

> **Note:** Rwanda (50) and Uganda (56) use the same base path (`/u01/equity_fe/FinacleApps/...`) for both Branch and FI. The `--server-type` argument determines which physical machine to SSH into, not which path to write.

**Routing tags emitted:**
`J2EE-group-branch`, `J2EE-group-fi`, `J2EE-50-branch`, `J2EE-50-fi`, `J2EE-56-branch`, `J2EE-56-fi`, `J2EE-55`

**Deploy script arguments:**
```bash
deploy-j2ee.sh --target group --server-type branch
deploy-j2ee.sh --target group --server-type fi
deploy-j2ee.sh --target 50 --server-type branch
deploy-j2ee.sh --target 50 --server-type fi
deploy-j2ee.sh --target 56 --server-type branch
deploy-j2ee.sh --target 56 --server-type fi
deploy-j2ee.sh --target 55
```

**CD pipeline routing stages:** 7

**Notes on `--server-type`:**
- For Group: `--server-type branch` → `EQPROD` prefix; `--server-type fi` → `EQPRODFI` prefix (different server path)
- For Rwanda/Uganda: Branch and FI servers use the **same path** — `--server-type` determines which machine to SSH into, not which path to write. The CD pipeline calls `suScript.sh` with separate server IPs per server type; the script itself uses the same path either way.

**DRC (43) in PROD:**
DRC is currently routed to the Group server (same path as 11 and 54). Its own dedicated server logic must be written into `deploy-j2ee-prod.sh` but **commented out** — when DRC's dedicated servers arrive, the comment is removed and a new `J2EE-43-branch` / `J2EE-43-fi` routing stage is added to the CD pipeline. This avoids a scramble to retrofit the script later.

---

## 4. Repository Structures

The folder structure differs per environment because the bank topology differs. Each env lives on its own Git branch.

### SIT (`sit` branch)

```
fincore/custom/
  group/
    global/          ← group-wide files → server root (strips group/global)
    11/              ← Sudan
    43/              ← DRC
    50/              ← Rwanda
    54/              ← Kenya
    55/              ← Tanzania
    56/              ← Uganda
    99/              ← Finserve

crm/customization/
  group/
    global/
    11/  43/  50/  54/  55/  56/  99/
```

### UAT (`uat` branch)

```
fincore/custom/
  group/
    global/          ← one shared global folder for banks on the Group server (11, 54, 99)
    11/              ← Sudan (Group server)
    54/              ← Kenya (Group server)
    99/              ← Finserve (Group server)
  43/                ← DRC (own server)
    local/
    global/          ← DRC-server-specific global files
  50/                ← Rwanda (own server)
    local/
    global/
  55/                ← Tanzania (own server)
    local/
    global/
  56/                ← Uganda (own server)
    local/
    global/

crm/customization/
  (mirrors the same structure)
```

### PROD (`prod` branch)

```
fincore/
  branch/
    group/
      global/        ← Group Branch global (strips branch/group/global → server root)
      11/            ← Sudan Branch files
      43/            ← DRC Branch files (logic in script is commented out)
      54/            ← Kenya Branch files
    50/              ← Rwanda Branch (own server)
      local/
      global/        ← Rwanda Branch global
    56/              ← Uganda Branch (own server)
      local/
      global/
  fi/
    group/
      global/        ← Group FI global (strips fi/group/global → server root)
      11/            ← Sudan FI files
      43/            ← DRC FI files (commented out in script)
      54/            ← Kenya FI files
    50/              ← Rwanda FI (own server — same path as Branch, different machine)
      local/
      global/
    56/              ← Uganda FI (own server — same path as Branch, different machine)
      local/
      global/
  tanzania/
    55/              ← Tanzania (single server — handles both Branch and FI)
      local/
      global/        ← Tanzania global

crm/customization/
  (mirrors the same branch/fi/tanzania structure)
```

---

## 5. Server Path Mapping

### SIT — All files → one server

| Repo Path | Server Path (fincore) |
|-----------|----------------------|
| `fincore/custom/group/<bank_id>/<file>` | `/equity_fe/EQSIT/FrontEnd/FinacleApps/finbranch.war/custom/<bank_id>/<file>` |
| `fincore/custom/group/global/<file>` | `/equity_fe/EQSIT/FrontEnd/FinacleApps/finbranch.war/custom/<file>` |
| `crm/customization/group/<bank_id>/<file>` | `/equity_fe/EQSIT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<file>` |
| `crm/customization/group/global/<file>` | `/equity_fe/EQSIT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<file>` |

### UAT

**Fincore:**

| Target | Repo Path | Server Path |
|--------|-----------|-------------|
| `group` | `custom/group/<bank_id>/<f>` (11, 54, 99) | `/equity_fe/EQUAT/FrontEnd/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `group` | `custom/group/global/<f>` | `/equity_fe/EQUAT/FrontEnd/FinacleApps/finbranch.war/custom/<f>` |
| `43`, `50`, `56` | `custom/<bank_id>/local/<f>` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `43`, `50`, `56` | `custom/<bank_id>/global/<f>` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<f>` |
| `55` | `custom/55/local/<f>` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/55/<f>` |
| `55` | `custom/55/global/<f>` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/<f>` |

**CRM:**

| Target | Repo Path | Server Path |
|--------|-----------|-------------|
| `group` | `customization/group/<bank_id>/<f>` (11, 54, 99) | `/equity_fe/EQUAT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<f>` |
| `group` | `customization/group/global/<f>` | `/equity_fe/EQUAT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |
| `43`, `50`, `56` | `customization/<bank_id>/local/<f>` | `/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<f>` |
| `43`, `50`, `56` | `customization/<bank_id>/global/<f>` | `/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |
| `55` | `customization/55/local/<f>` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization/55/<f>` |
| `55` | `customization/55/global/<f>` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |

### PROD

**Fincore:**

| Target | Server-type | Repo Path | Server Path |
|--------|-------------|-----------|-------------|
| `group` | `branch` | `branch/group/<bank_id>/<f>` (11, 43, 54) | `/equity_fe/EQPROD/FrontEnd/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `group` | `fi` | `fi/group/<bank_id>/<f>` (11, 43, 54) | `/equity_fe/EQPRODFI/FrontEnd/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `group` | `branch` | `branch/group/global/<f>` | `/equity_fe/EQPROD/FrontEnd/FinacleApps/finbranch.war/custom/<f>` |
| `group` | `fi` | `fi/group/global/<f>` | `/equity_fe/EQPRODFI/FrontEnd/FinacleApps/finbranch.war/custom/<f>` |
| `50`, `56` | `branch` | `branch/<bank_id>/local/<f>` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `50`, `56` | `fi` | `fi/<bank_id>/local/<f>` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `50`, `56` | `branch` | `branch/<bank_id>/global/<f>` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<f>` |
| `50`, `56` | `fi` | `fi/<bank_id>/global/<f>` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<f>` |
| `55` | — | `tanzania/55/local/<f>` | `/finacle/EQTZPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/55/<f>` |
| `55` | — | `tanzania/55/global/<f>` | `/finacle/EQTZPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/<f>` |

**CRM:**

| Target | Server-type | Repo Path | Server Path |
|--------|-------------|-----------|-------------|
| `group` | `branch` | `branch/group/<bank_id>/<f>` (11, 43, 54) | `/equity_fe/EQPROD/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<f>` |
| `group` | `fi` | `fi/group/<bank_id>/<f>` (11, 43, 54) | `/equity_fe/EQPRODFI/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<f>` |
| `group` | `branch` | `branch/group/global/<f>` | `/equity_fe/EQPROD/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |
| `group` | `fi` | `fi/group/global/<f>` | `/equity_fe/EQPRODFI/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |
| `50`, `56` | `branch` | `branch/<bank_id>/local/<f>` | `/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<f>` |
| `50`, `56` | `fi` | `fi/<bank_id>/local/<f>` | `/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<f>` |
| `50`, `56` | `branch` or `fi` | `branch` or `fi/<bank_id>/global/<f>` | `/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |
| `55` | — | `tanzania/55/local/<f>` | `/finacle/EQTZPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization/55/<f>` |
| `55` | — | `tanzania/55/global/<f>` | `/finacle/EQTZPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |

> **Global strip rule:** `global/` AND its containing organizational folder (`group/`, or `<bank_id>/` for subsidiaries) are stripped from the server path. They are repo-only keywords.
> **Rwanda (50) and Uganda (56) PROD:** Branch and FI servers use the **same path** (`/u01/equity_fe/FinacleApps/...`) — `--server-type` determines which physical machine to SSH into, not which path to write.

---

## 6. Implementation Roadmap

---

### Phase 1 — Repository & Branch Setup

**Status: 🔜 Pending**

**What to do:**

1. Create three Git branches from the current working state:
   ```bash
   git checkout -b sit
   git checkout -b uat
   git checkout -b prod
   ```

2. Restructure the repo folder layout on each branch:
   - `sit` branch: wrap all bank folders under `group/` (e.g. `fincore/custom/group/54/`)
   - `uat` branch: create `group/` for banks 11, 54, 99; leave 43, 50, 55, 56 as top-level under `custom/` with `local/` and `global/` subfolders
   - `prod` branch: reorganize into `branch/`, `fi/`, and `tanzania/` top-level folders under `fincore/`

3. Rename YAML files per env:
   - `azure-pipelines-fincore-sit.yml`, `azure-pipelines-crm-sit.yml`
   - `azure-pipelines-fincore-uat.yml`, `azure-pipelines-crm-uat.yml`
   - `azure-pipelines-fincore-prod.yml`, `azure-pipelines-crm-prod.yml`

4. Update YAML `trigger.branches.include` to the new branch name on each branch (e.g. `sit` branch YAML triggers on `sit`).

---

### Phase 2 — SIT Scripts

**Status: 🔜 Pending**

**Goal:** Simplest possible scripts — all changes go to one server.

**`check-modified-files-sit.sh`:**
- Detect file changes as usual (git diff, manifest writing)
- `detect_deployment_targets()`: emit `DEPLOY_GROUP=true` for any changed file under `fincore/custom/group/` or `crm/customization/group/`
- `metadata.json` output:
  ```json
  {
    "deploy_group": true
  }
  ```
- Remove all `DEDICATED_BANKS_IDS`, `DEDICATED_BANK_PREFIX`, and multi-bank routing logic

**`deploy-j2ee-sit.sh`:**
- Arguments: `--target group` (only valid value in SIT)
- Path resolution: all files → `/equity_fe/EQSIT/...`; strip `group/` from the bank path segment; strip `global/` for global files
- No `--env` argument, no `DEDICATED_BANK_PREFIX` map — hard-coded EQSIT prefix

**`azure-pipelines-*-sit.yml` — `Determine Routing Tags` step:**
```bash
DEPLOY_GROUP=$(grep '"deploy_group"' metadata.json | grep -o 'true\|false')
if [ "$DEPLOY_GROUP" == "true" ]; then
    az pipelines build tag add --build-id $(Build.BuildId) --tags "J2EE-group"
fi
```

**`suScript.sh` arguments for SIT:**
```bash
suScript.sh <server-ip> J2EE-group <release_id>
# → calls: deploy-j2ee-sit.sh --target group
```

---

### Phase 3 — UAT Scripts

**Status: 🔜 Pending**

**`check-modified-files-uat.sh`:**
- `detect_deployment_targets()`: extract the top-level folder from each changed file path
  - `custom/group/...` → tag bank as `group`
  - `custom/43/...` → tag as `43`
  - `custom/50/...` → tag as `50`
  - etc.
- `metadata.json`:
  ```json
  {
    "deploy_group": true,
    "deploy_bank_ids": ["50", "56"]
  }
  ```

**`deploy-j2ee-uat.sh`:**
- Arguments: `--target group | 43 | 50 | 55 | 56`
- `GROUP_BANKS=("11" "54" "99")` — config array defining which bank IDs live under `group/`
- Path root constants (no per-bank prefix array needed — only three distinct base paths exist):
  ```bash
  GROUP_BASE="/equity_fe/EQUAT/FrontEnd/FinacleApps"
  SUBSIDIARY_BASE="/u01/equity_fe/FinacleApps"
  TANZANIA_BASE="/finacle/EQTZPPROD/Fin10218/J2EE/Deployment"
  ```
- `resolve_server_path()`: case on `--target`:
  - `group` → `$GROUP_BASE/finbranch.war/custom/<bank_id>/<file>` (bank_id read from path segment after `group/`)
  - `group` + `global/` → `$GROUP_BASE/finbranch.war/custom/<file>` (strips `group/global/`)
  - `43|50|56` → `$SUBSIDIARY_BASE/finbranch.war/custom/<bank_id>/<file>`
  - `43|50|56` + `global/` → `$SUBSIDIARY_BASE/finbranch.war/custom/<file>` (strips `<bank_id>/global/`)
  - `55` → `$TANZANIA_BASE/finbranch.ear/finbranch.war/custom/55/<file>`
  - `55` + `global/` → `$TANZANIA_BASE/finbranch.ear/finbranch.war/custom/<file>`
- `should_deploy_file()`: reads the file's bank_id from path; if `--target group` and bank_id is in `GROUP_BANKS`, deploy it; if `--target 50` and bank_id == `50`, deploy it; otherwise skip

**`azure-pipelines-*-uat.yml` — `Determine Routing Tags` step:**
```bash
DEPLOY_GROUP=$(grep '"deploy_group"' metadata.json | grep -o 'true\|false')
DEPLOY_BANK_IDS=$(sed -n 's/.*"deploy_bank_ids".*\[\(.*\)\].*/\1/p' metadata.json | tr -d '" ' | tr ',' ' ')

if [ "$DEPLOY_GROUP" == "true" ]; then
    az pipelines build tag add --build-id $(Build.BuildId) --tags "J2EE-group"
fi
for bank_id in $DEPLOY_BANK_IDS; do
    az pipelines build tag add --build-id $(Build.BuildId) --tags "J2EE-$bank_id"
done
```

**CD routing stages (UAT):** 5 stages (J2EE-group, J2EE-43, J2EE-50, J2EE-55, J2EE-56)

---

### Phase 4 — PROD Scripts

**Status: 🔜 Pending**

**`check-modified-files-prod.sh`:**
- Detect the top-level folder from each changed file path:
  - `branch/group/...` → routing tag `J2EE-group-branch`
  - `fi/group/...` → routing tag `J2EE-group-fi`
  - `branch/50/...` → routing tag `J2EE-50-branch`
  - `fi/50/...` → routing tag `J2EE-50-fi`
  - `branch/56/...` → routing tag `J2EE-56-branch`
  - `fi/56/...` → routing tag `J2EE-56-fi`
  - `tanzania/55/...` → routing tag `J2EE-55`
- `metadata.json`:
  ```json
  {
    "deploy_tags": ["J2EE-group-branch", "J2EE-50-fi", "J2EE-55"]
  }
  ```

**`deploy-j2ee-prod.sh`:**
- Arguments: `--target group|50|56|55 --server-type branch|fi`
- `--server-type` is required for all targets except `55` (Tanzania has no split)
- `GROUP_BANKS=("11" "43" "54")` — config array for Group banks in PROD
- Path root constants (four distinct base paths for PROD):
  ```bash
  GROUP_BRANCH_BASE="/equity_fe/EQPROD/FrontEnd/FinacleApps"
  GROUP_FI_BASE="/equity_fe/EQPRODFI/FrontEnd/FinacleApps"
  SUBSIDIARY_BASE="/u01/equity_fe/FinacleApps"
  TANZANIA_BASE="/finacle/EQTZPROD/Fin10218/J2EE/Deployment"
  ```
- `resolve_server_path()`:
  - `group` + `--server-type branch` → `$GROUP_BRANCH_BASE/finbranch.war/custom/<bank_id>/<file>`
  - `group` + `--server-type branch` + `global/` → `$GROUP_BRANCH_BASE/finbranch.war/custom/<file>` (strips `branch/group/global/`)
  - `group` + `--server-type fi` → `$GROUP_FI_BASE/finbranch.war/custom/<bank_id>/<file>`
  - `group` + `--server-type fi` + `global/` → `$GROUP_FI_BASE/finbranch.war/custom/<file>` (strips `fi/group/global/`)
  - `50|56` → `$SUBSIDIARY_BASE/finbranch.war/custom/<bank_id>/<file>` (same path for branch and fi — `--server-type` only selects the machine in CD)
  - `50|56` + `global/` → `$SUBSIDIARY_BASE/finbranch.war/custom/<file>` (strips `<bank_id>/global/`)
  - `55` → `$TANZANIA_BASE/finbranch.ear/finbranch.war/custom/55/<file>`
  - `55` + `global/` → `$TANZANIA_BASE/finbranch.ear/finbranch.war/custom/<file>` (strips `tanzania/55/global/`)
  - DRC (`43`) dedicated server: write the case for `43` → `$SUBSIDIARY_BASE/...` but **comment it out**; add `# UNCOMMENT WHEN DRC GETS OWN PROD SERVERS` marker

**`azure-pipelines-*-prod.yml` — `Determine Routing Tags` step:**
```bash
DEPLOY_TAGS=$(sed -n 's/.*"deploy_tags".*\[\(.*\)\].*/\1/p' metadata.json | tr -d '" ' | tr ',' ' ')
for tag in $DEPLOY_TAGS; do
    az pipelines build tag add --build-id $(Build.BuildId) --tags "$tag"
done
```

**CD routing stages (PROD):** 7 stages
- `J2EE-group-branch` → Group Branch server(s)
- `J2EE-group-fi` → Group FI server(s)
- `J2EE-50-branch` → Rwanda Branch server
- `J2EE-50-fi` → Rwanda FI server
- `J2EE-56-branch` → Uganda Branch server
- `J2EE-56-fi` → Uganda FI server
- `J2EE-55` → Tanzania server

**`suScript.sh` for PROD (examples):**
```bash
suScript.sh <group-branch-ip> J2EE-group-branch <release_id>
# → calls: deploy-j2ee-prod.sh --target group --server-type branch

suScript.sh <tz-ip> J2EE-55 <release_id>
# → calls: deploy-j2ee-prod.sh --target 55
```

---

### Phase 5 — Azure DevOps CI/CD Pipelines

**Status: 🔜 Pending**

#### CI Pipelines — 6 total (2 per env)

| Pipeline YAML | Branch | Trigger | Artifact |
|---|---|---|---|
| `azure-pipelines-fincore-sit.yml` | `sit` | `fincore/*` | `fincore_drop` |
| `azure-pipelines-crm-sit.yml` | `sit` | `crm/*` | `crm_drop` |
| `azure-pipelines-fincore-uat.yml` | `uat` | `fincore/*` | `fincore_drop` |
| `azure-pipelines-crm-uat.yml` | `uat` | `crm/*` | `crm_drop` |
| `azure-pipelines-fincore-prod.yml` | `prod` | `fincore/*` | `fincore_drop` |
| `azure-pipelines-crm-prod.yml` | `prod` | `crm/*` | `crm_drop` |

#### CD Pipelines — 6 total (2 per env), 13 routing stages across all

| CD Pipeline | Trigger Tag | Routing Stages | Per-Stage SSH Call |
|---|---|---|---|
| `J2EE-Fincore-SIT-CD` | `FINCORE-SIT` | `J2EE-group` | `suScript.sh <sit-ip> J2EE-group <rid>` |
| `J2EE-CRM-SIT-CD` | `CRM-SIT` | `J2EE-group` | `suScript.sh <sit-ip> J2EE-group <rid>` |
| `J2EE-Fincore-UAT-CD` | `FINCORE-UAT` | `J2EE-group`, `J2EE-43`, `J2EE-50`, `J2EE-55`, `J2EE-56` | per target |
| `J2EE-CRM-UAT-CD` | `CRM-UAT` | same 5 | per target |
| `J2EE-Fincore-Prod-CD` | `FINCORE-PROD` | 7 stages (see PROD section) | per target |
| `J2EE-CRM-Prod-CD` | `CRM-PROD` | same 7 | per target |

**Key CD configuration:**
- ✅ "Create a release when tags are added to an existing build" — required; routing tags are added after build finishes
- SCP source: `$(System.DefaultWorkingDirectory)/_<artifact-alias>/<drop_name>`
- SCP target: `/tmp/j2ee-deploy-$(Release.ReleaseId)/`
- SSH arguments: `<server-ip> <routing-tag> $(Release.ReleaseId)`
- Routing stage pre-deployment condition: artifact tag filter matches the routing tag

---

### Phase 6 — Rollback Pipeline (Future)

**Status: 🔜 Future — build after end-to-end testing passes**

**Goal:** Safe, auditable rollback without requiring git expertise.

`deploy-j2ee.sh` already creates timestamped backups before every MODIFIED or DELETED operation:
```
/equity_fe/.../custom/54/backup/cif/display/Account.xsl_20260415_142305
```

**What to build:**

#### 6a — `rollback-j2ee.sh`
- Accepts `--target` and `--timestamp` arguments
- Restores backed-up files to their original server paths
- Logs: who triggered, when, what was restored

#### 6b — Rollback CD Pipelines (manual trigger only)

| Pipeline | App | Trigger |
|---|---|---|
| `J2EE-Fincore-Rollback-CD` | Fincore | Manual only |
| `J2EE-CRM-Rollback-CD` | CRM | Manual only |

- No automatic trigger — manual initiation only
- Pre-deployment approval gate on every stage
- Operator selects previous artifact version from dropdown

**Rollback levels:**

| Level | Method | Access |
|---|---|---|
| 1 | Azure DevOps → previous release → Redeploy | Ops team |
| 2 | `rollback-j2ee.sh` on server | Support engineer |
| 3 | Dedicated rollback pipeline with approval gate | Any authorized user |

---

### Phase 7 — Testing & Validation (Future)

**Status: 🔜 Future**

#### Test Matrix

| Test Case | Expected Result |
|---|---|
| Commit `group/50/` fincore file on `sit` | `FINCORE-SIT` + `J2EE-group`; SIT server receives file at `custom/50/<file>` |
| Commit `50/local/` fincore file on `uat` | `FINCORE-UAT` + `J2EE-50`; Rwanda UAT server only |
| Commit `group/global/` file on `uat` | `FINCORE-UAT` + `J2EE-group`; Group server receives file at root `custom/` path |
| Commit `branch/group/54/` file on `prod` | `FINCORE-PROD` + `J2EE-group-branch`; Group Branch server receives file |
| Commit same file in `branch/` and `fi/` on `prod` | `J2EE-group-branch` + `J2EE-group-fi` both emit; both servers receive file |
| Commit `tanzania/55/` file on `prod` | `FINCORE-PROD` + `J2EE-55`; Tanzania server only; no Branch/FI split |
| Commit non-J2EE file (e.g. `.md`) | No manifest entries; no routing tags; no CD triggered |
| Delete a file on `prod` | File backed up (timestamped) then deleted from target server |

#### Validation Checklist Per Deployment

- [ ] `deployment-manifest.txt` contains correct entries
- [ ] `metadata.json` has correct deploy tags/flags
- [ ] Correct routing tags appear on the CI build in Azure DevOps
- [ ] Correct CD routing stages triggered — and only those
- [ ] Global files arrive at server root (without `global/` in path)
- [ ] Per-bank files arrive under correct `<bank_id>/` subfolder
- [ ] Backups created before MODIFIED/DELETED
- [ ] File permissions: `chmod -R 755`, owner `applmgr`
- [ ] `deploy-j2ee.sh` summary shows `FAILED DEPLOYMENTS COUNTER : 0`

---

## 7. CI/CD Tag Reference

### Environment Tags — set by `Determine Deployment Tag` step

| Tag | Branch | Purpose |
|---|---|---|
| `CRM-SIT` | `sit` | Triggers `J2EE-CRM-SIT-CD` |
| `CRM-UAT` | `uat` | Triggers `J2EE-CRM-UAT-CD` |
| `CRM-PROD` | `prod` | Triggers `J2EE-CRM-Prod-CD` |
| `FINCORE-SIT` | `sit` | Triggers `J2EE-Fincore-SIT-CD` |
| `FINCORE-UAT` | `uat` | Triggers `J2EE-Fincore-UAT-CD` |
| `FINCORE-PROD` | `prod` | Triggers `J2EE-Fincore-Prod-CD` |

### Routing Tags — set by `Determine Routing Tags` step

**SIT:**
| Tag | Gates |
|---|---|
| `J2EE-group` | SIT Group server stage |

**UAT:**
| Tag | Gates |
|---|---|
| `J2EE-group` | UAT Group server stage (banks 11, 54, 99) |
| `J2EE-43` | UAT DRC server stage |
| `J2EE-50` | UAT Rwanda server stage |
| `J2EE-55` | UAT Tanzania server stage |
| `J2EE-56` | UAT Uganda server stage |

**PROD:**
| Tag | Gates |
|---|---|
| `J2EE-group-branch` | PROD Group Branch server stage (banks 11, 43, 54) |
| `J2EE-group-fi` | PROD Group FI server stage |
| `J2EE-50-branch` | PROD Rwanda Branch server stage |
| `J2EE-50-fi` | PROD Rwanda FI server stage |
| `J2EE-56-branch` | PROD Uganda Branch server stage |
| `J2EE-56-fi` | PROD Uganda FI server stage |
| `J2EE-55` | PROD Tanzania server stage |

---

## 8. End-to-End Flow

```
Developer commits to prod → CI Pipeline triggers (fincore/* changed)
│
├─ Determine Deployment Tag
│    Branch prod → adds tag: FINCORE-PROD         ← fires the CD pipeline
│
├─ Check Modified Files (check-modified-files-prod.sh)
│    Detects NEW/MODIFIED/DELETED, writes manifest
│    metadata.json: { "deploy_tags": ["J2EE-group-branch", "J2EE-group-fi", "J2EE-55"] }
│
├─ Determine Routing Tags
│    Reads metadata.json (pure bash)
│    Emits: J2EE-group-branch, J2EE-group-fi, J2EE-55   ← gates CD routing stages
│
├─ Archive → j2ee-scripts.tar.gz
└─ Publish: fincore_drop artifact
                │
                ▼
   J2EE-Fincore-Prod-CD fires (triggered by FINCORE-PROD tag)
                │
   ┌────────────┼──────────────┬──────────────┬──────────────┐
   │            │              │              │              │
J2EE-group- J2EE-group-  J2EE-50-   J2EE-56-   J2EE-55
  branch       fi          branch     branch
[gate: tag]  [gate: tag]  [NO TAG]   [NO TAG]   [gate: tag]
   │            │                                   │
   ▼            ▼                                   ▼
Group Branch  Group FI                          Tanzania
Server(s)     Server(s)                         Server
SCP + SSH     SCP + SSH                         SCP + SSH
│             │                                 │
▼             ▼                                 ▼
suScript.sh   suScript.sh                       suScript.sh
--target group  --target group                  --target 55
--server-type   --server-type
  branch          fi
```

---

## 9. Key Design Decisions

| Decision | Rationale |
|---|---|
| **Per-env branches (`sit`, `uat`, `prod`) — independent, never merged** | Each env has fundamentally different topology. Merging would require complex conflict resolution across folder structures. Independent branches let each env evolve at its own pace. |
| **Separate scripts per env** | Eliminates conditional branching within scripts (no `if ENV == prod` trees). Each script is readable and testable in isolation. Reduces risk of a change in one env accidentally affecting another. |
| **`group/global/` shared folder (not per-bank global)** | Banks sharing a physical server cannot each have their own `global/` — different repo folders would overwrite each other at the same server destination. One `group/global/` per shared server enforces one canonical version. |
| **`--target group` replaces individual bank IDs for shared-server banks** | A single CD routing stage and a single `suScript.sh` invocation deploys all Group banks in one shot. No need for separate routing stages per bank within a group. |
| **`--server-type branch\|fi` in PROD** | Groups Branch and FI under a single `--target group` while still targeting the correct physical server and path prefix. Without this, PROD would need 6 separate group targets (group-branch, group-fi, 50-branch, 50-fi, 56-branch, 56-fi) each with different path logic rather than one argument. |
| **Tanzania (`55`) isolated under `tanzania/` folder in PROD repo** | Tanzania has one server that handles both Branch and FI functions. Placing it under `branch/` or `fi/` would be misleading. Its own top-level folder makes its unique topology self-documenting. |
| **DRC (43) PROD logic written but commented out** | DRC is temporarily routed to the Group server. When dedicated servers arrive, removing one comment block and adding a CD routing stage is all that's needed — no retrofitting of script logic. |
| **Environment tags trigger CD pipeline; routing tags gate CD stages** | Clean separation: `FINCORE-PROD` opens the door to the release pipeline; `J2EE-group-branch`/`J2EE-55`/etc. decide which server stages run. |
| **"Create release when tags are added to existing build" must be checked** | Routing tags are added after build completion — without this setting, the CD would not re-trigger when routing tags arrive. |
| **Routing tag step reads `metadata.json` in pure bash (grep + sed + tr)** | Dependency-free. Works on any standard Linux agent without Python, jq, or other tools. |
| **`j2ee-scripts.tar.gz` — same name in all 6 CI pipelines** | `suScript.sh` extracts it without needing to know which app or env the artifact came from. |
| **`RESOLVED_PATH` global variable in `resolve_server_path()`** | Avoids `$()` command substitution, which would capture all stdout including `log()` output and corrupt the returned path. |
| **Backup before every MODIFIED/DELETED — timestamped in `backup/` subfolder** | Foundation for file-level rollback. Any change can be undone without a full re-deploy. |
| **Staging dir under `/tmp/j2ee-deploy-<release_id>/`** | `/tmp` needs no permission setup. Unique per-release suffix prevents file mixing when multiple deployments run concurrently. |
| **`suScript.sh` owns cleanup** | Creator-cleans-up: `suScript.sh` set up the staging directory, so it tears it down. `deploy-j2ee.sh` has no knowledge of staging setup. Exit code is captured before cleanup so pipeline sees failures. |
| **Rollback deferred until Phase 7 testing passes** | Rollback tooling is most valuable once forward deployment is stable and trusted. Building it in parallel adds risk. |
