#!/bin/bash
CY="\033[36m"
CYN="\033[96m"
CYB="\033[46m"
W="\033[0;37m"
WB="\033[1;37m"
NC="\033[0m"
CHATID=""
KEY=""
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
IP=$(curl -sS ipv4.icanhazip.com)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
domain=$(cat /root/scdomain)
clear
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" 
echo -e "${CYB}${WB}       Add SSH Account        ${NC}"
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
until [[ $Login =~ ^[a-zA-Z0-9_.-]+$ && ${CLIENT_EXISTS} == '0' ]]; do
read -p " Username       : " Login
Login="painshop-$Login"
CLIENT_EXISTS=$(grep -w $Login /etc/xray/ssh | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" 
echo -e "${CYB}${WB}       Add SSH Account        ${NC}"
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e " Name ${CY}$Login${NC} Already In Use"
echo -e "${W} Please Use Another Name!.${NC}"
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -n 1 -s -r -p "Enter To repeat again"
addssh
  fi
done
read -p " Password       : " Pass
until [[ $iplimit =~ ^[0-9]+$ ]]; do
read -p " Limit IP       : " iplimit
done
until [[ $masaaktif =~ ^[0-9]+$ ]]; do
read -p " Expired (Days) : " masaaktif
done
if [ ! -e /etc/xray/sshx ]; then
mkdir -p /etc/xray/sshx
fi
if [ -z ${iplim} ]; then
iplim="0"
fi
echo "${iplimit}" >/etc/xray/sshx/${Login}IP
sleep 1
clear
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "### $Login $expi $Pass" >> /etc/xray/ssh
cat > /home/vps/public_html/ssh-$Login.txt <<-END
_______________________________
       PORT INFORMATION 
_______________________________
Port OpenSSH    : 22
Port Dropbear   : 143, 109
Port SSH WS     : 80
Port SSH SSL WS : 443
Port SSL/TLS    : 777, 222
Port SSH UDP    : 1-65535
Port OVPN SSL   : 990
Port OVPN TCP   : 1194
Port OVPN UDP   : 2200,
BadVPN UDP      : 7100, 7300, 7300
_______________________________
END

CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
TEXT="
<code>────────────────────</code>
<b> Premium SSH Account </b>
<code>────────────────────</code>
<code>IP/Host      : </code> <code>$domain</code>
<code>Username     : </code> <code>$Login</code>
<code>Password     : </code> <code>$Pass</code>
<code>────────────────────</code>
<code>IP Limit     : </code> <code>${iplimit} IP</code>
<code>ISP Provider : </code> <code>$ISP</code>
<code>Location     : </code> <code>$CITY</code>
<code>────────────────────</code>
<code>HTTP CUSTOM  : </code><code>$domain:80@$Login:$Pass</code>
<code>────────────────────</code>
<code>Payload WS   : </code><code>GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]</code>
<code>────────────────────</code>
<code>Port Running : </code>http://$IP:89/ssh-$Login.txt
<code>────────────────────</code>
Expired On  :  $exp
<code>────────────────────</code>
"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
echo ""
echo -e "────────────────────" 
echo -e "SSH WebSocket Account"
echo -e "────────────────────" 
echo -e "Username     : $Login" 
echo -e "Password     : $Pass" 
echo -e "IP/Host      : $domain" 
echo -e "Limit Ip     : ${iplimit} IP" 
echo -e "Provider     : $ISP" 
echo -e "Location     : $CITY" 
echo -e "────────────────────"  
echo -e "Port Running : http://$IP:89/ssh-$Login.txt"
echo -e "────────────────────" 
echo -e "HTTP CUSTOM  : $IP:80@$Login:$Pass" 
echo -e "────────────────────" 
echo -e "Payload WS   : GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]" 
echo -e "────────────────────" 
echo -e "Expired On   : $exp" 
echo -e "────────────────────" 
echo "" 
read -p "Press Enter To Back On Menu"
menu
