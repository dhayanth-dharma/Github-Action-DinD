#!/bin/bash

if [[ $# -lt 1 ]] ; then
  printf "\n%s\n\n" "Missing arguments. Usage: $0 [REINITIATE] [PATH_TO_ROOT]"
  exit 1
fi

if [[ $# -lt 2 ]] ; then
  printf "\n%s\n\n" "Missing arguments. Usage: $0 [REINITIATE] [PATH_TO_ROOT]"
  exit 1
fi

REINITATE=$1
PATH_TO_ROOT=$2 && shift


cd "$PATH_TO_ROOT"

set -e
set -x


if $REINITATE; then
  docker compose down -v
  docker image prune -a
  docker system prune
fi

docker compose stop
docker compose up -d
rm repo_name.txt
rm personal_token.txt
