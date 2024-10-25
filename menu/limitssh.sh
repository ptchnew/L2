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
clear
cd
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/ssh")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${U} ${N}${O}       ${W}⇱ Limit SSH Account ⇲      ${N} ${U} ${N}"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${U} ${N}${O}      ${W}⇱ Limit SSH Account ⇲      ${N} ${U} ${N}"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo " Select one of the clients to set its IP"
echo " Type [0] back to menu"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
printf "   %-5s%-15s%-15s\n" "NO." "NAMA" "EXPIRED"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2-3 | nl -s ') ' |awk -v OFS="\t" '{ printf "   %-5s%-15s%-15s\n", $1, $2, $3 '}
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-sshovpn
fi
fi
done
until [[ $iplim =~ ^[0-9]+$ ]]; do
read -p "Limit User (IP) New: " iplim
done
if [ ! -e /etc/xray/sshx ]; then
mkdir -p /etc/xray/sshx
fi
if [ -z ${iplim} ]; then
iplim="0"
fi
user=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
echo "${iplim}" >/etc/xray/sshx/${user}IP
clear
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo " SSH Account Was Successfully Change Limit IP"
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""
echo " Client Name : $user"
echo " Limit IP    : $iplim IP"
echo ""
echo -e "${U}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu