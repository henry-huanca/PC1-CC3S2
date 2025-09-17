# Sprint 3 – Bitácora

## Variables de entorno

| Variable    | Efecto observable                                    | Ejemplo                |
|-------------|------------------------------------------------------|------------------------|
| RELEASE     | Versión del build / empaquetado                      | v0.3                   |
| CONFIG_URL  | URL objetivo de pruebas TLS/HSTS/Redirects           | https://github.com     |

---

## Ejecución de chequeos

### 1. Metadatos TLS
```bash
CONFIG_URL=https://github.com make meta
head -n 15 out/tls-meta.txt
```

Salida relevante:
```bash
issuer=C = GB, O = Sectigo Limited, CN = Sectigo ECC Domain Validation Secure Server CA
subject=CN = github.com
notBefore=Feb  5 00:00:00 2025 GMT
notAfter=Feb  5 23:59:59 2026 GMT`
[INFO] Cert OK: 141 días restantes
```
### 2. HSTS
```bash
CONFIG_URL=https://github.com make hsts
grep -i strict-transport-security out/hsts-headers.txt
```
Salida relevante:
```bash
strict-transport-security: max-age=31536000; includeSubdomains; preload
[INFO] HSTS presente
```
### 3. Redirecciones HTTP→HTTPS
```bash
CONFIG_URL=https://github.com make redirects
grep -i location out/redirects.txt
```
Salida relevante:
```bash
HTTP/1.1 301 Moved Permanently
Location: https://github.com/
[INFO] HTTP redirige a HTTPS
```

### 4. Orquestador de seguridad
```bash
CONFIG_URL=https://github.com make check
```
Salida:
```bash
[INFO] HSTS presente
[INFO] HTTP redirige a HTTPS
[INFO] Check de seguridad completado
```
### 5.Empaquetado reproducible
```bash
RELEASE=v0.3 make pack
ls -lh dist/
make verify
```
Salida:

```bash
[INFO] Manifest generado en dist/manifest.txt
[INFO] Paquete y checksum en dist/

dist/manifest.txt
dist/pipeline-v0.3.tar.gz
dist/SHA256SUMS

dist/pipeline-v0.3.tar.gz: OK
```
### 6.Pruebas automáticas
```bash
make test
```
Salida:

```bash
✓ HSTS presente en respuesta HTTPS
✓ HTTP redirige a HTTPS
✓ Empaquetado y checksum OK
✓ tls-meta genera metadatos y días de vigencia > 0
✓ tls-check genera evidencias HTTP y HTTPS
5 tests, 0 failures
```

### 6.Evidencias generadas
```out/tls-meta.txt``` → metadatos TLS y días de vigencia

```out/hsts-headers.txt```→ evidencia de cabecera HSTS

```out/redirects.txt``` → evidencia de redirección HTTP→HTTPS

```dist/manifest.txt``` → manifest reproducible del build

```dist/pipeline-v0.3.tar.gz``` → artefacto empaquetado

```dist/SHA256SUMS```→ checksum SHA-256 del paquete

**Conclusión**
- El Sprint 3 se completó exitosamente:

- Validaciones de seguridad (meta, hsts, redirects) integradas al Makefile.

- Orquestador make check operativo.

- Empaquetado reproducible y verificable (make pack, make verify).

- Pruebas automatizadas (make test) pasando al 100%.