#!/bin/bash

# general
export PALLADIUM_DIR=$(dirname "$(readlink -f "$0")")
export PALLADIUM_HOSTNAME="example.com"
export PALLADIUM_DOCKER_NETWORK="palladium_default"
export PALLADIUM_ADMIN_EMAIL="admin@example.com"

# databases
export PALLADIUM_MARIADB_ROOT_PASSWORD="mariadb_root_password"
export PALLADIUM_POSTGRES_ROOT_PASSWORD="postgres_root_password"

# healthchecks
export PALLADIUM_HEALTHCHECKS_PASSWORD="healthchecks_password"

# mattermost
export PALLADIUM_MATTERMOST_POSTGRES_USER="mattermost_user"
export PALLADIUM_MATTERMOST_POSTGRES_PASSWORD="mattermost_password"

# nextcloud
export PALLADIUM_MARIADB_NEXTCLOUD_USER="nextcloud_user"
export PALLADIUM_MARIADB_NEXTCLOUD_PASSWORD="nextcloud_password"

# smtp
export PALLADIUM_SMTP_PORT=25
export PALLADIUM_POSTMASTER_USER="postmaster@example.com"
export PALLADIUM_POSTMASTER_PASSWORD="postmaster_password"

# swag
# SEE: https://developers.cloudflare.com/api/tokens/create/ (use "Edit zone DNS" template)
export PALLADIUM_CLOUDFLARE_TOKEN="your-token-here"

# wikijs
export PALLADIUM_MARIADB_WIKIJS_USER="wikijs_user"
export PALLADIUM_MARIADB_WIKIJS_PASSWORD="wikijs_password"
