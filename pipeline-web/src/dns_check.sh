#!/usr/bin/env bash
# dns_check.sh - Verificación DNS para pipeline web
set -euo pipefail
trap 'echo "[ERROR] Fallo en la línea $LINENO"; exit 1' ERR

DOMAIN="${DOMAIN:-pipeline.local}"
CODIGO_IP="${CODIGO_IP:-127.0.0.1}"

log() { echo "[INFO] $*"; }

dns_checks() {
    log "Verificando disponibilidad de dig y getent..."
    command -v dig >/dev/null 2>&1 || { echo "[ERROR] Falta dig"; exit 1; }
    command -v getent >/dev/null 2>&1 || { echo "[ERROR] Falta getent"; exit 1; }

    echo
    log "Resolviendo $DOMAIN con dig"
    dig +short "$DOMAIN" || true

    echo
    log "Resolviendo $DOMAIN con getent hosts"
    getent hosts "$DOMAIN" || true

    echo
    log "Comprobando que $DOMAIN resuelva a $CODIGO_IP"
    ip_resuelto="$(getent hosts "$DOMAIN" | awk '{print $1}' || true)"
    if [ "$ip_resuelto" = "$CODIGO_IP" ]; then
        echo "[OK] $DOMAIN → $CODIGO_IP"
    else
        echo "[WARN] $DOMAIN no resuelve a $CODIGO_IP (resuelto: $ip_resuelto)"
        echo "       Añade '127.0.0.1 $DOMAIN' en /etc/hosts"
    fi
}

dns_checks
