#!/bin/bash
RP="https://raw.githubusercontent.com/ptchnew/L2/main/install"

wget -O /usr/local/bin/ws-dropbear ${RP}/ws-dropbear
chmod +x /usr/local/bin/ws-dropbear

cat > /etc/systemd/system/ws-nontls.service << END
[Unit]
Description=Python Proxy Mod By PainTech 
Documentation=https://painshop.id
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-dropbear
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

wget -O /usr/local/bin/ws-stunnel ${RP}/ws-stunnel
chmod +x /usr/local/bin/ws-stunnel

# Installing Service
cat > /etc/systemd/system/ws-stunnel.service << END
[Unit]
Description=Python Proxy Mod By PAINTECH
Documentation=https://painshop.id
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-stunnel
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service
