#!/bin/bash

# Procura processo

PROCESSO=$1

VALIDA=$(ps aux | grep -m 1 "$PROCESSO" | grep -v grep)

while [ "$VALIDA" ];
do
	echo Processo $PROCESSO nao esta em execucao
	sleep 4
	VALIDA=$(ps aux | grep "$PROCESSO" | grep -v grep)
done
	
echo Processo $PROCESSO nao esta em execucao

