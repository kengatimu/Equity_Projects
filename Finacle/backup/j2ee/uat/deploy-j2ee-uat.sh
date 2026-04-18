#!/bin/bash

# ==================================================================================================
# SCRIPT : deploy-j2ee-uat.sh
# PURPOSE: Deploy J2EE customization files (fincore / crm) to the correct UAT Finacle server.
#          Reads deployment-manifest.txt and copies, backs up, or deletes each file on the target.
#
# USAGE  : deploy-j2ee-uat.sh --target <group|43|50|55|56> [--env uat]
#
#   --target group : EQUAT Group server (banks 11, 54, 99)
#   --target 43/50/55/56 : dedicated subsidiary server (DRC / Rwanda / Tanzania / Uganda)
#   --env uat      : accepted for suScript.sh compatibility; paths are hardcoded constants
#
# NOTE   : The CI pipeline copies this file as deploy-j2ee.sh so suScript.sh can call it
#          by its standard name without modification.
#
# AUTHOR : Kennedy Gatimu
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
# UAT SERVER BASE PATHS
# Root deployment directory per server. Bank ID (or nothing for global files) is appended at deploy time.
#   GROUP    : banks 11, 54, 99 — local: /equity_fe/EQUAT/.../<bank_id>/..., global: /equity_fe/EQUAT/...
#   Subsidiaries 43/50/56 : shared /u01/equity_fe/... base path; target IP distinguishes the machine
#   Tanzania (55)    : unique /finacle/EQTZPPROD/... base path — same local/global structure
# To update a path, edit the constant here only — it is used throughout the script.
# ---------------------------------------------------------------------------------------------------------------------
GROUP_FINCORE_BASE="/equity_fe/EQUAT/FrontEnd/FinacleApps/finbranch.war/custom"
GROUP_CRM_BASE="/equity_fe/EQUAT/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization"

SUBSIDIARY_FINCORE_BASE="/u01/equity_fe/FinacleApps/finbranch.war/custom"
SUBSIDIARY_CRM_BASE="/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization"

TZ_FINCORE_BASE="/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom"
TZ_CRM_BASE="/finacle/EQTZPPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization"

# ---------------------------------------------------------------------------------------------------------------------
# EXECUTION COUNTERS AND GLOBALS
# All counter names end with _COUNTER and are printed in the summary at the end.
# RESOLVED_PATH is a global used by resolve_server_path() to return its result without $()
# ---------------------------------------------------------------------------------------------------------------------
RESOLVED_PATH=""

TOTAL_FILES_IN_MANIFEST_COUNTER=0   # every line read from the manifest
NEW_FILES_DEPLOYED_COUNTER=0        # files that were newly created on the server
MODIFIED_FILES_DEPLOYED_COUNTER=0   # files that were updated on the server
DELETED_FILES_DEPLOYED_COUNTER=0    # files that were removed from the server
SKIPPED_FILES_COUNTER=0             # files skipped because they belong to a different target
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
# Builds the full server destination path from TARGET_SERVER_GROUP, finacle_app, and bank_id.
#   group    : GROUP_FINCORE_BASE / GROUP_CRM_BASE
#   43|50|56 : SUBSIDIARY_FINCORE_BASE / SUBSIDIARY_CRM_BASE
#   55       : TZ_FINCORE_BASE / TZ_CRM_BASE
# "global" as bank_id means no bank folder appended (file lands at the base root).
# Result is written to RESOLVED_PATH global — no $() needed, avoids capturing log output.
# Args: $1 finacle_app | $2 bank_id (or "global") | $3 relative_path
# ---------------------------------------------------------------------------------------------------------------------
resolve_server_path() {
    local finacle_app=$1
    local bank_id=$2
    local relative_path=$3
    local base_path

    log "Building server destination path — app: $finacle_app | bank: $bank_id | file: $relative_path"

    case "$TARGET_SERVER_GROUP" in

        group)
            # Group server — hosts banks 11 (South Sudan), 54 (Kenya), 99 (Finserve)
            # Global files deploy to the server root (no bank folder); bank files get a bank subfolder
            if [ "$finacle_app" == "fincore" ]; then
                case "$bank_id" in
                    global)    base_path="$GROUP_FINCORE_BASE" ;;
                    11|54|99)  base_path="$GROUP_FINCORE_BASE/$bank_id" ;;
                    *)         error_exit "Unknown bank_id '$bank_id' for group target (app: fincore). Expected: 11 | 54 | 99 | global" ;;
                esac
            elif [ "$finacle_app" == "crm" ]; then
                case "$bank_id" in
                    global)    base_path="$GROUP_CRM_BASE" ;;
                    11|54|99)  base_path="$GROUP_CRM_BASE/$bank_id" ;;
                    *)         error_exit "Unknown bank_id '$bank_id' for group target (app: crm). Expected: 11 | 54 | 99 | global" ;;
                esac
            else
                error_exit "Unknown Finacle app '$finacle_app' for group target. Expected: fincore | crm"
            fi
            ;;

        43|50|56)
            # Dedicated subsidiary servers — DRC (43), Rwanda (50), Uganda (56)
            # All three share the same /u01/equity_fe/... base path; the CD pipeline SSH target IP
            # determines which physical machine is deployed to — the path itself is the same.
            # Global files deploy to the server root (no bank folder); local files get a bank subfolder.
            if [ "$finacle_app" == "fincore" ]; then
                case "$bank_id" in
                    global)     base_path="$SUBSIDIARY_FINCORE_BASE" ;;
                    43|50|56)   base_path="$SUBSIDIARY_FINCORE_BASE/$bank_id" ;;
                    *)          error_exit "Unknown bank_id '$bank_id' for subsidiary target '$TARGET_SERVER_GROUP' (app: fincore). Expected: $TARGET_SERVER_GROUP | global" ;;
                esac
            elif [ "$finacle_app" == "crm" ]; then
                case "$bank_id" in
                    global)     base_path="$SUBSIDIARY_CRM_BASE" ;;
                    43|50|56)   base_path="$SUBSIDIARY_CRM_BASE/$bank_id" ;;
                    *)          error_exit "Unknown bank_id '$bank_id' for subsidiary target '$TARGET_SERVER_GROUP' (app: crm). Expected: $TARGET_SERVER_GROUP | global" ;;
                esac
            else
                error_exit "Unknown Finacle app '$finacle_app' for subsidiary target '$TARGET_SERVER_GROUP'. Expected: fincore | crm"
            fi
            ;;

        55)
            # Tanzania dedicated server — unique /finacle/EQTZPPROD/... base path
            # Local files always include /55/ in the server path; global files deploy to the root.
            if [ "$finacle_app" == "fincore" ]; then
                case "$bank_id" in
                    global)    base_path="$TZ_FINCORE_BASE" ;;
                    55)        base_path="$TZ_FINCORE_BASE/55" ;;
                    *)         error_exit "Unknown bank_id '$bank_id' for Tanzania target (app: fincore). Expected: 55 | global" ;;
                esac
            elif [ "$finacle_app" == "crm" ]; then
                case "$bank_id" in
                    global)    base_path="$TZ_CRM_BASE" ;;
                    55)        base_path="$TZ_CRM_BASE/55" ;;
                    *)         error_exit "Unknown bank_id '$bank_id' for Tanzania target (app: crm). Expected: 55 | global" ;;
                esac
            else
                error_exit "Unknown Finacle app '$finacle_app' for Tanzania target. Expected: fincore | crm"
            fi
            ;;

        *)
            error_exit "Unknown TARGET_SERVER_GROUP: '$TARGET_SERVER_GROUP'. Expected: group | 43 | 50 | 55 | 56"
            ;;

    esac

    # Combine the base path with the file's relative path to get the full server destination.
    # Result is written to RESOLVED_PATH (global) instead of echoed — prevents stdout pollution
    # when the caller reads this value (no $() command substitution needed).
    RESOLVED_PATH="$base_path/$relative_path"
    log "Server destination path resolved : $RESOLVED_PATH"
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: backup_file
# Creates a timestamped copy of a file before it is changed or deleted.
# Backup is saved under a /backup/ subfolder in the same base directory as the original.
# Skipped silently if the file does not yet exist on the server (e.g. NEW files).
# Args: $1 file_on_server — full server path of the file to back up
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
# Executes the deployment operation for a single file.
#   NEW      : copy to server (no backup — file does not exist yet)
#   MODIFIED : backup existing file, then overwrite with the new version
#   DELETED  : backup existing file, then remove it from the server
# Args: $1 file_change_type (NEW|MODIFIED|DELETED) | $2 source_file | $3 dest_path
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
# Deploys a global file to the server root — no bank folder in the destination path.
# Applies to both Group global (group/global/...) and subsidiary global (<bank_id>/global/...) files.
# Args: $1 file_change_type | $2 finacle_app | $3 path_after_global | $4 source_file
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
    # resolve_server_path knows that "global" means: use the base path root, no bank number appended.
    # Result is in $RESOLVED_PATH — no $() needed (avoids stdout capture of log messages).
    resolve_server_path "$finacle_app" "global" "$path_after_global"
    dest_path="$RESOLVED_PATH"
    log "  Destination path     : $dest_path"

    deploy_file "$file_change_type" "$source_file" "$dest_path"
    log "Global file deployment complete"
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: should_deploy_file
# Returns 0 if the file belongs to the current --target server, 1 if it should be skipped.
# The 3rd path segment (group|43|50|55|56) is the routing key — it always matches --target.
# Files for other targets are left for their own CD stage to handle.
# Args: $1 file_path — full file path from the manifest
# ---------------------------------------------------------------------------------------------------------------------
should_deploy_file() {
    local file_path=$1
    local routing_segment

    # Extract f3 — the segment that identifies the target server for this file
    routing_segment=$(echo "$file_path" | cut -d '/' -f3)

    if [ "$routing_segment" == "$TARGET_SERVER_GROUP" ]; then
        return 0  # this file belongs to the current target server — proceed with deployment
    fi

    log "  Skipping: $file_path — belongs to '$routing_segment' server, current target is '$TARGET_SERVER_GROUP'"
    SKIPPED_FILES_COUNTER=$((SKIPPED_FILES_COUNTER + 1))
    return 1  # this file is for a different server — the correct CD stage will handle it
}

# =====================================================================================================================
# SCRIPT BODY — all functions are defined above; execution starts here
# =====================================================================================================================

echo "============================================================"
echo "STEP 0: ARGUMENT PARSING AND VALIDATION"
echo "============================================================"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0A: PARSE ARGUMENTS
# --target group|43|50|55|56 : required — identifies which UAT server this run targets
# --env                       : accepted for suScript.sh compatibility; no effect on paths
# ---------------------------------------------------------------------------------------------------------------------

TARGET_SERVER_GROUP=""
DEPLOY_ENV=""

log "Parsing script arguments..."

while [ "$#" -gt 0 ]; do
    case "$1" in
        --target)
            TARGET_SERVER_GROUP="$2"
            log "  --target : '$TARGET_SERVER_GROUP'"
            shift 2 ;;
        --env)
            DEPLOY_ENV="$2"
            log "  --env    : '$DEPLOY_ENV' (informational only — UAT paths are hardcoded constants)"
            shift 2 ;;
        *)
            error_exit "Unknown argument: '$1'. Usage: deploy-j2ee-uat.sh --target <group|43|50|55|56> [--env uat]" ;;
    esac
done

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0B: VALIDATE --target
# Each valid value maps to a specific UAT server. Any other value is rejected.
# ---------------------------------------------------------------------------------------------------------------------
log "Validating --target..."

if [ -z "$TARGET_SERVER_GROUP" ]; then
    error_exit "Missing required argument: --target. Usage: deploy-j2ee-uat.sh --target <group|43|50|55|56>"
fi

case "$TARGET_SERVER_GROUP" in
    group|43|50|55|56)
        log "  --target '$TARGET_SERVER_GROUP' : valid"
        ;;
    *)
        error_exit "Invalid --target value: '$TARGET_SERVER_GROUP'. UAT accepts: group | 43 | 50 | 55 | 56"
        ;;
esac

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0C: STARTUP SUMMARY — confirm all resolved config before deployment begins
# ---------------------------------------------------------------------------------------------------------------------
echo "------------------------------------------------------------"
echo "  DEPLOYMENT CONFIGURATION"
echo "------------------------------------------------------------"
echo "  Environment      : UAT"
echo "  Target           : $TARGET_SERVER_GROUP"
echo "  Manifest file    : $MANIFEST"
echo "  Working directory: $WORKING_DIR"
echo "------------------------------------------------------------"

case "$TARGET_SERVER_GROUP" in
    group)
        echo "  Server           : Group server (EQUAT)"
        echo "  Banks            : 11 (South Sudan), 54 (Kenya), 99 (Finserve)"
        echo "  Fincore base     : $GROUP_FINCORE_BASE"
        echo "  CRM base         : $GROUP_CRM_BASE"
        ;;
    43|50|56)
        echo "  Server           : Dedicated subsidiary server"
        echo "  Bank             : $TARGET_SERVER_GROUP"
        echo "  Fincore base     : $SUBSIDIARY_FINCORE_BASE"
        echo "  CRM base         : $SUBSIDIARY_CRM_BASE"
        ;;
    55)
        echo "  Server           : Tanzania dedicated server (EQTZPPROD)"
        echo "  Bank             : 55 (Tanzania)"
        echo "  Fincore base     : $TZ_FINCORE_BASE"
        echo "  CRM base         : $TZ_CRM_BASE"
        ;;
esac
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
#        NEW|fincore/custom/43/local/cif/js/custom.js
#
# Path segment layout (f = field position from cut -d'/'):
#   Group      (--target group): f1=app  f2=custom  f3=group    f4=bank_id|global  f5-=relative_path
#   Subsidiary (--target 43+) : f1=app  f2=custom  f3=bank_id  f4=local|global    f5-=relative_path
# ---------------------------------------------------------------------------------------------------------------------
echo "============================================================"
echo "STEP 2: PROCESSING MANIFEST ENTRIES"
echo "============================================================"
echo

while IFS='|' read -r FILE_CHANGE_TYPE FILE_PATH
do
    TOTAL_FILES_IN_MANIFEST_COUNTER=$((TOTAL_FILES_IN_MANIFEST_COUNTER + 1))

    echo "------------------------------------------------------------"
    echo "  Manifest entry    : $TOTAL_FILES_IN_MANIFEST_COUNTER"
    echo "  File change type  : $FILE_CHANGE_TYPE"
    echo "  File path         : $FILE_PATH"
    echo "------------------------------------------------------------"

    # First path segment tells us which Finacle app this file belongs to (fincore or crm)
    FINACLE_APP=$(echo "$FILE_PATH" | cut -d '/' -f1)
    log "Finacle application : $FINACLE_APP"

    # Check whether this file belongs to the current --target server.
    # The 3rd path segment ("group", "43", "50", "55", "56") identifies the target.
    # Files for other targets are skipped — their own CD stage will handle them.
    if ! should_deploy_file "$FILE_PATH"; then
        continue
    fi

    log "File confirmed for '$TARGET_SERVER_GROUP' server — proceeding with deployment"

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

    # ---- PATH EXTRACTION AND ROUTING ----------------------------------------------------------------
    # Extract the bank_id, path type, and relative path depending on which target we are serving.
    # Group and subsidiary targets have different path structures (see STEP 2 comment block above).

    if [ "$TARGET_SERVER_GROUP" == "group" ]; then

        # Group path: fincore/custom/group/<bank_id>/<relative_path>
        #   f4 = bank_id (11, 54, 99) or "global"
        #   f5- = relative path
        BANK_ID=$(echo "$FILE_PATH" | cut -d '/' -f4)          # e.g. "54", "11", "99", or "global"
        RELATIVE_PATH=$(echo "$FILE_PATH" | cut -d '/' -f5-)   # e.g. "cif/display/Account.xsl"

        # Group global file: deploy to the Group server root — no bank folder in server path
        if [ "$BANK_ID" == "global" ]; then
            log "Group global file — relative path: $RELATIVE_PATH"
            handle_global_file "$FILE_CHANGE_TYPE" "$FINACLE_APP" "$RELATIVE_PATH" "$SOURCE_FILE"
            continue
        fi

        log "Group bank-specific file — bank: $BANK_ID | relative path: $RELATIVE_PATH"

    else

        # Subsidiary path: fincore/custom/<bank_id>/local|global/<relative_path>
        #   f3 = bank_id (the target itself — already confirmed by should_deploy_file)
        #   f4 = "local" or "global"
        #   f5- = relative path
        BANK_ID="$TARGET_SERVER_GROUP"                           # the target IS the bank_id for subsidiary servers
        PATH_TYPE=$(echo "$FILE_PATH" | cut -d '/' -f4)         # "local" or "global"
        RELATIVE_PATH=$(echo "$FILE_PATH" | cut -d '/' -f5-)    # e.g. "cif/display/Account.xsl"

        # Subsidiary global file: deploy to the subsidiary server root — no bank folder in server path
        if [ "$PATH_TYPE" == "global" ]; then
            log "Subsidiary global file (bank $BANK_ID) — relative path: $RELATIVE_PATH"
            handle_global_file "$FILE_CHANGE_TYPE" "$FINACLE_APP" "$RELATIVE_PATH" "$SOURCE_FILE"
            continue
        fi

        log "Subsidiary local file — bank: $BANK_ID | relative path: $RELATIVE_PATH"

    fi

    # Non-global file: resolve the full server path and deploy
    # Result is in $RESOLVED_PATH — no $() needed (avoids stdout capture of log messages).
    resolve_server_path "$FINACLE_APP" "$BANK_ID" "$RELATIVE_PATH"
    DEST_PATH="$RESOLVED_PATH"

    deploy_file "$FILE_CHANGE_TYPE" "$SOURCE_FILE" "$DEST_PATH"

done < "$MANIFEST"

# ---------------------------------------------------------------------------------------------------------------------
# EXECUTION SUMMARY
# Shows a complete breakdown of what happened during this deployment run.
# ---------------------------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "                 DEPLOYMENT EXECUTION SUMMARY"
echo "============================================================"
echo "ENVIRONMENT                         : UAT"
echo "TARGET SERVER GROUP                 : $TARGET_SERVER_GROUP"

case "$TARGET_SERVER_GROUP" in
    group)  echo "BANKS ON SERVER                     : 11 (South Sudan), 54 (Kenya), 99 (Finserve)" ;;
    43)     echo "BANK ON SERVER                      : 43 (DRC)" ;;
    50)     echo "BANK ON SERVER                      : 50 (Rwanda)" ;;
    55)     echo "BANK ON SERVER                      : 55 (Tanzania)" ;;
    56)     echo "BANK ON SERVER                      : 56 (Uganda)" ;;
esac

echo "------------------------------------------------------------"
echo "TOTAL FILES IN MANIFEST COUNTER     : $TOTAL_FILES_IN_MANIFEST_COUNTER"
echo "SKIPPED FILES COUNTER               : $SKIPPED_FILES_COUNTER"
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
