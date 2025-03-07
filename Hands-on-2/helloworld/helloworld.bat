@echo off
:: Imprimir "Hello World" en la pantalla
echo Hello World

:: Listar el contenido del directorio actual
echo Listando el contenido del directorio actual:
dir

:: Crear un subdirectorio llamado "Test"
echo Creando el subdirectorio "Test"
mkdir Test

:: Cambiarse al subdirectorio "Test"
cd Test

:: Listar el contenido del subdirectorio "Test" (que debería estar vacío en este momento)
echo Listando el contenido del subdirectorio "Test":
dir

:: Pausar para que puedas ver el resultado
pause

