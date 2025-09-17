#!/usr/bin/env bats

# Definir configuración de prueba
setup() {
  # Configuración opcional, por ejemplo, puedes definir el dominio y la IP
  DOMAIN="${DOMAIN:-pipeline.local}"
  CODIGO_IP="${CODIGO_IP:-127.0.0.1}"
  SCRIPT_PATH="/path/to/dns_check.sh"  # Ajusta la ruta al script real
}

# Verificar que el script se ejecute correctamente
@test "El script dns_check.sh se ejecuta correctamente" {
  run bash "$SCRIPT_PATH"
  [ "$status" -eq 0 ]
}

# Verificar que el dominio se resuelve correctamente con dig
@test "Resolución del dominio con dig" {
  run dig +short "$DOMAIN"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "$CODIGO_IP" ]]
}

# Verificar que el dominio se resuelve correctamente con getent
@test "Resolución del dominio con getent" {
  run getent hosts "$DOMAIN"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "$CODIGO_IP" ]]
}

# Verificar que el dominio no resuelve a una IP incorrecta
@test "Comprobando resolución incorrecta" {
  run getent hosts "$DOMAIN"
  ip_resuelto=$(echo "$output" | awk '{print $1}')
  [ "$ip_resuelto" = "$CODIGO_IP" ] || [ "$status" -ne 0 ]
}

# Comprobar que el dominio se resuelve correctamente a la IP definida en /etc/hosts
@test "Comprobando que el dominio resuelve a la IP correcta" {
  # Aquí asumimos que el script añade el dominio a /etc/hosts si no se resuelve
  # Asegúrate de que la IP de la máquina coincida con la variable $CODIGO_IP
  run bash "$SCRIPT_PATH"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "$DOMAIN" ]]
}
