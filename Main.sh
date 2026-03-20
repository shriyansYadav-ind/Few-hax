#!/bin/bash

echo -e "\033]0;MultiTool - by Plutonicdarwf\091"

cd files 2>/dev/null

while true
do
    clear

    # Banner
    echo
    echo
    echo -e "\e[38;2;255;0;0m███╗   ███╗██╗   ██╗██╗  ████████╗██╗    ████████╗ ██████╗  ██████╗ ██╗\e[0m"
    echo -e "\e[38;2;255;51;0m████╗ ████║██║   ██║██║  ╚══██╔══╝██║    ╚══██╔══╝██╔═══██╗██╔═══██╗██║\e[0m"
    echo -e "\e[38;2;255;102;0m██╔████╔██║██║   ██║██║     ██║   ██║       ██║   ██║   ██║██║   ██║██║\e[0m"
    echo -e "\e[38;2;255;153;0m██║╚██╔╝██║██║   ██║██║     ██║   ██║       ██║   ██║   ██║██║   ██║██║\e[0m"
    echo -e "\e[38;2;255;204;0m██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║       ██║   ╚██████╔╝╚██████╔╝███████╗\e[0m"
    echo -e "\e[38;2;255;255;0m╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝\e[0m"
    echo

    # Menu
    echo -e "\e[38;2;255;255;0m        ╔═(1) IP Scanner\e[0m"
    echo -e "\e[38;2;255;255;0m        ╠══(2) DNS Lookup\e[0m"
    echo -e "\e[38;2;255;255;0m        ╠═══(3) Ping Test\e[0m"
    echo -e "\e[38;2;255;255;0m        ╚════(4) System Info\e[0m"

    echo
    read -p "        ╚══════> " input

    case $input in
        1)
            echo "Enter base IP (example: 192.168.1): "
            read baseip
            echo "Scanning..."
            for i in {1..10}
            do
                ping -c 1 $baseip.$i > /dev/null 2>&1 && echo "$baseip.$i is UP"
            done
            ;;

        2)
            echo "Enter domain (example: google.com): "
            read domain
            nslookup $domain
            ;;

        3)
            echo "Enter IP or domain: "
            read host
            ping -c 4 $host
            ;;

        4)
            echo "System Information:"
            uname -a
            echo
            echo "IP Address:"
            hostname -I
            ;;

        *)
            echo "Invalid option"
            ;;
    esac

    echo
    read -p "Press Enter to continue..."
done
