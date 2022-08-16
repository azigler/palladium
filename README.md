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
    - [Environment Variables](#environment-variables)
- [Install](#install)
- [Usage](#usage)
- [Setup](#setup)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

Easy-to-use `docker-compose.yml` to bootstrap a [Docker network](https://docs.docker.com/network/) of open source containers and provide a web service suite.

### Containers

- **[healthchecks](https://github.com/linuxserver/docker-healthchecks):** lscr.io/linuxserver/healthchecks:latest
- **[mailserver](https://github.com/docker-mailserver/docker-mailserver):** docker.io/mailserver/docker-mailserver:latest
  - **Ports**:
    - **25**: SMTP  (explicit TLS to STARTTLS)
    - **143**: IMAP4 (explicit TLS to STARTTLS)
    - **465**: ESMTP (implicit TLS)
    - **587**: ESMTP (explicit TLS to STARTTLS)
    - **993**: IMAP4 (implicit TLS)
- **[mattermost](https://hub.docker.com/r/mattermost/mattermost-team-edition/tags):** mattermost/mattermost-team-edition:latest
- **[mariadb](https://github.com/linuxserver/docker-mariadb):** lscr.io/linuxserver/mariadb:latest
- **[nextcloud](https://github.com/linuxserver/docker-nextcloud):** lscr.io/linuxserver/nextcloud:latest
- **[postgres](https://hub.docker.com/_/postgres/tags):** postgres:latest
- **[roundcube](https://github.com/roundcube/roundcubemail-docker):** roundcube/roundcubemail:latest
- **[swag](https://github.com/linuxserver/docker-swag):** lscr.io/linuxserver/swag:latest
- **[wikijs](https://github.com/linuxserver/docker-wikijs):** lscr.io/linuxserver/wikijs:latest

### Environment Variables

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
export PALLADIUM_MARIADB_WIKIJS_USER="wikijs_user"
export PALLADIUM_MARIADB_WIKIJS_PASSWORD="wikijs_password"
```

## Install

This project was tested in the `/opt` directory of a Ubuntu 22.04 (LTS) x64 Droplet with 2GB memory and 25GB disk space hosted by [DigitalOcean](https://m.do.co/c/a3448cce0762). You need to have the latest [Docker Desktop](https://docs.docker.com/engine/install/) installed for your operating system, with `docker compose` available as a command.

1. Clone and enter the repository:

```bash
git clone https://github.com/azigler/palladium.git
cd palladium
```

2. Edit `exports.sh` and add your own values.

3. Use `git update-index --assume-unchanged exports.sh` to keep your values out of source control.

4. Proceed to [Usage](#usage) to start your [Docker containers](https://docs.docker.com/compose/). Services may work inconsistently the first time they are brought online, specifically if you are generating certificates. It's recommended to restart the [Docker containers](https://docs.docker.com/compose/) once after they fully come online for the first time before troubleshooting further.

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

This setup guide is presented in the recommended order of completion.

### mailserver

Follow the [official documentation for docker-mailserver](https://docker-mailserver.github.io/docker-mailserver/edge/config/setup.sh/) to create your desired email accounts. **You will need to create at least one email address to keep the server online.** For example, you could create an email account with:

```
./setup.sh email add postmaster@example.com postmaster_password
```

Once you're set up, consider following the guides to support [DKIM](https://docker-mailserver.github.io/docker-mailserver/edge/config/best-practices/dkim/), [SPF](https://docker-mailserver.github.io/docker-mailserver/edge/config/best-practices/spf/), and PTR records. Running your own mail server will open yourself up to a new vector of threats, so protect yourself appropriately. This configuration comes with [fail2ban](https://github.com/fail2ban/fail2ban) enabled.

`palladium` will automatically enable TLS on `mailserver` if you have configured your DNS as per the following [swag](#swag) guide.

Troubleshooting `mailserver`:
- [CheckTLS](https://www.checktls.com/TestReceiver)
- [DKIM Test](https://www.appmaildev.com/en/dkim)
- [DKIM Record Checker](https://easydmarc.com/tools/dkim-lookup?domain=zigmoo.net&selector=mail)
- [MXToolBox](https://mxtoolbox.com/SuperTool.aspx)

Example `PTR` record configuration in [Cloudflare](https://www.cloudflare.com/). Replace `example.com` with your domain name:
![](https://user-images.githubusercontent.com/7295363/176978730-19937143-5261-4268-b631-621718514aa9.png)

Example `DKIM` configuration in [Cloudflare](https://www.cloudflare.com/). Replace `mygeneratedkeygoeshere==` with all of the content after `p=` in `containers/mailserver/config/opendkim/keys/example.com/mail.txt` (combining the lines between the quotes to create a single string):
![](https://user-images.githubusercontent.com/7295363/176978742-8931ec0b-8cc2-4957-927d-5487a3c653a1.png)

Example `SPF` configuration in [Cloudflare](https://www.cloudflare.com/). Replace `example.com` with your domain name and `your.ip.address.here` with your server's public IP address:
![](https://user-images.githubusercontent.com/7295363/176978757-d3cd08cc-37a1-42a2-8e41-0ec6cada5f29.png)

### swag

This container requires a [wildcard DNS record](https://blog.cloudflare.com/wildcard-proxy-for-everyone/). **This setup assumes you are using [Cloudflare](https://www.cloudflare.com/) for your DNS.**

1. Log in to [Cloudflare](https://www.cloudflare.com/), select your domain, then select DNS in the left menu. 

2. Create an `A` type record with the name as your domain name and the target as your server's public IP address.

3. Create a `CNAME` type record with the name `*` and the target being your domain name.

4. Disable proxying and use only DNS on the records (toggle the orange clouds to gray)

5. Wait for your DNS changes to fully propagate.

6. You may need to restart the container in order to see your TLS credentials successfully generated in the `swag` container log.

Consider adding your IP to `ignoreip` in `containers/swag/config/fail2ban/jail.local`.

### mattermost

1. Access your `mattermost` deployment in your web browser at `https://mattermost.example.com`.

2. Follow the steps to create your admin account and team.

3. Click the grid in the top left, select **System Console**, and select **SMTP** on the left menu.

4. Configure the settings like the following, swapping `example.com` and the email credentials for your own:
![](https://user-images.githubusercontent.com/7295363/176979673-4d2b84af-68fc-4747-b5a2-ed90f7bbfe1a.png)

5. Send a test email to confirm it's working. It will arrive in the email you used to register your Mattermost admin account.

If you will be using `healthchecks` for monitoring, consider setting up an integration from that service to this `mattermost` deployment.

### nextcloud

1. Access your `nextcloud` deployment in your web browser at `https://nextcloud.example.com`.

2. Follow the steps at the top to create your admin account.

3. Click **Storage & database** and select `MySQL/MariaDB`.

4. Configure the initialization settings using the database credentials for `nextcloud` from your `exports.sh`. The database host is `mariadb`, which is the name of the database container on the network:
![](https://user-images.githubusercontent.com/7295363/176980141-11554c93-971a-4074-93aa-fc2600ca9658.png)

5. Confirm your settings and initialize the server. It may take a few moments to finish.

6. In the top right, click your profile circle, then click **Settings**.

7. In the left menu, select **Personal settings** and add a valid email address.

8. In the left menu, under **Administration**, select **Basic settings**.

9. Configure the **Email server** settings like the following, using your own domain and credentials:
![](https://user-images.githubusercontent.com/7295363/176980377-91310136-7af7-4f8c-aeb7-c4e36f426c24.png)

10. Send a test email to confirm it's working. It will arrive in the email you added to your Nextcloud account.

### wikijs

1. Access your `wikijs` deployment in your web browser at `https://wikijs.example.com`.

2. Follow the steps at the top to create your admin account.

3. Log in.

4. Click **Administration**.

5. In the left menu, under **System**, select **Mail**.

6. Configure the **Mail** settings like the following, using your own domain, credentials, and DKIM key (if applicable):
![](https://user-images.githubusercontent.com/7295363/176981160-c64789c6-b659-4722-96c7-caf9419f2409.png)

7. Click **Apply** at the top.

8. Send a test email to confirm it's working.

### healthchecks

This container requires no setup. To confirm it's able to communicate with `mailserver`, log in and send a test from the default email integration. It will arrive in your `$PALLADIUM_ADMIN_EMAIL` inbox.

### roundcube

This container requires no setup. To confirm it's able to communicate with `mailserver`, access the service in your web browser and log in with an email you've created.

### mariadb

This container requires no setup.

### postgres

This container requires no setup.

## Maintainers

[@azigler](https://github.com/azigler)

## Contributing

Feedback and contributions are encouraged! After reading the [Code of Conduct](./.github/CODE_OF_CONDUCT.md), use the [Bug Report](https://github.com/azigler/palladium/issues/new?assignees=&labels=bug&template=bug-report.md&title=) and [Feature Request](https://github.com/azigler/palladium/issues/new?assignees=&labels=enhancement&template=feature-request.md&title=) issue templates to discuss any bugs or contributions to palladium. For more information, please read the [Contributing Guide](./.github/CONTRIBUTING.md).

## License

[MIT](./LICENSE.md) © Andrew Zigler
