#!/bin/bash

# general
export PALLADIUM_DIR=$(dirname "$(readlink -f "$0")")
export PALLADIUM_HOSTNAME="example.com"
export PALLADIUM_DOCKER_NETWORK="palladium_default"
export PALLADIUM_ADMIN_EMAIL="admin@example.com"

# databases
export PALLADIUM_POSTGRES_ROOT_PASSWORD="postgres_root_password"
export PALLADIUM_REDIS_PASSWORD="redis_password"

# listmonk
export PALLADIUM_LISTMONK_POSTGRES_USER="listmonk_postgres_user"
export PALLADIUM_LISTMONK_POSTGRES_PASSWORD="listmonk_postgres_password"
export PALLADIUM_LISTMONK_ADMIN_USER="listmonk_admin_user"
export PALLADIUM_LISTMONK_ADMIN_PASSWORD="listmonk_admin_password"

# mattermost
export PALLADIUM_MATTERMOST_POSTGRES_USER="mattermost_postgres_user"
export PALLADIUM_MATTERMOST_POSTGRES_PASSWORD="mattermost_postgres_password"
export PALLADIUM_MATTERMOST_ADMIN_USER="mattermost_admin_user"
export PALLADIUM_MATTERMOST_ADMIN_PASSWORD="mattermost_admin_password"

# swag
export PALLADIUM_CLOUDFLARE_TOKEN="your-token-here"

# wikijs
export PALLADIUM_WIKIJS_POSTGRES_USER="wikijs_postgres_user"
export PALLADIUM_WIKIJS_POSTGRES_PASSWORD="wikijs_postgres_password"
export PALLADIUM_WIKIJS_ADMIN_USER="wikijs_admin_user"
export PALLADIUM_WIKIJS_ADMIN_PASSWORD="wikijs_admin_password"
