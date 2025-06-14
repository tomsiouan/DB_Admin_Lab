#!/bin/bash
set -e -u -o pipefail

USER="tom"
DB="postgres"
HOST="localhost"
PORT="5432"
export PGPASSWORD="2212"

psql -h "$HOST" -p "$PORT" -U "$USER" -d "$DB"
