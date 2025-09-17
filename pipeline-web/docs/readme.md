## Sprint 1 Configuracion inicial

## Despliegue de programa

    1 ejecutamos el comando  python3 -m venv venv
    2 activamos el venv con el comando source venv/bin/activate
    3 desplegamos el programa con python3 app.py

## Verificacion HHTP

    1  verificamos el http con el comando curl -v http://127.0.0.1:8080/
    
    < HTTP/1.1 200 OK
    < Server: Werkzeug/3.1.3 Python/3.12.3
    < Date: Tue, 16 Sep 2025 17:48:11 GMT
    < Content-Type: application/json
    < Content-Length: 60
    < Connection: close
    <
    {"message":"pipeline0","port":8080,"release":"v0","status":"ok"}
    
    2  curl -i -X POST http://127.0.0.1:8080/

    <h1>Method Not Allowed</h1>
    <p>The method is not allowed for the requested URL.</p>

    3  verificamos que el http este funcionando correctamente para ello hacemos uso de los comandos chmod +x src/http-check.sh y bash src/http-check.sh

    [INFO] Verificando código de estado y mostrando cuerpo
    Código correcto: 200
    [INFO] Mostrando cuerpo de la respuesta
    {"message":"pipeline0","port":8080,"release":"v0","status":"ok"}

    [INFO] Mostrando cabeceras
    HTTP/1.1 200 OK
    Server: Werkzeug/3.1.3 Python/3.12.3

## Verificacion DNS

    1   añadimos un host local con la ip de dominio y el nombre
    2   comprobamos la resolucion del dns con dig +short pipeline.local y getent hosts pipeline.local

    127.0.0.1       pipeline.local

    3   Verificamos la disponibilidad del dig y getent con los comandos chmod +x src/dns_check.sh y bash src/dns_check.sh

    [INFO] Resolviendo pipeline.local con getent hosts
    127.0.0.1       pipeline.local

    [INFO] Comprobando que pipeline.local resuelva a 127.0.0.1
    [OK] pipeline.local → 127.0.0.1

## factor 12-app

    1 se levanta el proyecto con el comando  PORT=8080 MESSAGE="pipeline1" RELEASE="v1" python3 app.pypy
    2 con el comando ss -ltnp | grep :8080 verificamos que se esta trabajando en el puerto 8080

    LISTEN 0      128         127.0.0.1:8080      0.0.0.0:*    users:(("python3",pid=2813,fd=3))

    3 para la configuracion por entorno levantamos el proyecto con los datos del puerto mensaje y version PORT=8080 MESSAGE="pipeline1" RELEASE="v1" python3 app.py

    {"message":"pipeline1","port":8080,"release":"v1","status":"ok"}

    4 se verifica el levantamiento del proyecto con el comando curl http://127.0.0.1:8080/
    5 se verifica que se crearon los logs en stdout: 
    * Running on http://127.0.0.1:8080
    Press CTRL+C to quit
    [INFO] GET /  message=pipeline1 release=v1
    127.0.0.1 - - [16/Sep/2025 17:55:00] "GET / HTTP/1.1" 200 -
