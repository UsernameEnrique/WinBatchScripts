@echo off
setlocal EnableExtensions

REM === Define tus rutas reales aquí ===
set /p "ORIGEN=Introduce la ruta de ORIGEN: "
set /p "DESTINO=Introduce la ruta de DESTINO: "
set /p "RUTALOG=Introduce la ruta del archivo de log: "

REM Quita comillas si el usuario las puso
set ORIGEN=%ORIGEN:"=%
set DESTINO=%DESTINO:"=%
set RUTALOG=%RUTALOG:"=%

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
for %%A in ("%RUTALOG%") do set "RUTALOG=%%~fA"

REM Verifica que los destinos no sean iguales
if /I "%ORIGEN%"=="%DESTINO%"=="%RUTALOG%" (
  echo ERROR: ORIGEN, DESTINO y RUTALOG no pueden tener la misma ruta.
  goto :fin
)

REM Verifica que existan como carpetas
if not exist "%ORIGEN%\" (
  echo ERROR: La carpeta ORIGEN no existe: "%ORIGEN%"
  goto :fin
)

if not exist "%DESTINO%\" (
  echo ERROR: La carpeta DESTINO no existe: "%DESTINO%"
  goto :fin
)

if not exist "%RUTALOG%\" (
  echo ERROR: La carpeta del archivo de log no existe: "%RUTALOG%"
  goto :fin
)

REM === Ejecucion ===
set RUTALOG=%RUTALOG%\verificacion.txt
REM type nul > "%RUTALOG%"
robocopy "%ORIGEN%" "%DESTINO%" /MIR /L /FFT /R:0 /W:0 /XJ /NP /LOG:"%RUTALOG%"
echo Robocopy termino con ERRORLEVEL=%ERRORLEVEL%

:fin
pause
endlocal
