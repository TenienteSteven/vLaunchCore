@echo off

title LaunchCore

REM LaunchCore - Sistema de Inicio y Actualización
set "programa_nombre=LaunchCore"
set "version_local=beta-0w2ac1"
echo %programa_nombre% - Version actual: %version_local%

REM Crear carpeta de historial si no existe
if not exist "%~dp0historial de versiones" mkdir "%~dp0historial de versiones"

REM Descargar archivo de versión desde Dropbox (enlace directo con &dl=1 al final)
curl -s "https://www.dropbox.com/scl/fi/xrujhaj27mo4ydrrxftp3/version.txt?rlkey=pjrhzvl29msrf1ocmwl9ns6z8^&st=0jpek7j8^&dl=1" -o "%temp%\version.txt" >nul 2>&1

REM Verificar si el archivo se descargó correctamente
if not exist "%temp%\version.txt" (
    set "modo=md0"
    set /a version_offline=0
    if exist "%temp%\offline_version.txt" (
        set /p version_offline=<"%temp%\offline_version.txt"
        set /a version_offline+=1
    )
    echo [%programa_nombre%] Modo sin servidor activado (modo: %modo%)
    echo Version offline: %version_offline%
    echo %version_offline% > "%temp%\offline_version.txt"
    timeout /t 3 /nobreak >nul
    goto continuar
)

set "modo=md1"
set /p version_server=<"%temp%\version.txt"
echo Version del servidor: %version_server%

REM Comparar versiones y notificar si hay una nueva
if not "%version_local%"=="%version_server%" (
    echo *** [%programa_nombre%] Hay una nueva version disponible: %version_server% ***
    set /p update_choice="Deseas actualizar ahora? (s/n): "
    if /i "%update_choice%"=="s" (
        REM Descargar archivo de actualización externa (.pupd) mostrando progreso
        echo Descargando actualizacion...
        curl -# -o "%temp%\actualizacion.pupd" "https://www.dropbox.com/scl/fi/xrujhaj27mo4ydrrxftp3/update-pupd.pupd?rlkey=pjrhzvl29msrf1ocmwl9ns6z8^&st=0jpek7j8^&dl=1"

        REM Crear marca de ejecución autorizada
        set "auth_token=from_program"

        REM Verificar y ejecutar el archivo pupd
        if exist "%temp%\actualizacion.pupd" (
            echo Ejecutando archivo de actualizacion...
            call "%temp%\actualizacion.pupd" %auth_token%
            REM Guardar version en historial con prefijo v.
            echo v.%version_server% >> "%~dp0historial de versiones\historial.txt"
        )
    ) else (
        echo Has elegido no actualizar.
    )
)

:continuar
echo Iniciando %programa_nombre%...
timeout /t 5 /nobreak >nul
cls
echo %programa_nombre% Iniciado
cls

echo Modo actual: %modo%

REM abre Voicemeeter
start "" "C:\Program Files (x86)\VB\Voicemeeter"
echo Habriendo Voicemeeter...
timeout /t 3 /nobreak >nul
cls
echo "Voicemeeter" Iniciado

echo Ya puede cerrar esta ventana
pause
