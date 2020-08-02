#!/bin/sh
set -e

# https://github.com/nodejs/docker-node/blob/master/10/alpine/docker-entrypoint.sh
if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- expo "$@"
fi

exec "$@"
