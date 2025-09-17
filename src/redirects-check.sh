#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/common.sh"
requerida CONFIG_URL || exit 1

host=$(echo "$CONFIG_URL" | sed 's~^https\?://~~; s~/.*~~')
mkdir -p out

# Seguimos redirecciones desde HTTP
curl -sIL "http://$host" | tee out/redirects.txt

# Validar que el destino final sea HTTPS
if grep -iE '^location: https://' out/redirects.txt >/dev/null; then
  echo "[INFO] HTTP redirige a HTTPS" | tee -a out/redirects.txt
else
  echo "[WARN] No se observó redirección a HTTPS" | tee -a out/redirects.txt
  exit 1
fi
