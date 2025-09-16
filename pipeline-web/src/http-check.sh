#!/usr/bin/env bash
# http_checks.sh - Verificación HTTP para pipeline web
set -euo pipefail
trap 'echo "[ERROR] Fallo en la línea $LINENO"; exit 1' ERR
# Variables de entorno con valores por defecto
PORT="${PORT:-8080}"
TARGETS="${TARGETS:-http://127.0.0.1:$PORT}"
CODIGO_DE_ESTADO_ESPERADO="${CODIGO_DE_ESTADO_ESPERADO:-200}"

log() { echo "[INFO] $*"; }

http_checks() {
    log "Verificando disponibilidad de curl..."
    command -v curl >/dev/null 2>&1 || { echo "[ERROR] Falta curl"; exit 1; }

    # GET verbose
    log "Ejecutando GET verbose: curl -v $TARGETS"
    curl -v "$TARGETS" || true
    echo

    # Código HTTP y cuerpo
    log "Verificando código de estado y mostrando cuerpo"
    codigo_de_estado=$(curl -s -o /dev/null -w "%{http_code}" "$TARGETS")
    if [ "$codigo_de_estado" == "$CODIGO_DE_ESTADO_ESPERADO" ]; then
        echo " Código correcto: $codigo_de_estado"
    else
        echo " Código incorrecto (esperado $CODIGO_DE_ESTADO_ESPERADO, recibido $codigo_de_estado)"
    fi
    log "Mostrando cuerpo de la respuesta"
    curl -s "$TARGETS"
    echo
    log "Mostrando cabeceras"
    curl -sI "$TARGETS"
    echo
    log "HTTP checks completados"
}
http_checks
