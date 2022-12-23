![](https://user-images.githubusercontent.com/7295363/176799033-c0902aae-f2dd-4b66-9844-9739a5492402.jpg)

# palladium

> Deploy-and-enjoy web service suite via Docker

[![License](https://img.shields.io/badge/license-MIT-EEE.svg?style=popout-square)](./LICENSE.md)
[![Contributing Guide](https://img.shields.io/badge/contributing-guide-EEE.svg?style=popout-square)](./.github/CONTRIBUTING.md)
[![Code of Conduct](https://img.shields.io/badge/contributor-covenant-EEE.svg?style=popout-square)](./.github/CODE_OF_CONDUCT.md)
[![Security Policy](https://img.shields.io/badge/security-policy-EEE.svg?style=popout-square)](./.github/SECURITY.md)

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

Easy-to-use `docker-compose.yml` to bootstrap a [Docker network](https://docs.docker.com/network/) of open source containers and provide a web service suite.

- **[listmonk](https://hub.docker.com/r/listmonk/listmonk/tags):** listmonk/listmonk:latest
- **[mattermost](https://hub.docker.com/r/mattermost/mattermost-team-edition/tags):** mattermost/mattermost-team-edition:latest
- **[postgres](https://hub.docker.com/_/postgres/tags):** postgres:latest
- **[redis](https://hub.docker.com/_/redis/tags):** redis:latest
- **[swag](https://github.com/linuxserver/docker-swag):** lscr.io/linuxserver/swag:latest
- **[wikijs](https://github.com/linuxserver/docker-wikijs):** lscr.io/linuxserver/wikijs:latest

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

## Maintainers

[@azigler](https://github.com/azigler)

## Contributing

Feedback and contributions are encouraged! After reading the [Code of Conduct](./.github/CODE_OF_CONDUCT.md), use the [Bug Report](https://github.com/azigler/palladium/issues/new?assignees=&labels=bug&template=bug-report.md&title=) and [Feature Request](https://github.com/azigler/palladium/issues/new?assignees=&labels=enhancement&template=feature-request.md&title=) issue templates to discuss any bugs or contributions to palladium. For more information, please read the [Contributing Guide](./.github/CONTRIBUTING.md).

## License

[MIT](./LICENSE.md) © Andrew Zigler
