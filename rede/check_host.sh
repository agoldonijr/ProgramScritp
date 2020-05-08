# Copyright (C) 2020 Alcides Goldoni Junior <agoldonijr@gmail.com>

#
# Verifica se existe nmap e procura todas os equipamentos da rede e cria o arquivo no /tmp
#

#!/bin/bash

    which nmap  &> /dev/null 
    if [ $? -ne 0 ]; then
        echo "nmap nao encontrado!" 
        exit 1
    fi
    

    nmap -sP 192.168.1.0/24 | grep 192.168 | awk '{print $5}' > /tmp/hosts.txt
    for i in $( cat /tmp/hosts.txt ) 
        do
        ping -c 1 $i &> /dev/null
        
        if [[ $? -ne 0 ]]; then
            echo "$(date): ping failed. Host $i DOWN!"
        fi
    done


