#!/bin/bash

# ==================================================================================================
# SCRIPT : suScript.sh
# PURPOSE: SSH entrypoint called by the Azure CD agent on the Finacle server.
#          Transfers the staging directory to applmgr, then dispatches deploy-j2ee-uat.sh
#          as applmgr with the correct target and environment.
#
# USAGE  : suScript.sh <ip_address> <deploy_tag> <release_id> <deploy_env>
#
#   Example : suScript.sh 10.0.0.1 J2EE-group 487 uat
#
# AUTHOR : Kennedy Gatimu
# ==================================================================================================

# --------------------------------------------------------------------------------------------------
# ARGUMENTS
# Capture all positional arguments immediately so they are available for every section below.
# --------------------------------------------------------------------------------------------------
IP_ADDRESS=$1   # Finacle server IP — for tracing only
DEPLOY_TAG=$2   # Routing tag from the CD pipeline  e.g. J2EE-group
RELEASE_ID=$3   # Azure Release ID — used to name the isolated staging directory
DEPLOY_ENV=$4   # Environment — passed to deploy-j2ee-uat.sh for server path resolution

# --------------------------------------------------------------------------------------------------
# CONFIGURATION
# SOURCE_DIR must match the SCP target in the CD pipeline:
#   /tmp/j2ee-deploy-$(Release.ReleaseId)/
# Using the Release ID isolates each concurrent deployment in its own directory.
# --------------------------------------------------------------------------------------------------
SOURCE_DIR="/tmp/j2ee-deploy-${RELEASE_ID}"
FINACLE_APP_USER="applmgr"

# --------------------------------------------------------------------------------------------------
# DETECT FINACLE APP
# Determines whether this deployment is for fincore or crm by reading the first entry from the
# deployment manifest inside the artifact archive — without extracting the full archive.
# The manifest format is CHANGE_TYPE|FILE_PATH; the file path always starts with the app name.
#   e.g.  NEW|fincore/custom/group/54/cif/display/Account.xsl  →  fincore
#         MODIFIED|crm/customization/group/55/cif/Account.xsl  →  crm
# --------------------------------------------------------------------------------------------------
FINACLE_APP=$(tar -xOf "$SOURCE_DIR/j2ee-scripts.tar.gz" ./deployment-manifest.txt 2>/dev/null \
    | head -1 | cut -d'|' -f2 | cut -d'/' -f1)

[ -z "$FINACLE_APP" ] && FINACLE_APP="unknown"

# --------------------------------------------------------------------------------------------------
# STARTUP BANNER
# --------------------------------------------------------------------------------------------------
echo
echo "============================================================"
echo "         STARTING J2EE DEPLOYMENT DISPATCH SCRIPT"
echo "============================================================"
echo "START TIME    : $(date)"
echo
echo "FINACLE APP   : $FINACLE_APP"
echo "DEPLOY TAG    : $DEPLOY_TAG"
echo "DEPLOY ENV    : $DEPLOY_ENV"
echo "RELEASE ID    : $RELEASE_ID"
echo "SERVER IP     : $IP_ADDRESS"
echo

# --------------------------------------------------------------------------------------------------
# LOGGING UTILITIES
# --------------------------------------------------------------------------------------------------
log() {
    echo "[INFO] $1"
}

error_exit() {
    echo "[ERROR] $1"
    echo "[ERROR] Stopped at: $(date)"
    exit 1
}

# --------------------------------------------------------------------------------------------------
# ARGUMENT VALIDATION
# --------------------------------------------------------------------------------------------------
if [ -z "$DEPLOY_TAG" ]; then
    error_exit "Missing argument 2: DEPLOY_TAG. Expected: J2EE-group | J2EE-43 | J2EE-50 | J2EE-55 | J2EE-56"
fi

if [ -z "$RELEASE_ID" ]; then
    error_exit "Missing argument 3: RELEASE_ID. Expected: Azure \$(Release.ReleaseId)"
fi

if [ "$DEPLOY_ENV" != "prod" ] && [ "$DEPLOY_ENV" != "uat" ] && [ "$DEPLOY_ENV" != "sit" ]; then
    error_exit "Invalid DEPLOY_ENV: '$DEPLOY_ENV'. Expected: prod | uat | sit"
fi

# --------------------------------------------------------------------------------------------------
# FUNCTION: execute_j2ee_deploy
#
# Switches to applmgr via sudo su and runs deploy-j2ee-uat.sh via heredoc stdin.
# azurefin has NOPASSWD for "su - applmgr" but NOT for chown, so SOURCE_DIR ownership
# is never transferred. Instead, applmgr creates its own WORK_DIR, extracts and deploys
# from there, then cleans it up. azurefin cleans up SOURCE_DIR after the heredoc returns.
#
# The heredoc avoids needing "sudo su - applmgr -c '...'" (which requires extra sudoers
# permissions). Feeding commands via stdin matches the existing sudoers entry exactly:
#   NOPASSWD: /bin/su - applmgr   (no extra arguments)
#
# Args: $1 deploy_target  (group | 43 | 50 | 55 | 56)
#       $2 deploy_env     (prod | uat | sit)
# --------------------------------------------------------------------------------------------------
execute_j2ee_deploy() {
    local deploy_target=$1
    local deploy_env=$2
    local work_dir="/tmp/j2ee-work-${RELEASE_ID}"

    log "Running deployment as $FINACLE_APP_USER — app: $FINACLE_APP | target: $deploy_target | env: $deploy_env"
    log "Source directory : $SOURCE_DIR  (azurefin — tar readable by applmgr)"
    log "Work directory   : $work_dir    (created and owned by applmgr)"

    # Heredoc feeds commands via stdin — sudo sees "su - applmgr" with no extra args (matches sudoers).
    # Unescaped vars ($SOURCE_DIR, $work_dir, $FINACLE_APP, $deploy_target, $deploy_env) expand now
    # in the outer shell; \$deploy_exit_code is intentionally escaped to evaluate inside applmgr shell.
    sudo su - "$FINACLE_APP_USER" << SUEOF
log() { echo "[INFO] \$1"; }

log "Finacle application  : $FINACLE_APP"

log "Creating work directory: $work_dir"
mkdir -p $work_dir || { echo "[ERROR] mkdir failed for $work_dir"; exit 1; }

log "Extracting j2ee-scripts.tar.gz into $work_dir"
tar -xzf $SOURCE_DIR/j2ee-scripts.tar.gz -C $work_dir/ \
    || { echo "[ERROR] Extraction failed"; exit 1; }
log "Extraction complete"

log "Copying deployment script into work directory"
cp $SOURCE_DIR/deploy-j2ee-uat.sh $work_dir/deploy-j2ee-uat.sh \
    || { echo "[ERROR] Failed to copy deploy-j2ee-uat.sh from $SOURCE_DIR"; exit 1; }

log "Setting permissions and switching to working directory"
chmod +x $work_dir/deploy-j2ee-uat.sh || { echo "[ERROR] chmod failed"; exit 1; }
cd $work_dir                       || { echo "[ERROR] cd failed";    exit 1; }

log "Running deploy-j2ee-uat.sh --target $deploy_target --env $deploy_env"
bash $work_dir/deploy-j2ee-uat.sh --target $deploy_target --env $deploy_env
deploy_exit_code=\$?

log "Cleaning up work directory: $work_dir"
rm -rvf $work_dir
log "Work directory removed"

exit \$deploy_exit_code
SUEOF

    local su_exit=$?

    # azurefin cleans up SOURCE_DIR — it owns it and can delete it from /tmp
    log "Cleaning up staging directory: $SOURCE_DIR"
    rm -rf "$SOURCE_DIR"
    log "Staging directory removed"

    return $su_exit
}

# ==================================================================================================
# MAIN
# ==================================================================================================

# Extract the deploy target from the tag (e.g. "J2EE-group" → "group")
case "$DEPLOY_TAG" in
    "J2EE-"*)
        deploy_target="${DEPLOY_TAG#J2EE-}"
        log "Dispatch — app: $FINACLE_APP | target: $deploy_target | env: $DEPLOY_ENV"
        execute_j2ee_deploy "$deploy_target" "$DEPLOY_ENV"
        ;;
    *)
        error_exit "Unknown deploy tag: '$DEPLOY_TAG'. Expected: J2EE-group | J2EE-43 | J2EE-50 | J2EE-55 | J2EE-56"
        ;;
esac

deploy_status=$?

if [ "$deploy_status" -eq 0 ]; then
    status_line="SUCCESS"
else
    status_line="FAILED (exit code: $deploy_status)"
fi

echo "============================================================"
echo "                   DISPATCH SUMMARY"
echo "============================================================"
echo "  FINACLE APP   : $FINACLE_APP"
echo "  DEPLOY TAG    : $DEPLOY_TAG"
echo "  DEPLOY TARGET : $deploy_target"
echo "  DEPLOY ENV    : $DEPLOY_ENV"
echo "  SERVER IP     : $IP_ADDRESS"
echo "  STATUS        : $status_line"
echo "  END TIME      : $(date)"
echo "============================================================"
echo

exit $deploy_status
