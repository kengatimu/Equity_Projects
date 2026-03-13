#!/bin/bash

# -------------------------------------------------------------------------------------------------------------------- #
#   NOTE: DO NOT change or update this script file Manually
#
#   This script does the following tasks.
#     i.   Creates a common deployment directory
#	    ii.  Copies lib directory in the deployment directory
#	    iii. Copies tanuki directory in the deployment directory
#	    iv.  Copies deploy directory in the deployment directory
#	    v.   Copies java_env directory in the deployment directory
#	    vi.  Copies the application jar file in the deployment directory
#	    vii. Archives the deployment directory to be copied to azure drop
#
# -------------------------------------------------------------------------------------------------------------------- #

set -e # Exit immediately on error (exits which are non zero)
set -o pipefail # Capture errors in pipes

echo
echo "------------------------------- INFO: STARTING AZURE-PIPELINES-HELPER SCRIPT... --------------------------------"
echo

# Get app_name from azure-pipelines.yaml file. If not set, exit with error APP_NAME environment variable is required.
app_name="${APP_NAME:?APP_NAME environment variable is required.}"
echo "INFO: Application Name: ${app_name}"

# Static final variables
WORKING_DIRECTORY="$(pwd)"
BUILD_ARTIFACTS_STAGING_DIR="${BUILD_ARTIFACTS_STAGING_DIR:-$(Build.ArtifactStagingDirectory)}" # Default to Azure Pipelines' Build.ArtifactStagingDirectory if not set
ENVIRONMENT="${ENVIRONMENT:-uat}" # Get the environment value from azure-pipelines.yaml file (defaults to "uat" if not provided)

# Other variables
deployment_dir="${WORKING_DIRECTORY}/deployment_directory"

# Validate ENVIRONMENT
if [[ "$ENVIRONMENT" != "uat" && "$ENVIRONMENT" != "prod" ]]; then
  echo "ERROR: Invalid environment specified: ${ENVIRONMENT}. Allowed values are 'uat' or 'prod'."
  exit 1
fi

echo " INFO: Current Environment: ${ENVIRONMENT}"
echo " INFO: Azure Default Working Directory Path: ${WORKING_DIRECTORY}"
echo

# Function to create the deployment directory
create_directory() {
  directory_name=$1
  if [ -d "$directory_name" ]; then
    echo "INFO: Directory ${directory_name} exists. Recreating..."
    rm -rvf "${directory_name}" || true
  fi
  mkdir -vp "${directory_name}"
}

# Function to copy files or directories into the deployment directory
copy_files() {
  source_path=$1
  destination_path=$2

  if [ -d "$source_path" ]; then
    echo
    echo "INFO: Copying directory ${source_path} to ${destination_path}"
    cp -rv "${source_path}" "${destination_path}" || exit 1

  elif [ -f "$source_path" ]; then # For copying files
    echo
    echo "INFO: Copying file ${source_path} to ${destination_path}"
    cp -v "${source_path}" "${destination_path}" || exit 1

  else
    echo
    echo "WARNING: Source ${source_path} does not exist. Skipping..."
  fi
}
# Create the necessary directories
create_directory "${deployment_dir}"
create_directory "${deployment_dir}/app"

# Copy files and directories
copy_files "${WORKING_DIRECTORY}/target/lib" "${deployment_dir}/lib"
copy_files "${WORKING_DIRECTORY}/pipelines/apm/" "${deployment_dir}/apm"
copy_files "${WORKING_DIRECTORY}/target/${app_name}" "${deployment_dir}/app"
copy_files "${WORKING_DIRECTORY}/pipelines/tanuki/${ENVIRONMENT}" "${deployment_dir}/tanuki"
copy_files "${WORKING_DIRECTORY}/pipelines/deploy/${ENVIRONMENT}" "${deployment_dir}/deploy"
copy_files "${WORKING_DIRECTORY}/pipelines/java_env/${ENVIRONMENT}" "${deployment_dir}/java_env"

# Archive the deployment directory
# basename command ensures that only the directory's name (not the full path) is used for the tarball.
echo
echo "INFO: Archiving the deployment directory without paths..."
tar_file="${BUILD_ARTIFACTS_STAGING_DIR}/$(basename "${deployment_dir}").tar.gz"
tar -vzcf "${tar_file}" -C "${deployment_dir}" .

# Debugging: List the contents of the archive
echo
echo "DEBUG: Listing contents of the archive file ${tar_file} ...."
tar -tzf "${tar_file}"

echo
echo "-------------------------------  INFO: SCRIPT COMPLETED. --------------------------------"