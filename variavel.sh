#!/bin/bash

usuario=$USER
maquina=$HOSTNAME
caminho=$(pwd)
logados=$(users)

echo Nome do usuario $USER maquina $HOSTNAME
echo $caminho
echo logados $logados
echo $PATH
echo Posso criar um vetor
vet=($USER, $HOSTNAME)
echo Todos os elementos ${vet[*]}
echo Elemento 0 ${vet[0]}
echo Elemento 1 ${vet[1]}
