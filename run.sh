#!/bin/bash
set -e -u -o pipefail

export USER="tom"
export HOST="localhost"
export PORT="5432"
export PGPASSWORD="2212"


DATABASE_NAME="tp_multilang_db"

echo "--- Démarrage de la configuration de la base de données ${DATABASE_NAME} ---"

echo "1/ Création de la base de données '${DATABASE_NAME}'..."
psql -h "${HOST}" -p "${PORT}" -U "${USER}" -d postgres -c "DROP DATABASE IF EXISTS ${DATABASE_NAME};"
psql -h "${HOST}" -p "${PORT}" -U "${USER}" -d postgres -c "CREATE DATABASE ${DATABASE_NAME} WITH ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8' TEMPLATE = template0;"
echo "Base de données '${DATABASE_NAME}' créée avec succès."

echo "2/ Exécution du script de création de tables et insertion de données (tp_multilang_database.sql)..."
psql -h "${HOST}" -p "${PORT}" -U "${USER}" -d "${DATABASE_NAME}" -f ./sql/tp_multilang_database.sql
echo "Script tp_multilang_database.sql exécuté avec succès."

echo "3/ Exécution du script de gestion des utilisateurs et privilèges (users_privileges.sql)..."
psql -h "${HOST}" -p "${PORT}" -U "${USER}" -d "${DATABASE_NAME}" -f ./sql/users_privileges.sql
echo "Script users_privileges.sql exécuté avec succès."

echo "--- Configuration initiale de la base de données terminée avec succès ! ---"
