#!/bin/bash
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>

###############################################################################
# Esse script verifica o tamanho do home, caso ele chegue a 75% um email eh 
# enviando ao administrador para que verifique o tamanho do home
#
# Esse script pode ser colocado no cron pois sua utilizacao nao depende de nada
###############################################################################

HOST=$1
BUSCA=$2
EMAIL=goldoni@ggaunicamp.com

#procura pela particao da variavel BUSCA no comando df  e imprime a quinta coluna removendo o % do fim
#coluna referente ao valor utilizado
VALOR=$(ssh $HOST "df -h | grep $BUSCA | awk '{print \$5}' | tr -d %")

#echo $VALOR

if [ "$VALOR" -gt 75 ];
then
	#echo verificar tamanho do home
	echo "O $BUSCA de $HOST ultrapassou 75%! Verificar!" | mail -s "Verificar $HOST " $EMAIL
fi


#COTA=$(xfs_quota -x -c 'report -h' /home | grep day | awk '{print $1}')
#COTA=$(cat /tmp/teste1 | grep day | awk '{print $1}')

if [ "$COTA" != "" ];
then
#    echo $COTA
    echo "Existem usuarios que entraram na politica de cotas em disco, verificar!" | mail -s "Verificar Cotas em disco" $EMAIL
fi
