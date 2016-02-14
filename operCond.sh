#!/bin/bash

#para avaliar expressoes eh usado:
var=1

	test var = 0
		echo não é 1
	test var = 1
		echo é 1

#podemos fazer utilizando if[ ]then
	if [ -f /home/goldoni/.bashrc ]; 
		# Nesse if, verifico com o -f se o arquivo existe
	then
		echo existe!
	else	
		echo Não existe
	fi

# exite uma infinidades de parametros que podem ser usados dentro do if 
# para fazer uma infinidades de buscas. Existem os operadores booleanos
# e tambem os aritméticos
# Verificar man sh
