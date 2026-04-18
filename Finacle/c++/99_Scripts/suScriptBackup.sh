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

# Define directory paths for different environments
hpCBCRootDirectory="/finacle/EQPROD/BackEnd"
hpFIRootDirectory="/finacle/EQPRODFI/BackEnd/Finacle/FC/app"
hpUSERRootDirectory="/finacle/EQPROD/BackEnd/Finacle/FC/app"
hpUNISERRootDirectory="/finacle/EQPROD/BackEnd/Finacle/FC/app"

# Function to securely copy files and execute the deploy script
execute_deploy_script() {
    REMOTE_DIR="$1"
    REMOTE_SCRIPT="$2"

    # Securely copy files from /azurefin/home/ to the specified remote directory
	  # While using >/dev/null 2>&1 to supppress uthorized uses only. All activity may be monitored and reported error
    echo "Securely Copying Files To "$REMOTE_DIR""
    scp -r * "applmgr@$IP_ADDRESS:$REMOTE_DIR" >/dev/null 2>&1

    # SSH into the server as applmgr. Use EOF to combine block commands into one command and pass the command into ssh
    # Using grep suppress/ignore errors containing "Pseudo-terminal" and "Authorized uses only" while still displaying other error messages.
    ssh applmgr@"$IP_ADDRESS" <<EOF 2>&1 | grep -v "Pseudo-terminal" | grep -v "Authorized uses only."
        # Update permissions for the deploy script
        echo "Updating Permissions For "$REMOTE_DIR"/"$REMOTE_SCRIPT""
        chmod +x "$REMOTE_DIR"/"$REMOTE_SCRIPT"

        # Execute the deploy script
        echo "Calling "$REMOTE_SCRIPT" At Path: "$REMOTE_DIR"/"$REMOTE_SCRIPT""
        source "$REMOTE_DIR"/"$REMOTE_SCRIPT" "$BANK"
		echo
EOF
}

# Execute the deploy script based on the provided environment
case $ENVIRONMENT in
    "FI")
        echo "-------------- CALLING EXECUTE FUNCTION FOR FI ENVIROMENT --------------"
        execute_deploy_script "$hpFIRootDirectory" deploy-fi-scripts.sh
        ;;
    "CBC")
		echo "-------------- CALLING EXECUTE FUNCTION FOR CBC ENVIROMENT --------------"
        execute_deploy_script "$hpCBCRootDirectory" deploy-cbc-scripts.sh
        ;;
    "USER")
		echo "-------------- CALLING EXECUTE FUNCTION FOR USER ENVIROMENT --------------"
        execute_deploy_script "$hpUSERRootDirectory" deploy-user-scripts.sh
        ;;
    "UNISER")
		echo "-------------- CALLING EXECUTE FUNCTION FOR UNISER ENVIROMENT --------------"
        execute_deploy_script "$hpUNISERRootDirectory" deploy-uniser-scripts.sh
        ;;
    *)
        echo "UNKNOWN ENVIRONMENT: "$ENVIRONMENT" EXITING THE APPLICATION..."
        # Add handling for unknown environments here if needed
        ;;
esac
exit 0