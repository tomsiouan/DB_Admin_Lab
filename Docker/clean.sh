#!/bin/bash
set -e -u -o pipefail

docker stop postgres-fr
docker rm postgres-fr
docker volume rm pgdata
