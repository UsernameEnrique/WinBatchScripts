@echo off
:: =============================================
:: Script Batch: Lista archivos recursivos
:: Ruta raíz: C:\Ruta\A\Carpeta raíz
:: Salida:    C:\Ruta\A\Carpeta raíz\lista.txt
:: =============================================

:: --- ENTORNO SEGURO ---
setlocal EnableExtensions DisableDelayedExpansion
rem Evita que variables externas interfieran
set "carpetaRaiz=C:\Ruta\A\Carpeta raíz"

:: Verifica que la carpeta exista
if not exist "%carpetaRaiz%\" (  
    echo [ERROR] La carpeta raíz no existe: "%carpetaRaiz%"
    pause
    exit /b 1
)

:: Cambia al directorio raíz (útil si el script se ejecuta desde otro lugar)
pushd "%carpetaRaiz%" >nul

:: --- GENERA LA LISTA ---
:: /S   = recursivo
:: /B   = formato bare (solo rutas completas)
:: /A:-D = excluye directorios (solo archivos)
:: >    = redirige salida al archivo (sobrescribe)
dir /S /B /A:-D > "%carpetaRaiz%\lista.txt"

:: Mensaje de éxito
echo.
echo [OK] Lista generada en:
echo     "%carpetaRaiz%\lista.txt"
echo.

:: --- ELIMINA LA PRIMERA LÍNEA DE lista.txt ---
:: Usamos un archivo temporal para guardar todo excepto la primera línea
set "archivoLista=%carpetaRaiz%\lista.txt"
set "tempFile=%carpetaRaiz%\lista_temp.txt"

:: Si el archivo existe y tiene contenido, eliminamos la primera línea
if exist "%archivoLista%" (
    (for /f "skip=1 tokens=* usebackq" %%a in ("%archivoLista%") do @echo %%a) > "%tempFile%"
    move /y "%tempFile%" "%archivoLista%" >nul
)

:: Mensaje opcional de corte de primera línea
echo [INFO] Primera línea eliminada de "%archivoLista%".

pause

:: Restaura el directorio anterior
popd >nul
endlocal