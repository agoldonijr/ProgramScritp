#!/bin/bash

############################################################################### 
# Crie um script que gere um arquivo compactado de backup de todo o diretório
# home do usuário atual (/home/<usuario>).
# Considere que:
# • O arquivo de backup será criado no diretório /home/<usuario>/Backup
# • O nome do arquivo de backup deve seguir o padrão
# backup_home_AAAAMMDDHHMM.tgz, exemplo
# backup_home_201708241533.tgz
# • Caso o diretório /home/<usuario>/Backup não exista, o script deve criá-lo
# • Antes de criar o backup, o script deve consultar se existe algum arquivo
# de backup criado na última semana. Se exisitir, o usuário deve ser
# consultado se deseja continuar. Se o usuário optar por não continuar, o
# script deve abortar com código de saída 1.
# • Após gerar o backup, o script deve informar o nome do arquivo gerado.
# Exemplo de Execução:
# $ ./GeraBackupHome.sh
# Já foi gerado um backup do diretório /home/ricardo nos últimos 7 dias.
# Deseja continuar? (N/s): s
# Será criado mais um backup para a mesma semana
# Criando Backup...
# O backup de nome "backup_home_201708241547.tgz" foi criado em
# /home/ricardo/Backup
# Backup Concluído!
############################################################################### 

DESTINO=$HOME/backup

if [ ! -d $DESTINO ]
then
	echo Criando diretorio $DESTINO
	mkdir -p $DESTINO
fi

#Verifica se existe um arquivos de backup com menos de 7 dias
DAYS=$(find $DESTINO -ctime -7 -name backup_home\*.tgz) 

if [ "$DAYS" ] #testando se a variavel é nula
then
	echo "Já foi gerado um backup no diretório $HOME  nos ultimos 7 dias"
	echo -n "Deseja continuar? (N/s): "
	read -n1 CONT
	echo
	if [ "$CONT" = N -o "$CONT" = n -o "$CONT" = "" ]
	then
		echo Abortado!
		exit 1
	elif [ "$CONT" = s -o "$CONT" = S ]
	then
		echo "Será criado outro backup na mesma semana"
	else
		echo "Opcao invalida"
		exit 2
	fi
fi

echo "Criando backup... "
ARQ="backup_home+$(date +%Y%m%d%H%M).tgz"

tar zcvpf $DESTINO/$ARQ --absolute-names --exclude="$DESTINO" --exclude=$HOME/down "$HOME"/* > /dev/null

echo
echo "O backup de nome \""$ARQ"\"foi criado em $DESTINO"
echo
echo "Concluido"
