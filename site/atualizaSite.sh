# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>

#!/bin/bash

###############################################################################
#
# atualizaSite.sh - Script de 
#
# Autor: Alcides Goldoni Junior (goldoni@ggaunicamp.com)
# Data Criação: 18/12/2017
# Modificacao 1: 19/02/2018
#
# Descrição: Script de para a atualização do site, ele clone o repositorio,
# Verifica se isso foi feito com sucesso e sincroniza com o diretorio correto
#
###############################################################################

SOURCE=$PWD/hpg-site
TARGET=/var/www/hpg-site
LOG=/root/log_site
EMAIL=suporte@ggaunicamp.com

date > $LOG
cd $SOURCE 
if [ $? == 0 ]; then
	git pull >> $LOG
	if [ $? == 0 ]; then
		echo "Pull feito com sucesso!" >> $LOG
	fi
else
	echo "Nao foi possivel fazer o pull, tentando clonar repositorio!" >> $LOG
	git clone https://github.com/hpg-cepetro/hpg-site >> $LOG
	if [ $? == 0 ]; then
		echo "Clone feito com sucesso!" >> $LOG
	else
		echo "Falha ao clonar!" >> $LOG
		echo "Falha ao clonar repositorio! Verifique o log!" | mail -s "Falha ao clonar o site" $EMAIL 
	fi
fi

rsync -av --delete-excluded $SOURCE/* $TARGET/ 2>&1 > /dev/null
if [ $? == 0 ]; then
	echo "Success!" >> $LOG
else
	echo "Rsync Error!" >> $LOG
	echo "Falha ao sincronizar repositorio com o site! Verifique o log!" | mail -s "Falha no Rsync" $EMAIL 
fi

systemctl restart apache2
