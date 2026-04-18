#!/bin/bash

# ==================================================================================================
# SCRIPT : deploy-j2ee-prod.sh
# PURPOSE: Deploy J2EE customization files (fincore / crm) to the correct PROD Finacle server.
#          Reads deployment-manifest.txt and copies, backs up, or deletes each file on the target.
#
# USAGE  : deploy-j2ee-prod.sh --target <group|50|56|55> --server-type <branch|fi>
#
#   --target group              : Group Branch or FI server (banks 11, 43, 54) — requires --server-type
#   --target 50                 : Rwanda Branch or FI server — requires --server-type
#   --target 56                 : Uganda Branch or FI server — requires --server-type
#   --target 55                 : Tanzania server (no --server-type needed — single server)
#   --server-type branch|fi     : selects which physical server to deploy to (not applicable for 55)
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
# PROD SERVER BASE PATHS
# Group has two separate physical servers — Branch (EQPROD) and FI (EQPRODFI) — each with its own base path.
# Rwanda (50) and Uganda (56) also have Branch and FI servers but share the same base path on both;
#   the CD pipeline SSH target IP distinguishes the machine, not the path.
# Tanzania (55) has a single server covering both Branch and FI — no split needed.
# To update a path, edit the constant here only — it is used throughout the script.
# ---------------------------------------------------------------------------------------------------------------------
GROUP_BRANCH_FINCORE_BASE="/equity_fe/EQPROD/FrontEnd/FinacleApps/finbranch.war/custom"
GROUP_BRANCH_CRM_BASE="/equity_fe/EQPROD/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization"

GROUP_FI_FINCORE_BASE="/equity_fe/EQPRODFI/FrontEnd/FinacleApps/finbranch.war/custom"
GROUP_FI_CRM_BASE="/equity_fe/EQPRODFI/FrontEnd/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization"

SUBSIDIARY_FINCORE_BASE="/u01/equity_fe/FinacleApps/finbranch.war/custom"
SUBSIDIARY_CRM_BASE="/u01/equity_fe/FinacleApps/FinacleCRM.ear/FinacleCRM.war/Customization"

TZ_FINCORE_BASE="/finacle/EQTZPROD/Fin10218/J2EE/Deployment/finbranch.ear/finbranch.war/custom"
TZ_CRM_BASE="/finacle/EQTZPROD/Fin10218/J2EE/Deployment/FinacleCRM.ear/FinacleCRM.war/Customization"

# ---------------------------------------------------------------------------------------------------------------------
# EXECUTION COUNTERS AND GLOBALS
# All counter names end with _COUNTER and are printed in the summary at the end.
# RESOLVED_PATH is a global used by resolve_server_path() to return its result without $()
# ---------------------------------------------------------------------------------------------------------------------
RESOLVED_PATH=""

TOTAL_FILES_IN_MANIFEST_COUNTER=0
NEW_FILES_DEPLOYED_COUNTER=0
MODIFIED_FILES_DEPLOYED_COUNTER=0
DELETED_FILES_DEPLOYED_COUNTER=0
SKIPPED_FILES_COUNTER=0
SUCCESSFUL_DEPLOYMENTS_COUNTER=0
FAILED_DEPLOYMENTS_COUNTER=0

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
# Builds the full server destination path from TARGET_SERVER_GROUP, TARGET_SERVER_TYPE, finacle_app, and bank_id.
#   group  (branch) : GROUP_BRANCH_FINCORE/CRM_BASE  — banks 11, 43, 54
#   group  (fi)     : GROUP_FI_FINCORE/CRM_BASE      — banks 11, 43, 54
#   50|56  (branch|fi) : SUBSIDIARY_FINCORE/CRM_BASE — same path; CD pipeline SSH IP differs per server type
#   55              : TZ_FINCORE/CRM_BASE             — single server, no branch/fi split
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
            # Group has two physical machines — Branch (EQPROD) and FI (EQPRODFI).
            # TARGET_SERVER_TYPE determines which base path to use.
            # DRC (43) is currently on the Group server alongside 11 and 54.
            # When DRC receives its own dedicated PROD servers, update the routing here and
            # add J2EE-43-branch / J2EE-43-fi stages to the CD pipeline.
            if [ "$finacle_app" == "fincore" ]; then
                if [ "$TARGET_SERVER_TYPE" == "branch" ]; then
                    case "$bank_id" in
                        global)    base_path="$GROUP_BRANCH_FINCORE_BASE" ;;
                        11|43|54)  base_path="$GROUP_BRANCH_FINCORE_BASE/$bank_id" ;;
                        *)         error_exit "Unknown bank_id '$bank_id' for group/branch target (fincore). Expected: 11 | 43 | 54 | global" ;;
                    esac
                elif [ "$TARGET_SERVER_TYPE" == "fi" ]; then
                    case "$bank_id" in
                        global)    base_path="$GROUP_FI_FINCORE_BASE" ;;
                        11|43|54)  base_path="$GROUP_FI_FINCORE_BASE/$bank_id" ;;
                        *)         error_exit "Unknown bank_id '$bank_id' for group/fi target (fincore). Expected: 11 | 43 | 54 | global" ;;
                    esac
                fi
            elif [ "$finacle_app" == "crm" ]; then
                if [ "$TARGET_SERVER_TYPE" == "branch" ]; then
                    case "$bank_id" in
                        global)    base_path="$GROUP_BRANCH_CRM_BASE" ;;
                        11|43|54)  base_path="$GROUP_BRANCH_CRM_BASE/$bank_id" ;;
                        *)         error_exit "Unknown bank_id '$bank_id' for group/branch target (crm). Expected: 11 | 43 | 54 | global" ;;
                    esac
                elif [ "$TARGET_SERVER_TYPE" == "fi" ]; then
                    case "$bank_id" in
                        global)    base_path="$GROUP_FI_CRM_BASE" ;;
                        11|43|54)  base_path="$GROUP_FI_CRM_BASE/$bank_id" ;;
                        *)         error_exit "Unknown bank_id '$bank_id' for group/fi target (crm). Expected: 11 | 43 | 54 | global" ;;
                    esac
                fi
            else
                error_exit "Unknown Finacle app '$finacle_app' for group target. Expected: fincore | crm"
            fi
            ;;

        50|56)
            # Rwanda (50) and Uganda (56) — Branch and FI servers share the same base path.
            # TARGET_SERVER_TYPE (branch|fi) determines which physical machine the CD pipeline SSH's into.
            # Global files deploy to the server root; local files get a bank subfolder.
            if [ "$finacle_app" == "fincore" ]; then
                case "$bank_id" in
                    global)    base_path="$SUBSIDIARY_FINCORE_BASE" ;;
                    50|56)     base_path="$SUBSIDIARY_FINCORE_BASE/$bank_id" ;;
                    *)         error_exit "Unknown bank_id '$bank_id' for subsidiary target '$TARGET_SERVER_GROUP' (fincore). Expected: $TARGET_SERVER_GROUP | global" ;;
                esac
            elif [ "$finacle_app" == "crm" ]; then
                case "$bank_id" in
                    global)    base_path="$SUBSIDIARY_CRM_BASE" ;;
                    50|56)     base_path="$SUBSIDIARY_CRM_BASE/$bank_id" ;;
                    *)         error_exit "Unknown bank_id '$bank_id' for subsidiary target '$TARGET_SERVER_GROUP' (crm). Expected: $TARGET_SERVER_GROUP | global" ;;
                esac
            else
                error_exit "Unknown Finacle app '$finacle_app' for subsidiary target '$TARGET_SERVER_GROUP'. Expected: fincore | crm"
            fi
            ;;

        55)
            # Tanzania — single server covering both Branch and FI users.
            # Local files always include /55/ in the server path; global files deploy to the root.
            if [ "$finacle_app" == "fincore" ]; then
                case "$bank_id" in
                    global)    base_path="$TZ_FINCORE_BASE" ;;
                    55)        base_path="$TZ_FINCORE_BASE/55" ;;
                    *)         error_exit "Unknown bank_id '$bank_id' for Tanzania target (fincore). Expected: 55 | global" ;;
                esac
            elif [ "$finacle_app" == "crm" ]; then
                case "$bank_id" in
                    global)    base_path="$TZ_CRM_BASE" ;;
                    55)        base_path="$TZ_CRM_BASE/55" ;;
                    *)         error_exit "Unknown bank_id '$bank_id' for Tanzania target (crm). Expected: 55 | global" ;;
                esac
            else
                error_exit "Unknown Finacle app '$finacle_app' for Tanzania target. Expected: fincore | crm"
            fi
            ;;

        *)
            error_exit "Unknown TARGET_SERVER_GROUP: '$TARGET_SERVER_GROUP'. Expected: group | 50 | 56 | 55"
            ;;

    esac

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

    timestamp=$(date +"%Y%m%d_%H%M%S")

    base_path=$(echo "$file_on_server" | sed -E 's#(.*/(custom|Customization)(/[0-9]+)?).*#\1#')
    relative_path=$(echo "$file_on_server" | sed -E 's#.*/(custom|Customization)(/[0-9]+)?/##')

    if [ -z "$base_path" ] || [ -z "$relative_path" ]; then
        error_exit "Could not parse server path for backup: $file_on_server"
    fi

    log "  Bank base directory  : $base_path"
    log "  File relative path   : $relative_path"

    backup_folder="$base_path/backup/$(dirname "$relative_path")"

    log "  Backup folder        : $backup_folder"
    mkdir -p "$backup_folder" || error_exit "Failed to create backup folder: $backup_folder"

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
            log "Deploying new file..."
            mkdir -p "$(dirname "$dest_path")"
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
                log "File not found on server — deletion skipped : $dest_path"
            fi
            ;;

        *)
            FAILED_DEPLOYMENTS_COUNTER=$((FAILED_DEPLOYMENTS_COUNTER + 1))
            error_exit "Unrecognised file change type in manifest: '$file_change_type'. Expected NEW, MODIFIED, or DELETED."
            ;;
    esac
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: handle_global_file
# Deploys a global file to the server root — no bank folder in the destination path.
# Applies to both Group global (branch/group/global/...) and subsidiary global (<bank_id>/global/...) files.
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

    resolve_server_path "$finacle_app" "global" "$path_after_global"
    dest_path="$RESOLVED_PATH"
    log "  Destination path     : $dest_path"

    deploy_file "$file_change_type" "$source_file" "$dest_path"
    log "Global file deployment complete"
}

# ---------------------------------------------------------------------------------------------------------------------
# FUNCTION: should_deploy_file
# Returns 0 if the file belongs to the current --target/--server-type pair, 1 if it should be skipped.
# Fincore paths : f2=branch|fi|tanzania  f3=group|50|56|55  — routing key is f2+f3
# CRM paths     : f3=branch|fi|tanzania  f4=group|50|56|55  — routing key is f3+f4
# Files for other targets are left for their own CD stage to handle.
# Args: $1 file_path — full file path from the manifest
# ---------------------------------------------------------------------------------------------------------------------
should_deploy_file() {
    local file_path=$1
    local finacle_app server_type routing_target

    finacle_app=$(echo "$file_path" | cut -d '/' -f1)

    if [ "$finacle_app" == "fincore" ]; then
        server_type=$(echo "$file_path" | cut -d '/' -f2)    # branch | fi | tanzania
        routing_target=$(echo "$file_path" | cut -d '/' -f3) # group  | 50 | 56 | 55
    else
        # crm/customization/<server_type>/<routing_target>/...
        server_type=$(echo "$file_path" | cut -d '/' -f3)
        routing_target=$(echo "$file_path" | cut -d '/' -f4)
    fi

    # Tanzania has no server_type distinction — match on server_type=tanzania and routing_target=55
    if [ "$TARGET_SERVER_GROUP" == "55" ]; then
        if [ "$server_type" == "tanzania" ] && [ "$routing_target" == "55" ]; then
            return 0
        fi
    else
        if [ "$server_type" == "$TARGET_SERVER_TYPE" ] && [ "$routing_target" == "$TARGET_SERVER_GROUP" ]; then
            return 0
        fi
    fi

    log "  Skipping: $file_path — belongs to '$server_type/$routing_target', current target is '$TARGET_SERVER_TYPE/$TARGET_SERVER_GROUP'"
    SKIPPED_FILES_COUNTER=$((SKIPPED_FILES_COUNTER + 1))
    return 1
}

# =====================================================================================================================
# SCRIPT BODY — all functions are defined above; execution starts here
# =====================================================================================================================

echo "============================================================"
echo "STEP 0: ARGUMENT PARSING AND VALIDATION"
echo "============================================================"

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0A: PARSE ARGUMENTS
# --target group|50|56|55       : required — identifies which PROD server group this run targets
# --server-type branch|fi       : required for group, 50, 56 — selects Branch or FI physical machine
#                                 not applicable for Tanzania (55) — single server, no split
# --env                         : accepted for suScript.sh compatibility; no effect on paths
# ---------------------------------------------------------------------------------------------------------------------

TARGET_SERVER_GROUP=""
TARGET_SERVER_TYPE=""
DEPLOY_ENV=""

log "Parsing script arguments..."

while [ "$#" -gt 0 ]; do
    case "$1" in
        --target)
            TARGET_SERVER_GROUP="$2"
            log "  --target      : '$TARGET_SERVER_GROUP'"
            shift 2 ;;
        --server-type)
            TARGET_SERVER_TYPE="$2"
            log "  --server-type : '$TARGET_SERVER_TYPE'"
            shift 2 ;;
        --env)
            DEPLOY_ENV="$2"
            log "  --env         : '$DEPLOY_ENV' (informational only — PROD paths are hardcoded constants)"
            shift 2 ;;
        *)
            error_exit "Unknown argument: '$1'. Usage: deploy-j2ee-prod.sh --target <group|50|56|55> [--server-type <branch|fi>]" ;;
    esac
done

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0B: VALIDATE --target AND --server-type
# Group, Rwanda (50), and Uganda (56) each have separate Branch and FI servers — --server-type is required.
# Tanzania (55) has a single server — --server-type is not applicable.
# ---------------------------------------------------------------------------------------------------------------------
log "Validating arguments..."

if [ -z "$TARGET_SERVER_GROUP" ]; then
    error_exit "Missing required argument: --target. Usage: deploy-j2ee-prod.sh --target <group|50|56|55> [--server-type <branch|fi>]"
fi

case "$TARGET_SERVER_GROUP" in
    group|50|56)
        if [ -z "$TARGET_SERVER_TYPE" ]; then
            error_exit "Missing required argument: --server-type. Required for --target $TARGET_SERVER_GROUP. Expected: branch | fi"
        fi
        case "$TARGET_SERVER_TYPE" in
            branch|fi)
                log "  --target '$TARGET_SERVER_GROUP' --server-type '$TARGET_SERVER_TYPE' : valid"
                ;;
            *)
                error_exit "Invalid --server-type value: '$TARGET_SERVER_TYPE'. Expected: branch | fi"
                ;;
        esac
        ;;
    55)
        log "  --target '55' : valid (Tanzania — single server, no --server-type required)"
        ;;
    *)
        error_exit "Invalid --target value: '$TARGET_SERVER_GROUP'. PROD accepts: group | 50 | 56 | 55"
        ;;
esac

# ---------------------------------------------------------------------------------------------------------------------
# STEP 0C: STARTUP SUMMARY — confirm all resolved config before deployment begins
# ---------------------------------------------------------------------------------------------------------------------
echo "------------------------------------------------------------"
echo "  DEPLOYMENT CONFIGURATION"
echo "------------------------------------------------------------"
echo "  Environment      : PROD"
echo "  Target           : $TARGET_SERVER_GROUP"
echo "  Server type      : ${TARGET_SERVER_TYPE:-N/A (Tanzania — single server)}"
echo "  Manifest file    : $MANIFEST"
echo "  Working directory: $WORKING_DIR"
echo "------------------------------------------------------------"

case "$TARGET_SERVER_GROUP" in
    group)
        if [ "$TARGET_SERVER_TYPE" == "branch" ]; then
            echo "  Server           : Group Branch server (EQPROD)"
            echo "  Banks            : 11 (South Sudan), 43 (DRC), 54 (Kenya)"
            echo "  Fincore base     : $GROUP_BRANCH_FINCORE_BASE"
            echo "  CRM base         : $GROUP_BRANCH_CRM_BASE"
        elif [ "$TARGET_SERVER_TYPE" == "fi" ]; then
            echo "  Server           : Group FI server (EQPRODFI)"
            echo "  Banks            : 11 (South Sudan), 43 (DRC), 54 (Kenya)"
            echo "  Fincore base     : $GROUP_FI_FINCORE_BASE"
            echo "  CRM base         : $GROUP_FI_CRM_BASE"
        fi
        ;;
    50|56)
        echo "  Server           : Dedicated subsidiary server ($TARGET_SERVER_TYPE)"
        echo "  Bank             : $TARGET_SERVER_GROUP"
        echo "  Note             : Branch and FI share the same path — SSH target IP differs per server type"
        echo "  Fincore base     : $SUBSIDIARY_FINCORE_BASE"
        echo "  CRM base         : $SUBSIDIARY_CRM_BASE"
        ;;
    55)
        echo "  Server           : Tanzania server (EQTZPROD)"
        echo "  Bank             : 55 (Tanzania)"
        echo "  Note             : Single server — covers both Branch and FI users"
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
#   e.g. MODIFIED|fincore/branch/group/54/cif/display/Account.xsl
#        NEW|fincore/fi/50/local/cif/js/custom.js
#        DELETED|crm/customization/branch/group/global/menu/menu.xml
#
# Path segment layout (f = field position from cut -d'/'):
#   Fincore group   : f1=app  f2=branch|fi  f3=group    f4=bank_id|global  f5-=relative_path
#   Fincore sub     : f1=app  f2=branch|fi  f3=bank_id  f4=local|global    f5-=relative_path
#   Fincore Tanzania: f1=app  f2=tanzania   f3=55        f4=local|global    f5-=relative_path
#   CRM group       : f1=crm  f2=cust.  f3=branch|fi  f4=group    f5=bank_id|global  f6-=relative_path
#   CRM sub/TZ      : f1=crm  f2=cust.  f3=branch|fi  f4=bank_id  f5=local|global    f6-=relative_path
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

    FINACLE_APP=$(echo "$FILE_PATH" | cut -d '/' -f1)
    log "Finacle application : $FINACLE_APP"

    if ! should_deploy_file "$FILE_PATH"; then
        continue
    fi

    log "File confirmed for '$TARGET_SERVER_TYPE/$TARGET_SERVER_GROUP' — proceeding with deployment"

    if [ "$FILE_CHANGE_TYPE" == "NEW" ]; then
        SOURCE_FILE="$WORKING_DIR/newFiles/$FILE_PATH"
    elif [ "$FILE_CHANGE_TYPE" == "MODIFIED" ]; then
        SOURCE_FILE="$WORKING_DIR/modifiedFiles/$FILE_PATH"
    elif [ "$FILE_CHANGE_TYPE" == "DELETED" ]; then
        SOURCE_FILE=""
    else
        error_exit "Unrecognised file change type in manifest: '$FILE_CHANGE_TYPE'"
    fi

    log "Source file : ${SOURCE_FILE:-N/A (deletion)}"

    # ---- PATH EXTRACTION AND ROUTING ----------------------------------------------------------------
    # Extract server_type, routing_target, bank_or_type, and relative_path.
    # Fincore has no 'custom/' segment, so field positions are one less than CRM.

    if [ "$FINACLE_APP" == "fincore" ]; then
        # fincore/<server_type>/<routing_target>/<bank_or_type>/<relative_path>
        SERVER_TYPE=$(echo "$FILE_PATH" | cut -d '/' -f2)      # branch | fi | tanzania
        ROUTING_TARGET=$(echo "$FILE_PATH" | cut -d '/' -f3)   # group  | 50 | 56 | 55
        BANK_OR_TYPE=$(echo "$FILE_PATH" | cut -d '/' -f4)     # global | local | 11 | 43 | 54 | 55
        RELATIVE_PATH=$(echo "$FILE_PATH" | cut -d '/' -f5-)
    elif [ "$FINACLE_APP" == "crm" ]; then
        # crm/customization/<server_type>/<routing_target>/<bank_or_type>/<relative_path>
        SERVER_TYPE=$(echo "$FILE_PATH" | cut -d '/' -f3)
        ROUTING_TARGET=$(echo "$FILE_PATH" | cut -d '/' -f4)
        BANK_OR_TYPE=$(echo "$FILE_PATH" | cut -d '/' -f5)
        RELATIVE_PATH=$(echo "$FILE_PATH" | cut -d '/' -f6-)
    else
        error_exit "Unrecognised Finacle app '$FINACLE_APP' in path: $FILE_PATH. Expected: fincore | crm"
    fi

    if [ "$TARGET_SERVER_GROUP" == "group" ]; then

        # Group path: BANK_OR_TYPE is a bank ID (11/43/54) or "global"
        if [ "$BANK_OR_TYPE" == "global" ]; then
            log "Group global file — server type: $TARGET_SERVER_TYPE | relative path: $RELATIVE_PATH"
            handle_global_file "$FILE_CHANGE_TYPE" "$FINACLE_APP" "$RELATIVE_PATH" "$SOURCE_FILE"
            continue
        fi

        BANK_ID="$BANK_OR_TYPE"
        log "Group bank-specific file — server type: $TARGET_SERVER_TYPE | bank: $BANK_ID | relative path: $RELATIVE_PATH"

    else

        # Subsidiary or Tanzania path: BANK_OR_TYPE is "local" or "global"
        BANK_ID="$TARGET_SERVER_GROUP"
        PATH_TYPE="$BANK_OR_TYPE"

        if [ "$PATH_TYPE" == "global" ]; then
            log "Subsidiary global file (bank $BANK_ID) — relative path: $RELATIVE_PATH"
            handle_global_file "$FILE_CHANGE_TYPE" "$FINACLE_APP" "$RELATIVE_PATH" "$SOURCE_FILE"
            continue
        fi

        log "Subsidiary local file — bank: $BANK_ID | relative path: $RELATIVE_PATH"

    fi

    resolve_server_path "$FINACLE_APP" "$BANK_ID" "$RELATIVE_PATH"
    DEST_PATH="$RESOLVED_PATH"

    deploy_file "$FILE_CHANGE_TYPE" "$SOURCE_FILE" "$DEST_PATH"

done < "$MANIFEST"

# ---------------------------------------------------------------------------------------------------------------------
# EXECUTION SUMMARY
# ---------------------------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "                 DEPLOYMENT EXECUTION SUMMARY"
echo "============================================================"
echo "ENVIRONMENT                         : PROD"
echo "TARGET SERVER GROUP                 : $TARGET_SERVER_GROUP"
echo "SERVER TYPE                         : ${TARGET_SERVER_TYPE:-N/A (Tanzania)}"

case "$TARGET_SERVER_GROUP" in
    group)
        if [ "$TARGET_SERVER_TYPE" == "branch" ]; then
            echo "SERVER                              : Group Branch (EQPROD)"
            echo "BANKS ON SERVER                     : 11 (South Sudan), 43 (DRC), 54 (Kenya)"
        elif [ "$TARGET_SERVER_TYPE" == "fi" ]; then
            echo "SERVER                              : Group FI (EQPRODFI)"
            echo "BANKS ON SERVER                     : 11 (South Sudan), 43 (DRC), 54 (Kenya)"
        fi
        ;;
    50)  echo "BANK ON SERVER                      : 50 (Rwanda)" ;;
    56)  echo "BANK ON SERVER                      : 56 (Uganda)" ;;
    55)  echo "BANK ON SERVER                      : 55 (Tanzania)" ;;
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
