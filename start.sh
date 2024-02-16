#! /bin/bash

if [ -f /run/secrets/personal_token ]; then
  export ACCESS_TOKEN=$(cat /run/secrets/personal_token)
fi


if [ -f /run/secrets/repo_name ]; then
  export REPO=$(cat /run/secrets/repo_name)
fi

# Install the docker compose
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
docker compose version


REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPO}/actions/runners/registration-token | jq .token --raw-output)

cd /home/docker/actions-runner

./config.sh --url https://github.com/$REPO --token $REG_TOKEN


cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token $REG_TOKEN
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!