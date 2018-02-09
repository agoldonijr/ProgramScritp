#!/bin/bash

###############################################################################
# Esse script verifica o tamanho do home, caso ele chegue a 75% um email eh 
# enviando ao administrador para que verifique o tamanho do home
#
# Esse script pode ser colocado no cron pois sua utilizacao nao depende de nada
#
# PS: A parte do envio do e-mail não esta feita
###############################################################################

#VALOR=$(df -h | grep home | tail -c 10 | tr -d "% /home")
VALOR=$(df -h | grep home | tr -s " " | tr -s ' ' ':' | cut -d":" -f5 | tr -d "%")

if [ "$VALOR" -gt 75 ];
then
	echo verificar tamanho do home
fi
