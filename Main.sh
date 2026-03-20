#!/bin/bash

# Colors (safe for Termux)
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
WHITE="\033[37m"
RESET="\033[0m"

# Loading screen
clear
echo -e "${CYAN}"
echo "Starting MultiTool..."
sleep 1
echo "Loading modules..."
sleep 1
echo -e "${RESET}"

while true
do
    clear

    # Banner
    echo -e "${RED}"
    echo "███╗   ███╗██╗   ██╗██╗  ████████╗██╗"
    echo "████╗ ████║██║   ██║██║  ╚══██╔══╝██║"
    echo "██╔████╔██║██║   ██║██║     ██║   ██║"
    echo "██║╚██╔╝██║██║   ██║██║     ██║   ██║"
    echo "██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║"
    echo "╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝"
    echo -e "${RESET}"

    echo -e "${YELLOW}========== MULTITOOL MENU ==========${RESET}"
    echo
    echo -e "${GREEN}[1] IP Scanner${RESET}"
    echo -e "${GREEN}[2] DNS Lookup${RESET}"
    echo -e "${GREEN}[3] Ping Test${RESET}"
    echo -e "${GREEN}[4] System Info${RESET}"
    echo -e "${GREEN}[0] Exit${RESET}"
    echo

    read -p "Select option > " choice

    case $choice in
        1)
            echo -e "${CYAN}Enter base IP (example: 192.168.1):${RESET}"
            read baseip
            echo "Scanning..."
            for i in {1..10}
            do
                ping -c 1 $baseip.$i > /dev/null 2>&1 && echo -e "${GREEN}$baseip.$i is UP${RESET}"
            done
            ;;

        2)
            echo -e "${CYAN}Enter domain:${RESET}"
            read domain
            nslookup $domain
            ;;

        3)
            echo -e "${CYAN}Enter IP or domain:${RESET}"
            read host
            ping -c 4 $host
            ;;

        4)
            echo -e "${YELLOW}System Info:${RESET}"
            uname -a
            echo
            echo "IP Address:"
            hostname -I
            ;;

        0)
            echo -e "${RED}Exiting...${RESET}"
            exit
            ;;

        *)
            echo -e "${RED}Invalid option${RESET}"
            ;;
    esac

    echo
    read -p "Press Enter to continue..."
done
