 TP3 Docker :

Mettre en place une architecture web avec Nginx + PHP-FPM + MariaDB en suivant 3 étapes progressives :
- Étape 1 → Serveur HTTP + PHP avec communication FPM  
- Étape 2 → Ajout d'une base MariaDB + CRUD  
- Étape 3 → Automatisation avec Docker Compose + Volume persistant

Étape 1 — Nginx + PHP-FPM
- 2 containers : `http` (Nginx) et `script` (PHP-FPM)
- Serveur accessible sur : http://localhost:8080
- `index.php` affiche `phpinfo()`



Étape 2 — Ajout MariaDB + CRUD
- 3 containers : `http`, `script`, `data`
- Initialisation via `/docker-entrypoint-initdb.d/create.sql`
- Ext. `mysqli` installée via Dockerfile
- `test.php` insère+compte en BDD

 
http://localhost:8080/test.php → compteur qui s’incrémente 


Étape 3 — Docker Compose + Volume persistant
Orchestration automatique :
```bash
docker compose up -d 
