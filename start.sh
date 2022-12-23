#!/bin/bash

source ./exports.sh

cd containers/swag/config/etc/letsencrypt/archive/zigmoo.net
CURRENT_NUMBER=$(ls -tp | grep -v /$ | head -1 | tr -dc '0-9')
CERT="fullchain$CURRENT_NUMBER.pem"
PRIVKEY="privkey$CURRENT_NUMBER.pem"

cp $CERT $PALLADIUM_DIR/palladium-cert.pem
cp $PRIVKEY $PALLADIUM_DIR/palladium-privkey.pem

if [[ $* == *--init* ]]; then
  mkdir -p $PALLADIUM_DIR/containers/swag/config/dns-conf/
  mkdir -p $PALLADIUM_DIR/containers/postgres/docker-entrypoint-initdb.d/

  echo "CREATE DATABASE mattermost;
  CREATE USER $PALLADIUM_MATTERMOST_POSTGRES_USER WITH ENCRYPTED PASSWORD '$PALLADIUM_MATTERMOST_POSTGRES_PASSWORD';
  ALTER USER $PALLADIUM_MATTERMOST_POSTGRES_USER WITH SUPERUSER;
  GRANT ALL PRIVILEGES ON DATABASE mattermost TO $PALLADIUM_MATTERMOST_POSTGRES_USER;" > $PALLADIUM_DIR/containers/postgres/docker-entrypoint-initdb.d/mattermost.sql

  echo "CREATE DATABASE listmonk;
  CREATE USER $PALLADIUM_LISTMONK_POSTGRES_USER WITH ENCRYPTED PASSWORD '$PALLADIUM_LISTMONK_POSTGRES_PASSWORD';
  ALTER USER $PALLADIUM_LISTMONK_POSTGRES_USER WITH SUPERUSER;
  GRANT ALL PRIVILEGES ON DATABASE listmonk TO $PALLADIUM_LISTMONK_POSTGRES_USER;" > $PALLADIUM_DIR/containers/postgres/docker-entrypoint-initdb.d/listmonk.sql

  echo "CREATE DATABASE wikijs;
  CREATE USER $PALLADIUM_WIKIJS_POSTGRES_USER WITH ENCRYPTED PASSWORD '$PALLADIUM_WIKIJS_POSTGRES_PASSWORD';
  ALTER USER $PALLADIUM_WIKIJS_POSTGRES_USER WITH SUPERUSER;
  GRANT ALL PRIVILEGES ON DATABASE wikijs TO $PALLADIUM_WIKIJS_POSTGRES_USER;" > $PALLADIUM_DIR/containers/postgres/docker-entrypoint-initdb.d/wikijs.sql

  echo "dns_cloudflare_api_token = $PALLADIUM_CLOUDFLARE_TOKEN" > $PALLADIUM_DIR/containers/swag/config/dns-conf/cloudflare.ini
fi

docker compose pull
docker compose up --detach --build --force-recreate

if [[ $* == *--init* ]]; then
  sleep 10
  docker compose run listmonk ./listmonk --install --yes
fi