#!/bin/bash
set -e -u -o pipefail

export USER="tom"
export HOST="localhost"
export PORT="5432"
export PGPASSWORD="2212"

SOURCE_DUMP_FILE="tp_multilang_db_backup.dump"
DATABASE_NAME="but3_eleves_only"

echo "--- Démarrage de la restauration ciblée de la base de données ${DATABASE_NAME} ---"
echo "1/ Suppression de la base de données existante (si elle existe) : '${DATABASE_NAME}'..."
psql -h "${HOST}" -p "${PORT}" -U "${USER}" -d postgres -c "DROP DATABASE IF EXISTS ${DATABASE_NAME};"

echo "2/ Création de la base de données '${DATABASE_NAME}' avec la locale française..."
psql -h "${HOST}" -p "${PORT}" -U "${USER}" -d postgres -c "CREATE DATABASE ${DATABASE_NAME} WITH ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8' TEMPLATE = template0;"
echo "Base de données '${DATABASE_NAME}' créée avec succès."

echo "3/ Restauration uniquement de la table 'eleves' dans la base '${DATABASE_NAME}'..."
pg_restore -h "${HOST}" -p "${PORT}" -U "${USER}" -d "${DATABASE_NAME}" -t eleves "${SOURCE_DUMP_FILE}"
echo "Restauration ciblée de la table 'eleves' terminée avec succès."

echo "--- Restauration ciblée de la base de données terminée avec succès ! ---"
