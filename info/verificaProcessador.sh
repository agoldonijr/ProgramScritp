#!/bin/bash

###############################################################################
# Esse script verifica se alguem esta logado e se sim, verifica as porcentagem
# de utilizacao da CPU para instantaneo, cinco e dez minutos
###############################################################################

#EMAIL=goldoni@ggaunicamp.com

INST=$(awk '{print $1}'< /proc/loadavg)
CINCO=$(awk '{print $2}'< /proc/loadavg)
DEZ=$(awk '{print $3}'< /proc/loadavg)


while [ $(w | wc -l) -gt 1 ]; do

    echo Inst $INST Cinco $CINCO Dez $DEZ  >> /tmp/logProcessador.txt
    sleep 3
    
    free -m >> /tmp/logMemoria.txt
    dmesg > /tmp/logDmesg.txt
done

    #echo "Existem usuarios que entraram na politica de cotas em disco, verificar!" | mail -s "Verificar Cotas em disco" $EMAIL
