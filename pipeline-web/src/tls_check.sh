#!/usr/bin/env bash
# tls_check.sh - Verificación TLS con cadena completa de certificados
set -euo pipefail
trap 'echo "[ERROR] Fallo en la línea $LINENO"; exit 1' ERR

DOMAIN="${1:-pipeline.local}"  
PORT="${2:-443}"             # Puerto TLS (default: 443)

log() { echo "[INFO] $*"; }

log "Conectando a ${DOMAIN}:${PORT} con openssl s_client..."
RAW_OUTPUT=$(echo | openssl s_client -connect "${DOMAIN}:${PORT}" \
    -servername "${DOMAIN}" -showcerts -brief 2>&1 || true)

echo "$RAW_OUTPUT" | grep -E "Protocol|Ciphersuite|Verification error" || true
echo

log "Extrayendo certificados de la cadena..."
# Extrae certificados directamente a stdout
CERTS=$(echo "$RAW_OUTPUT" | awk '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/')

i=0
echo "$CERTS" | csplit -z -f /tmp/cert_ -b "%02d.pem" - '/-----BEGIN CERTIFICATE-----/' '{*}' >/dev/null 2>&1 || true

for cert in /tmp/cert_*.pem; do
    if grep -q "BEGIN CERTIFICATE" "$cert"; then
        echo "--------------------------------------------------"
        echo "[Certificado $i] Validación con openssl x509"
        openssl x509 -in "$cert" -noout -subject -issuer -dates -fingerprint
        ((i++))
    fi
done

echo
log "Validando cadena completa con openssl verify..."
cat /tmp/cert_*.pem > /tmp/chain.pem
openssl verify -CAfile /tmp/chain.pem /tmp/cert_*.pem || true
