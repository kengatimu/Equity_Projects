#!/bin/bash

# ==================================================================================================
# SCRIPT: deploy-j2ee.sh
#
# PURPOSE:
#   Deploy J2EE customization files (fincore / crm) to the correct Finacle servers.
#   Reads a manifest file that lists every file to deploy, then copies, backs up,
#   or deletes each file on the target server accordingly.
#
# FEATURES:
#   - Target filtering  (--target <bank_id>)
#   - Manifest-driven   (reads deployment-manifest.txt line by line)
#   - Path resolution   (builds the correct server path per Finacle app and bank)
#   - Backup on change  (backs up any file before it is modified or deleted)
#   - Global file support (strips /global/ folder from server path)
#   - Detailed logging and execution summary
#
# USAGE:
#   deploy-j2ee.sh --target <bank_id> --env <prod|uat|sit>
#
#   --target <bank_id>   : bank to deploy to e.g. --target 54
#                          Accepted: 11 (Sudan) | 43 (DRC) | 50 (Rwanda) | 54 (Kenya) | 55 (Tanzania) | 56 (Uganda)
#                          Note: --target 54 also deploys Finserve (99) and global files — all on the same server
#   --env prod|uat|sit   : determines which server environment paths are used
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
#
# Finserve (99) is a virtual bank that shares Kenya's (54) servers.
# Its files are always deployed together with Kenya — use --target 54.
# ---------------------------------------------------------------------------------------------------------------------
MANIFEST="deployment-manifest.txt"
WORKING_DIR=$(pwd)

# ---------------------------------------------------------------------------------------------------------------------
# DEDICATED BANKS IDS CONFIG
# Every bank runs on its own dedicated servers.
# List every bank ID here — routing and --target validation are driven by this array.
#
# When a new bank gets dedicated servers, make THREE changes:
#   1. Add its ID here                                   e.g. DEDICATED_BANKS_IDS=("11" "43" "50" "54" "55" "56" "57")
#   2. Add its env prefix in STEP 0C below               e.g. DEDICATED_BANK_PREFIX["57"]="EQNEWPROD"
#   3. Add its ID to the case branch in resolve_server_path() below (both fincore and crm sections)
#
# Note: Finserve (99) is NOT listed here — it shares Kenya's (54) servers and is always deployed with --target 54.
# ---------------------------------------------------------------------------------------------------------------------
DEDICATED_BANKS_IDS=("11" "43" "50" "54" "55" "56")

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
FILES_ROUTED_ELSEWHERE_COUNTER=0    # files that belong to a different bank (intentionally skipped)
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
#   2. Which bank        : each bank has its own server and prefix
#                          Kenya (54), Finserve (99), and global files share the /equity_fe/ server
#                          All other banks use their own /finacle/<prefix>/... server
#
# Arguments:
#   $1 finacle_app   : "fincore" or "crm"
#   $2 bank_id       : bank number e.g. "54", "55", or the word "global"
#   $3 relative_path : the file path after the bank folder e.g. "cif/display/Account.xsl"
#
# Bank env prefixes are looked up from DEDICATED_BANK_PREFIX (set in STEP 0C).
# To add a new bank using the /finacle/ path structure, append its ID to the existing
# case pattern marked below — both fincore and crm sections need the update.
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
                # Global files live at the root of Kenya's server — no bank folder in the path
                base_path="/equity_fe/${DEDICATED_BANK_PREFIX["54"]}/FrontEnd/FinacleApps/finbranch.war/custom"
                ;;
            54|99)
                # Kenya (54) and Finserve (99) share the equity_fe server — Kenya's prefix applies to both
                base_path="/equity_fe/${DEDICATED_BANK_PREFIX["54"]}/FrontEnd/FinacleApps/finbranch.war/custom/$bank_id"
                ;;
            11|43|50|55|56)
                # ADD NEW DEDICATED BANK HERE: append its ID to the pattern e.g. 11|43|50|55|56|57
                base_path="/finacle/${DEDICATED_BANK_PREFIX[$bank_id]}/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom/$bank_id"
                ;;
            *)
                error_exit "Unknown bank_id in resolve_server_path: '$bank_id' (app: fincore)."
                ;;
        esac

    # ---- CRM paths ----
    elif [ "$finacle_app" == "crm" ]; then
        case "$bank_id" in
            global)
                base_path="/equity_fe/${DEDICATED_BANK_PREFIX["54"]}/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization"
                ;;
            54|99)
                base_path="/equity_fe/${DEDICATED_BANK_PREFIX["54"]}/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization/$bank_id"
                ;;
            11|43|50|55|56)
                # ADD NEW DEDICATED BANK HERE: append its ID to the pattern e.g. 11|43|50|55|56|57
                base_path="/finacle/${DEDICATED_BANK_PREFIX[$bank_id]}/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization/$bank_id"
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
# Deploys a global file to Kenya's server root path.
# Global files are shared across banks — they live at the root of the
# Customization / custom folder on Kenya's server, with NO bank number in the path.
#
# Example:
#   Repo path   : crm/customization/global/cif/js/Account.js
#   Server path : /equity_fe/.../FinacleCRM.war/Customization/cif/js/Account.js
#                                                             ^^ no bank folder here
# Arguments:
#   $1 file_change_type  : NEW | MODIFIED | DELETED
#   $2 finacle_app       : "fincore" or "crm"
#   $3 path_after_global : the file path after the /global/ segment
#                          e.g. for "crm/customization/global/cif/js/Account.js" → "cif/js/Account.js"
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
# Answers the question: "Does this file belong to the bank we are deploying to right now?"
#
# Each pipeline run targets ONE bank, passed via --target:
#   --target <bank_id> : deploy only files for that specific bank e.g. --target 55
#
# Special cases that route to --target 54 (Kenya's server):
#   - Finserve (99) : virtual bank hosted on Kenya's servers
#   - global        : files with no bank folder, deployed to Kenya's server root
#
# Returns:
#   0 (true)  = yes, deploy this file on this run
#   1 (false) = no, this file belongs to a different bank — skip it here
# ---------------------------------------------------------------------------------------------------------------------
should_deploy_file() {
    local file_path=$1
    local bank_id
    local effective_target

    # Extract the bank ID from the file path (always the 3rd segment)
    # e.g. "crm/customization/55/cif/Account.xsl"  →  bank_id = "55"
    # e.g. "fincore/custom/global/jsp/custom.jsp"  →  bank_id = "global"
    bank_id=$(echo "$file_path" | cut -d '/' -f3)

    # Finserve (99) and global files both live on Kenya's (54) servers — deploy them on --target 54
    if [ "$bank_id" == "99" ] || [ "$bank_id" == "global" ]; then
        effective_target="54"
    else
        effective_target="$bank_id"
    fi

    log "Routing decision — bank: $bank_id | effective target: $effective_target | this run targets: $TARGET_SERVER_GROUP"

    if [ "$effective_target" == "$TARGET_SERVER_GROUP" ]; then
        log "Routing result  : DEPLOY — bank $bank_id belongs to target '$TARGET_SERVER_GROUP'"
        return 0
    else
        log "Routing result  : SKIP   — bank $bank_id does not belong to target '$TARGET_SERVER_GROUP'"
        return 1
    fi
}

# =====================================================================================================================
# SCRIPT BODY — all functions are defined above; execution starts here
# =====================================================================================================================

echo "============================================================"
echo "STEP 0: ARGUMENT PARSING AND VALIDATION"
echo "============================================================"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0A: PARSE ARGUMENTS
# Both --target and --env are required and can be passed in any order.
# Examples:
#   deploy-j2ee.sh --target 54 --env prod
#   deploy-j2ee.sh --env sit --target 55
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
            log "  --env    : '$DEPLOY_ENV'"
            shift 2 ;;
        *)
            error_exit "Unknown argument: '$1'. Usage: deploy-j2ee.sh --target <bank_id> --env <prod|uat|sit>" ;;
    esac
done

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0B: VALIDATE --target
# ---------------------------------------------------------------------------------------------------------------------
log "Validating --target..."

if [ -z "$TARGET_SERVER_GROUP" ]; then
    error_exit "Missing required argument: --target. Usage: deploy-j2ee.sh --target <bank_id> --env prod|uat|sit"
fi

# Accept any bank ID listed in DEDICATED_BANKS_IDS — reject everything else
valid_target=false
for bank_id in "${DEDICATED_BANKS_IDS[@]}"; do
    if [ "$TARGET_SERVER_GROUP" == "$bank_id" ]; then
        valid_target=true
        log "  --target '$TARGET_SERVER_GROUP' : valid bank"
        break
    fi
done

if [ "$valid_target" != "true" ]; then
    error_exit "Invalid --target value: '$TARGET_SERVER_GROUP'. Accepted values: ${DEDICATED_BANKS_IDS[*]}"
fi

log "  --target validation passed"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0C: VALIDATE --env AND RESOLVE SERVER PATH PREFIXES
#
# Each bank has one env prefix per environment, looked up from DEDICATED_BANK_PREFIX at deploy time.
# Kenya's (54) prefix is also used for Finserve (99) and global files — all share the same server.
#
# To add a new bank, add its prefix entry in each case below.
# Note: if a bank has no SIT server, map sit to its UAT prefix (same value as uat).
# ---------------------------------------------------------------------------------------------------------------------
log "Validating --env..."

if [ -z "$DEPLOY_ENV" ]; then
    error_exit "Missing required argument: --env. Usage: deploy-j2ee.sh --target <bank_id> --env prod|uat|sit"
fi

declare -A DEDICATED_BANK_PREFIX

case "$DEPLOY_ENV" in
    prod)
        DEDICATED_BANK_PREFIX["11"]="EQSSPROD"
        DEDICATED_BANK_PREFIX["43"]="EQCDPROD"
        DEDICATED_BANK_PREFIX["50"]="EQRWPROD"
        DEDICATED_BANK_PREFIX["54"]="EQPROD"
        DEDICATED_BANK_PREFIX["55"]="EQTZPROD"
        DEDICATED_BANK_PREFIX["56"]="EQUGPROD"
        ;;
    uat)
        DEDICATED_BANK_PREFIX["11"]="EQSSPPROD"
        DEDICATED_BANK_PREFIX["43"]="EQCDPPROD"
        DEDICATED_BANK_PREFIX["50"]="EQRWPPROD"
        DEDICATED_BANK_PREFIX["54"]="EQPPROD"
        DEDICATED_BANK_PREFIX["55"]="EQTZPPROD"
        DEDICATED_BANK_PREFIX["56"]="EQUGPPROD"
        ;;
    sit)
        DEDICATED_BANK_PREFIX["11"]="EQSSPPROD"    # no SIT — reuses UAT prefix
        DEDICATED_BANK_PREFIX["43"]="EQCDPPROD"    # no SIT — reuses UAT prefix
        DEDICATED_BANK_PREFIX["50"]="EQRWPPROD"    # no SIT — reuses UAT prefix
        DEDICATED_BANK_PREFIX["54"]="EQSIT"
        DEDICATED_BANK_PREFIX["55"]="EQTZPPROD"    # no SIT — reuses UAT prefix
        DEDICATED_BANK_PREFIX["56"]="EQUGPPROD"    # no SIT — reuses UAT prefix
        ;;
    *)
        error_exit "Invalid --env value: '$DEPLOY_ENV'. Expected: prod | uat | sit"
        ;;
esac

log "  --env '$DEPLOY_ENV' : prefixes resolved"
log "  Server path prefix : ${DEDICATED_BANK_PREFIX[$TARGET_SERVER_GROUP]}"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0D: STARTUP SUMMARY — confirm all resolved config before deployment begins
# ---------------------------------------------------------------------------------------------------------------------
echo "------------------------------------------------------------"
echo "  DEPLOYMENT CONFIGURATION"
echo "------------------------------------------------------------"
echo "  Target bank                   : $TARGET_SERVER_GROUP"
echo "  Deploy environment            : $DEPLOY_ENV"
echo "  Server path prefix            : ${DEDICATED_BANK_PREFIX[$TARGET_SERVER_GROUP]}"
if [ "$TARGET_SERVER_GROUP" == "54" ]; then
    echo "  Includes Finserve (99)        : yes"
    echo "  Includes global files         : yes"
fi
echo "  Manifest file                 : $MANIFEST"
echo "  Working directory             : $WORKING_DIR"
echo "  Dedicated bank IDs            : ${DEDICATED_BANKS_IDS[*]}"
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
#   e.g. MODIFIED|crm/customization/54/cif/display/Account.xsl
#        NEW|fincore/custom/global/jsp/custom.jsp
#        DELETED|crm/customization/55/cif/display/OldFile.xsl
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

    # Skip files that belong to a different bank — they will be handled by that bank's pipeline run
    if ! should_deploy_file "$FILE_PATH"; then
        log "ROUTED ELSEWHERE — not for bank '$TARGET_SERVER_GROUP' : $FILE_PATH"
        FILES_ROUTED_ELSEWHERE_COUNTER=$((FILES_ROUTED_ELSEWHERE_COUNTER + 1))
        continue
    fi

    log "File confirmed for '$TARGET_SERVER_GROUP' — proceeding with deployment"

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

    # Global file: strip /global/ from the path and deploy to Kenya's server root (no bank folder)
    # e.g. crm/customization/global/cif/js/Account.js  →  relative path becomes cif/js/Account.js
    if [[ "$FILE_PATH" == *"/global/"* ]]; then
        RELATIVE_PATH=$(echo "$FILE_PATH" | sed 's|.*/global/||')  # strip everything up to and including /global/
        log "Global file detected — relative path : $RELATIVE_PATH"
        handle_global_file "$FILE_CHANGE_TYPE" "$FINACLE_APP" "$RELATIVE_PATH" "$SOURCE_FILE"
        continue
    fi

    # Bank-specific file: extract bank ID (3rd segment) and relative path (everything after it), then deploy
    # e.g. crm/customization/54/cif/display/Account.xsl  →  BANK_ID=54 | RELATIVE_PATH=cif/display/Account.xsl
    BANK_ID=$(echo "$FILE_PATH" | cut -d '/' -f3)              # e.g. "54", "55", "99"
    RELATIVE_PATH=$(echo "$FILE_PATH" | cut -d '/' -f4-)       # e.g. "cif/display/Account.xsl"
    log "Bank-specific file — bank: $BANK_ID | relative path: $RELATIVE_PATH"

    # Result is in $RESOLVED_PATH — no $() needed (avoids stdout capture of log messages).
    resolve_server_path "$FINACLE_APP" "$BANK_ID" "$RELATIVE_PATH"
    DEST_PATH="$RESOLVED_PATH"

    # Verify the bank directory exists on this server before attempting deployment.
    # If the bank directory is missing it means this server does not host that bank —
    # deploying anyway would silently create the directory, masking a routing error.
    # Extract the bank-level directory from the resolved path (everything up to and including the bank folder).
    BANK_BASE_DIR=$(echo "$DEST_PATH" | sed -E 's#(.*/(custom|Customization)/[0-9]+).*#\1#')
    if [ ! -d "$BANK_BASE_DIR" ]; then
        error_exit "Bank directory not found on this server: $BANK_BASE_DIR (bank_id=$BANK_ID). Verify this bank is hosted here."
    fi
    log "Bank directory confirmed : $BANK_BASE_DIR"

    deploy_file "$FILE_CHANGE_TYPE" "$SOURCE_FILE" "$DEST_PATH"

done < "$MANIFEST"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 3: APPLY FILE PERMISSIONS
# After all files have been deployed, reset permissions across both server directories.
# All J2EE files must be owned by applmgr with read+write+execute for the owner.
# The "|| true" prevents the script from failing if a directory does not exist.
# ---------------------------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "STEP 3: APPLYING FILE PERMISSIONS"
echo "============================================================"

log "Resetting permissions (owner: applmgr, mode: 755)..."

for dir in /equity_fe /finacle; do
    if [ -d "$dir" ]; then
        log "  Applying chmod 755 + chown applmgr on $dir..."
        chmod -R 755 "$dir"     || true
        chown -R applmgr "$dir" || true
    else
        log "  $dir not present on this server — skipping"
    fi
done

log "Permissions reset successfully"

# ---------------------------------------------------------------------------------------------------------------------
# EXECUTION SUMMARY
# Shows a complete breakdown of what happened during this deployment run.
# "Routed elsewhere" means those files are intentionally not deployed here —
# they will be handled by the other bank's pipeline run.
# ---------------------------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "                 DEPLOYMENT EXECUTION SUMMARY"
echo "============================================================"
echo "TARGET BANK                         : $TARGET_SERVER_GROUP"
echo "DEPLOY ENVIRONMENT                  : $DEPLOY_ENV"
echo "------------------------------------------------------------"
echo "TOTAL FILES IN MANIFEST COUNTER     : $TOTAL_FILES_IN_MANIFEST_COUNTER"
echo "FILES ROUTED ELSEWHERE COUNTER      : $FILES_ROUTED_ELSEWHERE_COUNTER  (handled by other bank's pipeline run)"
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
