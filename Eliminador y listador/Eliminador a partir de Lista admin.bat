@echo off
:: =============================================
:: Script Batch: Elimina archivos de lista.txt
:: Ruta raíz: C:\Ruta\A\Carpeta raíz
:: Entrada:   C:\Ruta\A\Carpeta raíz\lista.txt
:: =============================================


:: --- ENTORNO SEGURO ---
setlocal EnableExtensions DisableDelayedExpansion
rem Evita que variables externas interfieran
set "carpetaRaiz=C:\Ruta\A\Carpeta raíz"
set "archivoLista=%carpetaRaiz%\lista.txt"

:: Verifica que la carpeta exista
if not exist "%carpetaRaiz%\" (  
    echo [ERROR] La carpeta raíz no existe: "%carpetaRaiz%"
    pause
    exit /b 1
)

:: Verifica que el archivo lista.txt exista
if not exist "%archivoLista%" (
    echo [ERROR] El archivo lista.txt no existe: "%archivoLista%"
    echo Ejecuta primero el script generador de lista.
    pause
    exit /b 1
)

:: Cambia al directorio raíz
pushd "%carpetaRaiz%" >nul

:: --- VERIFICACIÓN DE PERMISOS DE ADMINISTRADOR ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ADVERTENCIA] Este script requiere permisos de administrador para forzar el borrado.
    echo Ejecutando como administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo [INFO] Ejecutando con permisos de administrador.
echo.


:: --- CONFIRMACIÓN DE SEGURIDAD ---
echo [ADVERTENCIA] Este script eliminará TODOS los archivos listados en:
echo     "%archivoLista%"
echo.
echo ¿Estás seguro de continuar? (S/N)
set /p "confirmacion="
if /i not "%confirmacion%"=="S" (
    echo [CANCELADO] Operación cancelada por el usuario.
    pause
    goto :cleanup
)

:: --- ELIMINA ARCHIVOS DE LA LISTA ---
echo.
echo [PROCESO] Eliminando archivos listados...
echo.

set "contadorEliminados=0"
set "contadorErrores=0"

:: Lee cada línea del archivo lista.txt y elimina el archivo correspondiente
for /f "tokens=* usebackq" %%a in ("%archivoLista%") do (
    if exist "%%a" (
        echo Eliminando: "%%a"
        
        :: Intenta eliminar el archivo normalmente
        del /f /q "%%a" >nul 2>&1
        
        :: Si falla, intenta forzar con attrib
        if exist "%%a" (
            attrib -r -h -s "%%a" >nul 2>&1
            del /f /q "%%a" >nul 2>&1
        )
        
        :: Verifica si se eliminó correctamente
        if not exist "%%a" (
            set /a "contadorEliminados+=1"
        ) else (
            echo [ERROR] No se pudo eliminar: "%%a"
            set /a "contadorErrores+=1"
        )
    ) else (
        echo [OMITIDO] Archivo no encontrado: "%%a"
    )
)

:: --- RESUMEN FINAL ---
echo.
echo =============================================
echo [RESUMEN] Proceso completado:
echo     Archivos eliminados: %contadorEliminados%
echo     Errores encontrados: %contadorErrores%
echo =============================================
echo.

:: Pregunta si eliminar también el archivo lista.txt
echo ¿Deseas eliminar también el archivo lista.txt? (S/N)
set /p "eliminarLista="
if /i "%eliminarLista%"=="S" (
    del /f /q "%archivoLista%" >nul 2>&1
    if not exist "%archivoLista%" (
        echo [OK] Archivo lista.txt eliminado.
    ) else (
        echo [ERROR] No se pudo eliminar lista.txt
    )
)

:cleanup
pause

:: Restaura el directorio anterior
popd >nul
endlocal