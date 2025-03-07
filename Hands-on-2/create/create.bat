@echo off
:: Crear un archivo de texto plano llamado "mytext.txt" y agregarle "Hola Mundo"
echo Hola Mundo > mytext.txt

:: Desplegar/Imprimir el contenido del archivo "mytext.txt"
echo El contenido del archivo mytext.txt es:
type mytext.txt

:: Crear un subdirectorio llamado "backup"
mkdir backup

:: Copiar el archivo "mytext.txt" al subdirectorio "backup"
copy mytext.txt backup\

:: Listar el contenido del subdirectorio "backup"
echo Listando el contenido del subdirectorio "backup":
dir backup

:: Eliminar el archivo "mytext.txt" del subdirectorio "backup"
del backup\mytext.txt

:: Eliminar el subdirectorio "backup"
rmdir backup

:: Pausar para que puedas ver el resultado
pause

