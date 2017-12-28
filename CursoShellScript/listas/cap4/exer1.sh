#!/bin/bash

###############################################################################
# Crie um script que baseado no horário atual escreva “Bom Dia”, “Boa Tarde” ou
# “Boa Noite”. Considere que o começo do dia às 06:00.
# O mesmo script deve mostrar também a hora atual no formato de 0 a 12,
# indicando AM ou PM.
# Exemplo de Execução:
# $ ./HoraAtual.sh
# Boa Tarde!
# A hora atual é: 3:39 PM
###############################################################################

HORA=$(date +%H)

if [ "$HORA" -ge 6 -a "$HORA" -le 12 ];
then
	echo "Bom dia"
elif [ "$HORA" -gt 12 -a "$HORA" -le 18 ];
then
	echo "Boa tarde"
else
	echo "Boa noite"
fi

echo -n "A hora atual é "
HORA=$(date +%I)
if [ "$HORA" -gt 11 ];
then
	echo $(date +%I:%M) PM
else
	echo $(date +%I:%M) AM
fi
	
