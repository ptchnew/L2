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
clear
echo -e "${U}┌──────────────────────────────────────────┐${N}"
echo -e "${U}│ \033[1;37mPlease select a your Choice              ${U}│${N}"
echo -e "${U}└──────────────────────────────────────────┘${N}"
echo -e "${U}┌──────────────────────────────────────────┐${N}"
echo -e "${U}│  [ 1 ]  \033[1;37mAUTO LOCKED USER SSH      ${N}"
echo -e "${U}│  "
echo -e "${U}│  [ 2 ]  \033[1;37mAUTO DELETE USER SSH    ${N}"
echo -e "${U}│  "
echo -e "${U}│  "
echo -e "${U}│  [ 0 ]  \033[1;37mBACK TO MENU    ${N}"
echo -e "${U}└──────────────────────────────────────────┘${N}"
until [[ $lock =~ ^[0-2]+$ ]]; do
read -p "   Please select no : " lock
done
if [[ $lock == "0" ]]; then
menu
elif [[ $lock == "1" ]]; then
clear
echo "lock" > /etc/typessh
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N}${O}           ${W}  SETTING MULTI LOGIN               ${N}${U}│ ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N} Success Auto Lock Replacement  ${N}"
echo -e "${U}│${N} If User Violates Account auto lock. ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
sleep 1
elif [[ $lock == "2" ]]; then
clear
echo "delete" > /etc/typessh
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N}${O}           ${W}  SETTING MULTI LOGIN               ${N}${U}│ ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N} Success Auto Lock Replacement ${N}"
echo -e "${U}│${N} If User Violates Account auto lock. ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
sleep 1
fi
type=$(cat /etc/typessh)
if [ $type = "lock" ]; then
clear
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N}${O}           ${W}  SETTING MULTI LOGIN               ${N}${U}│ ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N} Please write the amount of time to be locked  ${N}"
echo -e "${U}│${N} Can write 15 minutes etc. ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
read -rp "   Amount of Lock Time: " -e notif2
echo "${notif2}" > /etc/waktulockssh
clear
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N}${O}           ${W}  SETTING MULTI LOGIN               ${N}${U}│ ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│ ${N} Please write the number of notifications for auto lock.    ${N}"
echo -e "${U}│ ${N} Multi login user accounts     ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
read -rp "   If you want 3x new notifications to lock, write 3, etc.: " -e notif
cd /etc/xray/sshx
echo "$notif" > notif
clear
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N}${O}           ${W}  SETTING MULTI LOGIN               ${N}${U}│ ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│ ${N} SUCCESSFULLY CHANGE NOTIF LOCK TO $notif ${N} "
echo -e "${U}│ ${N} SUCCESSFULLY CHANGE TIME NOTIF LOCK TO $notif2 MINUTE ${N} "
echo -e "${U}└───────────────────────────────────────────────┘${N}"
else
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N}${O}           ${W}  SETTING MULTI LOGIN               ${N}${U}│ ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N} Please write the amount of time to scan ${N}"
echo -e "${U}│${N} Current User multi login . ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
read -rp "   Write Scan Time (Minutes) : " -e notif2
echo "# Autokill" >/etc/cron.d/tendang
echo "SHELL=/bin/sh" >>/etc/cron.d/tendang
echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >>/etc/cron.d/tendang
echo "*/$notif2 * * * *  root /usr/bin/tendang" >>/etc/cron.d/tendang
clear
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N}${O}           ${W}  SETTING MULTI LOGIN               ${N}${U}│ ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│ ${N} Please write the number of notifications for auto lock.    ${N}"
echo -e "${U}│ ${N} Multi login user accounts     ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
read -rp "   If you want 3x new notifications to lock, write 3, etc.: " -e notif
cd /etc/xray/sshx
echo "$notif" > notif
clear
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│${N}${O}           ${W}  SETTING MULTI LOGIN               ${N}${U}│ ${N}"
echo -e "${U}└───────────────────────────────────────────────┘${N}"
echo -e "${U}┌───────────────────────────────────────────────┐${N}"
echo -e "${U}│ ${N} SUCCESSFULLY CHANGE NOTIF LOCK TO $notif ${N} "
echo -e "${U}│ ${N} SUCCESSFULLY CHANGE TIME NOTIF LOCK TO $notif2 MINUTE ${N} "
echo -e "${U}└───────────────────────────────────────────────┘${N}"
fi
read -n 1 -s -r -p "Press any key to back on menu"
menu
}