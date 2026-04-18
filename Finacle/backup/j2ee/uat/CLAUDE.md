# CLAUDE.md — J2EE Deployment Automation Project

> **Absolute Project Path:** `/Users/bishop/Programming/projects/work/WorkSpace/NetBeans/GAG/Finacle/j2ee/j2ee-scripts`
> Always use this absolute path when referencing, reading, or editing any file in this project.

---

## Project Summary

This is a **Finacle J2EE customization deployment automation system** for a multi-subsidiary banking group operating across East and Central Africa.

It manages two Finacle applications:
- **CRM** (`crm/customization/`) — Finacle CRM customizations → artifact `crm_drop`
- **Fincore** (`fincore/custom/`) — Finacle Financial Core customizations → artifact `fincore_drop`

Deployment is automated via **Azure DevOps** — YAML pipelines for CI, Classic Release Pipelines for CD.

**Architecture status:** The current scripts (`deploy-j2ee.sh`, `check-modified-files.sh`) represent an intermediate state from an earlier refactor. The target architecture (full 3-environment per-env separation) is documented in this file and in `j2ee_roadmap.md`. The implementation plan is in roadmap Phases 1–5.

---

## Subsidiaries

| ID  | Country     | Notes                                                  |
|-----|-------------|--------------------------------------------------------|
| 11  | South Sudan | Group member in UAT and PROD                           |
| 43  | DRC         | Group member in PROD; individual server in UAT         |
| 50  | Rwanda      | Own dedicated servers in UAT and PROD                  |
| 54  | Kenya       | Group member in UAT and PROD                           |
| 55  | Tanzania    | Own dedicated server in all envs; no Branch/FI split in PROD |
| 56  | Uganda      | Own dedicated servers in UAT and PROD                  |
| 99  | Finserve    | Virtual bank — shares Kenya (54) servers in SIT and UAT; NOT in PROD |

---

## Bank Groupings Per Environment

### SIT — One Group server, all banks together

| Group  | Banks           | Notes                              |
|--------|-----------------|------------------------------------|
| group  | 11, 43, 50, 54, 55, 56, 99 | All banks on single SIT server |

**Routing tag emitted:** `J2EE-group`

---

### UAT — Group server + individual servers per subsidiary

| Target | Banks | Base path (fincore) |
|--------|-------|---------------------|
| `group` | 11, 54, 99 | `/equity_fe/EQUAT/FrontEnd/FinacleApps/finbranch.war/custom/` |
| `43`, `50`, `56` | DRC, Rwanda, Uganda | `/u01/equity_fe/FinacleApps/finbranch.war/custom/` |
| `55` | Tanzania | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/` |

> DRC, Rwanda, and Uganda share the same `/u01/equity_fe/FinacleApps/...` base path — differentiated by bank ID and SSH target IP.

**Routing tags emitted:** `J2EE-group`, `J2EE-43`, `J2EE-50`, `J2EE-55`, `J2EE-56`

---

### PROD — Group Branch server + Group FI server + individual servers

| Target | Banks | Branch base path (fincore) | FI base path (fincore) |
|--------|-------|---------------------------|------------------------|
| `group` | 11, 43, 54 | `/equity_fe/EQPROD/FrontEnd/FinacleApps/finbranch.war/custom/` | `/equity_fe/EQPRODFI/FrontEnd/FinacleApps/finbranch.war/custom/` |
| `50`, `56` | Rwanda, Uganda | `/u01/equity_fe/FinacleApps/finbranch.war/custom/` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/` (same path, different machine) |
| `55` | Tanzania | `/finacle/EQTZPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/` | — (single server, no split) |

**Notes:**
- Finserve (99) is **NOT in PROD**
- DRC (43) is in the PROD Group but its own server logic is written and commented out (dedicated servers coming)
- `--server-type branch|fi` determines which physical machine to target; only affects path resolution for Group

**Routing tags emitted:** `J2EE-group-branch`, `J2EE-group-fi`, `J2EE-50-branch`, `J2EE-50-fi`, `J2EE-56-branch`, `J2EE-56-fi`, `J2EE-55`

---

## Per-Environment Design Rules

| Rule | Description |
|------|-------------|
| **Independent branches** | `sit`, `uat`, `prod` — changes are NOT promoted between branches via git merge |
| **Separate scripts per env** | Each env has its own YAML files and shell scripts — no shared logic |
| **`group/global/` folder** | One global folder per physical server — banks sharing a server use `group/global/`, never `<bank_id>/global/` |
| **Tanzania isolation (PROD)** | Tanzania lives under `tanzania/` folder at PROD level — outside `branch/` and `fi/` — because it shares one server for both |
| **`--target group`** | New value replacing individual bank IDs for banks sharing a server |
| **`--server-type branch\|fi`** | PROD-only argument; for Group it changes the path prefix (EQPROD vs EQPRODFI); for subsidiaries same path on different machine |

---

## Repository Structures

### SIT (`sit` branch)

```
fincore/custom/
  group/
    global/          ← group-wide files → server root (strips group/global from path)
    11/              ← Sudan files
    43/              ← DRC files
    50/              ← Rwanda files
    54/              ← Kenya files
    55/              ← Tanzania files
    56/              ← Uganda files
    99/              ← Finserve files
```

### UAT (`uat` branch)

```
fincore/custom/
  group/
    global/          ← Group server global files (shared by 11, 54, 99 — one folder avoids overwrite conflicts)
    11/              ← Sudan files
    54/              ← Kenya files
    99/              ← Finserve files
  43/                ← DRC (own server)
    local/
    global/          ← DRC server global files
  50/                ← Rwanda (own server)
    local/
    global/          ← Rwanda server global files
  55/                ← Tanzania (own server)
    local/
    global/          ← Tanzania server global files
  56/                ← Uganda (own server)
    local/
    global/          ← Uganda server global files
```

### PROD (`prod` branch)

```
fincore/
  branch/
    group/
      global/        ← Group Branch global (strips branch/group/global from server path)
      11/            ← Sudan Branch files
      43/            ← DRC Branch files (logic commented out; will activate when own servers arrive)
      54/            ← Kenya Branch files
    50/              ← Rwanda Branch (own server)
      local/
      global/        ← Rwanda Branch global
    56/              ← Uganda Branch (own server)
      local/
      global/        ← Uganda Branch global
  fi/
    group/
      global/        ← Group FI global (strips fi/group/global from server path)
      11/            ← Sudan FI files
      43/            ← DRC FI files (commented out)
      54/            ← Kenya FI files
    50/              ← Rwanda FI (own server)
      local/
      global/        ← Rwanda FI global
    56/              ← Uganda FI (own server)
      local/
      global/        ← Uganda FI global
  tanzania/
    55/              ← Tanzania files (no branch/fi split — single server handles both)
      local/
      global/        ← Tanzania global
```

*(CRM mirrors the same structure under `crm/customization/` instead of `fincore/custom/`)*

---

## Server Path Mapping

### SIT — All banks, all files → one server (EQSIT prefix)

| Repo Path                            | Server Path                                                                  |
|--------------------------------------|------------------------------------------------------------------------------|
| `fincore/custom/group/<bank_id>/<f>` | `/equity_fe/EQSIT/FrontEnd/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `fincore/custom/group/global/<f>`    | `/equity_fe/EQSIT/FrontEnd/FinacleApps/finbranch.war/custom/<f>`           |

### UAT

**Fincore:**

| Repo Path | Server Path |
|-----------|-------------|
| `custom/group/<bank_id>/<f>` (11, 54, 99) | `/equity_fe/EQUAT/FrontEnd/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `custom/group/global/<f>` | `/equity_fe/EQUAT/FrontEnd/FinacleApps/finbranch.war/custom/<f>` |
| `custom/<bank_id>/local/<f>` (43, 50, 56) | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<bank_id>/<f>` |
| `custom/<bank_id>/global/<f>` (43, 50, 56) | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<f>` |
| `custom/55/local/<f>` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/55/<f>` |
| `custom/55/global/<f>` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/<f>` |

**CRM:**

| Repo Path | Server Path |
|-----------|-------------|
| `customization/group/<bank_id>/<f>` (11, 54, 99) | `/equity_fe/EQUAT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<f>` |
| `customization/group/global/<f>` | `/equity_fe/EQUAT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |
| `customization/<bank_id>/local/<f>` (43, 50, 56) | `/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<bank_id>/<f>` |
| `customization/<bank_id>/global/<f>` (43, 50, 56) | `/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |
| `customization/55/local/<f>` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization/55/<f>` |
| `customization/55/global/<f>` | `/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization/<f>` |

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
| `50`, `56` | `branch` or `fi` | `branch` or `fi/<bank_id>/global/<f>` | `/u01/equity_fe/FinacleApps/finbranch.war/custom/<f>` |
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

> **Global strip rule:** `global/` AND its containing parent folder (`group/` or `<bank_id>/`) are stripped from the server path — repo-only keywords.
> **Rwanda (50) and Uganda (56) PROD:** Branch and FI servers use the **same path** — `--server-type` determines which physical machine to SSH into, not which path.
> **`bank_id`** in Group paths is literal (11, 43, or 54) — "group" is a routing concept, not a path keyword.

---

## Key Files

| File | Purpose |
|------|---------|
| `check-modified-files.sh` | CI script — detects git changes, writes manifest/audit/metadata.json |
| `deploy-j2ee.sh` | CD script — reads manifest, resolves paths, copies/deletes files with backup |
| `suScript.sh` | SSH entrypoint on server — switches to `applmgr`, extracts artifact, runs deploy script |
| `azure-pipelines-crm.yml` | Azure DevOps YAML CI pipeline for CRM |
| `azure-pipelines-fincore.yml` | Azure DevOps YAML CI pipeline for Fincore |
| `j2ee_roadmap.md` | Full implementation roadmap — read before making structural changes |

---

## Deployment Artifacts

| App | CI Artifact | Archive Name |
|-----|-------------|--------------|
| CRM | `crm_drop` | `j2ee-scripts.tar.gz` |
| Fincore | `fincore_drop` | `j2ee-scripts.tar.gz` |

Both pipelines use `j2ee-scripts.tar.gz` — `suScript.sh` extracts it without needing to know which app it came from.

Each artifact (`publishFincoreDir/` or `publishCRMDir/`) contains:
- `j2ee-scripts.tar.gz` — contains `newFiles/`, `modifiedFiles/`, `deletedFiles/`, `deployment-manifest.txt`, `deployment-audit.txt`, `metadata.json`
- `deploy-j2ee.sh` — deployment script
- `suScript.sh` — SSH entrypoint script

---

## Branch → Environment Mapping

| Git Branch | Environment | CI Deployment Tag       |
|------------|-------------|-------------------------|
| `sit`      | SIT         | `CRM-SIT` / `FINCORE-SIT` |
| `uat`      | UAT         | `CRM-UAT` / `FINCORE-UAT` |
| `prod`     | PROD        | `CRM-PROD` / `FINCORE-PROD` |

**Important:** Changes are NOT promoted between branches via git merge. Each branch is maintained independently. A change that goes to SIT is separately applied to UAT and PROD branches when ready.

---

## Build Tag System

### Environment Tags — set by `Determine Deployment Tag` step (branch-based)

```
CRM-SIT / CRM-UAT / CRM-PROD
FINCORE-SIT / FINCORE-UAT / FINCORE-PROD
```

These tags trigger the correct CD Release Pipeline.

### Routing Tags — set by `Determine Routing Tags` step (manifest-based)

**SIT:**
```
J2EE-group    → gates the single Group server stage
```

**UAT:**
```
J2EE-group    → gates the Group server stage  (banks 11, 54, 99)
J2EE-43       → gates the DRC server stage
J2EE-50       → gates the Rwanda server stage
J2EE-55       → gates the Tanzania server stage
J2EE-56       → gates the Uganda server stage
```

**PROD:**
```
J2EE-group-branch  → gates the Group Branch server stage (banks 11, 43, 54)
J2EE-group-fi      → gates the Group FI server stage     (banks 11, 43, 54)
J2EE-50-branch     → gates the Rwanda Branch server stage
J2EE-50-fi         → gates the Rwanda FI server stage
J2EE-56-branch     → gates the Uganda Branch server stage
J2EE-56-fi         → gates the Uganda FI server stage
J2EE-55            → gates the Tanzania server stage (no branch/fi split)
```

### How the two tag types work together in the CD pipeline

- `FINCORE-PROD` tag → **fires** the `J2EE-Fincore-Prod-CD` release pipeline
- Routing tags → **gate** which routing stages (and therefore which servers) run
- ✅ "Create a release when tags are added to an existing build" must be checked in the CD trigger — routing tags are added after build completion

---

## CI/CD Architecture

### CI Pipelines (YAML) — 6 total (2 per env)

Step order in all pipeline YAML files:
1. `Determine Deployment Tag` — emits environment tag based on branch
2. `Check Modified Files` — runs `check-modified-files.sh`, produces `metadata.json`
3. `Determine Routing Tags` — reads `metadata.json`, emits routing tags (e.g. `J2EE-group`, `J2EE-55`)
4. `Copy Files To Staging Directory`
5. `Archive FINCORE/CRM Files` — creates `j2ee-scripts.tar.gz`
6. `List Items Of The Archive`
7. `Create Publishing Directory` — assembles `publishFincoreDir/` or `publishCRMDir/`
8. `Publish Build Artifacts`

### CD Pipelines (Classic Release) — 6 pipelines, 13 routing stages total

| Pipeline | Artifact | Trigger Tag | Routing Stages |
|---|---|---|---|
| `J2EE-Fincore-SIT-CD` | `fincore_drop` | `FINCORE-SIT` | 1 (J2EE-group) |
| `J2EE-Fincore-UAT-CD` | `fincore_drop` | `FINCORE-UAT` | 5 (J2EE-group, J2EE-43, J2EE-50, J2EE-55, J2EE-56) |
| `J2EE-Fincore-Prod-CD` | `fincore_drop` | `FINCORE-PROD` | 7 (J2EE-group-branch, J2EE-group-fi, J2EE-50-branch, J2EE-50-fi, J2EE-56-branch, J2EE-56-fi, J2EE-55) |
| `J2EE-CRM-SIT-CD` | `crm_drop` | `CRM-SIT` | 1 |
| `J2EE-CRM-UAT-CD` | `crm_drop` | `CRM-UAT` | 5 |
| `J2EE-CRM-Prod-CD` | `crm_drop` | `CRM-PROD` | 7 |

Each routing stage has **no tasks** — it is a pure gate (pre-deployment condition checks for the routing tag). Downstream server stages (one per physical machine) carry the SCP + SSH tasks.

### Server-Side Execution Flow

```
suScript.sh <ip> <deploy_tag> <release_id>
  1. mv /tmp/j2ee-deploy-<release_id>/* $deploy_dir/
  2. rm -rf /tmp/j2ee-deploy-<release_id>
  3. tar -xzf $deploy_dir/j2ee-scripts.tar.gz -C $deploy_dir/
  4. chmod +x $deploy_dir/deploy-j2ee.sh
  5. cd $deploy_dir
  6. bash $deploy_dir/deploy-j2ee.sh --target <target> [--server-type branch|fi]
  7. [cleanup all staging files from deploy_dir]
  8. exit $deploy_exit_code
```

`deploy_tag` examples: `J2EE-group-branch`, `J2EE-50-branch`, `J2EE-55`
`<release_id>` = Azure `$(Release.ReleaseId)` — creates isolated staging dir per release run.

---

## Phase Status (New Implementation Plan)

| Phase | Description | Status |
|-------|-------------|--------|
| 1 | Repository & branch setup: create `sit`, `uat`, `prod` branches; restructure repo folders per env | 🔜 Pending |
| 2 | SIT scripts: simplified `check-modified-files-sit.sh` + `deploy-j2ee-sit.sh`; one server, J2EE-group tag | 🔜 Pending |
| 3 | UAT scripts: `--target group\|43\|50\|55\|56`; `group/global/` handling; 5-stage CD routing | 🔜 Pending |
| 4 | PROD scripts: `--target group\|50\|56\|55 --server-type branch\|fi`; branch/fi/tanzania path parsing; DRC commented-out logic | 🔜 Pending |
| 5 | Azure DevOps: 6 CI YAML pipelines; 6 CD Release Pipelines (13 routing stages total) | 🔜 Pending |
| 6 | Rollback Pipeline: `rollback-j2ee.sh` + dedicated rollback CD pipeline | 🔜 Future |
| 7 | End-to-end testing SIT → UAT → PROD | 🔜 Future |

---

## Coding Conventions

- **Shell style:** `#!/bin/bash`, functions named in `snake_case`, global constants in `UPPER_CASE`
- **Local variables:** all function-local variables must be declared with `local`
- **Counter names:** all counter variables end with `_COUNTER` (e.g. `FAILED_DEPLOYMENTS_COUNTER`)
- **Logging:** use the `log()` function — prints `[INFO] message`
- **Error handling:** use `error_exit()` for fatal errors; `|| true` for non-fatal operations
- **Conditions:** prefer `[ -n "$var" ]` over `[ ! -z "$var" ]`
- **No hardcoded bank names:** never compare to "tanzania", "uganda", "kenya" etc. — always use bank IDs
- **No hardcoded IPs:** IPs are always passed as arguments from the CD pipeline
- **Manifest format:** `ACTION|FILE_PATH` — pipe-delimited, one entry per line
- **Backup:** always backup before MODIFIED or DELETED operations; timestamped, in `backup/` subfolder
- **Permissions:** after deployment, `chmod -R 755` and `chown -R applmgr` on `/equity_fe` and `/finacle`
- **RESOLVED_PATH pattern:** `resolve_server_path()` writes result to the global `RESOLVED_PATH` variable instead of echoing — avoids `$()` capturing `log()` output
- **YAML metadata parsing:** pure bash only (`grep`, `sed`, `tr`) — no Python, no jq

---

## Things Claude Should Always Do

- Always reference files using the **absolute project path** above
- Always read `j2ee_roadmap.md` before suggesting structural or architectural changes
- Always treat `group/global/` as a repo-only keyword — strip it (and the level above) from server paths
- When modifying `deploy-j2ee.sh`, preserve `resolve_server_path()` — it contains authoritative server path logic
- When modifying `check-modified-files.sh`, preserve `detect_deployment_targets()` and `is_j2ee_file()` helpers
- Routing tag step in YAML must always come **after** `Check Modified Files` (needs `metadata.json`)
- Remember DRC (43) is Group in PROD — its PROD-specific dedicated server logic should be written but commented out

## Things Claude Should Never Do

- Never deploy global files without stripping the `global/` keyword (and its parent folder) from the server path
- Never remove or bypass the backup step in `deploy-j2ee.sh`
- Never hardcode bank names (e.g. "tanzania", "uganda") in routing logic — use bank IDs
- Never hardcode server IPs into scripts — always passed as arguments
- Never skip `AZURE_DEVOPS_EXT_PAT` / `System.AccessToken` setup when adding Azure DevOps API calls
- Never use Python or jq to parse `metadata.json` in YAML steps — use pure bash (`grep`, `sed`, `tr`)
- Never run `deploy-j2ee.sh` without first extracting `j2ee-scripts.tar.gz` (handled by `suScript.sh`)
- Never merge changes between `sit`, `uat`, and `prod` branches — they are maintained independently
- Never put Finserve (99) files in the PROD repository — Finserve is SIT and UAT only
- Never increment deployment counters before the operation succeeds — increment only inside the success branch
