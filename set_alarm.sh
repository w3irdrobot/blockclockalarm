#!/bin/bash

set -Eeo pipefail

[[ -f ./.env ]] && . ./.env

function blockclock_request() {
    url="$1"

    curl -s --digest -u "${BLOCKCLOCK_USER}:${BLOCKCLOCK_PASS}" "http://${BLOCKCLOCK_IP}/api${url}" > /dev/null
}

echo "alarm will sound for ${ALARM_LENGTH}s when block ${ALARM_BLOCK} or later is seen."
echo

# check the block tip
tip_block=$(curl -sL https://mempool.space/api/blocks/tip/height)
while [[ ${tip_block} -lt ${ALARM_BLOCK} ]]
do
    echo "current tip block is ${tip_block}. sleeping while we wait..."
    echo
    # sleep for 5m. we got time.
    sleep 5m
    # get tip block now
    tip_block=$(curl -sL https://mempool.space/api/blocks/tip/height)
done

echo "current tip block is ${tip_block}. it's time to sound the alarm!"
echo

# set off alarm once we see the block tip we are looking for
start=$(date +%s)
now=$(date +%s)

while [[ $((now - start)) -le ${ALARM_LENGTH} ]]
do
    # turn on white light
    blockclock_request /lights/000F
    # tick 10 times
    for _ in {1..10}
    do
        blockclock_request /action/sound?demo
    done
    # turn off light
    blockclock_request /lights/off
    sleep 1
    now=$(date +%s)
done
