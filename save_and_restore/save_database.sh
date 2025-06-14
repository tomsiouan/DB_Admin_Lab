#!/bin/bash
set -e -u -o pipefail

export USER_FOR_DUMP="admin_user"
export PGPASSWORD="admin_password"
export HOST="localhost"
export PORT="5432"

DATABASE_TO_BACKUP="tp_multilang_db"
BACKUP_FILE="${DATABASE_TO_BACKUP}_backup.dump"

echo "--- Démarrage de la sauvegarde logique de la base de données ${DATABASE_TO_BACKUP} ---"
echo "Sauvegarde de la base de données '${DATABASE_TO_BACKUP}' dans '${BACKUP_FILE}' (format custom)..."

pg_dump -h "${HOST}" -p "${PORT}" -U "${USER_FOR_DUMP}" -Fc "${DATABASE_TO_BACKUP}" > "${BACKUP_FILE}"

echo "Sauvegarde terminée avec succès. Fichier : ${BACKUP_FILE}"
