# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>

###############################################################################
# Esse script verifica se os repos estao montados
# Foi criado pelo Caian e atualizado pelo Alcides
# https://github.com/Caian
###############################################################################

#maquinas=("vader" "succubus" "scar" "negan" "baronesa" "alcapone" "loki" "charada" "kratos")

echo "Verificando repos...."
printf "IP \t Repo-Processamento \t Maquina"
echo "" 
for m in $(cat maquinas ) ; do
	printf "$m \t "

      	if [ $(ssh $m "ls -1 /opt/repo-processamento/ | wc -l") -eq 0 ]; then
            printf "\t Sem \t"
      	
        else
            printf "\t Ok \t"
	fi
        
        printf $(ssh $m " hostname ")

        echo ""
done
