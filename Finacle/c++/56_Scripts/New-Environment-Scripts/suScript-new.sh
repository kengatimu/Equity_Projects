#!/bin/bash

# --------------------------------------------------------------- #
#                                 																#
# NOTE: DO NOT change or update this script file Manually 				#
# Sript Funtion: 																									#
#   i. 		Change user to applmgr																	#
#	ii. 	Run deploy scripts using applmgr													#
#																														      #
# --------------------------------------------------------------- #

# Retrieve the IP address and environment from the arguments
IP_ADDRESS=$1
ENVIRONMENT=$2
BANK=$3

# Display information about the environment and IP address
echo
echo "The Environment Is: $ENVIRONMENT"
echo "The Bank Is: $BANK"
#echo "The IP address of the remote machine is: $IP_ADDRESS"
echo

# FI /finacle/equity_be/Finacle/FC/app/cust/56/INFENG
# UNISER /finacle/equity_be/Finacle/FC/app/cust/56/INFENG
# CBC /finacle/equity_be/CBC/services/cbc
# USER /finacle/equity_be/Finacle/FC/app/cust/56/INFENG

# Define directory paths for different environments
sourceDirectory="/CommonEquity/FINCICD"
hpCBCRootDirectory="/finacle/equity_be/CBC"
hpFIRootDirectory="/finacle/equity_be/Finacle/FC/app"
hpUSERRootDirectory="/finacle/equity_be/Finacle/FC/app"
hpUNISERRootDirectory="/finacle/equity_be/Finacle/FC/app"

# Function to securely copy files and execute the deploy script
execute_deploy_script() {
   REMOTE_DIR="$1"
   REMOTE_SCRIPT="$2"
   FIN_USER="applmgr"

#   echo "Running as: $(whoami)"
#   sudo -l

   # Switch to FIN_USER and handle file operations
   sudo su - "$FIN_USER" -c "
        echo 'Moving files from $sourceDirectory to $REMOTE_DIR'
        mv $sourceDirectory/* $REMOTE_DIR/ || { echo 'Move failed'; exit 1; }
        echo 'Files moved from $sourceDirectory to $REMOTE_DIR'

        # Update permissions for the deploy script
        echo 'Updating Permissions For $REMOTE_DIR/$REMOTE_SCRIPT'
        chmod +x $REMOTE_DIR/$REMOTE_SCRIPT || { echo 'Updating permissions failed'; exit 1; }

        # Execute the deploy script
        echo 'Calling $REMOTE_SCRIPT at $REMOTE_DIR'
        source $REMOTE_DIR/$REMOTE_SCRIPT "$BANK" || { echo 'Deploy script execution failed'; exit 1; }
      "
   echo
 }

# Execute the deploy script based on the provided environment
case $ENVIRONMENT in
    "FI")
        echo "-------------- CALLING EXECUTE FUNCTION FOR FI ENVIROMENT --------------"
        execute_deploy_script "$hpFIRootDirectory" deploy-fi-scripts-new.sh
        ;;
    "CBC")
		echo "-------------- CALLING EXECUTE FUNCTION FOR CBC ENVIROMENT --------------"
        execute_deploy_script "$hpCBCRootDirectory" deploy-cbc-scripts-new.sh
        ;;
    "USER")
		echo "-------------- CALLING EXECUTE FUNCTION FOR USER ENVIROMENT --------------"
        execute_deploy_script "$hpUSERRootDirectory" deploy-user-scripts-new.sh
        ;;
    "UNISER")
		echo "-------------- CALLING EXECUTE FUNCTION FOR UNISER ENVIROMENT --------------"
        execute_deploy_script "$hpUNISERRootDirectory" deploy-uniser-scripts-new.sh
        ;;
    *)
        echo "UNKNOWN ENVIRONMENT: "$ENVIRONMENT" EXITING THE APPLICATION..."
        # Add handling for unknown environments here if needed
        ;;
esac
exit 0