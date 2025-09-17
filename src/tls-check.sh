#!/usr/bin/env bash
# Script simple para comparar HTTP vs HTTPS (Sprint 2)
# Estilo estudiante: comentarios claros y sin floro :)

set -euo pipefail
trap 'echo "[INFO] TLS-check terminó limpio"' EXIT

# Funciones comunes (msg, err, requerida)
source "$(dirname "$0")/common.sh"

# Necesitamos CONFIG_URL (ej: https://example.com)
requerida CONFIG_URL || exit 1

mkdir -p out

# Quitar el protocolo si viene con http:// o https:// (dejamos host[/ruta])
host_y_ruta=$(echo "$CONFIG_URL" | sed 's~^https\?://~~')

msg "Probando HTTP (80) contra: http://$host_y_ruta"
# -k: no validar cert; -v: verboso; redirigimos stderr a archivo también
curl -vk "http://$host_y_ruta"  > out/tls-http.txt  2>&1 || true

msg "Probando HTTPS (443) contra: https://$host_y_ruta"
curl -vk "https://$host_y_ruta" > out/tls-https.txt 2>&1 || true

msg "Listo. Evidencias:"
ls -lh out/tls-*.txt
