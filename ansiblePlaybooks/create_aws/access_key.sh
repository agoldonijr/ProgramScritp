#!/bin/bash


which ansible 2&>1 /dev/null
if [[ $? -eq 1 ]]; then
    echo "asnible nao instalado ou fora do PATH\n Verificar"
    exit 1
fi 


if [[ "$AWS_ACCESS_KEY_ID" == "" && "AWS_SECRET_ACCESS_KEY" ==  "" ]]; then
    echo "Exportar access keu id e secret access key"
    #export AWS_ACCESS_KEY_ID=""
    #export AWS_SECRET_ACCESS_KEY=""
    exit 1
fi


