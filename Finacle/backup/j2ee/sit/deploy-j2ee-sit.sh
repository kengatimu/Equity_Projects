#!/bin/bash

# ==================================================================================================
# SCRIPT: deploy-j2ee-sit.sh
#
# PURPOSE:
#   Deploy J2EE customization files (fincore / crm) to the correct Finacle servers.
#   Reads a manifest file that lists every file to deploy, then copies, backs up,
#   or deletes each file on the target server accordingly.
#
# FEATURES:
#   - Target filtering  (--target group — one group server for all SIT banks)
#   - Manifest-driven   (reads deployment-manifest.txt line by line)
#   - Path resolution   (builds the correct server path per Finacle app and bank)
#   - Backup on change  (backs up any file before it is modified or deleted)
#   - Global file support (strips /global/ folder from server path)
#   - Detailed logging and execution summary
#
# USAGE:
#   deploy-j2ee-sit.sh --target group [--env sit]
#
#   --target group   : the only valid value; all SIT banks share one Group server
#                      Banks on this server: 11 (Sudan) | 43 (DRC) | 50 (Rwanda) | 54 (Kenya) |
#                                            55 (Tanzania) | 56 (Uganda) | 99 (Finserve)
#   --env sit        : accepted for suScript.sh interface compatibility; has no effect on path
#                      resolution — SIT base paths are hardcoded constants
#
# SIT TOPOLOGY:
#   All banks share one Group server (EQSIT). No per-bank routing takes place.
#   Every manifest entry is deployed to the same server.
#   Repo path structure has an extra group/ segment not present in UAT/PROD:
#     fincore/custom/group/<bank_id>/<relative_path>
#     crm/customization/group/<bank_id>/<relative_path>
#   Bank ID is therefore at segment 4 (not segment 3 as in UAT/PROD).
#
# NOTE:
#   The CI pipeline copies this file as deploy-j2ee.sh into the publish directory so
#   suScript.sh can call it by its standard name without modification.
#
# AUTHOR: Kennedy Gatimu
# ==================================================================================================

echo "============================================================"
echo "            STARTING J2EE DEPLOYMENT PROCESS"
echo "============================================================"
echo "START TIME: $(date)"
echo

# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURATION
# MANIFEST    : file that lists every change to deploy (format: FILE_CHANGE_TYPE|FILE_PATH)
# WORKING_DIR : folder where newFiles/ and modifiedFiles/ directories live
# ---------------------------------------------------------------------------------------------------------------------
MANIFEST="deployment-manifest.txt"
WORKING_DIR=$(pwd)

# ---------------------------------------------------------------------------------------------------------------------
# SIT SERVER BASE PATHS
# Both paths live on the single SIT Group server (EQSIT).
# All banks share these base directories — the bank ID is appended as a subfolder per bank.
# Global files are deployed to the base path directly (no bank folder in the server path).
#
# When the SIT server path changes, update these two constants here — nowhere else.
# ---------------------------------------------------------------------------------------------------------------------
FINCORE_BASE="/equity_fe/EQSIT/FrontEnd/FinacleApps/finbranch.war/custom"
CRM_BASE="/equity_fe/EQSIT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization"

# ---------------------------------------------------------------------------------------------------------------------
# EXECUTION COUNTERS
# Tracks how many files were processed, deployed, skipped, and whether any failed.
# All counter variable names end with _COUNTER to make them easy to identify.
# Printed in the summary at the end of the script.
# ---------------------------------------------------------------------------------------------------------------------
# Return variable used by resolve_server_path() to pass its result back to the caller.
# Using a global avoids the need for $() command substitution, which would capture all
# stdout (including log() output) and corrupt the returned path.
RESOLVED_PATH=""

TOTAL_FILES_IN_MANIFEST_COUNTER=0   # every line read from the manifest
NEW_FILES_DEPLOYED_COUNTER=0        # files that were newly created on the server
MODIFIED_FILES_DEPLOYED_COUNTER=0   # files that were updated on the server
DELETED_FILES_DEPLOYED_COUNTER=0    # files that were removed from the server
SUCCESSFUL_DEPLOYMENTS_COUNTER=0    # total operations that completed without error
FAILED_DEPLOYMENTS_COUNTER=0        # total operations that encountered an error

# ---------------------------------------------------------------------------------------------------------------------
# LOGGING UTILITIES
# log()        : prints an informational message with [INFO] prefix
# error_exit() : prints an error message and immediately stops the script
# ---------------------------------------------------------------------------------------------------------------------
log() {
    echo "[INFO] $1"
}

error_exit() {
    echo "[ERROR] $1" >&2
    echo "[ERROR] Deployment stopped at: $(date)" >&2
    exit 1
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: resolve_server_path
#
# Builds the full path on the server where a file should be deployed.
# The path depends on two things:
#   1. Which Finacle app : fincore or crm (each has a different base directory on the server)
#   2. Which bank        : appended as a subfolder under the base directory
#                          Global files have no bank subfolder — they go to the base path directly
#
# Arguments:
#   $1 finacle_app   : "fincore" or "crm"
#   $2 bank_id       : bank number e.g. "54", "11", or the word "global"
#   $3 relative_path : the file path after the bank folder e.g. "cif/display/Account.xsl"
#
# SIT NOTE:
#   Repo paths have an extra group/ segment: fincore/custom/group/<bank_id>/<relative_path>
#   Bank ID is therefore extracted from segment 4 (not segment 3 as in UAT/PROD).
#   The group/ keyword is repo-only — it is never part of the server path.
# ---------------------------------------------------------------------------------------------------------------------
resolve_server_path() {
    local finacle_app=$1
    local bank_id=$2
    local relative_path=$3
    local base_path

    log "Building server destination path — app: $finacle_app | bank: $bank_id | file: $relative_path"

    # ---- Fincore paths ----
    if [ "$finacle_app" == "fincore" ]; then
        case "$bank_id" in
            global)
                # Global files live at the root of the custom directory — no bank folder in the path
                base_path="$FINCORE_BASE"
                ;;
            11|43|50|54|55|56|99)
                # All SIT banks share the same Group server — bank ID is appended as a subfolder
                base_path="$FINCORE_BASE/$bank_id"
                ;;
            *)
                error_exit "Unknown bank_id in resolve_server_path: '$bank_id' (app: fincore)."
                ;;
        esac

    # ---- CRM paths ----
    elif [ "$finacle_app" == "crm" ]; then
        case "$bank_id" in
            global)
                base_path="$CRM_BASE"
                ;;
            11|43|50|54|55|56|99)
                base_path="$CRM_BASE/$bank_id"
                ;;
            *)
                error_exit "Unknown bank_id in resolve_server_path: '$bank_id' (app: crm)."
                ;;
        esac

    else
        error_exit "Unknown Finacle app: '$finacle_app'. Expected 'fincore' or 'crm'."
    fi

    # Combine the base path with the file's relative path to get the full server destination.
    # Result is written to RESOLVED_PATH (global) instead of echoed — prevents stdout pollution
    # when the caller reads this value (no $() command substitution needed).
    RESOLVED_PATH="$base_path/$relative_path"
    log "Server destination path resolved : $RESOLVED_PATH"
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: backup_file
#
# Creates a timestamped backup copy of a file on the server BEFORE it is changed or deleted.
# This ensures we can always recover the previous version if something goes wrong.
#
# The backup is saved in a /backup/ subfolder inside the same base directory as the file.
# Example:
#   Original file : /equity_fe/.../Customization/54/cif/display/Account.xsl
#   Backup copy   : /equity_fe/.../Customization/54/backup/cif/display/Account.xsl_20260410_142305
#
# Arguments:
#   $1 file_on_server : full path of the file that is about to be changed or deleted
# ---------------------------------------------------------------------------------------------------------------------
backup_file() {
    local file_on_server=$1
    local timestamp
    local base_path
    local relative_path
    local backup_folder
    local original_filename
    local backup_filepath

    log "Backing up : $file_on_server"

    # Create a unique timestamp so each backup file has a different name
    # Format: YYYYMMDD_HHMMSS  e.g. 20260410_142305
    timestamp=$(date +"%Y%m%d_%H%M%S")

    # Split the server path into two parts so we can build the backup folder path.
    # Example: .../finbranch.war/custom/54/cif/display/Account.xsl
    #   base_path     = .../finbranch.war/custom/54       (everything up to and including the bank folder)
    #   relative_path = cif/display/Account.xsl           (everything after the bank folder)
    # Use # as sed delimiter — the pattern contains | for alternation (custom|Customization)
    # which would conflict if | were used as the delimiter.
    base_path=$(echo "$file_on_server" | sed -E 's#(.*/(custom|Customization)(/[0-9]+)?).*#\1#')
    relative_path=$(echo "$file_on_server" | sed -E 's#.*/(custom|Customization)(/[0-9]+)?/##')

    if [ -z "$base_path" ] || [ -z "$relative_path" ]; then
        error_exit "Could not parse server path for backup: $file_on_server"
    fi

    log "  Bank base directory  : $base_path"
    log "  File relative path   : $relative_path"

    # The backup folder mirrors the file's folder structure, but sits under /backup/
    # e.g. .../Customization/54/backup/cif/display/
    backup_folder="$base_path/backup/$(dirname "$relative_path")"

    log "  Backup folder        : $backup_folder"
    mkdir -p "$backup_folder" || error_exit "Failed to create backup folder: $backup_folder"

    # Only back up if the file actually exists on the server
    # (a NEW file will not exist yet — nothing to back up)
    if [ -f "$file_on_server" ]; then

        original_filename=$(basename "$file_on_server")
        backup_filepath="$backup_folder/${original_filename}_${timestamp}"

        log "Saving backup to : $backup_filepath"
        cp "$file_on_server" "$backup_filepath" || error_exit "Backup failed for: $file_on_server"
        log "Backup saved : $backup_filepath"

    else
        log "File not found on server — backup skipped"
    fi
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: deploy_file
#
# Carries out the actual deployment operation for a single file.
# Handles three possible file change types from the manifest:
#
#   NEW      : file is brand new — copy it to the server (no backup needed, nothing existed before)
#   MODIFIED : file already exists on the server — back it up first, then overwrite with new version
#   DELETED  : file should be removed from the server — back it up first, then delete it
#
# Arguments:
#   $1 file_change_type : NEW | MODIFIED | DELETED
#   $2 source_file      : where the file currently lives in the artifact (newFiles/ or modifiedFiles/)
#   $3 dest_path        : where the file should go on the server
# ---------------------------------------------------------------------------------------------------------------------
deploy_file() {
    local file_change_type=$1
    local source_file=$2
    local dest_path=$3

    log "Operation        : $file_change_type"
    log "Source file      : $source_file"
    log "Destination      : $dest_path"

    case "$file_change_type" in

        NEW)
            # This is a brand new file that does not yet exist on the server.
            # Just create the folder if needed and copy the file across.
            log "Deploying new file..."
            mkdir -p "$(dirname "$dest_path")"   # create parent folders if they don't exist yet
            if cp "$source_file" "$dest_path"; then
                NEW_FILES_DEPLOYED_COUNTER=$((NEW_FILES_DEPLOYED_COUNTER + 1))
                SUCCESSFUL_DEPLOYMENTS_COUNTER=$((SUCCESSFUL_DEPLOYMENTS_COUNTER + 1))
                log "[SUCCESS] New file deployed : $dest_path"
            else
                FAILED_DEPLOYMENTS_COUNTER=$((FAILED_DEPLOYMENTS_COUNTER + 1))
                error_exit "Failed to copy new file to server : $dest_path"
            fi
            ;;

        MODIFIED)
            # This file already exists on the server and has changed.
            # Back up the current version first, then overwrite it with the new one.
            log "Backing up before overwrite..."
            backup_file "$dest_path"
            mkdir -p "$(dirname "$dest_path")"
            if cp "$source_file" "$dest_path"; then
                MODIFIED_FILES_DEPLOYED_COUNTER=$((MODIFIED_FILES_DEPLOYED_COUNTER + 1))
                SUCCESSFUL_DEPLOYMENTS_COUNTER=$((SUCCESSFUL_DEPLOYMENTS_COUNTER + 1))
                log "[SUCCESS] Modified file deployed : $dest_path"
            else
                FAILED_DEPLOYMENTS_COUNTER=$((FAILED_DEPLOYMENTS_COUNTER + 1))
                error_exit "Failed to overwrite modified file on server : $dest_path"
            fi
            ;;

        DELETED)
            # This file should be removed from the server.
            # Back up the current version first (so it can be recovered if needed), then delete it.
            log "Processing deletion..."

            if [ -f "$dest_path" ]; then
                log "Backing up before deletion..."
                backup_file "$dest_path"
                if rm -f "$dest_path"; then
                    DELETED_FILES_DEPLOYED_COUNTER=$((DELETED_FILES_DEPLOYED_COUNTER + 1))
                    SUCCESSFUL_DEPLOYMENTS_COUNTER=$((SUCCESSFUL_DEPLOYMENTS_COUNTER + 1))
                    log "[SUCCESS] File deleted : $dest_path"
                else
                    FAILED_DEPLOYMENTS_COUNTER=$((FAILED_DEPLOYMENTS_COUNTER + 1))
                    error_exit "Failed to delete file from server : $dest_path"
                fi
            else
                # File is already gone — nothing to do, but not an error either
                log "File not found on server — deletion skipped : $dest_path"
            fi
            ;;

        *)
            # The manifest contained a file change type we do not recognise — this should never happen
            FAILED_DEPLOYMENTS_COUNTER=$((FAILED_DEPLOYMENTS_COUNTER + 1))
            error_exit "Unrecognised file change type in manifest: '$file_change_type'. Expected NEW, MODIFIED, or DELETED."
            ;;
    esac
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: handle_global_file
#
# Deploys a global file to the root of the custom/Customization directory on the SIT server.
# Global files are shared across banks — they live at the root with NO bank number in the path.
#
# Example:
#   Repo path   : fincore/custom/group/global/cif/js/custom.js
#   Server path : /equity_fe/EQSIT/.../finbranch.war/custom/cif/js/custom.js
#                                                           ^^ no bank folder here
# Arguments:
#   $1 file_change_type  : NEW | MODIFIED | DELETED
#   $2 finacle_app       : "fincore" or "crm"
#   $3 path_after_global : the file path after the /global/ segment
#                          e.g. for "fincore/custom/group/global/cif/js/custom.js" → "cif/js/custom.js"
#   $4 source_file       : where the file lives in the artifact (empty string for DELETED)
# ---------------------------------------------------------------------------------------------------------------------
handle_global_file() {
    local file_change_type=$1
    local finacle_app=$2
    local path_after_global=$3
    local source_file=$4
    local dest_path

    log "Global file — no bank folder in server path"
    log "  Finacle app          : $finacle_app"
    log "  Server relative path : $path_after_global"
    log "  Source file          : ${source_file:-N/A (deletion)}"

    # Resolve the full server path using "global" as the bank_id.
    # resolve_server_path knows that "global" means: use root path, no bank number.
    # Result is in $RESOLVED_PATH — no $() needed (avoids stdout capture of log messages).
    resolve_server_path "$finacle_app" "global" "$path_after_global"
    dest_path="$RESOLVED_PATH"
    log "  Destination path     : $dest_path"

    deploy_file "$file_change_type" "$source_file" "$dest_path"
    log "Global file deployment complete"
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: should_deploy_file
#
# SIT has only one Group server — every file in the manifest is deployed here.
# This function always returns 0 (deploy).
#
# In UAT/PROD this function performs per-bank routing (checking whether the file's bank ID
# matches the current --target). That logic is not needed in SIT because there is only one
# server and one pipeline run per CI build.
#
# Returns:
#   0 (true) always — deploy every manifest entry
# ---------------------------------------------------------------------------------------------------------------------
should_deploy_file() {
    log "SIT topology — all banks share one Group server. Deploying."
    return 0
}

# =====================================================================================================================
# SCRIPT BODY — all functions are defined above; execution starts here
# =====================================================================================================================

echo "============================================================"
echo "STEP 0: ARGUMENT PARSING AND VALIDATION"
echo "============================================================"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0A: PARSE ARGUMENTS
# --target group  : the only valid target for SIT
# --env           : accepted for suScript.sh interface compatibility; no effect on path resolution
# Examples:
#   deploy-j2ee-sit.sh --target group
#   deploy-j2ee-sit.sh --target group --env sit
# ---------------------------------------------------------------------------------------------------------------------

TARGET_SERVER_GROUP=""
DEPLOY_ENV=""

# Read through each argument pair (--name value) one at a time.
# $# is the count of remaining arguments; shift 2 skips past the current pair to the next one.
log "Parsing script arguments..."

while [ "$#" -gt 0 ]; do
    case "$1" in
        --target)
            TARGET_SERVER_GROUP="$2"
            log "  --target : '$TARGET_SERVER_GROUP'"
            shift 2 ;;
        --env)
            DEPLOY_ENV="$2"
            log "  --env    : '$DEPLOY_ENV' (informational only — SIT paths are hardcoded constants)"
            shift 2 ;;
        *)
            error_exit "Unknown argument: '$1'. Usage: deploy-j2ee-sit.sh --target group [--env sit]" ;;
    esac
done

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0B: VALIDATE --target
# SIT has only one Group server — only "group" is a valid target.
# ---------------------------------------------------------------------------------------------------------------------
log "Validating --target..."

if [ -z "$TARGET_SERVER_GROUP" ]; then
    error_exit "Missing required argument: --target. Usage: deploy-j2ee-sit.sh --target group"
fi

if [ "$TARGET_SERVER_GROUP" != "group" ]; then
    error_exit "Invalid --target value: '$TARGET_SERVER_GROUP'. SIT only accepts --target group (all banks share one Group server)."
fi

log "  --target 'group' : valid"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0C: STARTUP SUMMARY — confirm all resolved config before deployment begins
# ---------------------------------------------------------------------------------------------------------------------
echo "------------------------------------------------------------"
echo "  DEPLOYMENT CONFIGURATION"
echo "------------------------------------------------------------"
echo "  Environment                   : SIT"
echo "  Target server group           : $TARGET_SERVER_GROUP"
echo "  Banks on this server          : 11, 43, 50, 54, 55, 56, 99"
echo "  Fincore base path             : $FINCORE_BASE"
echo "  CRM base path                 : $CRM_BASE"
echo "  Manifest file                 : $MANIFEST"
echo "  Working directory             : $WORKING_DIR"
echo "------------------------------------------------------------"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 1: VALIDATE THE MANIFEST FILE
# ---------------------------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "STEP 1: VALIDATING MANIFEST FILE"
echo "============================================================"

if [ ! -f "$MANIFEST" ]; then
    error_exit "Manifest file not found : $MANIFEST — cannot proceed without it"
fi

log "Manifest file found : $MANIFEST"
log "Manifest contents :"
while IFS='|' read -r change_type file_path; do
    log "  $change_type | $file_path"
done < "$MANIFEST"
echo

# ---------------------------------------------------------------------------------------------------------------------
# STEP 2: PROCESS EACH FILE IN THE MANIFEST
# Format per line: FILE_CHANGE_TYPE|FILE_PATH
#   e.g. MODIFIED|fincore/custom/group/54/cif/display/Account.xsl
#        NEW|fincore/custom/group/global/jsp/custom.jsp
#        DELETED|crm/customization/group/55/cif/display/OldFile.xsl
#
# SIT repo path structure has an extra group/ segment:
#   fincore/custom/group/<bank_id>/<relative_path>
#   crm/customization/group/<bank_id>/<relative_path>
#   fincore/custom/group/global/<relative_path>
#
# Segment positions (1-indexed, cut -d'/'):
#   f1 = finacle app  (fincore | crm)
#   f2 = custom | customization
#   f3 = group        (SIT-only — repo keyword, never in server path)
#   f4 = bank_id      (11, 43, 50, 54, 55, 56, 99, or "global")
#   f5- = relative_path
# ---------------------------------------------------------------------------------------------------------------------
echo "============================================================"
echo "STEP 2: PROCESSING MANIFEST ENTRIES"
echo "============================================================"
echo

# split each manifest line on | into its two fields
while IFS='|' read -r FILE_CHANGE_TYPE FILE_PATH
do
    TOTAL_FILES_IN_MANIFEST_COUNTER=$((TOTAL_FILES_IN_MANIFEST_COUNTER + 1))

    echo "------------------------------------------------------------"
    echo "  Manifest entry    : $TOTAL_FILES_IN_MANIFEST_COUNTER"
    echo "  File change type  : $FILE_CHANGE_TYPE"
    echo "  File path         : $FILE_PATH"
    echo "------------------------------------------------------------"

    # First path segment tells us which Finacle app this file belongs to (crm or fincore)
    FINACLE_APP=$(echo "$FILE_PATH" | cut -d '/' -f1)          # e.g. "crm" or "fincore"
    log "Finacle application : $FINACLE_APP"

    # SIT: one Group server — every manifest entry is deployed here
    should_deploy_file "$FILE_PATH"

    log "File confirmed for Group server — proceeding with deployment"

    # Locate the source file in the artifact (DELETED files have no source — they exist only on the server)
    if [ "$FILE_CHANGE_TYPE" == "NEW" ]; then
        SOURCE_FILE="$WORKING_DIR/newFiles/$FILE_PATH"          # new files are staged in newFiles/
    elif [ "$FILE_CHANGE_TYPE" == "MODIFIED" ]; then
        SOURCE_FILE="$WORKING_DIR/modifiedFiles/$FILE_PATH"     # modified files are staged in modifiedFiles/
    elif [ "$FILE_CHANGE_TYPE" == "DELETED" ]; then
        SOURCE_FILE=""                                          # deletions have no source — file is removed from server
    else
        error_exit "Unrecognised file change type in manifest: '$FILE_CHANGE_TYPE'"
    fi

    log "Source file : ${SOURCE_FILE:-N/A (deletion)}"

    # Global file: strip /global/ from the path and deploy to the server base path (no bank folder)
    # e.g. fincore/custom/group/global/cif/js/custom.js  →  relative path becomes cif/js/custom.js
    if [[ "$FILE_PATH" == *"/global/"* ]]; then
        RELATIVE_PATH=$(echo "$FILE_PATH" | sed 's|.*/global/||')  # strip everything up to and including /global/
        log "Global file detected — relative path : $RELATIVE_PATH"
        handle_global_file "$FILE_CHANGE_TYPE" "$FINACLE_APP" "$RELATIVE_PATH" "$SOURCE_FILE"
        continue
    fi

    # Bank-specific file: extract bank ID (4th segment) and relative path (everything after it), then deploy.
    # SIT paths have group/ at f3, so bank_id is one segment later than in UAT/PROD.
    # e.g. fincore/custom/group/54/cif/display/Account.xsl  →  BANK_ID=54 | RELATIVE_PATH=cif/display/Account.xsl
    BANK_ID=$(echo "$FILE_PATH" | cut -d '/' -f4)              # e.g. "54", "11", "99"
    RELATIVE_PATH=$(echo "$FILE_PATH" | cut -d '/' -f5-)       # e.g. "cif/display/Account.xsl"
    log "Bank-specific file — bank: $BANK_ID | relative path: $RELATIVE_PATH"

    # Result is in $RESOLVED_PATH — no $() needed (avoids stdout capture of log messages).
    resolve_server_path "$FINACLE_APP" "$BANK_ID" "$RELATIVE_PATH"
    DEST_PATH="$RESOLVED_PATH"

    deploy_file "$FILE_CHANGE_TYPE" "$SOURCE_FILE" "$DEST_PATH"

done < "$MANIFEST"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 3: APPLY FILE PERMISSIONS
# After all files have been deployed, reset permissions on the SIT server directory.
# All J2EE files must be owned by applmgr with read+write+execute for the owner.
# SIT uses /equity_fe only — there is no /finacle path on this server.
# ---------------------------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "STEP 3: APPLYING FILE PERMISSIONS"
echo "============================================================"

log "Resetting permissions (owner: applmgr, mode: 755)..."

if [ -d "/equity_fe" ]; then
    log "  Applying chmod 755 + chown applmgr on /equity_fe..."
    chmod -R 755 /equity_fe     || true
    chown -R applmgr /equity_fe || true
else
    log "  /equity_fe not present on this server — skipping"
fi

log "Permissions reset successfully"

# ---------------------------------------------------------------------------------------------------------------------
# EXECUTION SUMMARY
# Shows a complete breakdown of what happened during this deployment run.
# ---------------------------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "                 DEPLOYMENT EXECUTION SUMMARY"
echo "============================================================"
echo "ENVIRONMENT                         : SIT"
echo "TARGET SERVER GROUP                 : $TARGET_SERVER_GROUP"
echo "BANKS ON SERVER                     : 11, 43, 50, 54, 55, 56, 99"
echo "------------------------------------------------------------"
echo "TOTAL FILES IN MANIFEST COUNTER     : $TOTAL_FILES_IN_MANIFEST_COUNTER"
echo "------------------------------------------------------------"
echo "NEW FILES DEPLOYED COUNTER          : $NEW_FILES_DEPLOYED_COUNTER"
echo "MODIFIED FILES DEPLOYED COUNTER     : $MODIFIED_FILES_DEPLOYED_COUNTER"
echo "DELETED FILES DEPLOYED COUNTER      : $DELETED_FILES_DEPLOYED_COUNTER"
echo "------------------------------------------------------------"
echo "SUCCESSFUL DEPLOYMENTS COUNTER      : $SUCCESSFUL_DEPLOYMENTS_COUNTER"
echo "FAILED DEPLOYMENTS COUNTER          : $FAILED_DEPLOYMENTS_COUNTER"
echo "------------------------------------------------------------"

if [ "$FAILED_DEPLOYMENTS_COUNTER" -eq 0 ]; then
    echo "STATUS                              : SUCCESS"
else
    echo "STATUS                              : FAILED — review errors above"
fi

echo "END TIME                            : $(date)"
echo "============================================================"
echo

exit 0
