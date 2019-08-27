# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>

#!/bin/bash

MIN_UID=$(grep "^UID_MIN" /etc/login.defs | tr -s "\t" | cut -f2)
MAX_UID=$(grep "^UID_MAX" /etc/login.defs | tr -s "\t" | cut -f2)

OLDIFS=$IFS
IFS=$'\n'

#cabecalho
echo -e "USUARIO\t\tUID\t\tDIR HOME\t\tNOME\t\tESPACO USADO"

for i in $(cat /etc/passwd)
do
	USERID=$(echo $i | cut -d":" -f3)
	if [ "$USERID" -ge "$MIN_UID" -a "$USERID" -le "$MAX_UID" ]
	then
		USER=$(echo $i | cut -d":" -f1)
		USERDESC=$(echo $i | cut -d":" -f5 | tr -d ',')
		USERHOME=$(echo $i | cut -d":" -f6)
		TAMHOME=$(du -sh /home/$USER | tr -d "/home/$USER")
		echo -e "$USER\t\t$USERID\t\t$USERHOME\t\t$USERDESC\t\t$TAMHOME"
	fi
done

IFS=$OLDIFS
