#!/bin/bash
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>
# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
#################################################################################################
#			Scrtip para roteamento							#
#################################################################################################

PATH=/sbin:/usr/sbin:/bin:/usr/bin
# Criando as variaveis referentes as interfaces de redes onde: 
# I_ETH refere-se a interface interna
# E_ETH refere-se a interface externa
I_ETH=enp3s0
E_ETH=enp4s0

#endereco de rede interna
REDE='172.16.0.0/24'


# Os proximos comando server para limpar todas as regras que por ventura 
# estejam rodando nas em alguma tabela de roteamento (nat, mangle, filter)
iptables --flush
iptables --table nat --flush
iptables --table mangle --flush
iptables --delete-chain

# Comando de roteamento:

# Permite um input(pacotes de entrada) pela interface lo 
iptables --append INPUT --in-interface lo --jump ACCEPT

# Permite o encaminhamento se já existir uma conexao estabelecida
iptables --append INPUT --match state --state ESTABLISHED,RELATED --jump ACCEPT

# Permite o encaminhamento de pacotes novos pela interface externa
iptables --append INPUT --match state --state NEW --in-interface $E_ETH --jump ACCEPT

# Permite o encaminhamento da interface externa para interface interna quando já existir uma conexao estabelecida
iptables --append FORWARD --in-interface $E_ETH --out-interface $I_ETH --match state --state ESTABLISHED,RELATED --jump ACCEPT

# Faz o encaminhamento da interface interna para a interface externa
iptables --append FORWARD -i $I_ETH -o $E_ETH --jump ACCEPT

# Faz o pós roteamento da rede 172.16.10.0/24 pela interface externa seja mascarada
iptables --table nat --append POSTROUTING --source $REDE --out-interface $E_ETH --jump MASQUERADE
