NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
clear
domain=$(cat /usr/local/etc/xray/domain)
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "${BB}————————————————————————————————————————————————————${NC}"
echo -e "                  ${WB}Add Vless Account${NC}                 "
echo -e "${BB}————————————————————————————————————————————————————${NC}"
read -rp "User: " -e user
CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "${BB}————————————————————————————————————————————————————${NC}"
echo -e "                  Add Vless Account                 "
echo -e "${BB}————————————————————————————————————————————————————${NC}"
echo -e "${YB}A client with the specified name was already created, please choose another name.${NC}"
echo -e "${BB}————————————————————————————————————————————————————${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
add-vless
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\#= '"$user $exp"'\
},{"id": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless-grpc$/a\#= '"$user $exp"'\
},{"id": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink1="vless://${user}@104.18.25.139:443?sni=${domain}&host=${domain}&type=ws&security=tls&path=%2Fvless&encryption=none#Tsel_Edu_${domain}"
vlesslink2="vless://${user}@${domain}:80?host=myorbit.id&path=%2Fkuota-habis%2F&encryption=none&type=ws#Orbit_${domain}"
vlesslink3="vless://${user}@104.18.23.187:443?host=${domain}&path=%2Fvless&type=ws&encryption=none&security=tls&sni=${domain}#Tsel_GameMax_${domain}"
vlesslink4="vless://${user}@investor.fb.com:80?host=${domain}&path=%2Fvless&type=ws&encryption=none&security=tls&sni=${domain}#XL_FB_${domain}"
vlesslink5="vless://${user}@104.17.3.81:443?host=${domain}&path=%2Fvless&type=ws&encryption=none&security=tls&sni=${domain}#XL_VIP_${domain}"
vlesslink6="vless://${user}@quiz.staging.vidio.com:80?host=${domain}&path=%2Fvless&type=ws&encryption=none#XL_Vidio_${domain}"
vlesslink7="vless://${user}@investors.spotify.com:443?host=${domain}&path=%2Fvless&type=ws&encryption=none&security=tls&sni=${domain}#XL_Spotify_${domain}"
vlesslink8="vless://${user}@df.game.naver.com:80?host=${domain}&path=%2Fvless&type=ws&encryption=none#XL_WLG_${domain}"
cat > /var/www/html/vless/vless-$user.txt << END
==========================
Vless WS (CDN) TLS
==========================
- name: Vless-$user
type: vless
server: ${domain}
port: 443
uuid: ${user}
cipher: auto
udp: true
tls: true
skip-cert-verify: true
servername: ${domain}
network: ws
ws-opts:
path: /vless
headers:
Host: ${domain}
==========================
Vless WS (CDN)
==========================
- name: Vless-$user
type: vless
server: ${domain}
port: 80
uuid: ${user}
cipher: auto
udp: true
tls: false
skip-cert-verify: false
network: ws
ws-opts:
path: /vless
headers:
Host: ${domain}
==========================
Vless gRPC (CDN)
==========================
- name: Vless-$user
server: $domain
port: 443
type: vless
uuid: $user
cipher: auto
network: grpc
tls: true
servername: $domain
skip-cert-verify: true
grpc-opts:
grpc-service-name: "vless-grpc"
==========================
Link Vless Account
==========================
Link TL   : vless://$user@$domain:443?path=/vless&security=tls&encryption=none&host=$domain&type=ws&sni=$domain#$user
==========================
Link NTLS : vless://$user@$domain:80?path=/vless&security=none&encryption=none&host=$domain&type=ws#$user
==========================
Link gRPC : vless://$user@$domain:443?security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=$domain#$user
==========================
Sample Injek Bug
==========================
Tsel RG   : vless://$user@104.18.2.2:443?path=/vless&security=tls&encryption=none&host=$domain&type=ws&sni=$domain#Tsel_RG
XL Vidio : vless://$user@quiz.staging.vidio.com:80?path=/vless&security=none&encryption=none&host=$domain&type=ws#XL_Vidio
END
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
systemctl restart xray
clear
echo -e "${BB}————————————————————————————————————————————————————${NC}" | tee -a /user/log-vless-$user.txt
echo -e "                    Vless Account                   " | tee -a /user/log-vless-$user.txt
echo -e "${BB}————————————————————————————————————————————————————${NC}" | tee -a /user/log-vless-$user.txt
echo -e "Remarks       : ${user}" | tee -a /user/log-vless-$user.txt
echo -e "Domain        : ${domain}" | tee -a /user/log-vless-$user.txt
echo -e "ISP           : $ISP" | tee -a /user/log-vless-$user.txt
echo -e "City          : $CITY" | tee -a /user/log-vless-$user.txt
echo -e "Wildcard      : (bug.com).${domain}" | tee -a /user/log-vless-$user.txt
echo -e "Port TLS      : 443" | tee -a /user/log-vless-$user.txt
echo -e "Port NTLS     : 80" | tee -a /user/log-vless-$user.txt
echo -e "Port gRPC     : 443" | tee -a /user/log-vless-$user.txt
echo -e "Alt Port TLS  : 2053, 2083, 2087, 2096, 8443" | tee -a /user/log-vless-$user.txt
echo -e "Alt Port NTLS : 8080, 8880, 2052, 2082, 2086, 2095" | tee -a /user/log-vless-$user.txt
echo -e "id            : ${user}" | tee -a /user/log-vless-$user.txt
echo -e "Encryption    : none" | tee -a /user/log-vless-$user.txt
echo -e "Network       : Websocket, gRPC" | tee -a /user/log-vless-$user.txt
echo -e "Path          : /vless" | tee -a /user/log-vless-$user.txt
echo -e "ServiceName   : vless-grpc" | tee -a /user/log-vless-$user.txt
echo -e "Alpn          : h2, http/1.1" | tee -a /user/log-vless-$user.txt
echo -e "${BB}————————————————————————————————————————————————————${NC}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "Injek Tsel Pendidikan : " | tee -a /user/log-vless-$user.txt
echo -e "${vlesslink1}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "Injek Orbit Opok :  " | tee -a /user/log-vless-$user.txt
echo -e "${vlesslink2}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "Injek GameMax :  " | tee -a /user/log-vless-$user.txt
echo -e "${vlesslink3}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "Injek XL FB :  " | tee -a /user/log-vless-$user.txt
echo -e "${vlesslink4}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "Injek XL VIP :  " | tee -a /user/log-vless-$user.txt
echo -e "${vlesslink5}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "Injek XL Vidio :  " | tee -a /user/log-vless-$user.txt
echo -e "${vlesslink6}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "Injek XL Spotify :  " | tee -a /user/log-vless-$user.txt
echo -e "${vlesslink7}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "Injek WLG :  " | tee -a /user/log-vless-$user.txt
echo -e "${vlesslink8}" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "@burhansyam | Exp : $exp" | tee -a /user/log-vless-$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m" | tee -a /user/log-vless-$user.txt
echo -e "${BB}————————————————————————————————————————————————————${NC}" | tee -a /user/log-vless-$user.txt
echo -e "Format Clash  : http://$domain:8000/vless/vless-$user.txt" | tee -a /user/log-vless-$user.txt
echo -e "${BB}————————————————————————————————————————————————————${NC}" | tee -a /user/log-vless-$user.txt
echo -e "Expired On    : $exp" | tee -a /user/log-vless-$user.txt
echo -e "${BB}————————————————————————————————————————————————————${NC}" | tee -a /user/log-vless-$user.txt
echo " " | tee -a /user/log-vless-$user.txt
echo " " | tee -a /user/log-vless-$user.txt
echo " " | tee -a /user/log-vless-$user.txt
echo " " | tee -a /user/log-vless-$user.txt
echo " " | tee -a /user/log-vless-$user.txt
echo " " | tee -a /user/log-vless-$user.txt
echo " " | tee -a /user/log-vless-$user.txt
echo " " | tee -a /user/log-vless-$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
clear
vless
