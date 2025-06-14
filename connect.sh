#!/bin/bash
set -e -u -o pipefail

USER="tom"
DB="tp_multilang_db"
HOST="localhost"
PORT="5432"
export PGPASSWORD="2212"

psql -h "$HOST" -p "$PORT" -U "$USER" -d "$DB"
