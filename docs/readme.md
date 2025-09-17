## Sprint 1 – Documentación

### Variables de entorno (contrato)
| Variable      | Efecto observable                                     | Ejemplo                    |
|---------------|--------------------------------------------------------|----------------------------|
| `RELEASE`     | Versión usada en build, run y empaquetado (`dist/`)   | `v0.1`                     |
| `PORT`        | Puerto objetivo que quedará registrado en evidencias   | `8080`                     |
| `MESSAGE`     | Mensaje mostrado/registrado por el pipeline            | `"Hola CC3S2"`             |
| `CONFIG_URL`  | URL de configuración/endpoint analizado                | `https://example.com`      |
| `DNS_SERVER`  | Servidor DNS que se usará en consultas posteriores     | `1.1.1.1`                  |
| `TARGETS`     | Lista de destinos a verificar (`host:puerto`)          | `"httpbin.org:80 google.com:443"` |

> **Regla**: No modificar scripts para cambiar comportamiento.  
> Todo se controla mediante variables de entorno.

---

### Ejecución Sprint 1
```bash
# Preparar build
RELEASE=v0.1 make build

# Ejecutar pipeline con variables
RELEASE=v0.1 PORT=8080 MESSAGE="Hola CC3S2" CONFIG_URL="https://example.com" \
DNS_SERVER=1.1.1.1 TARGETS="httpbin.org:80 google.com:443" make run
```
### Salida :
```bash
[INFO] Guardando variables de entorno en out/variables.txt
[INFO] Sprint 1 listo: estructura + Makefile + evidencia básica
[INFO] Revisa out/variables.txt
```

**Archivo generado**:``` out/variables.txt```
```bash
RELEASE=v0.1
PORT=8080
MESSAGE=Hola CC3S2
CONFIG_URL=https://example.com
DNS_SERVER=1.1.1.1
TARGETS=httpbin.org:80 google.com:443
fecha=2025-09-16 19:59:52
```
**Evidencias**

```out/release.txt``` → versión del build.

```out/variables.txt ```→ contrato de variables registradas.
