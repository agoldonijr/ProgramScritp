#!/bin/bash

# Procura processo

PROCESSO=$1
if [ $# -eq 0 ]
then
	echo "Favor informar o nome do processo"
	echo " ./exer2.sh <processo>"
	exit 1
fi

until ps aux | grep $PROCESSO | grep -v grep | grep -v $0
do
	
	echo Processo $PROCESSO NAO esta em execucao
	sleep 4
done
	
