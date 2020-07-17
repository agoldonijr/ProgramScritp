# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>

#!/bin/bash
#####################################################################
#Script de shutdown de emergencia feito pela equipe de suporte do HPG

#####################################################################
#Politica
#Caso a temperatura do processador chegue a 80 graus, automaticamente
#o computador é desligado

## Verifica pre requisitos ##
WHO=$(whoami)
if [ $WHO !=  "root" ]; then
    echo "Run as root or sudo!"  
    exit 2
fi
command -v python3 &> /dev/null
if [ $? -ne 0 ]; then
    echo "Python3 nao encontrado! $(date)"  >> /var/log/shutdown_emergencia
    command -v python &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Python2 nao encontrado! $(date)"  >> /var/log/shutdown_emergencia
        echo "Impossivel prosseguir. Finalizando! $(date)"  >> /var/log/shutdown_emergencia
        exit 2
    else
        PT=$(command -v python)
    fi
fi
PT=$(command -v python3)

command -v sensors &> /dev/null
if [ $? -ne 0 ]; then
    echo "sensors nao encontrado! $(date)"  >> /var/log/shutdown_emergencia
    exit 2
fi

SENSORS=$(command -v sensors)
#echo $SENSORS

VALOR=$(sensors | grep temp | awk '{print $2}' | tr -d + | tr -d "°C" )
#echo $VALOR

if (( $(echo "$VALOR > 20" |bc -l) ));
then
    wall "System is going down in 15 seconds. Temperature is too high "
    sleep 15
    echo "System is going down in 15 seconds. Temperature is too high! $VALOR Degrees"  >> /var/log/shutdown_emergencia
    echo $(date) >> /var/log/shutdown_emergencia
    $PT ./sendMensageTelegram.py "Desligamento de emergencia $(hostname) $(date +%d-%m-%Y)" 
    #shutdown -h now
fi
