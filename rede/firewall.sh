#! /bin/bash

## Verifica pre requisitos ##
which iptables &> /dev/null
if [ $? -ne 0 ]; then
        echo "Iptables nao encontrado!"  
        exit 1
fi

IPT=$(which iptables)
echo $IPT

###############################################################################
# Variaveis 
ETHEXT=eth1
ETHINT=eth0
PORT_SSH=2022


###############################################################################
# Flush
$IPT --flush FORWARD
$IPT --flush blacklist
$IPT -X blacklist

###############################################################################
# Regras de blacklist 

#Criando a cadeia 
$IPT --new-chain  blacklist

$IPT --append blacklist --match recent --set --name BLACKLIST --rsource -j REJECT

$IPT --append INPUT -p tcp --dport $PORT_SSH -m state --state ESTABLISHED,RELATED -j ACCEPT

#negando pacotes fragmentados
$IPT --table mangle -A PREROUTING --fragment -j DROP

#limite de 50 acesso por minuto na porta de ssh
$IPT --append INPUT -p tcp --dport $PORT_SSH --match limit --limit 50/minute --limit-burst 100 -j ACCEPT

#Limite as conexões por IP de origem 
$IPT --append INPUT -p tcp -m connlimit --connlimit-above 10 -j REJECT --reject-with tcp-reset

# Limite novas conexões TCP por segunda por IP de origem 
$IPT --append INPUT -p tcp --match conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT

$IPT --append INPUT -p tcp --match conntrack --ctstate NEW -j DROP

$IPT --append INPUT -p tcp --match tcp --dport $PORT_SSH -m state --state NEW -m recent --rcheck --seconds 60 --hitcount 10 --name sshin --rsource -j blacklist

$IPT --append INPUT -p tcp --match tcp --dport $PORT_SSH -m state --state NEW -m recent --set --name sshin --rsource -j LOG --log-level 4 --log-prefix ' usuario entrou ' 2> /dev/null

$IPT --append INPUT -p tcp --match tcp --dport $PORT_SSH -m state --state NEW -m recent --set --name sshin --rsource -j ACCEPT

$IPT --append OUTPUT --match recent --rcheck --seconds 30 --name BLACKLIST --rdest -j REJECT --reject-with icmp-port-unreachable

# Proteção contra SSH força-bruta 
$IPT --append INPUT -p tcp --dport ssh --match conntrack --ctstate NEW -m recent --set

$IPT --append INPUT -p tcp --dport ssh --match conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP

# Proteção contra scanning de portas 
$IPT --new-chain port-scanning

$IPT --append port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN

$IPT --append port-scanning -j DROP
