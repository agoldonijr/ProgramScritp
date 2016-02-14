#!/bin/bash

# Nesse programa vamos testar os operadores booleanos
# Temos os seguintes operados: 
# -a ou (and)
# -o ou (or)
# ! or (not)

user=$USER
hora="$(date +%H)" #nesse caso, estou pegando apenas a hora
#hora="$(date +%M)" Nesse caso, estaria pegando os minutos
echo $hora

if [ $user == "goldoni" -a $hora -gt 11 ];
then
	echo Acordou tarde hein!
else
	echo xablau!
fi
