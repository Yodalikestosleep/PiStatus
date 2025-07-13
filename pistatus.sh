#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

echo -e "${CYAN}Raspberry Pi System Status${RESET}"

CPU_TEMP=$(vcgencmd measure_temp | awk -F= '{print $2}')
MEM_TOTAL=$( free -m | awk '/Mem:/ {print $2}')
MEM_USED=$( free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$( free -m | awk '/Mem:/ {print $4}')
SD_TOTAL=$( df / | awk 'NR==2 {print $2}')
SD_USED=$( df / | awk 'NR==2 {print $3}')
SD_FREE=$( df / | awk 'NR==2 {print $4}')
NVME_TEMP1=$( sudo nvme smart-log /dev/nvme0 | grep "Temperature Sensor 1" | awk '{print $5}')
NVME_TEMP2=$( sudo nvme smart-log /dev/nvme0 | grep "Temperature Sensor 2" | awk '{print $5}')
NET_IFACE="eth0"
RX=$(cat /sys/class/net/$NET_IFACE/statistics/rx_bytes)
TX=$(cat /sys/class/net/$NET_IFACE/statistics/tx_bytes)
UPTIME=$(uptime -p)

MEM_FREE_GB=$(echo "scale=2; $MEM_FREE/1024" | bc)
MEM_TOTAL_GB=$(echo "scale=2; $MEM_TOTAL/1024" | bc)
SD_USED_GB=$(echo "scale=2; $SD_USED/1024/1024" | bc)
SD_TOTAL_GB=$(echo "scale=2; $SD_TOTAL/1024/1024" | bc)
SD_FREE_GB=$(echo "scale=2; $SD_FREE/1024/1024" | bc)
RX_GB=$(echo "scale=4; $RX/1024/1024/1024" | bc)
TX_GB=$(echo "scale=4; $TX/1024/1024/1024" | bc)

echo -e "${YELLOW}CPU Temperature     = ${GREEN}${CPU_TEMP}${RESET}"
echo -e "${CYAN}------------------------------------${RESET}"
echo -e "${YELLOW}NVMe Temp Sensor 1  = ${GREEN}${NVME_TEMP1}${RESET}"
echo -e "${YELLOW}NVMe Temp Sensor 2  = ${GREEN}${NVME_TEMP2}${RESET}"
echo -e "${CYAN}------------------------------------${RESET}"
echo -e "${YELLOW}Memory Free         = ${GREEN}${MEM_FREE_GB} GB${RESET}"
echo -e "${YELLOW}Memory Total        = ${GREEN}${MEM_TOTAL_GB} GB${RESET}"
echo -e "${CYAN}------------------------------------${RESET}"
echo -e "${YELLOW}Used Disk Space     = ${GREEN}${SD_USED_GB} GB${RESET}"
echo -e "${YELLOW}Total Disk Space    = ${GREEN}${SD_TOTAL_GB} GB${RESET}"
echo -e "${YELLOW}Free Disk Space     = ${GREEN}${SD_FREE_GB} GB${RESET}"
echo -e "${CYAN}------------------------------------${RESET}"
echo -e "${YELLOW}Data Received       = ${GREEN}${RX_GB} GB${RESET}"
echo -e "${YELLOW}Data Sent           = ${GREEN}${TX_GB} GB${RESET}"
echo -e "${CYAN}------------------------------------${RESET}"
echo -e "${YELLOW}System Uptime       = ${GREEN}${UPTIME}${RESET}"

