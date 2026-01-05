# 🐳 Guide de Configuration Docker - Basket Stats

Guide complet pour déployer l'application Basket Stats avec Docker et Docker Compose.

- [GitHub Repository](https://github.com/RovereRicardo/Docker_347)
- [Docker Hub Repository](https://hub.docker.com/r/mtiii/basketstats)
- [Docker Hub Image - Développement](https://hub.docker.com/repository/docker/mtiii/basketstats/tags/dev)
- [Docker Hub Image - Production](https://hub.docker.com/repository/docker/mtiii/basketstats/tags/prod)
---
## 🐳 Images
| Environnement | Commande Docker Pull               |
|---------------|------------------------------------|
| Prod          | docker pull mtiii/basketstats:prod |
| Dev           | docker pull mtiii/basketstats:dev  |
---

## 📋 Prérequis

- [Docker](https://www.docker.com/get-started/) installé
- [Docker Compose](https://docs.docker.com/compose/install/) installé
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) (optionnel)
- [Compte Docker Hub](https://hub.docker.com) (pour récupérer les images)

---

## 🏗️ Structure du Projet

```plaintext
Docker_347/
├── docker-compose.yml          # Orchestration des services Docker
├── Dockerfile                  # Configuration multi-étapes de build
├── requirements.txt            # Dépendances Python
├── .env                        # Variables d'environnement
├── run_app.py                  # Point d'entrée de l'application
└── flaskr/                     # Application Flask
    ├── __init__.py
    ├── database/
    │   ├── db.py               # Logique de connexion à la base de données
    │   ├── rovere_ricardo_deva1a_basketstats_164_2025.sql      # Dump dev
    │   └── rovere_ricardo_deva1a_basketstats_164_2025-prod.sql # Dump prod
    ├── templates/
    ├── static/
    └── ...
```

---

## 🛠 Stack Technologique

| Composant | Technologie |
|-----------|-----------|
| Frontend  | Flask + Bootstrap 5 |
| Backend   | Python 3.12 |
| Base de données  | MySQL 8.0 |
| Serveur Web (Prod) | Gunicorn |

---

## 🌐 Architecture Docker

### Vue d'ensemble des Services

| Service | Nom du Conteneur | Port | Environnement | Objectif |
|---------|------------------|------|---------------|----------|
| `app-dev` | basketstats-dev | 5000 | Développement | Application Flask avec rechargement automatique |
| `db-dev` | basketstats-mysql-dev | 3308 | Développement | MySQL avec données complètes |
| `app-prod` | basketstats-prod | 5001 | Production | Application Flask avec Gunicorn |
| `db-prod` | basketstats-mysql-prod | 3309 | Production | MySQL avec tables vides |

### Différences Clés

| Fonctionnalité | Développement | Production |
|----------------|---------------|-----------|
| **Modifications du Code** | Rechargement automatique via montage de volumes | Code fixe (reconstruction nécessaire) |
| **Mode Debug** | `FLASK_DEBUG=1` | `FLASK_DEBUG=0` |
| **Journalisation** | `VERBOSE=ON` (logs détaillés) | `VERBOSE=OFF` (logs minimaux) |
| **Base de Données** | Données complètes avec matchs d'exemple | Tables vides (structure uniquement) |
| **Serveur Web** | Serveur de développement Flask | Gunicorn (4 workers) |

---

**Verification Mode Debug**
### **Voir les logs**

docker compose logs -f

**Voir les logs d'un service spécifique**
```bash
cker compose logs -f app-dev
docker compose logs -f app-prod
```

ou dans DockerHub

```bash
DockerHub -> Containers 
Choisir le container : app-dev ou app-prod
Choisir l`onglet `Logs`
Refraishir la page
```

**Verification Base de Données**
```bash
Environnement de Dev Base de données pré remplis.
http://localhost:5000/matches -> Matches affiché.

Environnement de Prod Base de données pas remplis.
http://localhost:5001/matches -> Pas de matchs affiché
```


## ⚙️ Installation & Configuration

### 1. Cloner le Dépôt

```bash
git clone https://github.com/RovereRicardo/Docker_347.git
cd Docker_347
```

### 2. Variables d'Environnement

Le fichier `.env` est déjà configuré avec les valeurs par défaut de développement :

```env
DB_NAME=basketstats_dev
DB_HOST=db-dev
DB_USER=root
DB_PASSWORD=root
DB_PORT=3306
SECRET_KEY=your-secret-key-here
FLASK_DEBUG=1
VERBOSE=ON
```

**Note** : Les variables d'environnement dans `docker-compose.yml` écrasent ces valeurs par défaut.

### 3. Récupérer les Images depuis Docker Hub

Au lieu de construire localement, récupérez les images pré-construites :

```bash
# Récupérer les images de développement et production
docker compose pull
```

Si vous devez construire localement :

```bash
# Construire toutes les images
docker compose build

# Ou construire des services spécifiques
docker compose build app-dev
docker compose build app-prod
```

---

## 🚀 Lancement de l'Application

### Démarrer Tous les Services

```bash
# Démarrer en mode détaché
docker compose up -d

# Voir les logs
docker compose logs -f

# Voir les logs d'un service spécifique
docker compose logs -f app-dev
docker compose logs -f app-prod
```

ou 

```bash
DockerHub -> Containers 
Choisir le container : app-dev ou app-prod
Choisir l`onglet `Logs`
Refraishir la page
```

### Démarrer des Environnements Spécifiques

```bash
# Développement uniquement
docker compose up -d app-dev db-dev

# Production uniquement
docker compose up -d app-prod db-prod
```

### Vérifier les Services

```bash
# Vérifier les conteneurs en cours d'exécution
docker compose ps

# Devrait afficher :
# basketstats-dev         running   0.0.0.0:5000->5000/tcp
# basketstats-mysql-dev   running   0.0.0.0:3308->3306/tcp
# basketstats-prod        running   0.0.0.0:5001->5000/tcp
# basketstats-mysql-prod  running   0.0.0.0:3309->3306/tcp
```

### Accéder à l'Application

- **Développement** : [http://localhost:5000](http://localhost:5000)
- **Production** : [http://localhost:5001](http://localhost:5001)

---

## 🔐 Identifiants de Connexion dans l'Application (Page WEB)

### Administrateur

```
Nom d'utilisateur : admin
Mot de passe : admin
```

### Entraîneurs d'Équipe

| Équipe | Nom d'utilisateur | Mot de passe |
|--------|-------------------|--------------|
| Bulle | bulle | bullebasket |
| Sarine | sarine | sarinebasket |
| Veveyse | veveyse | veveysebasket |
| Villars | villars | villarsbasket |
| Payerne | payerne | payernebasket |
| Fribourg | fribourg | fribourgbasket |
| Courtepin | courtepin | courtepinbasket |
| Marly | marly | marlybasket |

---

## 🗄️ Gestion de la Base de Données

### Accéder au Shell MySQL

```bash
# Base de données de développement
docker exec -it basketstats-mysql-dev mysql -u root -proot basketstats_dev

# Base de données de production
docker exec -it basketstats-mysql-prod mysql -u root -proot basketstats_prod
```

### Voir les Tables

```bash
# Dans le shell MySQL
SHOW TABLES;
SELECT COUNT(*) FROM t_match;  # Vérifier les données
```

### Réinitialiser la Base de Données

```bash
# Arrêter les services et supprimer les volumes
docker compose down -v

# Redémarrer (réimportera les dumps SQL)
docker compose up -d
```

---

## 🔧 Workflow de Développement

### Effectuer des Modifications de Code

L'environnement de développement utilise des montages de volumes pour le rechargement automatique :

1. Modifiez les fichiers dans le répertoire `flaskr/`
2. Enregistrez les modifications
3. Flask se recharge automatiquement
4. Rafraîchissez le navigateur pour voir les mises à jour

**Aucun redémarrage de conteneur nécessaire !**

### Voir les Logs en Temps Réel

```bash
# Tous les services
docker compose logs -f

# Service spécifique avec sortie détaillée
docker compose logs -f app-dev
```

---

## 🏭 Déploiement en Production

### Utilisation des Images Docker Hub

Le `docker-compose.yml` est déjà configuré pour utiliser les images depuis Docker Hub (`mtiii/basketstats:prod` et `mtiii/basketstats:dev`).

### Déployer en Production

```bash
# Production
git clone https://github.com/RovereRicardo/Docker_347.git
cd Docker_347

# Récupérer les dernières images
docker compose pull

# Démarrer les services de production
docker compose up -d app-prod db-prod

# Vérifier l'état
docker compose ps
```

### Déployer en Developpement

```bash
# Production
git clone https://github.com/RovereRicardo/Docker_347.git
cd Docker_347

# Récupérer les dernières images
docker compose pull

# Démarrer les services de production
docker compose up -d app-dev db-dev

# Vérifier l'état
docker compose ps
```

### Mettre à Jour en Développement

```bash
# Récupérer les dernières images
docker pull mtiii/basketstats:dev

# Recréer le conteneur
docker compose up -d --force-recreate app-dev
```

---

## 🧹 Nettoyage

### Arrêter les Services

```bash
# Arrêter tous les services
docker compose down

# Arrêter et supprimer les volumes (supprime les données !)
docker compose down -v
```

### Supprimer les Images

```bash
# Supprimer les images de l'application
docker rmi mtiii/basketstats:dev mtiii/basketstats:prod

# Supprimer toutes les images non utilisées
docker image prune -a
```

### Réinitialisation Complète

```bash
# Tout arrêter et nettoyer
docker compose down -v
docker system prune -a --volumes

# Redémarrer à neuf
docker compose up -d
```

---

## 📊 Surveillance

### Utilisation des Ressources

```bash
# Voir la consommation de ressources
docker stats

# Voir un conteneur spécifique
docker stats basketstats-dev
```

### Vérifications de Santé

Les deux bases de données incluent des vérifications de santé qui vérifient que MySQL répond :

```yaml
healthcheck:
  test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u", "root", "-proot"]
  interval: 10s
  timeout: 5s
  retries: 5
  start_period: 30s
```

---

## 🔗 Commandes Utiles

```bash
# Voir tous les conteneurs
docker compose ps

# Voir les logs
docker compose logs -f

# Redémarrer un service spécifique
docker compose restart app-dev

# Exécuter une commande dans un conteneur
docker compose exec app-dev flask --help

# Accéder au shell d'un conteneur
docker compose exec app-dev /bin/bash

# Mettre à jour les images
docker compose pull

# Reconstruire et redémarrer
docker compose up -d --build
```

---

## 📚 Ressources Supplémentaires

- [Documentation Docker](https://docs.docker.com/)
- [Documentation Docker Compose](https://docs.docker.com/compose/)
- [Documentation Flask](https://flask.palletsprojects.com/)
- [Documentation MySQL](https://dev.mysql.com/doc/)

---

## 👨‍💻 Auteur

**Ricardo Rovere**

**Santos Macuácua**

**Havana Al-Ali**

---
