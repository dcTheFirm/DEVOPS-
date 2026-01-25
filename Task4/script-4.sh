#!/bin/bash

echo "========================================="
echo "   SHELL SCRIPTING TASK"
echo "========================================="

#############################
#  VARIABLES
#############################

USER_NAME=$(whoami)
HOST=$(hostname)
DATE=$(date)

echo ""
echo "[INFO] User      : $USER_NAME"
echo "[INFO] Hostname  : $HOST"
echo "[INFO] Date/Time : $DATE"

#############################
# SYSTEM INFO
#############################

echo ""
echo "========== SYSTEM INFORMATION =========="

echo ""
echo "--- Uptime ---"
uptime

echo ""
echo "--- Disk Usage ---"
df -h /

echo ""
echo "--- Memory Usage ---"
free -h

echo ""
echo "--- Logged In Users ---"
who

#############################
#  CONDITIONALS
#############################

echo ""
echo "========== CONDITIONAL CHECK =========="

DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

THRESHOLD=80

if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    echo "[WARNING] Disk usage is high: ${DISK_USAGE}%"
else
    echo "[OK] Disk usage is under control: ${DISK_USAGE}%"
fi

#############################
# LOOPS
#############################

echo ""
echo "========== LOOP DEMONSTRATION =========="

echo "For loop example:"
for i in 1 2 3 4 5
do
    echo "Iteration: $i"
done

echo ""
echo "While loop example:"

COUNT=1
while [ $COUNT -le 3 ]
do
    echo "Count is: $COUNT"
    ((COUNT++))
done

#############################
# BACKUP + LOG CLEANUP
#############################

echo ""
echo "========== LOG BACKUP & CLEANUP =========="

LOG_DIR="/var/log"
BACKUP_DIR="$HOME/log_backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"

BACKUP_FILE="$BACKUP_DIR/logs_backup_$TIMESTAMP.tar.gz"

echo "[INFO] Creating backup at: $BACKUP_FILE"

tar -czf "$BACKUP_FILE" "$LOG_DIR" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Logs backed up successfully."
else
    echo "[ERROR] Log backup failed (permission issue likely)."
fi

# Cleanup old backups (older than 7 days)
echo "[INFO] Removing backups older than 7 days..."

find "$BACKUP_DIR" -type f -mtime +7 -name "*.tar.gz" -exec rm -f {} \;

echo "[INFO] Cleanup completed."

#############################
# OUTPUT MESSAGE
#############################

echo "========== SCRIPT EXECUTION FINISHED =========="
exit 0
