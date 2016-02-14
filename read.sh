#!/bin/bash

## Essse programa testa a entrada de paramentros para um script

nome=$1
idade=$2

echo Digite o sobrenome
read sobrenome

# "$#" mostra o numero de paramentros de entrada
echo Foram passados $# argumentos.

# "$8" mostra todos os paramentros de entrada
echo Foram passados $* como paramentros.

echo $nome $sobrenome $idade

#com a opçao -p pode-se levar uma frase e guardar cada palavra
read -p 'Digite frase com 3 palavras ' pri seg ter

echo $pri $seg $ter
