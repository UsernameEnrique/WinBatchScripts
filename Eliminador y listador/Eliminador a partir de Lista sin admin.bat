@echo off
:: =============================================
:: Script Batch: Elimina archivos desde lista.txt
:: Carpeta raíz: C:\Ruta\A\Carpeta raíz
:: Archivo lista: lista.txt en la misma carpeta raíz
:: =============================================

:: --- ENTORNO SEGURO ---
setlocal EnableExtensions DisableDelayedExpansion

:: Configuración de rutas
set "carpetaRaiz=C:\Ruta\A\Carpeta raíz"
set "archivoLista=%carpetaRaiz%\lista.txt"

:: Verifica existencia de la carpeta raíz
if not exist "%carpetaRaiz%\" (
    echo [ERROR] La carpeta raíz no existe: "%carpetaRaiz%"
    pause
    exit /b 1
)

:: Verifica existencia del archivo lista
if not exist "%archivoLista%" (
    echo [ERROR] El archivo lista.txt no existe en: "%carpetaRaiz%"
    pause
    exit /b 1
)

:: Cambia al directorio raíz
pushd "%carpetaRaiz%" >nul

:: --- PROCESO DE ELIMINACIÓN ---
echo.
echo [INICIO] Eliminando archivos de la lista...
echo.

:: Contador de archivos procesados
set "contador=0"

:: Procesa cada línea del archivo lista
for /f "usebackq delims=" %%F in ("%archivoLista%") do (
    if exist "%%F" (
        echo Eliminando: %%F
        del /f /q "%%F" >nul 2>&1
        if errorlevel 1 (
            echo [ERROR] No se pudo eliminar: %%F
        ) else (
            set /a contador+=1
        )
    ) else (
        echo [AVISO] Archivo no encontrado: %%F
    )
)

:: Mensaje de finalización
echo.
echo [COMPLETADO] Proceso terminado.
echo Archivos eliminados: %contador%
echo.

:: Restaura directorio anterior
popd >nul

pause
endlocal