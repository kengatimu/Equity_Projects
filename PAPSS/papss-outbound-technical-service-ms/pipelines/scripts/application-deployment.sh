#!/bin/bash

# -------------------------------------------------------------------------------------------------------------------- #
#   NOTE: DO NOT change or update this script file Manually
#
#   This script performs the following tasks for application deployment:
#     1. Creates required directories (drop, tanuki, and deploy directories).
#     2. Copies deployment artifacts and extracts them to relevant paths.
#     3. Sets up the environment and starts the application.
# -------------------------------------------------------------------------------------------------------------------- #

#set -e # Exit immediately on error (exits which are non zero)
#set -o pipefail # Capture errors in pipes

echo
echo "------------------------------- INFO: APPLICATION DEPLOYMENT STARTING... --------------------------------"

# Retrieve the application path from the release pipeline arguments
APP_PATH=$1
SERVER_PORT=$2

# Validate APP_PATH and SERVER_PORT
if [[ -z "$APP_PATH" || -z "$SERVER_PORT" ]]; then
  echo "ERROR: APP_PATH and SERVER_PORT must be specified as arguments."
  exit 1
fi

# Tanuki variables
LIB_DIR="${APP_PATH}/lib"
BIN_DIR="${APP_PATH}/bin"
CONF_DIR="${APP_PATH}/conf"
LOGS_DIR="${APP_PATH}/logs"

# OTHER Variables
DROP_DIR="${APP_PATH}/drop"
DEPLOY_DIR="${APP_PATH}/deploy"
BACK_UP_DIR="${APP_PATH}/backup"
DEPLOYMENT_TAR="/tmp/deployment_directory.tar.gz"

create_directory() {
	local directory_name=$1
	echo "INFO: Request to Create Directory ${directory_name} Starting..."

	if [ ! -d "${directory_name}" ]; then
		echo "INFO: Directory ${directory_name} DOES NOT EXIST. Creating the directory ${directory_name}..."
		mkdir -vp "${directory_name}"
	fi
}

re_create_directory() {
  local directory_name=$1
  echo "INFO: Request to Re-Create Directory ${directory_name} Starting..."

    if [ -d "${directory_name}" ]; then
      echo "INFO: Directory ${directory_name} exists. Recreating..."
      rm -rf "${directory_name}" || true
    fi
    mkdir -vp "${directory_name}"
}

# Copy and extract deployment artifacts
extract_tar_file() {
  echo "INFO: Extracting Deployment Artifacts Starting..."

  # Recreate drop directory for storing extracted files
  re_create_directory "${DROP_DIR}"

  if [ -f "${DEPLOYMENT_TAR}" ]; then
    echo "INFO: Copying ${DEPLOYMENT_TAR} to ${DROP_DIR}..."
    cp "${DEPLOYMENT_TAR}" "${DROP_DIR}"

    echo "INFO: Extracting ${DEPLOYMENT_TAR}..."
    if ! tar -xzf "${DEPLOYMENT_TAR}" -C "${DROP_DIR}"; then
      echo "ERROR: Failed to extract ${DEPLOYMENT_TAR}. Exiting..."
      exit 1
    else
      echo "INFO: ${DEPLOYMENT_TAR} Extracted Successfully."
    fi
  else
    echo "ERROR: Deployment TAR file ${DEPLOYMENT_TAR} not found. Exiting..."
    exit 1
  fi
}

# Get the start script
get_application_start_script() {
  # Find the first file with .sh extension
  APPLICATION_START_FILE=""
  for file in "${DROP_DIR}/tanuki/bin"/*.sh; do
    if [ -f "$file" ]; then
      APPLICATION_START_FILE=$(basename "$file")
      START_SCRIPT="${BIN_DIR}/${APPLICATION_START_FILE}"
      break
    fi
  done
}

# Stop all running instances of the application
check_and_kill_running_process() {
  echo "INFO: Stopping Application Process..."

  # Stop the application gracefully using the application's stop mechanism
  if [[ -x "${START_SCRIPT}" ]]; then
    echo "INFO: Attempting to stop the application using ${START_SCRIPT} stop..."
    "$START_SCRIPT" stop || echo "ERROR: Stopping application failed!"
    sleep 5
  else
    echo "WARNING: ${START_SCRIPT} not found or not executable. Skipping stop operation..."
  fi

  # Retrieve PID of the process using the port.
  echo "INFO: Checking and terminating any process running on port ${SERVER_PORT}..."

  # Handle scenarios where no netstat produces no result - empty prompt
  netstat_output=$(netstat -nlp 2>&1 | grep ":${SERVER_PORT} ")
  echo "DEBUG: netstat output: $netstat_output"

  # Check if netstat output is empty (no process on the port)
  if [[ -z "$netstat_output" ]]; then
    echo "INFO: No process found on port ${SERVER_PORT}. Proceeding with deployment..."
    return
  fi

  # Extract PID if a process is found
  pid=$(echo "$netstat_output" | awk '{print $NF}' | cut -d'/' -f1)

  # Return if no PID is found
  if [[ -z "$pid" ]]; then
    echo "INFO: No PID found for process on port ${SERVER_PORT}."
    return
  fi

  echo "INFO: Current PID: ${pid}"
  echo "INFO: Process found on port ${SERVER_PORT} with PID: ${pid}. Attempting to terminate..."

  # Attempt graceful termination
  kill -TERM "${pid}" 2>/dev/null
  echo "INFO: Sent SIGTERM to PID ${pid}. Waiting for process termination..."
  sleep 5

  # Retry mechanism for termination
  for attempt in {1..3}; do
    if ! ps -p "${pid}" > /dev/null 2>&1; then
      echo "INFO: Process ${pid} terminated successfully."
      return
    fi
    echo "WARNING: Process ${pid} still running. Retrying termination (Attempt ${attempt}/3)..."
    kill -9 "${pid}" 2>/dev/null
    sleep 5
  done

  # Final validation
  if ps -p "${pid}" > /dev/null 2>&1; then
    echo "ERROR: Failed to terminate process with PID: ${pid} after multiple attempts. Exiting..."
    exit 1
  fi

  echo "INFO: Process ${pid} terminated successfully."
}

backup_files() {
  file_path=$1
  echo "INFO: File ${file_path} Backup Request Starting..."

  # Define current timestamp
  timeStamp=$(date +"%Y-%m-%dT%H%M%S")

  if [ -f "${file_path}" ];
    then
      echo "INFO: Renaming ${file_path} To ${file_path}_${timeStamp}"
      mv -v "${file_path}" "${file_path}_${timeStamp}"

      echo "INFO: Moving ${file_path}_${timeStamp} To ${BACK_UP_DIR}"
      mv -v "${file_path}_${timeStamp}" "${BACK_UP_DIR}"
  else
    echo "INFO: File ${file_path} Does Not Exist..."
  fi
}

backup_all_files() {
  source_pattern=$1
  echo "INFO: Backing up files matching pattern: ${source_pattern}"

  found=false
  for file in $source_pattern; do
    if [ -f "$file" ]; then
      backup_files "$file"
      found=true
    fi
  done

  if [ "$found" = false ]; then
    echo "WARNING: No files matching pattern '${source_pattern}' found for backup."
  fi
}

# Function to process JAR files in a directory and copy them to a destination
process_jar_files() {
  source_dir=$1
  destination_dir=$2
  found=false

  for jar_file in "${source_dir}"/*.jar; do
    if [ -f "$jar_file" ]; then
      echo "INFO: Found JAR file: ${jar_file}. Copying to ${destination_dir}..."
      copy_files "$jar_file" "$destination_dir"
      found=true
    fi
  done

  if [ "$found" = false ]; then
    echo "ERROR: No JAR files found in ${source_dir}. Exiting..."
    exit 1
  fi
}

# Update tanuki directories
copy_tanuki_files() {
  echo "INFO: Update Tanuki Directories Starting..."
  JAR_FILE_DIR="${DROP_DIR}/app"
  INCOMING_APM_DIR="${DROP_DIR}/apm"
  INCOMING_BIN_DIR="${DROP_DIR}/tanuki/bin"
  INCOMING_CONF_DIR="${DROP_DIR}/tanuki/conf"
  INCOMING_LIB_DIR="${DROP_DIR}/tanuki/lib"

  # Handle bin directory
  if [ -d "${INCOMING_BIN_DIR}" ]; then
    # Create backup directory
    create_directory "${BACK_UP_DIR}"

    # Backup the existing jar file
    backup_all_files "${BIN_DIR}/*.jar" "$BACK_UP_DIR"

    # Backup the existing env.sh file
    backup_files "${BIN_DIR}/env.sh"

    # Delete bin dir
    echo "INFO: Dropping ${BIN_DIR}..."
    rm -rf "${BIN_DIR}" || true

    # Copy the incoming bin directory
    copy_files "${INCOMING_BIN_DIR}" "${BIN_DIR}"

    # Copy the incoming jar file to bin directory
    process_jar_files "${JAR_FILE_DIR}" "$BIN_DIR"

    # Copy the incoming apm directory
    copy_files "${INCOMING_APM_DIR}" "${BIN_DIR}"

    # Copy the incoming lib directory
    copy_files "${DROP_DIR}/lib" "${BIN_DIR}"
  fi

  # Handle conf directory
  if [ -d "${INCOMING_CONF_DIR}" ]; then
      echo "INFO: Dropping ${CONF_DIR}..."
      rm -rf "${CONF_DIR}" || true

      # Copy the incoming conf folder
      copy_files "${INCOMING_CONF_DIR}" "${CONF_DIR}"
  fi

  # Handle lib directory
  if [ -d "${INCOMING_LIB_DIR}" ]; then
      echo "INFO: Dropping ${LIB_DIR}..."
      rm -rf "${LIB_DIR}" || true

      # Copy the incoming lib folder
      copy_files "${INCOMING_LIB_DIR}" "${LIB_DIR}"
  fi

  # Create logs dir if it does not exist
  if [ ! -d "${LOGS_DIR}" ]; then
      create_directory "${LOGS_DIR}"
  fi
}

# Copying env scripts to bin directory
copy_env_files() {
  echo "INFO: Copying Env Script Files Starting..."
  INCOMING_ENV_DIR="${DROP_DIR}/java_env"

  if [ -d "${INCOMING_ENV_DIR}" ]; then
    cp -rv "${INCOMING_ENV_DIR}/." "${BIN_DIR}" || exit 1
  else
    echo "WARNING: ENV_DIR, ${INCOMING_ENV_DIR} does not exist. Skipping..."
  fi
}

# Copy finacle iso deploy files
copy_finacle_iso_files() {
  echo "INFO: Copying Finacle ISO Files Starting..."
  ISO_FILES_DIR="${DROP_DIR}/deploy"

  if [ -d "${ISO_FILES_DIR}" ]; then
    echo "INFO: Dropping ${DEPLOY_DIR}..."
    rm -rf "${DEPLOY_DIR}"

    # Copy the incoming lib folder
    copy_files "${ISO_FILES_DIR}" "${DEPLOY_DIR}"
  else
     echo "WARNING: Finacle ISO Deploy Directory, ${ISO_FILES_DIR} does not exist. Skipping..."
  fi
}

# Function to copy files or directories into the deployment directory
copy_files() {
  source_path=$1
  destination_path=$2

  if [ -d "$source_path" ]; then
    echo "INFO: Copying directory ${source_path} to ${destination_path}"
    cp -r "${source_path}" "${destination_path}" || exit 1

  elif [ -f "$source_path" ]; then
    echo "INFO: Copying file ${source_path} to ${destination_path}"
    cp -v "${source_path}" "${destination_path}" || exit 1

  else
    echo "WARNING: Source ${source_path} does not exist. Skipping..."
  fi
}

# Set permissions start application
#start_application() {
#  echo "INFO: Starting Application Process Starting..."
#  ENV_SCRIPT="${BIN_DIR}/env.sh"
#
#  if [ -f "$ENV_SCRIPT" ]; then
#    echo "INFO: Setting execute permission on $ENV_SCRIPT..."
#    chmod +x "$ENV_SCRIPT"
#
#    echo "INFO: Running $ENV_SCRIPT..."
#    source "$ENV_SCRIPT"
#  else
#    echo "WARNING: env.sh not found in ${ENV_SCRIPT}. Skipping..."
#  fi
#
#  # Start the application
#  echo "INFO: Starting the application..."
#  if [ -f "$START_SCRIPT" ]; then
#    chmod +x "$START_SCRIPT"
#    "$START_SCRIPT" start || { echo "ERROR: Starting application failed!"; exit 1; }
#  else
#    echo "ERROR: ${APPLICATION_START_FILE} not found in ${BIN_DIR}. Application startup failed. Exiting..."
#    exit 1
#  fi
#}
start_application() {
  echo "INFO: Starting Application Process Starting..."
  ENV_SCRIPT="${BIN_DIR}/env.sh"

  if [ -f "$ENV_SCRIPT" ]; then
    echo "INFO: Setting execute permission on $ENV_SCRIPT..."
    chmod +x "$ENV_SCRIPT"

    echo "INFO: Running $ENV_SCRIPT..."
    source "$ENV_SCRIPT"

#    echo "------------------------------------------------------------"
#    echo "DEBUG: PAPSS ENV VARIABLES"
#    echo "PAPSS_KEYSTORE_PASSWORD = [$PAPSS_KEYSTORE_PASSWORD]"
#    echo "PAPSS_KEY_ALIAS         = [$PAPSS_KEY_ALIAS]"
#    echo "PAPSS_TRUSTSTORE_PASSWORD = [$PAPSS_TRUSTSTORE_PASSWORD]"
#    echo "Length(KEYSTORE_PASSWORD) = $(echo -n "$PAPSS_KEYSTORE_PASSWORD" | wc -c)"
#    echo "Length(KEY_ALIAS)         = $(echo -n "$PAPSS_KEY_ALIAS" | wc -c)"
#    echo "Length(TRUSTSTORE_PASSWORD) = $(echo -n "$PAPSS_TRUSTSTORE_PASSWORD" | wc -c)"
#    echo "------------------------------------------------------------"

  else
    echo "WARNING: env.sh not found in ${ENV_SCRIPT}. Skipping..."
  fi

  echo "INFO: Starting the application..."
  if [ -f "$START_SCRIPT" ]; then
    chmod +x "$START_SCRIPT"
    "$START_SCRIPT" start || { echo "ERROR: Starting application failed!"; exit 1; }
  else
    echo "ERROR: ${APPLICATION_START_FILE} not found in ${BIN_DIR}. Application startup failed. Exiting..."
    exit 1
  fi
}

remove_env_sh_file() {
    echo "INFO: Checking if application started successfully to remove env.sh..."

    if [[ -z "$APPLICATION_START_FILE" || -z "$BIN_DIR" ]]; then
        echo "ERROR: APPLICATION_START_FILE or BIN_DIR is not set. Skipping env.sh removal."
        return
    fi

    PID_FILE="${BIN_DIR}/${APPLICATION_START_FILE%.sh}.pid"

    # Wait for the PID file to be created, retrying every 5 seconds (max 50 seconds)
    for i in {1..10}; do
        if [ -f "$PID_FILE" ]; then
            if [ -f "$ENV_SCRIPT" ]; then
                echo "INFO: ${PID_FILE} exists. Deleting env.sh file..."
                if rm -v "$ENV_SCRIPT"; then
                    echo "INFO: Successfully removed $ENV_SCRIPT"
                else
                    echo "ERROR: Failed to remove $ENV_SCRIPT"
                fi
            else
                echo "INFO: env.sh does not exist. Skipping cleanup."
            fi
            return
        fi
        echo "INFO: Waiting for PID file... Attempt $i"
        sleep 5
    done
    echo "WARNING: PID file ${PID_FILE} not found after 50 seconds. Skipping env.sh removal."
}

#function to do clean up
cleanup() {
  echo "INFO: Clean Up Starting..."

	directory=$1
	echo "INFO: Doing Clean Up At ${directory}"
	rm -rf "${directory}" || true
	echo "INFO: Clean up completed. Dropped ${directory}"
}

# Create app directory if it does not exist
create_directory "${APP_PATH}"

# Extract deployment zip file
extract_tar_file

# Get the application start script
get_application_start_script

# Check and kill the current running process
check_and_kill_running_process

# Handle tanuki files
copy_tanuki_files

# Handle env files
copy_env_files

# Handle iso related files
copy_finacle_iso_files

# Start application
start_application

# Remove the env.sh file after application startup
remove_env_sh_file

# Wait for 5 seconds
echo "Waiting 5 seconds before clean up"
sleep 5

#do clean up
echo
cleanup "${DROP_DIR}"

echo "-------------------------------  INFO: APPLICATION DEPLOYMENT COMPLETED SUCCESSFULLY. --------------------------------"