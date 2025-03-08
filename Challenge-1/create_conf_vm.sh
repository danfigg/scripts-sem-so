#!/bin/bash

# Verifica que se pasen 8 argumentos; si no, muestra un error y termina el script
if [ "$#" -ne 8 ]; then
    echo -e "\033[31mERROR: Faltan parámetros. Uso correcto:\033[0m"
    echo -e "\033[33m$0 <nombre_vm> <tipo_os> <num_cpus> <ram_gb> <vram_mb> <disco_duro_gb> <nombre_controlador_sata> <nombre_controlador_ide>\033[0m"
    exit 1
fi

# Asigna los parámetros a variables
NOMBRE_VM=$1
TIPO_OS=$2
NUM_CPUS=$3
RAM_GB=$(($4 * 1024))  # Convierte RAM de GB a MB
VRAM_MB=$5
DISCO_DURO_GB=$6
CONTROLADOR_SATA=$7
CONTROLADOR_IDE=$8

# Ruta del disco duro virtual (VDI)
DISCO_DURO_VDI="${NOMBRE_VM}.vdi"

# Crea la VM con el nombre y el tipo de OS
echo ""
echo "Creando la Máquina Virtual: $NOMBRE_VM"
if ! VBoxManage createvm --name "$NOMBRE_VM" --ostype "$TIPO_OS" --register; then
    echo -e "\033[31mERROR: No se pudo crear la máquina virtual. Verifique los parámetros.\033[0m"
    exit 1
fi

# Configura la CPU, RAM y VRAM
echo ""
echo "Configurando recursos de hardware:"
if ! VBoxManage modifyvm "$NOMBRE_VM" --cpus "$NUM_CPUS" --memory "$RAM_GB" --vram "$VRAM_MB"; then
    echo -e "\033[31mERROR: No se pudo configurar los recursos de hardware. Verifique los parámetros.\033[0m"
    exit 1
fi

# Crea el disco duro virtual
echo ""
echo "Creando disco duro virtual:"
if ! VBoxManage createmedium disk --filename "$DISCO_DURO_VDI" --size $(($DISCO_DURO_GB * 1024)) --format VDI; then
    echo -e "\033[31mERROR: No se pudo crear el disco duro virtual. Verifique el tamaño y el formato.\033[0m"
    exit 1
fi

# Configura el controlador SATA y lo asocia al disco duro
echo ""
echo "Configurando controlador SATA: $CONTROLADOR_SATA"
if ! VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR_SATA" --add sata --controller IntelAhci; then
    echo -e "\033[31mERROR: No se pudo crear el controlador SATA. Verifique el nombre del controlador.\033[0m"
    exit 1
fi
if ! VBoxManage storageattach "$NOMBRE_VM" --storagectl "$CONTROLADOR_SATA" --port 0 --device 0 --type hdd --medium "$DISCO_DURO_VDI"; then
    echo -e "\033[31mERROR: No se pudo asociar el disco duro al controlador SATA. Verifique la conexión.\033[0m"
    exit 1
fi

# Configura el controlador IDE para CD/DVD
echo ""
echo "Configurando controlador IDE: $CONTROLADOR_IDE"
if ! VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR_IDE" --add ide; then
    echo -e "\033[31mERROR: No se pudo crear el controlador IDE. Verifique el nombre del controlador.\033[0m"
    exit 1
fi
if ! VBoxManage storageattach "$NOMBRE_VM" --storagectl "$CONTROLADOR_IDE" --port 1 --device 0 --type dvddrive --medium emptydrive; then
    echo -e "\033[31mERROR: No se pudo asociar el CD/DVD al controlador IDE. Verifique la configuración.\033[0m"
    exit 1
fi

# Muestra la configuración de la VM
echo ""
echo "Resumen de la configuración creada para la Máquina Virtual: $NOMBRE_VM"
if ! VBoxManage showvminfo "$NOMBRE_VM"; then
    echo -e "\033[31mERROR: No se pudo mostrar la información de la máquina virtual.\033[0m"
    exit 1
fi

# Mensaje final indicando que la configuración fue exitosa
echo ""
echo "Máquina Virtual $NOMBRE_VM creada y configurada exitosamente."
echo ""
