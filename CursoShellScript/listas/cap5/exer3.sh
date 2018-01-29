#!/bin/bash

for user in /home/*
#comeco do lado onde verifica cada usuario
do
	MP4COUNT=0
	MP3COUNT=0
	JPGCOUNT=0
	PDFCOUNT=0
	OLDIFS=#IFS
	IFS=$'\n'

	for file in $(find $user -name '*.jpg' -o -name '*.mp4' -o -name '*.mp3' -o -name '*.pdf')
	#laco que procura os arquivos
	do
		case $file in
			*.mp4)
				MP4COUNT=$(expr $MP4COUNT + 1)
				;;

			*.mp3)
				MP3COUNT=$(expr $MP3COUNT + 1)
				;;
			*.jpg)
				JPGCOUNT=$(expr $JPGCOUNT + 1)
				;;
			*.pdf)
				PDFCOUNT=$(expr $PDFCOUNT + 1)
				;;
		esac
	done
	#fim do laco que procura os arquivos
	
	echo "Usuario: $(basename $user)"
	echo "Arquivos JPG: $JPGCOUNT"
	echo "Arquivos MP3: $MP3COUNT"
	echo "Arquivos MP4: $MP4COUNT"
	echo "Arquivos PDF: $PDFCOUNT"
	echo
done
#fim do laco para cada usuario

