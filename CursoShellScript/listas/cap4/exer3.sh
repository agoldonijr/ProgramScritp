#!/bin/bash

###############################################################################
# Crie um script que receba do usuário 2 valores e em seguida exiba um menu
# para ele escolha uma das 4 principais operações aritmétricas (soma,
# subtração, multiplicação e divisão). Após isso a operação e o resultado são
# exibidos ao usuário.
# Considere que:
# • O script deve validar e abortar a execução caso algum dos valores não
# seja informado
# • No caso de multiplicação, o script deve exibir uma mensagem de erro
# caso um dos valores seja 0, e então abortar
# • No caso de divisão, o script deve exibir uma mensagem de erro caso um
# dos valores seja 0, e então abortar
# • Também no caso de divisão, o script deve exibir se é uma divisão exata
# ou com resto.
###############################################################################

VAR1=$1
VAR2=$2

clear
echo ""
echo "1 = Soma"
echo "2 = Subtracao"
echo "3 = Multiplicacao"
echo "4 = Divisao"
echo ""
read op

case $op in
	1)
		echo -n "VAR1 + VAR2 = "
		expr $VAR1 + $VAR2
	;;
	2)
		echo -n "VAR1 - VAR2 = "
		expr $VAR1 - $VAR2
	;;
	3)
		echo -n "VAR1 * VAR2 = "
		expr $VAR1 \* $VAR2
	;;
	4)
		if [ $VAR2 = 0 ]
		then
			echo Divisao invalida
		else
			echo -n "VAR1 \ VAR2 = "
			expr $VAR1 / $VAR2
		fi
	;;
esac
