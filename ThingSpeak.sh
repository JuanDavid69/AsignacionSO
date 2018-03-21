#!/bin/bash

#Contar procesos
numProcesos=$(ps ax | tail -n +2 | wc -l)


#Porcentaje de memoria libre
valMemTotal=$(free | grep Mem | awk '{print $2}')
valMemLibre=$(free | grep Mem | awk '{print $4}')
valMemLibre=$((${valMemLibre} * 100))
memLibre=$((${valMemLibre} / ${valMemTotal}))

#Porcentaje libre de disco
discoUsado=$(df | grep root |awk '{print $5}' | sed 's/.$//g')
discoLibre=$((100 - ${discoUsado}))

#Se envia la informacion a thingspeak.com
curl --silent --request POST --header "X-THINGSPEAKAPIKEY: DZRZDQCO3IVESK5Z" --data "field1=${numProcesos}&field2=${memLibre}&field3=${discoLibre}" http://api.thingspeak.com/update


