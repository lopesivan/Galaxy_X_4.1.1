#!/bin/bash

# Passo 1: Envia o arquivo para o dispositivo
adb push swip.out /mnt/sdcard/

# Passo 2: Usa cat para redirecionar o conteúdo do arquivo para o evento desejado
adb shell "cat /mnt/sdcard/swip.out > /dev/input/event1"

# (Opcional) Passo 3: Remove o arquivo do dispositivo para limpeza
adb shell rm /mnt/sdcard/swip.out

