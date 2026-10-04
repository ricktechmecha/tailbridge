#!/usr/bin/env bash
# Carga la config desde .env (en la raíz del proyecto)
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ -f "$HERE/.env" ] || { echo "✗ Falta .env — copia .env.example a .env y edítalo"; exit 1; }
set -a; . "$HERE/.env"; set +a
SSH_NODE=(ssh -p "${NODE_PORT:-8022}" "${NODE_USER}@${NODE_IP}")
SCP_NODE_FLAG="-P ${NODE_PORT:-8022}"
mkdir -p "${SHARED_DIR:-$HOME/tailbridge-shared}"
