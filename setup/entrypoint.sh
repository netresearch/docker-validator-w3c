#!/usr/bin/env bash
set -ex

# no arguments at all - start apache as entry point command
if [ $# -eq 0 ]; then
    set -- apachectl -D "FOREGROUND" -k start >> /dev/stdout 2>&1 "$@"
fi

exec "$@"
