#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
NC="\e[0m"
RED="\033[0;31m"
COLOR1='\033[0;35m'
COLBG1='\E[0;100;36m'
WH='\033[1;37m'
clear
echo -e "$COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}                 ${WH}⇱ UPDATE ⇲                    ${NC} $COLOR1 $NC"
echo -e "$COLOR1└───────────────────────────────────────────────┘${NC}"

cd /usr/bin
rm -rf menu
rm -rf addssh
rm -rf cek-ssh
rm -rf delssh
rm -rf limitssh
rm -rf lock
rm -rf renewssh
rm -rf unlock
rm -rf speedtest
rm -rf tendang
rm -rf bantwidth
rm -rf xp

fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}
res1() {
    
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/ptchnew/L2/main/menu/menu.sh" && chmod +x /usr/bin/menu && dos2unix /usr/bin/menu 
wget -q -O /usr/bin/addssh "https://raw.githubusercontent.com/ptchnew/L2/main/menu/addssh.sh" && chmod +x /usr/bin/addssh
wget -q -O /usr/bin/cek-ssh "https://raw.githubusercontent.com/ptchnew/L2/main/menu/cek-ssh.sh" && chmod +x /usr/bin/cek-ssh
wget -q -O /usr/bin/delssh "https://raw.githubusercontent.com/ptchnew/L2/main/menu/delssh.sh" && chmod +x /usr/bin/delssh
wget -q -O /usr/bin/limitssh "https://raw.githubusercontent.com/ptchnew/L2/main/menu/limitssh.sh" && chmod +x /usr/bin/limitssh
wget -q -O /usr/bin/lock "https://raw.githubusercontent.com/ptchnew/L2/main/menu/lock.sh" && chmod +x /usr/bin/lock
wget -q -O /usr/bin/renewssh "https://raw.githubusercontent.com/ptchnew/L2/main/menu/renewssh.sh" && chmod +x /usr/bin/renewssh
wget -q -O /usr/bin/unlock "https://raw.githubusercontent.com/ptchnew/L2/main/menu/unlock.sh" && chmod +x /usr/bin/unlock
wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/ptchnew/L2/main/install/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/ptchnew/L2/main/menu/tendang.sh" && chmod +x /usr/bin/tendang
wget -q -O /usr/bin/bantwidth "https://raw.githubusercontent.com/ptchnew/L2/main/install/bantwidth" && chmod +x /usr/bin/bantwidth
wget -q -O /usr/bin/xp "https://raw.githubusercontent.com/ptchnew/L2/main/install/xp.sh" && chmod +x /usr/bin/xp
chmod +x menu
chmod +x addssh
chmod +x cek-ssh
chmod +x delssh
chmod +x limitssh
chmod +x lock
chmod +x renewssh
chmod +x unlock
chmod +x speedtest
chmod +x tendang
chmod +x bantwidth
chmod +x xp
clear

}
echo -e ""
echo -e "  \033[1;91m Update Script...\033[1;37m"
fun_bar 'res1'

echo -e ""

cd
menu
