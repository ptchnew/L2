#!/bin/bash
NC="\e[0m"
RED="\033[0;31m"
WH='\033[1;37m'
Y='\e[0;33m'
G='\e[1;32m'
WH='\033[1;37m'
U='\033[0;35m'
O='\E[0;100;36m'
W=$WH
N=${NC}
clear
function lockssh(){
clear
cd
if [ ! -e /etc/xray/sshx/listlock ]; then
echo "" > /etc/xray/sshx/listlock
fi
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/sshx/listlock")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${U} ${N}${O}     ${W}⇱ Unlock SSH Account ⇲      ${N} ${U} ${N}"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""
echo "You have no existing user Lock!"
echo ""
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
clear
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${U} ${N}${O}     ${W}⇱ Unlock SSH Account ⇲      ${N} ${U} ${N}"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo " [*] Select the client to be unlocked"
echo " [*] Type [0] back to the menu"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
printf "   %-5s%-15s%-15s\n" "NO." "NAMA" "EXPIRED"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
grep -E "^### " "/etc/xray/sshx/listlock" | cut -d ' ' -f 2-3 | nl -s ') ' |awk -v OFS="\t" '{ printf "   %-5s%-15s%-15s\n", $1, $2, $3 '}
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Unlock: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
menu
fi
if [[ ${CLIENT_NUMBER} == 'clear' ]]; then
rm /etc/xray/sshx/listlock
menu
fi
fi
done
user=$(grep -E "^### " "/etc/xray/sshx/listlock" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/sshx/listlock" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
pass=$(grep -E "^### " "/etc/xray/sshx/listlock" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
passwd -u $user &> /dev/null
iplim=$(cat /etc/xray/sshx/${user}IP)
echo -e "### $user $exp $Pass" >> /etc/xray/ssh
sed -i "/^### $user $exp $pass/d" /etc/xray/sshx/listlock &> /dev/null
cd
clear
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo " SSH Account Unlock Successfully"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo " Client Name : $user"
echo " Status  : Unlocked"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}