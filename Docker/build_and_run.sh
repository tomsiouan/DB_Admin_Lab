#!/bin/bash
set -e -u -o pipefail

dockerfile_path="."

# Analyse des arguments
for arg in "$@"; do
  case $arg in
    dockerfile_path=*)
      dockerfile_path="${arg#*=}"
      shift
      ;;
  esac
done

# Construction de l'image Docker
docker build -t postgres-fr "$dockerfile_path"

docker run -d \
  --name postgres-fr \
  -p 5432:5432 \
  -e POSTGRES_USER=tom \
  -e POSTGRES_PASSWORD=2212 \
  -e POSTGRES_DB=tp_multilang_db \
  -v pgdata:/var/lib/postgresql/data \
  postgres-fr
