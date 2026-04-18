🧭 MASTER ROADMAP — J2EE CI/CD FOR FINACLE
🔷 PHASE 0 — OBJECTIVE (Anchor This)

You are replacing:

❌ Manual SSH + WinSCP edits
❌ No audit
❌ No rollback
❌ High risk

With:

✅ Git-driven deployments
✅ Automated CI/CD
✅ Full audit trail
✅ Deterministic deployments
✅ Rollback by deployment ID

🔷 PHASE 1 — REPOSITORY DESIGN (FOUNDATION)
Final Structure (Correct — Locked)
j2ee-scripts-repo/
│
├── fincore/
│   └── custom/
│       ├── 54/
│       ├── 55/        (TZ)
│       ├── 56/
│       └── global/
│
├── crm/
│   └── customization/
│       ├── 54/
│       ├── 55/        (TZ)
│       ├── 56/
│       └── global/
Rules (ENFORCE STRICTLY)
No files outside custom/ or customization/
Subsidiary must be first-level directory
global/ = shared across subs
Full structure must mirror server structure
No direct server edits allowed
Outcome

✔ Repo becomes single source of truth
✔ Enables deterministic deployments

🔷 PHASE 2 — PIPELINE STRATEGY
Use 2 pipelines (recommended)
Pipeline	Scope
fincore-pipeline.yml	fincore/custom
crm-pipeline.yml	crm/customization
Trigger Strategy
Fincore
paths:
  include:
    - fincore/*
CRM
paths:
  include:
    - crm/*
Outcome

✔ Clean separation
✔ Easier debugging
✔ No mixed deployments

🔷 PHASE 3 — CHANGE DETECTION ENGINE

Reuse your script:
👉 check-modified-files.sh

Required Modifications
❌ REMOVE:
FI / CBC / USER / UNISER logic
✅ KEEP:
newFiles/
modifiedFiles/
deletedFiles/
✅ ADD (CRITICAL):
1. Preserve FULL PATH

Example output:

fincore/custom/54/jsp/a.jsp
crm/customization/56/js/app.js
2. Generate Deployment Manifest
deployment-manifest.txt

Example:

MODIFIED|fincore/custom/54/jsp/a.jsp
NEW|crm/customization/56/js/app.js
DELETED|fincore/custom/54/jsp/old.jsp
Outcome

✔ Accurate diff tracking
✔ Enables rollback later

🔷 PHASE 4 — ARTIFACT DESIGN
Structure
artifact/
├── newFiles/
├── modifiedFiles/
├── deletedFiles/
├── deployment-manifest.txt   ✅ CRITICAL
├── metadata.json
metadata.json Example
{
  "app": "fincore",
  "buildId": "12345",
  "timestamp": "2026-04-08T17:00:00"
}
Outcome

✔ Self-contained deployment package
✔ Traceable deployment

🔷 PHASE 5 — ENVIRONMENT MAPPING LAYER
Create:
env-config.sh
Logic
TZ (55)
Different server
Different base path
Others
Shared server
Shared base path
Example
get_server_and_base() {
  APP=$1
  SUB=$2

  if [ "$SUB" == "55" ]; then
    SERVER="TZ_IP"
    if [ "$APP" == "fincore" ]; then
      BASE="/finacle/.../custom/55"
    else
      BASE="/finacle/.../Customization/55"
    fi
  else
    SERVER="DEFAULT_IP"
    if [ "$APP" == "fincore" ]; then
      BASE="/equity_fe/.../custom"
    else
      BASE="/equity_fe/.../Customization"
    fi
  fi

  echo "$SERVER|$BASE"
}
Outcome

✔ No hardcoding
✔ Future-proof (more subs = easy)

🔷 PHASE 6 — DEPLOYMENT ENGINE (CORE SYSTEM)
Build:
deploy-j2ee.sh
Execution Flow
STEP 1 — Read manifest
while IFS='|' read ACTION FILE_PATH
STEP 2 — Parse path

Example:

fincore/custom/54/jsp/a.jsp

Extract:

APP=fincore
SUB=54
REL_PATH=jsp/a.jsp
STEP 3 — Resolve target

Call:

get_server_and_base "$APP" "$SUB"
STEP 4 — GLOBAL HANDLING

If:

custom/global/...

👉 Deploy to ALL subs:

SUB_LIST=(54 56 43 11 ...)

for SUB in "${SUB_LIST[@]}"
STEP 5 — BACKUP (MANDATORY)
BACKUP_ID=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=/backup/j2ee/$BACKUP_ID/$SUB

cp TARGET → BACKUP_DIR
STEP 6 — APPLY CHANGES
Action	Operation
NEW	cp
MODIFIED	backup + cp
DELETED	mv to backup
STEP 7 — PERMISSIONS
chmod -R 755
chown -R applmgr
Outcome

✔ Generic deployment engine
✔ Works for all apps + subs
✔ No duplication

🔷 PHASE 7 — ROLLBACK SYSTEM (CRITICAL)
Build:
rollback-j2ee.sh
Rollback Model

👉 Per deployment ID (recommended)

Backup Structure
/backup/j2ee/
   ├── 20260408_170000/
   │    ├── 54/
   │    ├── 56/
   │    └── ...
Rollback Flow
ROLLBACK_ID=20260408_170000

cp backup → original location
Deleted Files Recovery

Since delete = move:

mv backup/deleted/file → original path
Outcome

✔ Full rollback
✔ Safe recovery
✔ No data loss

🔷 PHASE 8 — suScript INTEGRATION

Reuse:
👉

Modify ONLY:

Replace:

FI | CBC | USER | UNISER

With:

fincore | crm
Keep:

✔ sudo su - applmgr
✔ execution delegation

🔷 PHASE 9 — RELEASE PIPELINE (CD)
Flow
Download artifact
Copy to server
Execute:
suScript.sh fincore 54
Add

✔ Approval gates (already done)
✔ Logging

🔷 PHASE 10 — SAFETY CONTROLS
1. Deployment Lock
flock /tmp/j2ee.lock -c "deploy"
2. Logging
/deployment_logs/j2ee.log
3. Validation
File exists before deploy
Fail fast on errors
4. No mv (IMPORTANT)

Use:

cp instead of mv
🚀 FINAL END-TO-END FLOW
Developer Push
   ↓
Azure Repo
   ↓
Pipeline Trigger (fincore / crm)
   ↓
check-modified-files.sh
   ↓
Generate manifest
   ↓
Package artifact
   ↓
Tag build
   ↓
Release pipeline
   ↓
Copy to server
   ↓
suScript (applmgr)
   ↓
deploy-j2ee.sh
   ↓
Backup snapshot created
   ↓
Apply changes
   ↓
Deployment ID logged
🧠 WHAT YOU HAVE BUILT (REALITY)

This is now:

A distributed file deployment system with version control, environment routing, and rollback

Not just CI/CD.