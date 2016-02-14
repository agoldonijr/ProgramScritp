#!/bin/bash

#
# Esse Script tem como objetivo executar as funcoes basicas de uma calculadora
# Soma, subtracao, multiplicacao e divisao

clear

menu(){

echo Operacoes com inteiros
echo Escolha uma opcao
echo '1)Soma'
echo '2)Subtracao'
echo '3)Multiplicacao'
echo '4)Divisao'
echo '5)Sair'
echo '6)Script'
read op

case $op in
1) soma ;;
2) subtra ;;
3) mult ;;
4) div ;;
5) exit ;;
6) . script.sh ;;
*) "Opção Inexistente" ;
	clear ;
menu ;;

esac
}

soma(){
	clear;
	echo Digite o primeiro numero
	read num1;
	echo Digite o segundo numero
	read num2;
	echo 'Resposta =' $(($num1+$num2))
	menu	
}

subtra(){
	clear;
	echo Digite o primeiro numero
	read num1;
	echo Digite o segundo numero
	read num2;
	echo 'Resposta =' $(($num1-$num2))
	menu	
}

mult(){
	clear;
	echo Digite o primeiro numero
	read num1;
	echo Digite o segundo numero
	read num2;
	echo 'Resposta =' $(($num1*$num2))
	menu	
}

div(){
	clear;
	echo Digite o primeiro numero
	read num1;
	echo Digite o segundo numero
	read num2;
	echo 'Resposta =' $(($num1/$num2))
	menu	
}

echo Calculadora Basica
menu

