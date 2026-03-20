#!/bin/bash

# Colors (Termux safe)
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

# Startup
clear
echo -e "${CYAN}Starting MultiTool...${RESET}"
sleep 1

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

    echo -e "${YELLOW}========= MULTITOOL MENU =========${RESET}"
    echo
    echo -e "${GREEN}[1] IP Scanner${RESET}"
    echo -e "${GREEN}[2] DNS Lookup${RESET}"
    echo -e "${GREEN}[3] Ping Test${RESET}"
    echo -e "${GREEN}[4] System Info${RESET}"
    echo -e "${GREEN}[5] URL Safety Checker${RESET}"
    echo -e "${GREEN}[6] WHOIS + DNS${RESET}"
    echo -e "${GREEN}[7] Password Strength Checker${RESET}"
    echo -e "${GREEN}[8] IP + Geo Info${RESET}"
    echo -e "${GREEN}[0] Exit${RESET}"
    echo

    read -p "Select option > " choice

    case $choice in

        1)
            read -p "Enter base IP (example 192.168.1): " baseip
            echo "Scanning..."
            for i in {1..20}
            do
                ping -c 1 $baseip.$i > /dev/null 2>&1 && \
                echo -e "${GREEN}$baseip.$i is UP${RESET}"
            done
            ;;

        2)
            read -p "Enter domain: " domain
            nslookup $domain
            ;;

        3)
            read -p "Enter IP or domain: " host
            ping -c 4 $host
            ;;

        4)
            echo "System Info:"
            uname -a
            echo
            echo "Local IP:"
            hostname -I
            ;;

        5)
            read -p "Enter URL: " url
            echo "Analyzing..."

            [[ $url == http://* ]] && echo "⚠️ Not secure (HTTP)"
            [[ $url =~ @ ]] && echo "⚠️ Contains '@'"
            [[ ${#url} -gt 60 ]] && echo "⚠️ Very long URL"
            [[ $url =~ [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]] && echo "⚠️ Uses IP"

            echo "Check complete."
            ;;

        6)
            pkg install whois dnsutils -y
            read -p "Enter domain: " d
            echo "------ WHOIS ------"
            whois $d | head -n 20
            echo "------ DNS ------"
            nslookup $d
            ;;

        7)
            read -s -p "Enter password: " pass
            echo

            score=0
            [[ ${#pass} -ge 12 ]] && ((score++))
            [[ $pass =~ [A-Z] ]] && ((score++))
            [[ $pass =~ [a-z] ]] && ((score++))
            [[ $pass =~ [0-9] ]] && ((score++))
            [[ $pass =~ [^a-zA-Z0-9] ]] && ((score++))

            echo "Strength score: $score/5"
            ;;

        8)
            echo "Fetching IP..."
            ip=$(curl -s ifconfig.me)
            echo "Public IP: $ip"
            echo "Geo Info:"
            curl -s "http://ip-api.com/json/$ip" | sed 's/,/\n/g'
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
