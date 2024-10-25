#!/bin/bash
rm -rf /tmp/ssh
clear
TIMES="10"
CHATID=$(cat /etc/perlogin/id)
KEY=$(cat /etc/perlogin/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
DATE=$(date +'%Y-%m-%d') 
TIME=$(date +'%H:%M:%S')
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)

MAX=$limitip
if [ -e "/var/log/auth.log" ]; then
        OS=1;
        LOG="/var/log/auth.log";
fi
if [ -e "/var/log/secure" ]; then
        OS=2;
        LOG="/var/log/secure";
fi

if [ $OS -eq 1 ]; then
	service sshd restart > /dev/null 2>&1;
fi
if [ $OS -eq 2 ]; then
	service sshd restart > /dev/null 2>&1;
fi
	service dropbear restart > /dev/null 2>&1;
				
if [[ ${1+x} ]]; then
        MAX=$limitip;
fi

        cat /etc/passwd | grep "/home/" | cut -d":" -f1 > /etc/user.txt
        username1=( `cat "/etc/user.txt" `);
        i="0";
        for user in "${username1[@]}"
			do
                username[$i]=`echo $user | sed 's/'\''//g'`;
                jumlah[$i]=0;
                i=$i+1;
			done
			
			
        cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/log-db.txt
        proc=( `ps aux | grep -i dropbear | awk '{print $2}'`);
        for PID in "${proc[@]}"
			do
                cat /tmp/log-db.txt | grep "dropbear\[$PID\]" > /tmp/log-db-pid.txt
                NUM=`cat /tmp/log-db-pid.txt | wc -l`;
                USER=`cat /tmp/log-db-pid.txt | awk '{print $10}' | sed 's/'\''//g'`;
                IP=`cat /tmp/log-db-pid.txt | awk '{print $12}'`;
                 if [ $NUM -eq 1 ]; then
                 TIME=$(date +'%H:%M:%S')
                 echo "$USER $TIME : $IP" >>/tmp/ssh
                        i=0;
                        for user1 in "${username[@]}"
							do
                                if [ "$USER" == "$user1" ]; then
                                        jumlah[$i]=`expr ${jumlah[$i]} + 1`;
                                        pid[$i]="${pid[$i]} $PID"
                                fi
                                i=$i+1;
							done
                fi
			done
			
			
        cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/log-db.txt
        data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
        for PID in "${data[@]}"
			do
                cat /tmp/log-db.txt | grep "sshd\[$PID\]" > /tmp/log-db-pid.txt;
                NUM=`cat /tmp/log-db-pid.txt | wc -l`;
                USER=`cat /tmp/log-db-pid.txt | awk '{print $9}'`;
                IP=`cat /tmp/log-db-pid.txt | awk '{print $11}'`;
                if [ $NUM -eq 1 ]; then
                TIME=$(date +'%H:%M:%S')
                echo "$USER $TIME : $IP" >>/tmp/ssh
                        i=0;
                        for user1 in "${username[@]}"
							do
                                if [ "$USER" == "$user1" ]; then
                                        jumlah[$i]=`expr ${jumlah[$i]} + 1`;
                                        pid[$i]="${pid[$i]} $PID"
                                 fi
                                i=$i+1;
							done
                fi
        done
        
        
        j="0";
        for i in ${!username[*]}
         do
        limitip=$(cat /etc/xray/sshx/${username[$i]}IP)
         if [[ ${jumlah[$i]} -gt $limitip ]]; then
                        date=`date +"%Y-%m-%d %X"`;
                        echo "$date - ${username[$i]} - ${jumlah[$i]}" >> /etc/xray/sshx/${username[$i]}login;
                        sship=$(cat /etc/xray/sshx/${username[$i]}login | wc -l)
                        sship2=$(cat /tmp/ssh | grep -w "${username[$i]}" | cut -d ' ' -f 2-8 | nl -s '. ' )
                        ssssh1=$(ls "/etc/xray/sshx" | grep -w "notif")
                        if [[ -z ${sssh1} ]]; then
                        ssssh="3"
                        else
                        ssssh=$(cat /etc/xray/sshx/notif)
                        fi
if [ $sship = $ssssh ]; then
TEXT2="
<code>◇━━━━━━━━━━━━━━◇</code>
<b> ⚠️ SSH NOTIF MULOG </b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN : ${domen} </b>
<b>ISP : ${ISP} $CITY</b>
<b>DATE LOGIN : $DATE</b>
<b>USERNAME : ${username[$i]} </b>
<b>TOTAL LOGIN IP : ${jumlah[$i]} </b>
<code>◇━━━━━━━━━━━━━━◇</code>
     <b>TIME LOGIN : IP LOGIN </b>
<code>$sship2</code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>${ssssh}x Multi Login Auto Lock Account...</i>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT2&parse_mode=html" $URL >/dev/null
cd
exp=$(grep -i "### ${username[$i]}" "/etc/xray/ssh" | cut -d ' ' -f 3 | sort | uniq)
pass=$(grep -i "### ${username[$i]}" "/etc/xray/ssh" | cut -d ' ' -f 4 | sort | uniq)
echo "### ${username[$i]} $exp $pass" >> /etc/xray/sshx/listlock
        passwd -l ${username[$i]}
        cd
        rm -rf /etc/xray/sshx/${username[$i]}login
        systemctl restart ws-stunnel > /dev/null 2>&1
        systemctl restart ws-dropbear > /dev/null 2>&1
        else
        TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b> ⚠️ SSH NOTIF MULOG</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN : ${domen} </b>
<b>ISP : ${ISP} $CITY</b>
<b>DATE LOGIN : $DATE</b>
<b>USERNAME : ${username[$i]} </b>
<b>TOTAL LOGIN IP : ${jumlah[$i]} </b>
<code>◇━━━━━━━━━━━━━━◇</code>
     <b>TIME LOGIN : IP LOGIN </b>
<code>$sship2</code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>${sship}x Multi Login : ${ssssh}x Multi Login Auto Lock Account...</i>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
        fi
        if [ $sship -gt $ssssh ]; then
        exp=$(grep -i "### ${username[$i]}" "/etc/xray/ssh" | cut -d ' ' -f 3 | sort | uniq)
pass=$(grep -i "### ${username[$i]}" "/etc/xray/ssh" | cut -d ' ' -f 4 | sort | uniq)
echo "### ${username[$i]} $exp $pass" >> /etc/xray/sshx/listlock
        passwd -l ${username[$i]}
        cd
        rm -rf /etc/xray/sshx/${username[$i]}login
        systemctl restart ws-stunnel > /dev/null 2>&1
        systemctl restart ws-dropbear > /dev/null 2>&1
        fi
                        j=`expr $j + 1`;
                fi
 			done
        if [ $j -gt 0 ]; then
                if [ $OS -eq 1 ]; then
                        service ssh restart > /dev/null 2>&1;
                fi
                if [ $OS -eq 2 ]; then
                        service sshd restart > /dev/null 2>&1;
                fi
                service dropbear restart > /dev/null 2>&1