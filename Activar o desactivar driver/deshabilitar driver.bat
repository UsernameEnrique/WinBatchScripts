@echo off
:: --- VERIFICACIÓN DE PERMISOS DE ADMINISTRADOR ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ADVERTENCIA] Este script requiere permisos de administrador.
    echo Ejecutando como administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

::buscar el id del driver especifico con: pnputil /enum-devices
::en Id. de instancia:                PCI\VEN..

::pnputil /disable-device "(rellenar con el id y quitar comentado)"

exit