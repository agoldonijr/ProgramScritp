# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>
# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
#!/bin/bash

PASTA=$1
ARQUIVO="/tmp/fdupes.log"

#Modo de utilizacao
if [ $# -ne 1 ]; then
    echo "      modo de uso: 
     ./arrumaFdupes.sh.swp <pasta>"

else
    #Verifica se o fdupes esta instalado
    which fdupes 1>&2 > /dev/null
    if [ $? -ne 0 ];
    then
        echo "Por favor, instale o fdupes"
        exit 0;

    else
        #encontra os arquivos duplicados e salva no arquivo /tmp/fdupes.log
        fdupes --recurse --size  --nohidden $PASTA > $ARQUIVO 

        #separa os tamanhos tamanhos e ordena
        cat $ARQUIVO | grep ^[0-9] | tr -s ' ' ':' | cut -d ":"  -f1 | sort -rg > $ARQUIVO-tamanhos.txt
     fi 
fi 
