#!/bin/bash

# ==================================================================================================
# SCRIPT: suScript.sh
#
# PURPOSE:
#   SSH entrypoint called by the Azure CD agent on the Finacle server.
#   Transfers ownership of the staging directory to the Finacle app user (applmgr),
#   then dispatches deploy-j2ee.sh as applmgr with the correct target and environment.
#
# USAGE:
#   suScript.sh <ip_address> <deploy_tag> <release_id> <deploy_env>
#
#   <deploy_tag>  : J2EE-group                           (SIT — all banks share one Group server)
#   <release_id>  : Azure $(Release.ReleaseId)           (e.g. 487)
#   <deploy_env>  : prod | uat | sit
#
#   Example : suScript.sh 10.0.0.1 J2EE-group 487 sit
#
# AUTHOR: Kennedy Gatimu
# ==================================================================================================

# --------------------------------------------------------------------------------------------------
# ARGUMENTS
# Capture all positional arguments immediately so they are available for every section below.
# --------------------------------------------------------------------------------------------------
IP_ADDRESS=$1   # Finacle server IP — for tracing only
DEPLOY_TAG=$2   # Routing tag from the CD pipeline  e.g. J2EE-group
RELEASE_ID=$3   # Azure Release ID — used to name the isolated staging directory
DEPLOY_ENV=$4   # Environment — passed to deploy-j2ee.sh for server path resolution

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
    error_exit "Missing argument 2: DEPLOY_TAG. Expected: J2EE-group"
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
# Runs the deployment as applmgr in two steps:
#   1. sudo chown  — transfers SOURCE_DIR ownership from azurefin to applmgr
#   2. sudo su     — switches to applmgr and runs deploy-j2ee.sh via heredoc stdin
#
# The heredoc avoids needing "sudo su - applmgr -c '...'" (which requires extra sudoers
# permissions). Feeding commands via stdin matches the existing sudoers entry exactly:
#   NOPASSWD: /bin/su - applmgr   (no extra arguments)
#
# Args: $1 deploy_target  (group)
#       $2 deploy_env     (prod | uat | sit)
# --------------------------------------------------------------------------------------------------
execute_j2ee_deploy() {
    local deploy_target=$1
    local deploy_env=$2

    # Give applmgr ownership of SOURCE_DIR so it can write, extract, and clean up inside it.
    log "Transferring $SOURCE_DIR ownership to $FINACLE_APP_USER..."
    sudo chown -R "$FINACLE_APP_USER":"$FINACLE_APP_USER" "$SOURCE_DIR" \
        || error_exit "chown failed for $SOURCE_DIR"
    log "Ownership transferred"

    log "Running deployment as $FINACLE_APP_USER — app: $FINACLE_APP | target: $deploy_target | env: $deploy_env"
    log "Working directory: $SOURCE_DIR"

    # Heredoc feeds commands via stdin — sudo sees "su - applmgr" with no extra args (matches sudoers).
    # Unescaped vars ($SOURCE_DIR, $FINACLE_APP, $deploy_target, $deploy_env) expand now in the outer shell;
    # \$deploy_exit_code is intentionally escaped so it evaluates inside the applmgr shell.
    sudo su - "$FINACLE_APP_USER" << SUEOF
log() { echo "[INFO] \$1"; }

log "Finacle application  : $FINACLE_APP"
log "Extracting j2ee-scripts.tar.gz into $SOURCE_DIR"
tar -xzf $SOURCE_DIR/j2ee-scripts.tar.gz -C $SOURCE_DIR/ \
    || { echo "[ERROR] Extraction failed"; exit 1; }
log "Extraction complete"

log "Setting permissions and switching to working directory"
chmod +x $SOURCE_DIR/deploy-j2ee.sh  || { echo "[ERROR] chmod failed"; exit 1; }
cd $SOURCE_DIR                        || { echo "[ERROR] cd failed";    exit 1; }

log "Running deploy-j2ee.sh --target $deploy_target --env $deploy_env"
bash $SOURCE_DIR/deploy-j2ee.sh --target $deploy_target --env $deploy_env
deploy_exit_code=\$?

log "Cleaning up staging directory: $SOURCE_DIR"
rm -rvf $SOURCE_DIR
log "Cleanup complete — deployment session ended"

exit \$deploy_exit_code
SUEOF

    return $?
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
        error_exit "Unknown deploy tag: '$DEPLOY_TAG'. Expected: J2EE-group"
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
