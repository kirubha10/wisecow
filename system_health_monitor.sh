#!/bin/bash

# Define thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Define log file
LOG_FILE="/var/log/system_health_monitor.log"

# Function to check CPU usage
check_cpu_usage() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        echo "$(date) - CPU usage is high: ${CPU_USAGE}%" | tee -a "$LOG_FILE"
    else
        echo "$(date) - CPU usage is normal: ${CPU_USAGE}%" | tee -a "$LOG_FILE"
    fi
}

# Function to check memory usage
check_memory_usage() {
    MEMORY_USAGE=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100.0}')
    if (( MEMORY_USAGE > MEMORY_THRESHOLD )); then
        echo "$(date) - Memory usage is high: ${MEMORY_USAGE}%" | tee -a "$LOG_FILE"
    else
        echo "$(date) - Memory usage is normal: ${MEMORY_USAGE}%" | tee -a "$LOG_FILE"
    fi
}

# Function to check disk space
check_disk_space() {
    DISK_USAGE=$(df / | awk '/\// {print $5}' | sed 's/%//')
    if (( DISK_USAGE > DISK_THRESHOLD )); then
        echo "$(date) - Disk space usage is high: ${DISK_USAGE}%" | tee -a "$LOG_FILE"
    else
        echo "$(date) - Disk space usage is normal: ${DISK_USAGE}%" | tee -a "$LOG_FILE"
    fi
}

# Function to check running processes
check_running_processes() {
    PROCESSES=$(ps aux --sort=-%mem | head -n 10)
    echo "$(date) - Top 10 processes by memory usage:" | tee -a "$LOG_FILE"
    echo "$PROCESSES" | tee -a "$LOG_FILE"
}

# Run checks
check_cpu_usage
check_memory_usage
check_disk_space
check_running_processes
