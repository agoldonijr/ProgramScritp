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
