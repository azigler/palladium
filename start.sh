#!/bin/bash

source ./exports.sh

mkdir -p $PALLADIUM_DIR/containers/swag/config/dns-conf/
mkdir -p $PALLADIUM_DIR/containers/mariadb/config/initdb.d/
mkdir -p $PALLADIUM_DIR/containers/postgres/docker-entrypoint-initdb.d/
mkdir -p $PALLADIUM_DIR/containers/mailserver/config/

echo "dns_cloudflare_api_token = $PALLADIUM_CLOUDFLARE_TOKEN" > $PALLADIUM_DIR/containers/swag/config/dns-conf/cloudflare.ini

echo "CREATE USER '$PALLADIUM_MARIADB_NEXTCLOUD_USER'@'nextcloud.$PALLADIUM_DOCKER_NETWORK' IDENTIFIED BY '$PALLADIUM_MARIADB_NEXTCLOUD_PASSWORD';
CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL PRIVILEGES on nextcloud.* to '$PALLADIUM_MARIADB_NEXTCLOUD_USER'@'nextcloud.$PALLADIUM_DOCKER_NETWORK';
FLUSH privileges;" > $PALLADIUM_DIR/containers/mariadb/config/initdb.d/nextcloud.sql

echo "CREATE USER '$PALLADIUM_MARIADB_WIKIJS_USER'@'wikijs.$PALLADIUM_DOCKER_NETWORK' IDENTIFIED BY '$PALLADIUM_MARIADB_WIKIJS_PASSWORD';
CREATE DATABASE IF NOT EXISTS wikijs CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL PRIVILEGES on wikijs.* to '$PALLADIUM_MARIADB_WIKIJS_USER'@'wikijs.$PALLADIUM_DOCKER_NETWORK';
FLUSH privileges;" > $PALLADIUM_DIR/containers/mariadb/config/initdb.d/wikijs.sql

echo "CREATE DATABASE mattermost;
CREATE USER $PALLADIUM_MATTERMOST_POSTGRES_USER WITH ENCRYPTED PASSWORD '$PALLADIUM_MATTERMOST_POSTGRES_PASSWORD';
GRANT ALL PRIVILEGES ON DATABASE mattermost TO $PALLADIUM_MATTERMOST_POSTGRES_USER;" > $PALLADIUM_DIR/containers/postgres/docker-entrypoint-initdb.d/mattermost.sql

wget https://raw.githubusercontent.com/docker-mailserver/docker-mailserver/master/setup.sh
chmod a+x ./setup.sh

wget https://raw.githubusercontent.com/docker-mailserver/docker-mailserver/master/mailserver.env
sed -i 's/SSL_TYPE=/SSL_TYPE=manual/' mailserver.env
sed -i 's/ENABLE_FAIL2BAN=0/ENABLE_FAIL2BAN=1/' mailserver.env
sed -i 's/TZ=/TZ=UTC/' mailserver.env
sed -i 's/PERMIT_DOCKER=none/PERMIT_DOCKER=connected-networks/' mailserver.env
sed -i "s/POSTMASTER_ADDRESS=/POSTMASTER_ADDRESS=$PALLADIUM_POSTMASTER_USER/" mailserver.env
sed -i "s/SSL_CERT_PATH=/SSL_CERT_PATH=\/etc\/letsencrypt\/live\/$PALLADIUM_HOSTNAME\/fullchain1.pem/" mailserver.env
sed -i "s/SSL_KEY_PATH=/SSL_KEY_PATH=\/etc\/letsencrypt\/live\/$PALLADIUM_HOSTNAME\/privkey1.pem/" mailserver.env

docker compose pull
docker compose up --detach --build --force-recreate
