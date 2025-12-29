@echo off
:: Espera x segundos (el parámetro /nobreak evita que se salte con una tecla)
timeout /t 20 /nobreak

:: Cierra el proceso steam.exe forzándolo (/F)
taskkill /F /IM steam.exe

:: Sale del script
exit