@echo off
setlocal EnableExtensions

rem --- Ubicar 7z.exe ---
set "SevenZip=%ProgramFiles%\7-Zip\7z.exe"
if not exist "%SevenZip%" set "SevenZip=%ProgramFiles(x86)%\7-Zip\7z.exe"
if not exist "%SevenZip%" (
  echo [ERROR] No se encontro 7z.exe. Ajusta la ruta en este .bat o instala 7-Zip.
  exit /b 1
)

rem --- Ajustes (puedes cambiarlos) ---
set "TYPE=7z"
set "LEVEL=9"

:loop
if "%~1"=="" goto :done

set "SRC=%~1"
for %%A in ("%SRC%") do (
  set "OUTDIR=%%~dpA"
  set "NAME=%%~nxA"
)

set "ARCHIVE=%OUTDIR%%NAME%.%TYPE%"
echo Creando "%ARCHIVE%" ...

"%SevenZip%" a -t%TYPE% -mx=%LEVEL% -y "%ARCHIVE%" "%SRC%" >nul
if errorlevel 1 (
  echo [ERROR] Fallo al comprimir "%SRC%"
) else (
  echo OK
)

shift
goto :loop

:done
endlocal