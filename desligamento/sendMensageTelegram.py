#!/usr/bin/python3.5


# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>


import requests
import sys 

def telegram_bot_sendtext(bot_message):
    

    #Para criar o toker é preciso usar o @botfather e seguir as instrucoes no telegram
    bot_token = ''
    #para o chat id, adicione o bote criado acima em um grupo e execute a linha abaixo no navegador
    #https://api.telegram.org/bot<bot token>/getUpdates
    #na opcao "chat" busque pelo ID
    bot_chatID = ''

    send_text = 'https://api.telegram.org/bot' + bot_token + '/sendMessage?chat_id=' + bot_chatID + '&text=' + bot_message

    response = requests.get(send_text)

    return response.json()
    
## MAIN #
text = sys.argv[1] 
#print (text)
telegram_bot_sendtext(text)
#test = telegram_bot_sendtext("Bora mandar mensagem para os outros pelo telegram?")
#print(test)
