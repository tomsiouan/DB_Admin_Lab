#!/bin/bash
set -e -u -o pipefail

export USER="tom"
export PGPASSWORD="2212"
export HOST="localhost"
export PORT="5432"

verify_database() {
    local db_name=$1
    echo "--- Début de la vérification pour la base de données : '${db_name}' ---"

    echo "  -> Tentative de connexion à '${db_name}'..."
    if psql -h "$HOST" -p "$PORT" -U "$USER" -d "$db_name" -c "\conninfo" > /dev/null 2>&1; then
        echo "  ✔️ Connexion réussie à '${db_name}'."
    else
        echo "  ❌ ERREUR: Impossible de se connecter à '${db_name}'. Vérifiez le nom, l'utilisateur et le serveur."
        exit 1
    fi

    echo "  -> Listage des bases de données (`\l` pour vérifier les locales et privilèges globaux)..."
    psql -h "$HOST" -p "$PORT" -U "$USER" -d "postgres" -c "\l ${db_name}" # Spécifie la base à lister pour plus de clarté

    echo "  -> Listage des tables (`\dt` pour vérifier les schémas et tables)..."
    psql -h "$HOST" -p "$PORT" -U "$USER" -d "$db_name" -c "\dt"

    echo "  -> Listage des utilisateurs/rôles (`\du` pour vérifier les rôles créés)..."
    psql -h "$HOST" -p "$PORT" -U "$USER" -d "$db_name" -c "\du"

    echo "  -> Listage des privilèges sur les objets (`\dp` pour les privilèges sur tables/vues/séquences)..."
    psql -h "$HOST" -p "$PORT" -U "$USER" -d "$db_name" -c "\dp"

    echo "--- Fin de la vérification pour la base de données : '${db_name}' ---"
    echo ""
}

verify_database "tp_multilang_db"

verify_database "but3_database"

echo "--- Vérification spécifique pour la base de données but3_eleves_only (restauration ciblée) ---"
echo "  -> Tentative de connexion à 'but3_eleves_only'..."
if psql -h "$HOST" -p "$PORT" -U "$USER" -d "but3_eleves_only" -c "\conninfo" > /dev/null 2>&1; then
    echo "  ✔️ Connexion réussie à 'but3_eleves_only'."
    echo "  -> Listage des tables dans 'but3_eleves_only' (devrait contenir uniquement 'eleves')..."
    psql -h "$HOST" -p "$PORT" -U "$USER" -d "but3_eleves_only" -c "\dt"
else
    echo "  ℹ️ La base de données 'but3_eleves_only' n'existe pas ou n'est pas accessible. (C'est normal si tu n'as pas exécuté la restauration ciblée)."
fi

echo ""
echo "--- Toutes les vérifications ont été effectuées. ---"
echo "Examinez les sorties pour confirmer le statut souhaité de chaque base de données."
