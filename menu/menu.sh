#!/bin/bash
NC="\e[0m"
N="\e[0m"
ANSI1='\033[0;37m'
ANSI1='\033[46m'
RED="\033[0;31m"
G="\033[1;97m"
GREEN='\033[0;32m'
WH='\033[1;37m'
M="\e[1;33m"
COLOR1="${ANSI1}"
COLBG1="${ANSI2}"
Left="\033[1;31m≻\033[1;35m≻\033[0;36m≻$NC"
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
MYIP=$(wget -qO- ifconfig.me)
cd

if [ ! -e /etc/xray/ssh ]; then
echo "" > /etc/xray/ssh
elif [ ! -e /etc/xray/sshx ]; then
mkdir -p /etc/xray/sshx
elif [ ! -e /etc/xray/sshx/listlock ]; then
echo "" > /etc/xray/sshx/listlock
fi
if [ ! -e /etc/xray/sshx/akun ]; then
mkdir -p /etc/xray/sshx/akun
fi

clear
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/etc/t1
bulan=$(date +%b)
tahun=$(date +%y)
ba=$(curl -s https://pastebin.com/raw/0gWiX6hE)
today=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
todayd=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
today_v=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $9}')
today_rx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $2}')
today_rxv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $3}')
today_tx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $5}')
today_txv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $6}')
if [ "$(grep -wc ${bulan} /etc/t1)" != '0' ]; then
bulan=$(date +%b)
month=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $9}')
month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $10}')
month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $3}')
month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $4}')
month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $6}')
month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $7}')
else
bulan2=$(date +%Y-%m)
month=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $8}')
month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $9}')
month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $2}')
month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $3}')
month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $5}')
month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $6}')
fi
if [ "$(grep -wc yesterday /etc/t1)" != '0' ]; then
yesterday=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $8}')
yesterday_v=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $9}')
yesterday_rx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $2}')
yesterday_rxv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $3}')
yesterday_tx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $5}')
yesterday_txv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $6}')
else
yesterday=NULL
yesterday_v=NULL
yesterday_rx=NULL
yesterday_rxv=NULL
yesterday_tx=NULL
yesterday_txv=NULL
fi

ssh_ws=$( systemctl status ws-stunnel | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
status_ws="${COLOR1}ON${NC}"
else
status_ws="${RED}OFF${NC}"
fi
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
status_nginx="${COLOR1}ON${NC}"
else
status_nginx="${RED}OFF${NC}"
systemctl start nginx
fi
if [[ -e /usr/bin/kyt ]]; then
nginx=$( systemctl status kyt | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
echo -ne
else
systemctl start kyt
fi
fi
rm -rf /etc/status
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $dropbear_status == "running" ]]; then
   status_beruangjatuh="${COLOR1}ON${NC}"
else
   status_beruangjatuh="${RED}OFF${NC}"
fi

total_ssh=$(grep -c -E "^### " "/etc/xray/ssh")

function restartservice(){    
clear
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
    systemctl restart nginx
    systemctl restart daemon
    systemctl restart udp-custom
    systemctl restart dropbear
    systemctl restart ws-dropbear
    systemctl restart ws-stunnel
    systemctl restart cron
    systemctl restart netfilter-persistent
    systemctl restart squid
    systemctl restart badvpn1
    systemctl restart badvpn2
    systemctl restart badvpn3
}
clear
echo -e "$COLOR1 ┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}          ${WH}RESTART SERVICE VPS             ${NC} $COLOR1 $NC"
echo -e "$COLOR1 └──────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  \033[1;91m Restart All Service... \033[1;37m"
fun_bar 'res1'

echo -e ""
read -n 1 -s -r -p "Press [ Enter ] to back on menu"
menu
}

clear
clear && clear && clear
clear;clear;clear
neofetch
echo -e "${G}──────────────────────────────────────────────────${NC} "
echo -e "${M}    NGINX  ${N} ${status_nginx}  ${N}|${M}  SSHWS  ${N} ${status_ws} ${N}|${M}    DROPBEAR  ${N} ${status_beruangjatuh} ${NC} "
echo -e "${G}──────────────────────────────────────────────────${NC} "
echo -e " ${Left} Total Ssh Account Created ${COLOR1}⋍${NC} ${WH}${total_ssh} Account${NC}"
echo -e "${G}┌─────────────────────────────────────────────────${NC}"
echo -e "${G}│  ${COLOR1}01.]${NC} Create SSH Account   ${G}(menu)${NC}"
echo -e "${G}│  ${COLOR1}02.]${NC} Renew  SSH Account   ${G}(menu)${NC}"
echo -e "${G}│  ${COLOR1}03.]${NC} Delete SSH Account   ${G}(menu)${NC}"
echo -e "${G}│  ${COLOR1}04.]${NC} Online SSH Account   ${G}(menu)${NC}"
echo -e "${G}│  ${COLOR1}05.]${NC} Limit  SSH Account   ${G}(menu)${NC}"
echo -e "${G}│  ${COLOR1}06.]${NC} Unlock SSH Account   ${G}(menu)${NC}"
echo -e "${G}│  ${COLOR1}07.]${NC} Settings Lock SSH    ${G}(menu)${NC}"
echo -e "${G}└─────────────────────────────────────────────────${NC}"
echo -e "${G}│  ${COLOR1}08.]${NC} Restart Service SSH  ${G}(menu)${NC}"
echo -e "${G}│  ${COLOR1}09.]${NC} Notifikasi Bot Tele  ${G}(menu)${NC}"
echo -e "${G}│  ${COLOR1}10.]${NC} Reboot System        ${G}(menu)${NC}"
echo -e "${G}└─────────────────────────────────────────────────${NC}"
echo -e ""
echo -ne " ${WH}Select menu ${COLOR1}: ${WH}"; read opt
case $opt in
01 | 1) clear ; addssh ;;
02 | 2) clear ; renewssh ;;
03 | 3) clear ; delssh ;;
04 | 4) clear ; cek-ssh ;;
05 | 5) clear ; limitssh ;;
06 | 6) clear ; unlock ;;
07 | 7) clear ; lock  ;;
08 | 8) clear ; restartservice ;;
09 | 9) clear ; menu ;;
10 | 10) clear ; reboot ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac