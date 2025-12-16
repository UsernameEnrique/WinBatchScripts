@echo off
setlocal EnableExtensions

REM === Define tus rutas reales aquí ===
set "ORIGEN=C:\Carpeta\de\origen"
set "DESTINO=C:\Carpeta\de\destino"
set "RUTALOG=C:\Ruta\del\log"

REM === Validaciones básicas ===
if not defined ORIGEN (
  echo ERROR: La variable ORIGEN no esta definida.
  goto :fin
)

if not defined DESTINO (
  echo ERROR: La variable DESTINO no esta definida.
  goto :fin
)

if not defined RUTALOG (
  echo ERROR: La variable RUTALOG no esta definida.
  goto :fin
)

REM Normaliza a ruta absoluta (si aplica)
for %%A in ("%ORIGEN%") do set "ORIGEN=%%~fA"
for %%A in ("%DESTINO%") do set "DESTINO=%%~fA"

REM Verifica que no sean iguales
if /I "%ORIGEN%"=="%DESTINO%" (
  echo ERROR: ORIGEN y DESTINO son la misma ruta: "%ORIGEN%"
  goto :fin
)

REM Verifica que existan como carpetas
if not exist "%ORIGEN%\NUL" (
  echo ERROR: La carpeta ORIGEN no existe: "%ORIGEN%"
  goto :fin
)

if not exist "%DESTINO%\NUL" (
  echo ERROR: La carpeta DESTINO no existe: "%DESTINO%"
  goto :fin
)

if not exist "%RUTALOG%" (
  echo ERROR: El archivo de log no existe: "%RUTALOG%"
  goto :fin
)

REM === Ejecucion ===
robocopy "%ORIGEN%" "%DESTINO%" /MIR /L /FFT /R:0 /W:0 /XJ /NP /LOG:"%RUTALOG%"
echo Robocopy termino con ERRORLEVEL=%ERRORLEVEL%

:fin
pause
endlocal
