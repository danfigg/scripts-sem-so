#!/bin/bash

while true; do
    echo "Menu de servicios"
    echo "1) Listar el contenido de un fichero (carpeta)"
    echo "2) Crear un archivo de texto con una línea"
    echo "3) Comparar dos archivos de texto"
    echo "4) Mostrar uso de awk"
    echo "5) Mostrar uso de grep"
    echo "6) Salir"
    echo -n "Seleccione una opción: "
    read opc

    case $opc in
        1)
            echo -e "\nIngrese la ruta absoluta del directorio: "
            read dir
            if [ -d "$dir" ]; then
                ls -l "$dir"
            else
                echo "Error: La ruta ingresada no es un directorio válido."
            fi
            ;;
        2)
            echo -e "\nIngrese el nombre del archivo a crear: "
            read filename
            echo -n "Ingrese la línea de texto: "
            read text
            echo "$text" > "$filename"
            echo "Archivo '$filename' creado con éxito."
            ;;
        3)
            echo -e "\nIngrese la ruta del primer archivo: "
            read file1
            echo -n "Ingrese la ruta del segundo archivo: "
            read file2
            if [[ -f "$file1" && -f "$file2" ]]; then
                diff "$file1" "$file2"
            else
                echo "Error: Uno o ambos archivos no existen."
            fi
            ;;
        4)
            echo -e "\nFormato: awk [opción] \"condición {sentencia}\" [archivo]"
            echo -e 'Ejemplo de awk (awk -F, "{print $2}" empleados.csv)'
            echo -e "Mostrando la segunda columna del archivo empleados.csv:"
            awk -F, '{print $2}' /home/daniel-garcia-figueroa/Documentos/scripts-sem-so/Hands-on-4/empleados.csv | head -10

            while true; do
                echo -n "¿Quieres ingresar un comando personalizado para awk? (s/n): "
                read respuesta
                if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
                    echo -n "Ingresa el comando awk (sin escribir 'awk'): "
                    read -r comando
                    eval "awk $comando | head -10"
                    break
                elif [[ "$respuesta" == "n" || "$respuesta" == "N" ]]; then
                    break
                else
                    echo "Opción inválida, ingresa (s/n)"
                fi
            done
            ;;
        5)
            echo -e "\nFormato: grep [opción] \"patrón\" [archivo]"
            echo -e 'Ejemplo de grep (grep "error" archivo1.txt)'
            echo -e "Buscando la palabra 'error' en archivo1.txt:"
            grep "error" /home/daniel-garcia-figueroa/Documentos/scripts-sem-so/Hands-on-4/archivo1.txt | head -10

            while true; do
                echo -n "¿Quieres ingresar un comando personalizado para grep? (s/n): "
                read respuesta
                if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
                    echo -n "Ingresa el comando grep (sin escribir 'grep'): "
                    read -r comando
                    eval "grep $comando | head -10"
                    break
                elif [[ "$respuesta" == "n" || "$respuesta" == "N" ]]; then
                    break
                else
                    echo "Opción inválida, ingresa (s/n)"
                fi
            done
            ;;
        6)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción inválida, intente nuevamente."
            ;;
    esac

    echo -n "Presione cualquier tecla para continuar..."
    read -n 1
    clear
done
