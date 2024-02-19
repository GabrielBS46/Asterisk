#!/bin/bash
# Script para aplicar regras básicas de firewall no PABX

NETWORK=192.168.0.0/24      # Verificar rede do cliente
EXTERNAL_1=100.100.100.100/32 # Ip1 
EXTERNAL_2=200.200.200.200/32  # Ip2

# Carregar modulos
modprobe ip_tables
modprobe iptable_nat
modprobe ip_conntrack
modprobe ip_conntrack_ftp
modprobe ip_nat_ftp
modprobe ipt_LOG
modprobe ipt_REJECT
modprobe ipt_MASQUERADE
modprobe ipt_state
modprobe ipt_multiport
modprobe iptable_mangle
modprobe ipt_tos
modprobe ipt_limit
modprobe ipt_mark
modprobe ipt_MARK

#Limpando regras

echo "Modulos carregados"

iptables -F
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
iptables -t mangle -F
iptables -t nat -F
iptables -X


# Politica de bloqueio geral
iptables -P INPUT DROP

# Permissoes padroes para loopback e conexoes relacionadas
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -m state --state RELATED -j ACCEPT

# Somente para IPs do Brasil

# Instalar CSV com IP dos paises
# apt-get install xtables-addons-common
# mkdir /usr/share/xt_geoip
# apt-get install libtext-csv-xs-perl unzip
# /usr/libexec/xtables-addons/xt_geoip_dl
# /usr/libexec/xtables-addons/xt_geoip_build -D /usr/share/xt_geoip *.csv

#iptables -A INPUT -m geoip --dst-cc BR -j ACCEPT

# Filtro por palavras de scanner
# kernel version : 2.6.18 ou acima
# iptables program(1.3.5 or acima
# Verificar arquivo /usr/src/linux-headers-6.1.0-17-amd64/.config possui a seguinte linha CONFIG_NETFILTER_XT_MATCH_STRING=m


iptables -I INPUT -p udp --dport 5060 -m string --string friendly-scanner --algo bm -j DROP
iptables -I INPUT -p udp --dport 5060 -m string --string sipvicious --algo bm -j DROP
iptables -I INPUT -p udp --dport 5060 -m string --string Ozeki --algo bm -j DROP
iptables -I INPUT -p udp --dport 5060 -m string --string sipcli --algo bm -j DROP
iptables -I INPUT -p udp --dport 5060 -m string --string VaxSIPUserAgent --algo bm -j DROP
iptables -I INPUT -p udp --dport 5060 -m string --string Cisco-SIPGateway --algo bm -j DROP

# ICMP
#iptables -A INPUT -p icmp -s $NETWORK -j ACCEPT

# SSH
iptables -A INPUT -p tcp -s $NETWORK --dport 22 -j ACCEPT

iptables -A INPUT -p tcp -s $EXTERNAL_1 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s $EXTERNAL_2 --dport 22 -j ACCEPT

# Web
iptables -A INPUT -p tcp -s $NETWORK --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -s $NETWORK --dport 443 -j ACCEPT

iptables -A INPUT -p tcp -s $EXTERNAL_1 --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -s $EXTERNAL_1 --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -s $EXTERNAL_2 --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -s $EXTERNAL_2 --dport 443 -j ACCEPT

# SIP + RTP
iptables -A INPUT -p udp -m udp -s $NETWORK --dport 5060 -j ACCEPT
iptables -A INPUT -p udp -m udp -s $NETWORK --dport 10000:20000 -j ACCEPT

iptables -A INPUT -p udp -m udp -s $EXTERNAL_1 --dport 5060 -j ACCEPT
iptables -A INPUT -p udp -m udp -s $EXTERNAL_1 --dport 10000:20000 -j ACCEPT
iptables -A INPUT -p udp -m udp -s $EXTERNAL_2 --dport 5060 -j ACCEPT
iptables -A INPUT -p udp -m udp -s $EXTERNAL_2 --dport 10000:20000 -j ACCEPT

# IAX
iptables -A INPUT -p udp -m udp -s $NETWORK --dport 4569 -j ACCEPT

iptables -A INPUT -p udp -m udp -s $EXTERNAL_1 --dport 4569 -j ACCEPT
iptables -A INPUT -p udp -m udp -s $EXTERNAL_2 --dport 4569 -j ACCEPT

echo "Carregado firewall com sucesso !!!"

service fail2ban restart

echo "fail2ban recarregado !!!"

### iptables -L -v -n


# etc/fail2ban/jail.d/asterisk.local

# [iptables-asterisk]
# enabled = true
# ignoreip = 192.168.0.0/24
# findtime = 300
# maxretry = 3
# bantime = 86400
# backend = polling
# logpath = /var/log/asterisk/messages
# filter  = asterisk
# action  = iptables[name=ASTERISK, port=5060, protocol=udp]
#           iptables-multiport[name=ASTERISK, port=10000:20000, protocol=udp]
