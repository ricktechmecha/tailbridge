#!/usr/bin/env bash
# Carga la config desde .env (en la raíz del proyecto)
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ -f "$HERE/.env" ] || { echo "✗ Falta .env — copia .env.example a .env y edítalo"; exit 1; }
set -a; . "$HERE/.env"; set +a
: "${NODE_IP:?Define NODE_IP en .env}"
: "${NODE_USER:?Define NODE_USER en .env}"
SSH_NODE=(ssh -o ConnectTimeout=10 -p "${NODE_PORT:-8022}" "${NODE_USER}@${NODE_IP}")
SCP_NODE_FLAG="-P ${NODE_PORT:-8022}"
mkdir -p "${SHARED_DIR:-$HOME/tailbridge-shared}"
