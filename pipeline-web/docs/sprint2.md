## Sprint 2
## Administracion basica

    creacion de usuarios,usuarios,grupos,permisos

    1 se creo un nuevo usuario devsec con el comando sudo adduser devsec
    2 se creo un nuevo grupo que se llama pipeline con el comando sudo addgroup pipeline
    3 se añade el usuario creado al grupo pipeline con el objetivo de que este usuario tenga los permisos necesarios para modificar los archivos para esto se usa el comando sudo usermod -aG pipeline devsec
    4 se crea el archivo gestion_pipeline que va a permitir la gestion de permisos y propiedad de los archivos con el comando touch gestion_pipeline.txt
    5 se cambia los permmisos de escritura y de lectura al archivo gestion_pipeline dependiendo del usuario con el comando sudo chmod 640 gestion_pipeline.txt

    passwd: password updated successfully
    Changing the user information for devsec
    Enter the new value, or press ENTER for the default
            Full Name []: andre
            Room Number []:
            Work Phone []:
            Home Phone []:
            Other []:
    Is the information correct? [Y/n] y
    info: Adding new user `devsec' to supplemental / extra groups `users' ...
    info: Adding user `devsec' to group `users' ...

    procesos

    1 con el comando ps aux | grep bash se lista los procesos que se vienen desarrollando

    henry        520  0.0  0.0   6204  4864 pts/0    Ss+  09:21   0:00 -bash
    henry        528  0.0  0.0   6204  4992 pts/2    Ss+  09:21   0:00 -bash
    henry        543  0.0  0.0   6204  4992 pts/3    Ss+  09:21   0:00 -bash
    henry        731  0.0  0.0   6072  4992 pts/1    S+   09:21   0:00 -bash
    henry       1095  0.0  0.0   6204  5248 pts/4    Ss   10:19   0:00 -bash
    henry       1603  0.0  0.0   6204  5248 pts/5    Ss   12:48   0:00 -bash
    henry       4196  0.0  0.0   4092  1920 pts/5    S+   21:03   0:00 grep --color=auto bas

    señales 

    1 se identifica el proceso al cual se quiere dar por terminado por su id y se utiliza el comando sudo kill <PID>
    2 En caso de fallar se utiliza el comando sudo kill -9 <PID> que obliga al sistema a terminar el proceso