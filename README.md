![](https://user-images.githubusercontent.com/7295363/176799033-c0902aae-f2dd-4b66-9844-9739a5492402.jpg)

# palladium

> Deploy-and-enjoy web service suite via Docker

[![License](https://img.shields.io/badge/license-MIT-EEE.svg?style=popout-square)](./LICENSE.md)
[![Contributing Guide](https://img.shields.io/badge/contributing-guide-EEE.svg?style=popout-square)](./.github/CONTRIBUTING.md)
[![Code of Conduct](https://img.shields.io/badge/contributor-covenant-EEE.svg?style=popout-square)](./.github/CODE_OF_CONDUCT.md)
[![Security Policy](https://img.shields.io/badge/security-policy-EEE.svg?style=popout-square)](./.github/SECURITY.md)

## Table of Contents

- [Background](#background)
	- [Containers](#containers)
    - [Environmental Variables](#environmental-variables)
- [Install](#install)
- [Usage](#usage)
- [Setup](#setup)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

Easy-to-use `docker-compose.yml` to bootstrap a Docker network of open source containers and provide a web service suite.

### Containers

- **[healthchecks](https://github.com/linuxserver/docker-healthchecks):** lscr.io/linuxserver/healthchecks:latest
- **[mailserver](https://github.com/docker-mailserver/docker-mailserver):** docker.io/mailserver/docker-mailserver:latest
  - **Ports**:
    - **25**: SMTP  (explicit TLS to STARTTLS)
    - **143**: IMAP4 (explicit TLS to STARTTLS)
    - **465**: ESMTP (implicit TLS)
    - **587**: ESMTP (explicit TLS to STARTTLS)
    - **993**: IMAP4 (implicit TLS)
- **[mattermost](https://hub.docker.com/layers/mattermost-team-edition/mattermost/mattermost-team-edition/release-7.0/images/sha256-c8b1ab756155e36b8c9a97e41e90d23e35f12f3f6e15f05c18edb1c2e94a27cb?context=explore):** mattermost/mattermost-team-edition:release-7.0
- **[mariadb](https://github.com/linuxserver/docker-mariadb):** lscr.io/linuxserver/mariadb:latest
- **[nextcloud](https://github.com/linuxserver/docker-nextcloud):** lscr.io/linuxserver/nextcloud:latest
- **[postgres](https://hub.docker.com/layers/postgres/library/postgres/latest/images/sha256-d3eecdd28512e721b10d6e270d4ede4cbd57706f0c5bf28ea1dc952eff325650?context=explore):** postgres:latest
- **[roundcube](https://github.com/roundcube/roundcubemail-docker):** roundcube/roundcubemail:latest
- **[swag](https://github.com/linuxserver/docker-swag):** lscr.io/linuxserver/swag:latest
- **[wikijs](https://github.com/linuxserver/docker-wikijs):** lscr.io/linuxserver/wikijs:latest

### Environmental Variables

Edit these values in `exports.sh` before use.

```bash
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
export PALLADIUM_NEXTCLOUD_PASSWORD="nextcloud_password"
export PALLADIUM_MARIADB_NEXTCLOUD_USER="nextcloud_user"
export PALLADIUM_MARIADB_NEXTCLOUD_PASSWORD="nextcloud_password"

# smtp
export PALLADIUM_SMTP_PORT=25
export PALLADIUM_POSTMASTER_USER="postmaster@example.com"
export PALLADIUM_POSTMASTER_PASSWORD="smtp_password"

# swag
# SEE: https://developers.cloudflare.com/api/tokens/create/ (use "Edit zone DNS" template)
export PALLADIUM_CLOUDFLARE_TOKEN="your-token-here"

# wikijs
export PALLADIUM_WIKIJS_PASSWORD="wikijs_password"
export PALLADIUM_MARIADB_WIKIJS_USER="wikijs_user"
export PALLADIUM_MARIADB_WIKIJS_PASSWORD="wikijs_password"
```

## Install

1. Clone and enter the repository:

```bash
git clone https://github.com/azigler/palladium.git
cd palladium
```

2. Edit `exports.sh` and add your own values.

3. *(Optional)* Create a `init.sh` script to run after starting the containers. You'll need to create your first email address in order to keep `mailserver` online, so you could start by creating a `postmaster@example.com` address:

```bash
#!/bin/bash
source ./exports.sh
./setup.sh email add $PALLADIUM_POSTMASTER_USER $PALLADIUM_POSTMASTER_PASSWORD
```

4. Proceed to [Usage](#usage) to start your Docker containers (then execute your `init.sh`, if created).

5. Proceed to [Setup](#setup) to finalize your configuration.

## Usage

Start the containers with:

```bash
./start.sh
```

If you have not yet done so, proceed to [Setup](#setup) to finalize your configuration.

Stop the containers with:

```bash
./stop.sh
```

## Setup

Coming soon!

## Maintainers

[@azigler](https://github.com/azigler)

## Contributing

Feedback and contributions are encouraged! After reading the [Code of Conduct](./.github/CODE_OF_CONDUCT.md), use the [Bug Report](https://github.com/azigler/palladium/issues/new?assignees=&labels=bug&template=bug-report.md&title=) and [Feature Request](https://github.com/azigler/palladium/issues/new?assignees=&labels=enhancement&template=feature-request.md&title=) issue templates to discuss any bugs or contributions to palladium. For more information, please read the [Contributing Guide](./.github/CONTRIBUTING.md).

## License

[MIT](./LICENSE.md) © Andrew Zigler
