@echo off
setlocal enabledelayedexpansion

:: Establecer la ruta de la carpeta raíz
set "carpetaRaiz=C:\Ruta\A\Carpeta raíz"

:: Verificar si la carpeta raíz existe
if not exist "%carpetaRaiz%" (
    echo Error: La carpeta raíz no existe.
    echo Ruta especificada: "%carpetaRaiz%"
    echo Por favor, verifica la ruta y asegúrate de que exista.
    pause
    exit /b
)

:: Pedir al usuario el número de carpetas que desea crear
set /p numCarpetas="¿Cuántas carpetas deseas crear? (número): "

:: Cambiar al directorio de la carpeta raíz
cd /d "%carpetaRaiz%"

:: Crear las carpetas y generar archivos dentro de ellas
for /l %%i in (1,1,%numCarpetas%) do (
    :: Crear la nueva carpeta
    mkdir "Nueva Carpeta %%i"
    
    :: Generar un número aleatorio de archivos entre 1 y 50
    set /a numArchivos=!random! %% 50 + 1
    
    :: Crear los archivos dentro de la carpeta
    for /l %%j in (1,1,!numArchivos!) do (
        :: Decidir aleatoriamente entre .txt y .bin
        set /a ext=!random! %% 2
        if !ext! == 0 (
            set "extension=.txt"
        ) else (
            set "extension=.bin"
        )
        
        :: Crear el archivo vacío con la extensión seleccionada
        echo. > "Nueva Carpeta %%i\Archivo %%j!extension!"
    )
)

echo Se han creado %numCarpetas% carpetas, cada una con un número aleatorio de archivos.
pause
