#!/bin/bash

# Colours
declare -r greenColour="\e[0;32m\033[1m"
declare -r endColour="\033[0m\e[0m"
declare -r redColour="\e[0;31m\033[1m"
declare -r blueColour="\e[0;34m\033[1m"
declare -r yellowColour="\e[0;33m\033[1m"
declare -r purpleColour="\e[0;35m\033[1m"

# CTRL+C
trap ctrl_c INT
function ctrl_c() {
        echo -e "${purpleColour}**${endColour} ${redColour}Detected Ctrl+C, Exiting...${endColour}"
        sleep 1
        exit 1
}

list=$(curl -s https://gtfobins.github.io/ | awk '{print $2}' FS="/gtfobins/"  | sort -u | grep '#' | awk '{print $1}' FS='"')

echo -e "$list" | tr " " "\n" > /tmp/gtfobins_list 

while true; do
    clear
    tput civis
    echo -e '\n[*]GTFOBins Command Line Tool. "https://gtfobins.github.io/"\n'
    echo -e "\nSelect option.\n"
    echo -e "1.- Find Binary."
    echo -e "2.- Find Function."
    echo -e "0.- Exit.\n"
    echo -ne "#> "
    read op

    case $op in
        1)  
            clear
            echo -e '\n[*]GTFOBins Command Line Tool. "https://gtfobins.github.io/"\n'
            echo -e "\nInput binary name.\n"
            echo -ne "#> "
            read binary
            echo -e "\n[*] Finding matches for binary: $binary\n"
            while read linea; do
                ln=$(echo $linea | awk '{print $1}' FS="/")
                if [[ $ln == $binary ]]; then
                    fn=$(echo $linea | awk '{print $2}' FS="/")
                    echo -e "\t$fn"
                fi
            done < /tmp/gtfobins_list
            tput cnorm
            exit 0
        ;;                    
        2)
            while true; do
                clear
                echo -e '\n[*]GTFOBins Command Line Tool. "https://gtfobins.github.io/"\n'
                echo -e "\nSelect function.\n"
                echo -e "1.-  File upload." 
                echo -e "2.-  File download." 
                echo -e "3.-  File write." 
                echo -e "4.-  File read." 
                echo -e "5.-  Library load." 
                echo -e "6.-  SUID." 
                echo -e "7.-  Sudo." 
                echo -e "8.-  Capabilities." 
                echo -e "9.-  Limited SUID."
                echo -e "10.- Command\n"
                read function
                clear
                echo -e '\n[*]GTFOBins Command Line Tool. "https://gtfobins.github.io/"\n'
                case $function in
                    1)
                        cat /tmp/gtfobins_list | grep "#file upload" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    2)
                        cat /tmp/gtfobins_list | grep "#file download" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    3)
                        cat /tmp/gtfobins_list | grep "#file write" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    4)
                        cat /tmp/gtfobins_list | grep "#file read" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    5)
                        cat /tmp/gtfobins_list | grep "#library load" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    6)  
                        cat /tmp/gtfobins_list | grep "#suid" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    7)
                        cat /tmp/gtfobins_list | grep "#sudo" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    8)
                        cat /tmp/gtfobins_list | grep "#capabilities" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    9)
                        cat /tmp/gtfobins_list | grep "limited suid" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    10)
                        cat /tmp/gtfobins_list | grep "command" | awk '{print $1}' FS="/"
                        tput cnorm
                        exit 0
                    ;;
                    0)
                        tput cnorm
                        exit 0
                    ;;
                    *)
                        echo -e "[*] ${redColour}Incorrect option!.${endColour}"
                        tput cnorm
                        exit 1
                esac 
            done
        ;;
        0)
            tput cnorm
            exit 0
        ;;
        *)
            clear
            echo -e '\n[*]GTFOBins Command Line Tool. "https://gtfobins.github.io/"\n'
            echo -e "[*] ${redColour}Incorrect option.${endColour}"
            tput cnorm
            exit 1
    esac
    
done
