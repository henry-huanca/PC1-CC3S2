## sprint3 pruebas de scripts
    1 se realiza la creacion del test par el script http-check.sh para lo cual se creo el http_check.bats
    2 se da los permisos de ejecucion con el comando chmod +x tests/http_check.bats
    3 se ejecuta el test con el comando bats tests/http_check.bats

    ✗ HTTP check con TARGET válido
   (in test file tests/http_check.bats, line 13)
     `[ "$status" -eq 0 ]' failed
   Ruta del script: /mnt/d/DESARROLLO-SOFTWARE/PC1-CC3S2/pipeline-web/src/http-check.sh  
 ✗ HTTP check con TARGET inválido
   (in test file tests/http_check.bats, line 24)
     `[[ "$output" =~ "Fallo" || "$output" =~ "Could not resolve host" || "$output" =~ "Código incorrecto" ]]' failed
   Ruta del script: /mnt/d/DESARROLLO-SOFTWARE/PC1-CC3S2/pipeline-web/src/http-check.sh  

2 tests, 2 failures


    4 se realiza la creacion del test par el script dns-check.sh para lo cual se creo el dns_check.bats
    5 se da los permisos de ejecucion con el comando chmod +x tests/dns_check.bats
    6 se ejecuta el test con el comando bats tests/dns_check.bats

    henry@LAPTOP-J58LHNLD:/mnt/d/DESARROLLO-SOFTWARE/PC1-CC3S2/pipeline-web$ bats tests/dns_check.bats
    
    dns_check.bats
    ✗ El script dns_check.sh se ejecuta correctamente
    (in test file tests/dns_check.bats, line 14)
        `[ "$status" -eq 0 ]' failed
    ✗ Resolución del dominio con dig
    (in test file tests/dns_check.bats, line 21)
        `[[ "$output" =~ "$CODIGO_IP" ]]' failed
    ✓ Resolución del dominio con getent
    ✓ Comprobando resolución incorrecta
    ✗ Comprobando que el dominio resuelve a la IP correcta
    (in test file tests/dns_check.bats, line 43)
        `[ "$status" -eq 0 ]' failed

    5 tests, 3 failures