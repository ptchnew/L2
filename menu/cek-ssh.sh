#!/bin/bash
NC="\e[0m"
RED="\033[0;31m"
COLOR1="\033[0;37m"
COLBG1="\033[46m"
WH='\033[1;37m'
Y='\e[0;33m'
G='\e[1;32m'
WH='\033[1;37m'
U=$COLOR1
O=$COLBG1
W=$WH
N=${NC}
clear
    echo -e " ${U}┌─────────────────────────────────────────────────┐${N}"
    echo -e " ${U}│${N}${O}              ${W}  SSH ACTIVE USERS                 ${N}${U}│ ${N}"
    echo -e " ${U}└─────────────────────────────────────────────────┘${N}"
    echo -e " ${U}┌─────────────────────────────────────────────────┐${N}"
    rm -rf /tmp/ssh2

    
    systemctl restart ws-stunnel > /dev/null 2>&1

    sleep 3

    cat /etc/passwd | grep "/home/" | cut -d ":" -f1 > /etc/user.txt
    username1=( `cat "/etc/user.txt" `)
    i="0"
    for user in "${username1[@]}"; do
        username[$i]=`echo $user | sed 's/'\''//g'`
        jumlah[$i]=0
        i=$i+1
    done

    journalctl -u dropbear --since "5 minutes ago" | grep -i "Password auth succeeded" > /tmp/log-db.txt

    proc=( `ps aux | grep -i dropbear | awk '{print $2}'`)
    for PID in "${proc[@]}"; do
        cat /tmp/log-db.txt | grep "dropbear\[$PID\]" > /tmp/log-db-pid.txt
        NUM=`cat /tmp/log-db-pid.txt | wc -l`
        USER=`cat /tmp/log-db-pid.txt | awk '{print $10}' | sed 's/'\''//g'`
        IP=`cat /tmp/log-db-pid.txt | awk '{print $12}'`
        if [ $NUM -eq 1 ]; then
            TIME=$(date +'%H:%M:%S')
            echo "$USER $TIME : $IP" >> /tmp/ssh2
            i=0
            for user1 in "${username[@]}"; do
                if [ "$USER" == "$user1" ]; then
                    jumlah[$i]=`expr ${jumlah[$i]} + 1`
                    pid[$i]="${pid[$i]} $PID"
                fi
                i=$i+1
            done
        fi
    done

    journalctl -u sshd --since "5 minutes ago" | grep -i "Accepted password for" > /tmp/log-ssh.txt

    data=( `ps aux | grep "[s]shd" | grep -v grep | awk '{print $2}'`)
    for PID in "${data[@]}"; do
        cat /tmp/log-ssh.txt | grep "sshd\[$PID\]" > /tmp/log-ssh-pid.txt
        NUM=`cat /tmp/log-ssh-pid.txt | wc -l`
        USER=`cat /tmp/log-ssh-pid.txt | awk '{print $9}'`
        IP=`cat /tmp/log-ssh-pid.txt | awk '{print $11}'`
        if [ $NUM -eq 1 ]; then
            TIME=$(date +'%H:%M:%S')
            echo "$USER $TIME : $IP" >> /tmp/ssh2
            i=0
            for user1 in "${username[@]}"; do
                if [ "$USER" == "$user1" ]; then
                    jumlah[$i]=`expr ${jumlah[$i]} + 1`
                    pid[$i]="${pid[$i]} $PID"
                fi
                i=$i+1
            done
        fi
    done
    printf " ${U}%-7s${W}%-20s%-13s%-12s${U}%s\n" "│" "USERNAME" "LOGIN" "LIMIT IP" "│"
    echo -e " ├─────────────────────────────────────────────────┤"
    j="0"
    for i in ${!username[*]}; do
        limitip="0"
        if [[ ${jumlah[$i]} -gt $limitip ]]; then
            iplim=$(cat /etc/xray/sshx/${username[$i]}IP) > /dev/null
            sship=$(cat /tmp/ssh2 | grep -w "${username[$i]}" | wc -l)
            printf " %-7s${Y}%-20s${G}%-13s${Y}%-12s${U}%s\n" "│" "${username[$i]}" "${sship} IP" "${iplim} IP" "│"
        fi
    done

    if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
        echo " "
        cat /etc/openvpn/server/openvpn-tcp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
        cat /tmp/vpn-login-tcp.txt
    fi

    if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
        echo " "
        cat /etc/openvpn/server/openvpn-udp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
        cat /tmp/vpn-login-udp.txt
    fi

    echo -e " ${U}└─────────────────────────────────────────────────┘${N}"
    echo " "
    read -n 1 -s -r -p "  Press any key to back on menu"
	menu