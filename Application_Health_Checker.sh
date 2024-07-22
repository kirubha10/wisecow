#!/bin/bash

# Define variables
APP_URL="http://192.168.1.65:4499"  
LOG_FILE="/var/log/app_uptime.log"   

# Function to check application status
check_app_status() {
    echo "$(date) - Checking application status at $APP_URL" | tee -a "$LOG_FILE"

    # Send HTTP request and get the status code
    HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "$APP_URL")

    # Check if the status code is 200
    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "$(date) - Application is UP (Status code: $HTTP_STATUS)" | tee -a "$LOG_FILE"
    else
        echo "$(date) - Application is DOWN (Status code: $HTTP_STATUS)" | tee -a "$LOG_FILE"
    fi
}

# Run status check
check_app_status
