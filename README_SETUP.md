### 📋 Prerequisites
- Docker installed (Get docker [here](https://www.docker.com/get-started/))
- Docker Compose installed (Get docker compose [here](https://docs.docker.com/compose/install/))
- Git installed (Get git [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)) [ Opinional ]


### 🏗️ Project Structure
``` plaintext
Rovere_Ricardo_DEVA1A_2025_164/
├── docker-compose.yml          # Docker services configuration
├── Dockerfile                  # Application image definition
├── requirements.txt            # Python dependencies
├── run_app.py                  # Application entry point
└── flaskr/                     # Flask application
    ├── __init__.py
    ├── database/
    │   ├── db.py
    │   └── rovere_ricardo_deva1a_basketstats_164_2025.sql
    ├── templates/
    ├── static/
    └── ...
```

### Tech Stack
- Frontend Flask , Bootstrap5
- Backend Python 3.9
- Database MySQL

### Architecture Docker
- Environment : MySQL , Flask , Python (app-dev container)
- Test : MySQL , Flask, Python (app-test container)

### Caractéristiques Differences
- Env. Développement 
```bash
- Caractéristique --> Chargement de code 
  - Env. Développement
   . Changements du code modifiable directement via le code source
  - Env. de Prod
   . Code source fixe (Pas de changement si le code source est modifié)
   
- Caractéristique --> Variables d`environnement
  - Env. Développement
   . Verbose = ON, debug = ON -> Pour faire la confirmation : Les logs apparait dans le container sur DockerHub - Containers. Container app-dev
  - Env. Prod
    . Verbose = Off , debug = off -> Pour faire la confirmation :  Pas de log dans le container sur DockerHub - Containers. Container app-prod
```

### ⚙️ Configuration
#### 1. Clone the repository:
   ```bash
   git clone {ulr_repository}
   ```
#### 2. Environment variables:
   - Create a `.env` file in the root directory.
     - Add necessary environment variables (e.g., `FLASK_APP`, `FLASK_ENV`, database credentials).
       - Exemple :
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
#### 3. Docker Compose configuration:
   - The `docker-compose.yml` file defines four services: `dev` and `prod` (the Flask application) and `db-dev` (the MySQL database).
   - Ensure the ports and environment variables are correctly set according to your needs.
   - Services : 
     - db-dev : MySQL database for development Port: 3308
     - app-dev : Flask application in development mode Port: 5000
     - db-prod : MySQL database for production Port: 3309
     - app-prod : Flask application in production mode Port: 5001

#### 4. Start the Services:
   - Run the following command to build and start the services:
     ```bash
     docker compose build
     ```
     To build specific service (e.g., development):
     ```bash
     docker compose build app-dev
     docker compose build app-prod
     ```
   - This command will build the Docker images and start the containers for both the Flask application and the MySQL database.
   - Start all services:
     ```bash
     docker compose up -d
     ```
   - Verify that the services are running:
     ```bash
     docker compose ps
     ```
#### 5. Access the Application:
   - Open your web browser and navigate to:
     - Development: `http://localhost:5000`
     - Production: `http://localhost:5001`

### 🔧 Development Workflow
#### Changes to code are automatically detected in development environment.
1. Edit any Python files in the `flaskr/` directory.
2. Save the changes.
3. Refresh your web browser to see the updates.

### Accessing the Database
```bash
  docker exec -it basketstats-db-dev mysql -u root -p basketstats_dev
```

### Login Credentials on Website
- Username: admin
- Password: admin