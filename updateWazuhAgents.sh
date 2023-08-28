#!/bin/bash

# Actualizador de agentes desde el manager (Wazuh)

actualizar() {
    echo "[!] Iniciando actualizacion de agentes desactualizados..."
    for i in $(/var/ossec/bin/agent_upgrade -l | awk 'NR>1{print $1}' | grep '^0'); do
        /var/ossec/bin/agent_upgrade -a $i
    done
    echo ""
    echo "[*] Agentes actualizados."
    echo "[!] Si existiesen errores, vuelve a lanzar el script."
}
echo ""
echo "       ██╗    ██╗ █████╗ ███████╗██╗   ██╗██╗  ██╗"
echo "       ██║    ██║██╔══██╗╚══███╔╝██║   ██║██║  ██║"
echo "       ██║ █╗ ██║███████║  ███╔╝ ██║   ██║███████║"
echo "       ██║███╗██║██╔══██║ ███╔╝  ██║   ██║██╔══██║"
echo "       ╚███╔███╔╝██║  ██║███████╗╚██████╔╝██║  ██║"
echo "        ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝"
echo ""
echo "[!] Listando agentes y versiones instaladas..."
/var/ossec/bin/agent_upgrade -l
echo ""

read -p "[*] Quieres actualizar los agentes desactualizados? (s/N) " respuesta

respuesta=$(echo "$respuesta" | tr '[:upper:]' '[:lower:]')

if [ -z "$respuesta" ]; then
    echo "No se proporcionó una respuesta. Saliendo..."
    exit 1
elif [ "$respuesta" = "s" ]; then
    echo "[!] Continuando..."
    actualizar
else
    echo "[!] Saliendo..."
    echo "[!] Agentes NO actualizados."
fi
