#! /bin/bash
#===========================================
#  System Health Check Script
#  Auther : MJ
#  Purpose : Check system resource usage & health
#===========================================


LOGFILE="/var/log/system_health_$(date +%F).log"

# Create log file

touch $LOGFILE

echo "=========================================" | tee -a $LOGFILE

echo " System Health Check - $(date) " | tee -a $LOGFILE

echo "=========================================" | tee -a $LOGFILE

# Hostname & Uptime

echo -e "\n🔹 Hostname & Uptime" | tee -a $LOGFILE
echo "Hostname: $(hostname)" | tee -a $LOGFILE
echo "Uptime $(uptime -p) | "tee -a $LOGFILE

# CPU Usage
echo -e "\n🔹 CPU Usage" | tee -a $LOGFILE
mpstat 1 1 | awk '/Average:/ {print "CPU Idle: " $12 "% | CPU Usage: " 100-$12 "%"}' | tee -a $LOGFILE

# Memory Usage
echo -e "\n🔹 Memory Usage" | tee -a $LOGFILE
free -h | tee -a $LOGFILE

# Disk Usage
echo -e "\n🔹 Disk Usage" | tee -a $LOGFILE
df -h --output=source,fstype,size,used,avail,pcent,target | tee -a $LOGFILE

# Top 5 Memory Consuming Processes
echo -e "\n🔹 Top 5 Memory Consuming Processes" | tee -a $LOGFILE
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 | tee -a $LOGFILE

# Top 5 CPU Consuming Processes
echo -e "\n🔹 Top 5 CPU Consuming Processes" | tee -a $LOGFILE
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 | tee -a $LOGFILE

# Network Check (Ping Google DNS)
echo -e "\n🔹 Network Connectivity" | tee -a $LOGFILE
ping -c 2 8.8.8.8 &>/dev/null && echo "Internet: Connected" | tee -a $LOGFILE || echo "Internet: Disconnected" | tee -a $LOGFILE

# Open Ports
echo -e "\n🔹 Open Ports" | tee -a $LOGFILE
ss -tuln | tee -a $LOGFILE

# Last 5 Logins
echo -e "\n🔹 Last 5 Logins" | tee -a $LOGFILE
last -n 5 | tee -a $LOGFILE

echo -e "\n✅ Health check completed. Log saved at $LOGFILE"
