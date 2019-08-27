# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>

#!/bin/bash

###############################################################################
# Esse script procura os pacotes faltantes de uma maquina baseada numa maquina
# que esteja padrão. Ele recebe os arquivos texto com os pacotes das maquians
# que podem ser gerados atraves de comando como dpkg --get-selections para
# distribuicoes Debia like
#
# Utilizacao:
# ./procuraPacote.sh <arquivoPadrao> <arquivoParaBuscar>
###############################################################################
PADRAO=$1
BUSCAR=$2

echo Pacotes nao encontrados:
#for i in $(cat pacotesMinime)
for i in $(cat $PADRAO)
do
	grep $i $BUSCAR> /dev/null
	if [ $? -eq 1 ]
	then
		echo $i 
	fi
done
