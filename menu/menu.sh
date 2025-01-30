#!/bin/bash

NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
# Getting
ipsaya=$(wget -qO- ipinfo.io/ip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/burhansyam/scxray-test/main/ip"
checking_sc() {
  useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e ""
    echo -e "            ${RED}PERMISSION DENIED !${NC}"
    echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
    echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
    echo -e "             \033[0;33mContact Admin :${NC}"
    echo -e "      \033[0;36mTelegram${NC} t.me/@burhansyam"
    echo -e "      ${GREEN}WhatsApp${NC} wa.me/6282242228600"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    exit
  fi
}
checking_sc
clear
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray_service == "running" ]]; then
status_xray="${GB}[ ON ]${NC}"
else
status_xray="${RB}[ OFF ]${NC}"
fi
if [[ $nginx_service == "running" ]]; then
status_nginx="${GB}[ ON ]${NC}"
else
status_nginx="${RB}[ OFF ]${NC}"
fi
dtoday="$(vnstat | grep today | awk '{print $2" "substr ($3, 1, 3)}')"
utoday="$(vnstat | grep today | awk '{print $5" "substr ($6, 1, 3)}')"
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}')"
dmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $2" "substr ($3, 1 ,3)}')"
umon="$(vnstat -m | grep `date +%G-%m` | awk '{print $5" "substr ($6, 1 ,3)}')"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}')"
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
WKT=$(cat /usr/local/etc/xray/timezone)
DATE=$(date -R | cut -d " " -f -4)
MYIP=$(curl -sS ipv4.icanhazip.com)
# TOTAL ACC CREATE VMESS WS
vmess=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")
# TOTAL ACC CREATE  VLESS WS
vless=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")
# TOTAL ACC CREATE  VLESS TCP XTLS
trojan=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE  TROJAN
ss=$(grep -c -E "^#trx " "/usr/local/etc/xray/tcp.json")
# TOTAL ACC CREATE  TROJAN WS TLS
ss20=$(grep -c -E "^#trws " "/usr/local/etc/xray/trojan.json")
# TOTAL ACC SOCKS
ss22=$(grep -c -E "^#trws " "/usr/local/etc/xray/trojan.json")
clear
echo -e " \033[31m##########\033[33m##########\033[32m##########\033[34m##########\033[35m##########\033[36m##########\e[0m"
echo -e " \033[35m╭══════════════════════════════════════════════════════════╮\e[0m"
echo -e " \033[32m│$NC\033[33m     BURHANSYAM  TUNELING           $NC\033[35m│\e[0m"
echo -e " \033[31m╰══════════════════════════════════════════════════════════╯\e[0m"
echo -e " \033[33m╭══════════════════════════════════════════════════════════╮\e[0m"
echo -e " \033[35m│$NC ${YB}Service Provider${NC} ${WB}: $ISP${NC}"
echo -e " \033[35m│$NC ${YB}Timezone${NC}         ${WB}: $WKT${NC}"
echo -e " \033[35m│$NC ${YB}City${NC}             ${WB}: $CITY${NC}"
echo -e " \033[35m│$NC ${YB}Date${NC}             ${WB}: $DATE${NC}"
echo -e " \033[35m│$NC ${YB}Domain${NC}           ${WB}: $domain${NC}"
echo -e " \033[34m╰══════════════════════════════════════════════════════════╯\e[0m"
echo -e "     ${WB}NGINX STATUS :${NC} $status_nginx    ${WB}XRAY STATUS :${NC} $status_xray   "
echo -e " \033[36m╭══════════════════════════════════════════════════════════╮\e[0m"
echo -e " \033[35m│$NC          ${WB}━━━━━ [ Bandwidth Monitoring ] ━━━━━${NC}"
echo -e " \033[35m│$NC"
echo -e " \033[35m│$NC  ${GB}Today ($DATE)     Monthly ($(date +%B/%Y))${NC}  "
echo -e " \033[35m│$NC    ${GB}↓↓ Down: $dtoday          ↓↓ Down: $dmon${NC}   "
echo -e " \033[35m│$NC    ${GB}↑↑ Up  : $utoday          ↑↑ Up  : $umon${NC}   "
echo -e " \033[35m│$NC    ${GB}≈ Total: $ttoday          ≈ Total: $tmon${NC}   "
echo -e " \033[33m╰══════════════════════════════════════════════════════════╯\e[0m"
echo -e "      \e[${MB} Vmess   Vless   Trojan   SS   SS2022   Sockes5 \e[0m "    
echo -e "      \e[${MB}    $vmess         $vless       $trojan        $ss           $ss20           $ss22 \e[0m "
echo -e " \033[31m╭══════════════════════════════════════════════════════════╮\e[0m"
echo -e " \033[35m│$NC\033[33m                         MENU XRAY                        $NC\033[35m│\e[0m"
echo -e " \033[34m╰══════════════════════════════════════════════════════════╯\e[0m"
echo -e " \033[32m╭══════════════════════════════════════════════════════════╮\e[0m"
echo -e " \033[35m│$NC ${MB}[01]${NC} ${YB}Vmess Menu${NC}             ${MB}[06]${NC} ${YB}Socks5 Menu${NC}"
echo -e " \033[35m│$NC ${MB}[02]${NC} ${YB}Vless Menu${NC}             ${MB}[07]${NC} ${YB}All Acount Menu${NC}"
echo -e " \033[35m│$NC ${MB}[03]${NC} ${YB}Trojan Menu${NC}            ${MB}[08]${NC} ${YB}Log Create Account${NC}"
echo -e " \033[35m│$NC ${MB}[04]${NC} ${YB}Ssh Menu${NC}               ${MB}[09]${NC} ${YB}Backup Vps Menu${NC}"
echo -e " \033[35m│$NC ${MB}[05]${NC} ${YB}Shadowsoks2022 Menu${NC}    ${MB}[10]${NC} ${YB}Restore Vps Menu${NC}"
echo -e " \033[33m╰══════════════════════════════════════════════════════════╯\e[0m"
echo -e " \033[36m╭══════════════════════════════════════════════════════════╮\e[0m"
echo -e " \033[35m│$NC ${MB}[11]${NC} ${YB}Resart service${NC}         ${MB}[15]${NC} ${YB}Change Xray-core Mod${NC}"
echo -e " \033[35m│$NC ${MB}[12]${NC} ${YB}Speedtest${NC}              ${MB}[16]${NC} ${YB}Change Xray-core Official${NC}"
echo -e " \033[35m│$NC ${MB}[13]${NC} ${YB}Change Domain${NC}          ${MB}[17]${NC} ${YB}About Script${NC}"
echo -e " \033[35m│$NC ${MB}[14]${NC} ${YB}Cert Acme.sh${NC}           ${MB}[18]${NC} ${YB}Rebot vps${NC}"
echo -e " \033[32m╰══════════════════════════════════════════════════════════╯\e[0m"
echo -e " \033[31m╭══════════════════════════════════════════════════════════╮\e[0m"
echo -e " \033[33m│$NC  \e[${YB} Certificate Status   : Expired in $certifacate days"
echo -e " \033[33m│$NC  \e[${YB} Client Name          : $username"
echo -e " \033[32m╰══════════════════════════════════════════════════════════╯\e[0m"
echo -e " \033[31m##########\033[33m##########\033[32m##########\033[34m##########\033[35m##########\033[36m##########\e[0m"
echo -e ""
echo -e " ${WB}Press [ ctrl + c ] or Input x To Exit Script${NC}"
echo -e ""
read -p " Select Menu :  "  opt
echo -e ""
case $opt in
1) clear ; vmess ;;
2) clear ; vless ;;
3) clear ; trojan ;;
4) clear ; menu-ssh ;;
5) clear ; shadowsocks2022 ;;
6) clear ; socks ;;
7) clear ; allxray ;;
8) clear ; log-create ;;
9) clear ; Backup ;;
10) clear ; Restore ;;
11) clear ; restart ; systemctl daemon-reload ;;
12) clear ; speedtest ;;
13) clear ; dns ;;
14) clear ; certxray ;;
15) clear ; xraymod ;;
16) clear ; xrayofficial ;;
17) clear ; about ;;
18) clear ; reboot ; /sbin/reboot ;;
x) exit ;;
*) echo -e "salah input" ; sleep 0.5 ; menu ;;
esac
