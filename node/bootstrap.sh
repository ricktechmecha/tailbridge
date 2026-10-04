#!/usr/bin/env bash
# Prepara el NODO (Termux / proot / Linux) para tailbridge.
# Detecta el gestor de paquetes y instala lo necesario.
set -e
if [ -d /data/data/com.termux ]; then KIND=termux
elif [ -f /etc/debian_version ]; then KIND=debian
else KIND=linux; fi
echo "▶ Entorno detectado: $KIND"

install() {
  case "$KIND" in
    termux) pkg install -y "$@" ;;
    debian) sudo apt-get update -y && sudo apt-get install -y "$@" ;;
    *)      echo "Instala manualmente: $@" ;;
  esac
}

echo "▶ Instalando: openssh, nmap, tmux, mosh, rsync..."
install openssh nmap tmux mosh rsync || true

if [ "$KIND" = termux ]; then
  echo "▶ Termux: servicios + wake-lock"
  pkg install -y termux-services termux-api 2>/dev/null || true
fi

mkdir -p ~/bin
echo "✓ Bootstrap OK. Copia los wrappers a ~/bin y el script de boot."
