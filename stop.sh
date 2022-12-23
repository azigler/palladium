#!/bin/bash

source ./exports.sh

docker image prune --force
docker compose down
