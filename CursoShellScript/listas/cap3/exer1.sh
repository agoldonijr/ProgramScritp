#!/bin/bash

###############################################################################
#  Crie um Script que após executado solicite dois valores como entrada. 
#  Esses valores devem ser somados e o resultado exibido para o usuário.
###############################################################################

VALOR1=$1
VALOR2=$2

echo $(expr $VALOR1 + $VALOR2)
