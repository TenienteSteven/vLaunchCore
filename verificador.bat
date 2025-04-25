@echo off
REM ===========================================
REM Verificador externo para LaunchCore
REM Decide si debe forzarse una actualización
REM ===========================================

REM Aquí puedes poner condiciones personalizadas
REM En este ejemplo, siempre se forzará actualización

REM También se puede agregar lógica más compleja:
REM - Leer desde archivo config
REM - Verificar integridad
REM - Comprobar fecha, etc.

REM Enviar señal de actualización
> "%temp%\respuesta_actualizacion.txt" echo actualizar=1

exit /b
