###############################################################################
#Crie um script que gere um relatório de algumas informações da máquina atual:
# Nome da Máquina
# Data e Hora Atual
# Desde quando a máquina está ativa
# Versão do Kernel
# Quantidade de CPUs/Cores
# Modelo da CPU
# Partições
###############################################################################

echo "Relatorio de maquina"
echo Nome da maquina: $HOSTNAME
echo ""
echo Data: $(date "+%H:%M %d/%m/%Y")
echo ""
echo Uptime: $(uptime -s)
echo ""
echo Kernel: $(uname -r)
echo ""
echo $(lscpu | grep "CPU(s)" -m 1)
echo ""
echo $(lscpu | grep "Model name" -m 1)
echo ""
echo ""
echo Particoes: 
df -h
