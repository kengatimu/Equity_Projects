#!/bin/bash

# ==================================================================================================
# SCRIPT : check-modified-files-prod.sh
# PURPOSE: Detect J2EE file changes (NEW, MODIFIED, DELETED) in the PROD branch and produce
#          deployment artifacts: file trees, manifest, audit log, and per-server routing flags.
#
# USAGE  : check-modified-files-prod.sh --app <fincore|crm>
#
# OUTPUT : newFiles/ | modifiedFiles/ | deletedFiles/ | deployment-manifest.txt
#          deployment-audit.txt | metadata.json (7 deploy flags for group-branch/fi, 50/56 branch/fi, 55)
#
# AUTHOR : Kennedy Gatimu
# ==================================================================================================

echo
echo "------------------------------- J2EE PROD CHANGE DETECTION PROGRAM STARTING -------------------------------"
echo "START TIME: $(date)"
echo

AZURE_WORKING_DIR=$(pwd)
echo "AZURE WORKING DIRECTORY: $AZURE_WORKING_DIR"
echo

# ---------------------------------------------------------------------------------------------------------------------
# ARTIFACT DIRECTORIES — staging directories for changed files. Recreated fresh each CI run.
# ---------------------------------------------------------------------------------------------------------------------
NEW_FILES_DIR="$AZURE_WORKING_DIR/newFiles"
MODIFIED_FILES_DIR="$AZURE_WORKING_DIR/modifiedFiles"
DELETED_FILES_DIR="$AZURE_WORKING_DIR/deletedFiles"

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUT FILES — generated here, consumed by downstream pipeline stages.
# ---------------------------------------------------------------------------------------------------------------------
NEW_FILES_LIST=newFilesPath.txt
MODIFIED_FILES_LIST=modifiedFilesPath.txt
DELETED_FILES_LIST=deletedFilesPath.txt
MANIFEST_FILE=deployment-manifest.txt
AUDIT_FILE=deployment-audit.txt
METADATA_FILE=metadata.json
TEMP_DETAILS_FILE=fileDetails.tmp

# ---------------------------------------------------------------------------------------------------------------------
# CONTROL FLAGS
# APP_FILTER            : set from --app; controls which paths is_j2ee_file() accepts (fincore or crm)
# DEPLOY_GROUP_BRANCH   : true when any branch/group/** file changes — Group Branch server (EQPROD)
# DEPLOY_GROUP_FI       : true when any fi/group/** file changes    — Group FI server (EQPRODFI)
# DEPLOY_50_BRANCH      : true when any branch/50/** file changes   — Rwanda Branch server
# DEPLOY_50_FI          : true when any fi/50/** file changes       — Rwanda FI server
# DEPLOY_56_BRANCH      : true when any branch/56/** file changes   — Uganda Branch server
# DEPLOY_56_FI          : true when any fi/56/** file changes       — Uganda FI server
# DEPLOY_55             : true when any tanzania/55/** file changes  — Tanzania server (single)
# Each flag maps to a routing tag that gates its own PROD CD release stage.
# ---------------------------------------------------------------------------------------------------------------------
APP_FILTER=""
DEPLOY_GROUP_BRANCH=false
DEPLOY_GROUP_FI=false
DEPLOY_50_BRANCH=false
DEPLOY_50_FI=false
DEPLOY_56_BRANCH=false
DEPLOY_56_FI=false
DEPLOY_55=false

# ---------------------------------------------------------------------------------------------------------------------
# LOGGING UTILITIES — log() : [INFO] prefix | error_exit() : [ERROR] prefix then exits
# ---------------------------------------------------------------------------------------------------------------------
log() {
    echo "[INFO] $1"
}

error_exit() {
    echo "[ERROR] $1"
    echo "[ERROR] Script stopped at: $(date)"
    exit 1
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: create_directory
# Ensures a clean directory exists at the given path. Deletes and recreates if already present.
# Args: $1 dir_path
# ---------------------------------------------------------------------------------------------------------------------
create_directory() {
    local dir_path=$1

    echo "------------------------------------------------------------"
    log "Creating directory: $dir_path"

    if [ -d "$dir_path" ]; then
        log "Directory already exists — recreating to ensure a clean state..."
        rm -rvf "$dir_path" || true
        mkdir -vp "$dir_path"
        log "Directory recreated: $dir_path"
    else
        mkdir -vp "$dir_path"
        log "Directory created: $dir_path"
    fi
    echo
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: create_file
# Ensures a clean empty file exists at the given path. Deletes and recreates if already present.
# Args: $1 file_path
# ---------------------------------------------------------------------------------------------------------------------
create_file() {
    local file_path=$1

    echo "------------------------------------------------------------"
    log "Creating file: $file_path"

    if [ -f "$file_path" ]; then
        log "File already exists — recreating to ensure a clean state..."
        rm -vf "$file_path" || true
        touch "$file_path"
        log "File recreated: $file_path"
    else
        touch "$file_path"
        log "File created: $file_path"
    fi
    echo
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: is_j2ee_file
# Returns 0 if the file is within this pipeline's PROD J2EE scope (controlled by --app), 1 otherwise.
# Covers all three PROD top-level segments: branch/, fi/, and tanzania/.
# Args: $1 file_path — path from git diff
# ---------------------------------------------------------------------------------------------------------------------
is_j2ee_file() {
    local file_path=$1

    [ -z "$file_path" ] && return 1

    case "$APP_FILTER" in

        fincore)
            # Accept all PROD fincore paths: branch, fi, and tanzania segments
            if [[ "$file_path" == fincore/branch/* ]]   ||
               [[ "$file_path" == fincore/fi/* ]]       ||
               [[ "$file_path" == fincore/tanzania/* ]]; then
                return 0
            fi
            ;;

        crm)
            # Accept all PROD CRM paths: branch, fi, and tanzania segments
            if [[ "$file_path" == crm/customization/branch/* ]]   ||
               [[ "$file_path" == crm/customization/fi/* ]]       ||
               [[ "$file_path" == crm/customization/tanzania/* ]]; then
                return 0
            fi
            ;;

    esac

    log "  Skipping: $file_path — outside $APP_FILTER PROD scope"
    return 1
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: get_finacle_app
# Echoes the Finacle app (fincore | crm | unknown) for a file based on its path prefix.
# Args: $1 file_path
# ---------------------------------------------------------------------------------------------------------------------
get_finacle_app() {
    local file_path=$1

    if [[ "$file_path" == fincore/* ]]; then
        echo "fincore"
    elif [[ "$file_path" == crm/* ]]; then
        echo "crm"
    else
        echo "unknown"
    fi
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: check_new_files
# Copies newly added files into newFiles/ and records each in the manifest, audit log, and temp details.
# Args: $1 newline-separated list of new file paths from git diff
# ---------------------------------------------------------------------------------------------------------------------
check_new_files() {
    local files_array
    local file_path
    local finacle_app

    echo "============================================================"
    echo "                 COPYING NEW FILES"
    echo "============================================================"

    log "New file(s) detected. Preparing staging directory: $NEW_FILES_DIR"

    [ ! -d "$NEW_FILES_DIR" ]   && create_directory "$NEW_FILES_DIR"
    [ ! -f "$NEW_FILES_LIST" ]  && create_file "$NEW_FILES_LIST"

    readarray -t files_array <<< "$1"

    for file_path in "${files_array[@]}"; do
        if is_j2ee_file "$file_path"; then
            if [ -f "$file_path" ]; then
                log "Copying NEW file : $file_path : $NEW_FILES_DIR"
                cp --parents "$file_path" "$NEW_FILES_DIR"

                echo "$file_path"                                       >> "$NEW_FILES_LIST"
                echo "NEW|$file_path"                                   >> "$MANIFEST_FILE"
                echo "NEW|$file_path|AUTHOR=$AUTHOR|COMMIT=$COMMIT_ID" >> "$AUDIT_FILE"

                finacle_app=$(get_finacle_app "$file_path")
                echo "$file_path|$finacle_app|NEW"                     >> "$TEMP_DETAILS_FILE"
            else
                log "WARNING: File listed in git diff but not found on disk — skipping: $file_path"
            fi
        fi
    done

    cp "$NEW_FILES_LIST" "$NEW_FILES_DIR"
    echo
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: check_modified_files
# Copies modified files into modifiedFiles/ and records each in the manifest, audit log, and temp details.
# Args: $1 newline-separated list of modified file paths from git diff
# ---------------------------------------------------------------------------------------------------------------------
check_modified_files() {
    local files_array
    local file_path
    local finacle_app

    echo "============================================================"
    echo "                 COPYING MODIFIED FILES"
    echo "============================================================"

    log "Modified file(s) detected. Preparing staging directory: $MODIFIED_FILES_DIR"

    [ ! -d "$MODIFIED_FILES_DIR" ]   && create_directory "$MODIFIED_FILES_DIR"
    [ ! -f "$MODIFIED_FILES_LIST" ]  && create_file "$MODIFIED_FILES_LIST"

    readarray -t files_array <<< "$1"

    for file_path in "${files_array[@]}"; do
        if is_j2ee_file "$file_path"; then
            if [ -f "$file_path" ]; then
                log "Copying MODIFIED file : $file_path : $MODIFIED_FILES_DIR"
                cp --parents "$file_path" "$MODIFIED_FILES_DIR"

                echo "$file_path"                                            >> "$MODIFIED_FILES_LIST"
                echo "MODIFIED|$file_path"                                   >> "$MANIFEST_FILE"
                echo "MODIFIED|$file_path|AUTHOR=$AUTHOR|COMMIT=$COMMIT_ID" >> "$AUDIT_FILE"

                finacle_app=$(get_finacle_app "$file_path")
                echo "$file_path|$finacle_app|MODIFIED"                     >> "$TEMP_DETAILS_FILE"
            else
                log "WARNING: File listed in git diff but not found on disk — skipping: $file_path"
            fi
        fi
    done

    cp "$MODIFIED_FILES_LIST" "$MODIFIED_FILES_DIR"
    echo
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: check_deleted_files
# Records deleted file paths in the manifest and audit log. No copy needed — file is gone from disk.
# Args: $1 newline-separated list of deleted file paths from git diff
# ---------------------------------------------------------------------------------------------------------------------
check_deleted_files() {
    local files_array
    local file_path
    local finacle_app

    echo "============================================================"
    echo "                 TRACKING DELETED FILES"
    echo "============================================================"

    log "Deleted file(s) detected. Preparing tracking directory: $DELETED_FILES_DIR"

    [ ! -d "$DELETED_FILES_DIR" ]   && create_directory "$DELETED_FILES_DIR"
    [ ! -f "$DELETED_FILES_LIST" ]  && create_file "$DELETED_FILES_LIST"

    readarray -t files_array <<< "$1"

    for file_path in "${files_array[@]}"; do
        if is_j2ee_file "$file_path"; then
            log "Tracking deleted file: $file_path"

            echo "$file_path"                                            >> "$DELETED_FILES_LIST"
            echo "DELETED|$file_path"                                    >> "$MANIFEST_FILE"
            echo "DELETED|$file_path|AUTHOR=$AUTHOR|COMMIT=$COMMIT_ID"  >> "$AUDIT_FILE"

            finacle_app=$(get_finacle_app "$file_path")
            echo "$file_path|$finacle_app|DELETED"                      >> "$TEMP_DETAILS_FILE"
        fi
    done

    cp "$DELETED_FILES_LIST" "$DELETED_FILES_DIR"
    echo
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: detect_deployment_targets
# Scans the manifest and sets a deploy flag for each PROD server target that has files.
# Routing key is built from server_type + routing_target extracted from each file path.
# Fincore: f2=server_type, f3=routing_target
# CRM    : f3=server_type, f4=routing_target  (extra 'customization/' segment shifts fields by 1)
# Must be called AFTER all file change functions so the manifest is fully populated.
# ---------------------------------------------------------------------------------------------------------------------
detect_deployment_targets() {
    echo "============================================================"
    echo "         DETECTING DEPLOYMENT TARGET SERVER GROUPS"
    echo "============================================================"

    if [ ! -f "$MANIFEST_FILE" ]; then
        log "No manifest file found — skipping target detection."
        return
    fi

    if [ ! -s "$MANIFEST_FILE" ]; then
        log "Manifest file is empty — no $APP_FILTER PROD J2EE files detected in this commit."
        return
    fi

    log "Scanning manifest to determine which PROD server targets are affected..."

    while IFS='|' read -r change_type file_path; do
        local finacle_app server_type routing_target routing_key

        finacle_app=$(echo "$file_path" | cut -d '/' -f1)

        if [ "$finacle_app" == "fincore" ]; then
            server_type=$(echo "$file_path" | cut -d '/' -f2)    # branch | fi | tanzania
            routing_target=$(echo "$file_path" | cut -d '/' -f3) # group  | 50 | 56 | 55
        else
            # crm/customization/<server_type>/<routing_target>/...
            server_type=$(echo "$file_path" | cut -d '/' -f3)
            routing_target=$(echo "$file_path" | cut -d '/' -f4)
        fi

        routing_key="${server_type}_${routing_target}"

        case "$routing_key" in
            branch_group)
                if [ "$DEPLOY_GROUP_BRANCH" != "true" ]; then
                    DEPLOY_GROUP_BRANCH=true
                    log "  Group Branch target confirmed (EQPROD — banks 11, 43, 54) — triggered by: $file_path"
                fi
                ;;
            fi_group)
                if [ "$DEPLOY_GROUP_FI" != "true" ]; then
                    DEPLOY_GROUP_FI=true
                    log "  Group FI target confirmed (EQPRODFI — banks 11, 43, 54) — triggered by: $file_path"
                fi
                ;;
            branch_50)
                if [ "$DEPLOY_50_BRANCH" != "true" ]; then
                    DEPLOY_50_BRANCH=true
                    log "  Rwanda Branch target confirmed (bank 50) — triggered by: $file_path"
                fi
                ;;
            fi_50)
                if [ "$DEPLOY_50_FI" != "true" ]; then
                    DEPLOY_50_FI=true
                    log "  Rwanda FI target confirmed (bank 50) — triggered by: $file_path"
                fi
                ;;
            branch_56)
                if [ "$DEPLOY_56_BRANCH" != "true" ]; then
                    DEPLOY_56_BRANCH=true
                    log "  Uganda Branch target confirmed (bank 56) — triggered by: $file_path"
                fi
                ;;
            fi_56)
                if [ "$DEPLOY_56_FI" != "true" ]; then
                    DEPLOY_56_FI=true
                    log "  Uganda FI target confirmed (bank 56) — triggered by: $file_path"
                fi
                ;;
            tanzania_55)
                if [ "$DEPLOY_55" != "true" ]; then
                    DEPLOY_55=true
                    log "  Tanzania target confirmed (EQTZPROD — bank 55) — triggered by: $file_path"
                fi
                ;;
        esac
    done < "$MANIFEST_FILE"

    echo
    echo "------------------------------------------------------------"
    echo "DEPLOYMENT TARGET DETECTION RESULT"
    echo "------------------------------------------------------------"
    echo "  DEPLOY_GROUP_BRANCH  (EQPROD   — banks 11, 43, 54) : $DEPLOY_GROUP_BRANCH"
    echo "  DEPLOY_GROUP_FI      (EQPRODFI — banks 11, 43, 54) : $DEPLOY_GROUP_FI"
    echo "  DEPLOY_50_BRANCH     (Rwanda Branch)               : $DEPLOY_50_BRANCH"
    echo "  DEPLOY_50_FI         (Rwanda FI)                   : $DEPLOY_50_FI"
    echo "  DEPLOY_56_BRANCH     (Uganda Branch)               : $DEPLOY_56_BRANCH"
    echo "  DEPLOY_56_FI         (Uganda FI)                   : $DEPLOY_56_FI"
    echo "  DEPLOY_55            (Tanzania — EQTZPROD)         : $DEPLOY_55"
    echo "------------------------------------------------------------"
    echo

    echo "DEPLOY_GROUP_BRANCH=$DEPLOY_GROUP_BRANCH" >> "$AUDIT_FILE"
    echo "DEPLOY_GROUP_FI=$DEPLOY_GROUP_FI"         >> "$AUDIT_FILE"
    echo "DEPLOY_50_BRANCH=$DEPLOY_50_BRANCH"       >> "$AUDIT_FILE"
    echo "DEPLOY_50_FI=$DEPLOY_50_FI"               >> "$AUDIT_FILE"
    echo "DEPLOY_56_BRANCH=$DEPLOY_56_BRANCH"       >> "$AUDIT_FILE"
    echo "DEPLOY_56_FI=$DEPLOY_56_FI"               >> "$AUDIT_FILE"
    echo "DEPLOY_55=$DEPLOY_55"                     >> "$AUDIT_FILE"
}

# =====================================================================================================================
# SCRIPT BODY — all functions are defined above; execution starts here
# =====================================================================================================================

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0: PARSE AND VALIDATE ARGUMENTS
# ---------------------------------------------------------------------------------------------------------------------
log "Parsing script arguments..."

while [ "$#" -gt 0 ]; do
    case "$1" in
        --app)
            APP_FILTER="$2"
            log "  --app : '$APP_FILTER'"
            shift 2 ;;
        *)
            error_exit "Unknown argument: '$1'. Usage: check-modified-files-prod.sh --app <fincore|crm>" ;;
    esac
done

if [ "$APP_FILTER" != "fincore" ] && [ "$APP_FILTER" != "crm" ]; then
    error_exit "Missing or invalid --app argument: '$APP_FILTER'. Expected: fincore | crm"
fi

log "  --app '$APP_FILTER' : valid — only '$APP_FILTER' files will be processed"
echo "APP FILTER   : $APP_FILTER"
echo

# ---------------------------------------------------------------------------------------------------------------------
# STEP 1: INITIALISE OUTPUT FILES — created fresh each run; temp file cleared of any leftover data.
# ---------------------------------------------------------------------------------------------------------------------
create_file "$MANIFEST_FILE"
create_file "$AUDIT_FILE"
rm -f "$TEMP_DETAILS_FILE"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 2: GATHER COMMIT INFORMATION
# git log -2 | tail -1 targets the developer's commit, not the PR merge commit.
# ---------------------------------------------------------------------------------------------------------------------
COMMIT_ID=$(git log -2 --format=format:%h | tail -1)
BRANCH=${BUILD_SOURCEBRANCHNAME:-$(git rev-parse --abbrev-ref HEAD)}

if [[ "$BRANCH" == "main" ]]; then ENV="PROD"
else                               ENV="PROD (branch: $BRANCH)"
fi

AUTHOR=$(git show --pretty=format:"%an" "$COMMIT_ID" | head -1)
EMAIL=$(git show --pretty=format:"%ae" "$COMMIT_ID" | head -1)
COMMIT_MSG=$(git show --pretty=format:"%s"  "$COMMIT_ID" | head -1)
COMMIT_DATE=$(git show --pretty=format:"%cd" "$COMMIT_ID" | head -1)

echo "ENVIRONMENT  : $ENV"
echo "BRANCH       : $BRANCH"
echo "COMMIT       : $COMMIT_ID"
echo "AUTHOR       : $AUTHOR"
echo "AUTHOR EMAIL : $EMAIL"
echo "COMMIT MSG   : $COMMIT_MSG"
echo "COMMIT DATE  : $COMMIT_DATE"
echo

echo "ENV=$ENV"              >> "$AUDIT_FILE"
echo "COMMIT_ID=$COMMIT_ID"  >> "$AUDIT_FILE"
echo "AUTHOR=$AUTHOR"        >> "$AUDIT_FILE"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 3: DETECT FILE CHANGES
# diff-filter: A=Added, C=Copied (→ NEW), M=Modified, D=Deleted, T=Type-changed (→ MODIFIED)
# ---------------------------------------------------------------------------------------------------------------------
NEW_FILES=$(git show --diff-filter=A --name-only --format="" "$COMMIT_ID")
COPY_FILES=$(git show --diff-filter=C --name-only --format="" "$COMMIT_ID")
MODIFIED_FILES=$(git show --diff-filter=M --name-only --format="" "$COMMIT_ID")
DELETED_FILES=$(git show --diff-filter=D --name-only --format="" "$COMMIT_ID")
TYPE_FILES=$(git show --diff-filter=T --name-only --format="" "$COMMIT_ID")

[ -n "$NEW_FILES" ]      && check_new_files      "$NEW_FILES"
[ -n "$COPY_FILES" ]     && check_new_files      "$COPY_FILES"
[ -n "$MODIFIED_FILES" ] && check_modified_files "$MODIFIED_FILES"
[ -n "$DELETED_FILES" ]  && check_deleted_files  "$DELETED_FILES"
[ -n "$TYPE_FILES" ]     && check_modified_files "$TYPE_FILES"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 4: DETECT DEPLOYMENT TARGETS — runs after STEP 3 so the manifest is fully populated.
# ---------------------------------------------------------------------------------------------------------------------
detect_deployment_targets

# ---------------------------------------------------------------------------------------------------------------------
# STEP 5: CREATE METADATA FILE — JSON consumed by Azure pipeline routing to decide which CD stages to trigger.
# ---------------------------------------------------------------------------------------------------------------------
echo "============================================================"
echo "                 CREATING METADATA FILE"
echo "============================================================"

if [ -f "$NEW_FILES_LIST" ];      then NEW_COUNT=$(wc -l < "$NEW_FILES_LIST");           else NEW_COUNT=0;      fi
if [ -f "$MODIFIED_FILES_LIST" ]; then MODIFIED_COUNT=$(wc -l < "$MODIFIED_FILES_LIST"); else MODIFIED_COUNT=0; fi
if [ -f "$DELETED_FILES_LIST" ];  then DELETED_COUNT=$(wc -l < "$DELETED_FILES_LIST");   else DELETED_COUNT=0;  fi

log "New files      : $NEW_COUNT"
log "Modified files : $MODIFIED_COUNT"
log "Deleted files  : $DELETED_COUNT"
echo

{
echo "{"
echo "  \"application\": \"J2EE\","
echo "  \"buildTime\": \"$(date)\","
echo "  \"environment\": \"PROD\","
echo "  \"branch\": \"$BRANCH\","
echo "  \"commitId\": \"$COMMIT_ID\","
echo "  \"author\": \"$AUTHOR\","
echo "  \"email\": \"$EMAIL\","
echo "  \"message\": \"$COMMIT_MSG\","
echo "  \"commitDate\": \"$COMMIT_DATE\","
echo "  \"newFilesCount\": $NEW_COUNT,"
echo "  \"modifiedFilesCount\": $MODIFIED_COUNT,"
echo "  \"deletedFilesCount\": $DELETED_COUNT,"
echo "  \"deploy_group_branch\": $DEPLOY_GROUP_BRANCH,"
echo "  \"deploy_group_fi\": $DEPLOY_GROUP_FI,"
echo "  \"deploy_50_branch\": $DEPLOY_50_BRANCH,"
echo "  \"deploy_50_fi\": $DEPLOY_50_FI,"
echo "  \"deploy_56_branch\": $DEPLOY_56_BRANCH,"
echo "  \"deploy_56_fi\": $DEPLOY_56_FI,"
echo "  \"deploy_55\": $DEPLOY_55,"
echo "  \"files\": ["

if [ -f "$TEMP_DETAILS_FILE" ]; then
    awk -F'|' '{
        printf "    {\"path\":\"%s\",\"app\":\"%s\",\"type\":\"%s\"}", $1,$2,$3
        if (NR != total) printf ","
        printf "\n"
    }' total=$(wc -l < "$TEMP_DETAILS_FILE") "$TEMP_DETAILS_FILE"
fi

echo "  ]"
echo "}"
} > "$METADATA_FILE"

log "Metadata file created: $METADATA_FILE"
cat "$METADATA_FILE"
echo

# ---------------------------------------------------------------------------------------------------------------------
# EXECUTION SUMMARY
# ---------------------------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "                     EXECUTION SUMMARY"
echo "============================================================"
echo "ENVIRONMENT : PROD"
echo "BRANCH      : $BRANCH"
echo "COMMIT ID   : $COMMIT_ID"
echo "AUTHOR      : $AUTHOR"
echo "DATE        : $COMMIT_DATE"
echo
echo "-------------------- FILE CHANGE COUNTS --------------------"
echo "NEW FILES      : $NEW_COUNT"
echo "MODIFIED FILES : $MODIFIED_COUNT"
echo "DELETED FILES  : $DELETED_COUNT"
echo
echo "-------------------- DEPLOYMENT TARGETS --------------------"
echo "DEPLOY GROUP BRANCH  (EQPROD   — banks 11, 43, 54) : $DEPLOY_GROUP_BRANCH"
echo "DEPLOY GROUP FI      (EQPRODFI — banks 11, 43, 54) : $DEPLOY_GROUP_FI"
echo "DEPLOY 50 BRANCH     (Rwanda Branch)               : $DEPLOY_50_BRANCH"
echo "DEPLOY 50 FI         (Rwanda FI)                   : $DEPLOY_50_FI"
echo "DEPLOY 56 BRANCH     (Uganda Branch)               : $DEPLOY_56_BRANCH"
echo "DEPLOY 56 FI         (Uganda FI)                   : $DEPLOY_56_FI"
echo "DEPLOY 55            (Tanzania — EQTZPROD)         : $DEPLOY_55"
echo "(PROD topology : Group Branch/FI + Rwanda Branch/FI + Uganda Branch/FI + Tanzania single)"
echo
echo "-------------------- FILE CHANGE DETAILS -------------------"
if [ -s "$MANIFEST_FILE" ]; then
    while IFS= read -r line; do
        FILE_CHANGE_TYPE=$(echo "$line" | cut -d'|' -f1)
        FILE_PATH=$(echo "$line" | cut -d'|' -f2)
        printf "[%-9s] %s\n" "$FILE_CHANGE_TYPE" "$FILE_PATH"
    done < "$MANIFEST_FILE"
else
    echo "No changes detected."
fi

echo
echo "============================================================"
echo "END TIME: $(date)"
echo "============================================================"
echo
