#!/usr/bin/env bash
set -eu -o pipefail

CONTAINER_COUNT=$(docker ps -aq --filter "status=running" |  grep "" -c)

if [[ $CONTAINER_COUNT -eq 0 ]] ; then
    echo "No one else left to kill..."
    exit 0
fi

echo "I am inevitable."
HALF_CONTAINER_COUNT=$(printf "%.0f\n" $(($CONTAINER_COUNT/2)))

while [ $CONTAINER_COUNT -gt  $HALF_CONTAINER_COUNT ]
do
    LOCATION=$((1 + $RANDOM % $CONTAINER_COUNT))
    HASH=$(docker ps -aq --filter "status=running" | sed "$LOCATION!d")
    docker kill $HASH
    CONTAINER_COUNT=$(($CONTAINER_COUNT-1))
done
