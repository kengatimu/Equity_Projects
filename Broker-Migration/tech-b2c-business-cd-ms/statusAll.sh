#!/bin/bash

# Function to check the status and conditionally restart
process_script() {
    local script_path="$1"
    local service_name=$(basename "$script_path" .sh)

    # Check the status
    status_output=$(/bin/bash "$script_path" status)

    # If the service is already running, skip the restart
    if [[ "$status_output" == *"$service_name is running"* ]]; then
        echo "$service_name is already running. Skipping restart."
    else
        echo "$service_name is not running. Restarting..."
        /bin/bash "$script_path" restart
    fi
}

# List of scripts to process
scripts=(
    "tech-b2c-business-cd-ms/bin/tech-b2c-business-cd-ms.sh"
    "tech-b2c-vodacom-cd-ms/bin/tech-b2c-vodacom-cd-ms.sh"
    "tech-b2c-africell-cd-ms/bin/tech-b2c-africell-cd-ms.sh"
    "tech-b2c-airtel-cd-ms/bin/tech-b2c-airtel-cd-ms.sh"
    "tech-b2c-orange-cd-ms/bin/tech-b2c-orange-cd-ms.sh"
    "tech-imt-moneygram-cd-ms/bin/tech-imt-moneygram-cd-ms.sh"
    "tech-b2c-registry-cd-ms/bin/tech-b2c-registry-cd-ms.sh"
)

# Process each script
for script in "${scripts[@]}"; do
    process_script "$script"
done

echo "All scripts processed successfully."

