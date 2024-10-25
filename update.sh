#!/bin/bash
clear
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



sleep 1
exit