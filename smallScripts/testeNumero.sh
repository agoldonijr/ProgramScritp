#!/bin/bash

read -p  'Informe dois numeros' num1 num2
echo $num1 $num2
#o operado -eq refere-se a equal
if [ $num1 -eq $num2 ]; 
	then echo iguais
fi
#o operador -gt refere-se greater than (maior que)
if [ $num1 -gt $num2 ]; 
	then echo $num1 é maior que $num2
fi
# o operador -lt refere-se a less than (menor que)
if [ $num1 -lt $num2 ]; 
	then echo $num2 é maior que $num1
fi

#ainda temos: 
# -ge greater or equal
# -lt less than
# -le less or equal
# -ne Not equal
echo fim
