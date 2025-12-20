@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: Carpeta raíz y log
set "carpetaRaiz=C:\Ruta\A\Carpeta raíz"
set "archivoLog=%carpetaRaiz%\registro_de_ejecucion.log"

if not exist "%carpetaRaiz%" (
  echo [%date% %time%] ERROR: No existe "%carpetaRaiz%".
  pause
  exit /b 1
)

>>"%archivoLog%" echo ==========================================================
>>"%archivoLog%" echo [%date% %time%] Inicia el proceso de mover y limpiar carpetas...

:: Recorre recursivamente todos los archivos en subcarpetas (salta los que ya están en la raíz)
for /r "%carpetaRaiz%" %%F in (*.*) do (
  if /I not "%%~dpF"=="%carpetaRaiz%\" (
    set "origen=%%~fF"
    set "destino=%carpetaRaiz%\%%~nxF"
    call :MoverConNombreUnico "%%~fF" "!destino!" >>"%archivoLog%" 2>>&1
  )
)

:: Borra directorios vacíos de abajo hacia arriba
for /f "delims=" %%D in ('dir "%carpetaRaiz%" /ad /s /b ^| sort /R') do rd "%%D" 2>nul

>>"%archivoLog%" echo [%date% %time%] Fin.
exit /b 0

::-------------------------------------
:MoverConNombreUnico
:: %~1 = origen; %~2 = destino deseado (incluye nombre y ext)
setlocal EnableExtensions EnableDelayedExpansion
set "src=%~1"
set "dst=%~2"

set "dir=%~dp2"
set "base=%~n2"
set "ext=%~x2"

if not defined dir  set "dir=%carpetaRaiz%"
if not defined base set "base=%~n1"
if not defined ext  set "ext=%~x1"

set /a n=0
:BUSCAR
if exist "!dst!" (
  set /a n+=1
  set "dst=!dir!!base! (!n!)!ext!"
  goto BUSCAR
)

move /y "!src!" "!dst!" >nul
if errorlevel 1 (
  echo [%date% %time%] ERROR moviendo: "%~1" ^> "!dst!"
) else (
  echo [%date% %time%] Movido: "%~nx1" ^> "!dst!"
)
endlocal & exit /b% %time%] Movido: "%~nx1" ^> "!dst!"
)
endlocal & exit /b