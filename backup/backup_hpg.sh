#/bin/bash
#####################################################################
#Script de backup feito pela equipe de suporte do HPG
#Versao 0.1 (24/04/2019)
#Versao 0.2 (23/05/2019)

#####################################################################
#Politica
# Incremental   -> flag = 1
#                O backup incremental eh feito em uma mesma pasta. Arquivos apagados na origem sao apagados no destino

#Full           -> flag = 2
#               O backup é criado da forma <caminho>/<nome_backup><data>/
#####################################################################
#Saidas
# exit 1 -> date ou rsync nao encotrado
# exit 2 -> pasta de backup nao existe e nao foi criada
#####################################################################
#FLAG para incremental 1, para full 2
FLAG=$1

#Qual a pasta sera backupiada
ORIGEM=$2

#Destinos do incremental e do full
DESTINO=$3

#Numero de semanas
SEMANAS=$4

#Nome do backup
NOME=$5

#####################################################################
#Validando local dos logs
    if [ -d /var/log/backup_hpg ]; then 
        BACKUP_LOG=/var/log/backup_hpg
    else
        mkdir -p /var/log/backup_hpg
        if [ $? -eq 0 ]; then
            BACKUP_LOG=/var/log/backup_hpg
        else
            echo "Nao foi possivel criar a pasta /var/log/backup_hpg" >> /tmp/log_$NOME$(date +_%Y-%m-%d)
            exit 2
        fi
    fi


#####################################################################
#Opçoes do rsync e do log
OPT_RSYNC="-vazP --delete --delete-excluded --sparse"
RSYNC_LOG="--log-file=$BACKUP_LOG/rsync_$NOME$(date +_%Y-%m-%d).log"
echo -e ".gvfs\n.thumbnails/*\n.mozilla/firefox/*\n.default/Cache/*\n.cache/*\n.local/share/Trash/*\n.Trash/*i\n~/.Trash/*\n.adobe/*\n.config/*\n" > /tmp/arqaux$NOME
OPT_RSYNC_EXCLUDE="--exclude-from=/tmp/arqaux$NOME"


#####################################################################
## Verifica pre requisitos ##
which rsync &> /dev/null 
if [ $? -ne 0 ]; then
    echo "Rsync nao encontrado! Verifique a variável PATH e se o pacote rsync esta instalado. Finalizando."  >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
    exit 1
fi
which date &> /dev/null 
if [ $? -ne 0 ]; then 
    echo "Date nao encontrado. Verifique a variável PATH e se o pacote date está instalado. Finalizando."  >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
    exit 1
fi


#####################################################################
#Validando a forma de executar o script
if [ $# -ne 5 ]; then
    echo "usage: ./backup_hpg.sh <1,2> origem destino semanas "
    exit 1;
fi


#####################################################################
#Fazendo backup incremental
if [ $FLAG -eq 1 ]; then
   
    echo "Iniciando backup incremental $(date +%Y-%m-%d)"  >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
    #rsync $OPT_RSYNC $OPT_RSYNC_EXCLUDE $RSYNC_LOG $ORIGEM/ $DESTINO/$NOME >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
    rsync $OPT_RSYNC $OPT_RSYNC_EXCLUDE $RSYNC_LOG $ORIGEM/ $DESTINO/$NOME 
    echo "Finalizando backup incremental $(date +%Y-%m-%d)"  >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)

#####################################################################
#Fazendo backup full
else
    #verifica se ja existe uma pasta criada com o mesmo "nome": Se existe ele faz incremental. Se nao existe, ele faz
    if [ -d $DESTINO/$NOME$(date +_%Y-%m-%d) ]; then
        echo "A pasta desse dia ja existia! Iniciando backup incremental $(date +%Y-%m-%d)"  >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
        #rsync $OPT_RSYNC $OPT_RSYNC_EXCLUDE $RSYNC_LOG $ORIGEM/ $DESTINO/$NOME >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
        rsync $OPT_RSYNC $OPT_RSYNC_EXCLUDE $RSYNC_LOG $ORIGEM/ $DESTINO/$NOME 
        echo "Finalizando backup incremental de pasta existe $(date +%Y-%m-%d)"  >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)

    else
        echo "Iniciando backup full $(date +%Y-%m-%d)"  >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
        #rsync $OPT_RSYNC $OPT_RSYNC_EXCLUDE $RSYNC_LOG $ORIGEM/ $DESTINO/$NOME$(date +_%Y-%m-%d) >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
        rsync $OPT_RSYNC $OPT_RSYNC_EXCLUDE $RSYNC_LOG $ORIGEM/ $DESTINO/$NOME$(date +_%Y-%m-%d) 
        echo "Finalizando backup full $(date +%Y-%m-%d)"  >> $BACKUP_LOG/log_$NOME$(date +_%Y-%m-%d)
    fi
    
    #verifica se existem pastas com mais de N semanas e apaga
    find $DESTINO/ -type d -ctime +$(( $SEMANAS*7 ))  | grep $NOME | xargs rm -rf  

fi

rm /tmp/arqaux$NOME 

#verifica se existem arquivos de log com mais de N semanas e apaga
find  $BACKUP_LOG/ -type f -ctime +$(( $SEMANAS*7 )) -exec rm {} \;
