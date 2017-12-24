###############################################################################
# Crie um script que receba um nome de usuário como parâmetro e exiba as
# seguintes informações:
# UID do usuário
# Nome Completo / Descrição do Usuário
# Total em Uso no /home do usuário
# Informações do último login do usuário
# [Opcional] Validar se o usuário existe ou não sem o uso do if, que ainda
# não foi estudado. Se não existir retorne o exit code 1, se existir retorne
# exit 0
###############################################################################
NOME=$1
echo ""
echo Nome Completo: $(cat /etc/passwd | grep $NOME | cut -d":" -f5| tr -d ,)
echo ""
echo ID: $(cat /etc/passwd | grep $NOME | cut -d":" -f3)
echo ""
echo Total em uso /home: $(du -sh /home/$(cat /etc/passwd | grep $NOME | cut -d":" -f1))
echo ""
echo Ultimo login $(w | grep  $NOME)
echo ""
