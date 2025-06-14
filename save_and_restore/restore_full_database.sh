#!/bin/bash
set -e -u -o pipefail

export USER="tom"
export PGPASSWORD="2212"
export HOST="localhost"
export PORT="5432"

SOURCE_BACKUP_FILE="tp_multilang_db_backup.dump"
TARGET_DATABASE_NAME="but3_database"

echo "--- Démarrage de la restauration complète dans la base de données '${TARGET_DATABASE_NAME}' ---"

echo "1/ Suppression de la base de données cible '${TARGET_DATABASE_NAME}' (si elle existe)..."
psql -h "${HOST}" -p "${PORT}" -U "${USER}" -d postgres -c "DROP DATABASE IF EXISTS ${TARGET_DATABASE_NAME};"

echo "2/ Création de la base de données '${TARGET_DATABASE_NAME}' avec la locale fr_FR.UTF-8..."
psql -h "${HOST}" -p "${PORT}" -U "${USER}" -d postgres -c "CREATE DATABASE ${TARGET_DATABASE_NAME} WITH ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8' TEMPLATE = template0;"
echo "Base de données '${TARGET_DATABASE_NAME}' créée avec succès."

echo "3/ Restauration du fichier '${SOURCE_BACKUP_FILE}' dans '${TARGET_DATABASE_NAME}'..."
pg_restore -h "${HOST}" -p "${PORT}" -U "${USER}" -d "${TARGET_DATABASE_NAME}" "${SOURCE_BACKUP_FILE}"
echo "Restauration terminée avec succès dans '${TARGET_DATABASE_NAME}'."

echo "--- Restauration complète de la base de données terminée avec succès ! ---"
