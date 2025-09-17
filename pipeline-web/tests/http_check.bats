#!/usr/bin/env bats

setup() {
  SRC_DIR="$(pwd)/src"
  CHECK_SCRIPT="${SRC_DIR}/http-check.sh"
  PORT_TEST="${PORT:-8080}"
  echo "Ruta del script: $CHECK_SCRIPT"
}

@test "HTTP check con TARGET válido" {
  echo "Ejecutando con PORT=$PORT_TEST"
  
  # Verificar que el script existe
  if [ ! -f "$CHECK_SCRIPT" ]; then
    echo "[ERROR] El script no se encuentra en la ruta esperada: $CHECK_SCRIPT"
    fail "El script no existe en la ruta proporcionada."
  fi
  
  # Ejecutar el script con el valor de PORT configurado
  run PORT="$PORT_TEST" bash "$CHECK_SCRIPT"
  
  echo "Código de salida: $status"
  echo "Salida del script: $output"

  # Verificar el código de estado y que la salida contiene el texto esperado
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Código correcto" ]]
}

@test "HTTP check con TARGET inválido" {
  echo "Ejecutando con TARGETS=http://noexiste.local:$PORT_TEST"
  
  run TARGETS="http://noexiste.local:$PORT_TEST" bash "$CHECK_SCRIPT"
  
  echo "Código de salida: $status"
  echo "Salida del script: $output"

  # Verificar que el código de salida no es 0 y que la salida contiene "Fallo" o un mensaje de error
  [ "$status" -ne 0 ]
  [[ "$output" =~ "Fallo" || "$output" =~ "Could not resolve host" || "$output" =~ "Código incorrecto" ]]
}
