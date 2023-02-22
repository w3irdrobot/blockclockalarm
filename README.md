# BLOCKCLOCK Alarm

This is a simple bash script that will set off an "alarm" when a specific block is mined and propagated through the network. Right now, it just uses the [mempool.space REST API](https://mempool.space/docs/api/rest#get-block-tip-height) to get the current blockchain tip. The alarm is just turning on the white lights on the back of the BLOCKBLOCK, ticking ten times, and then shutting the lights on. This will continue to happen until the script is stopped or the configured alarm length is hit.

> Note: Because this script uses the tick feature as part of the alarm, this is only fully supported on the BLOCKCLOCK micro. However, the lights should still work.

## Usage

Copy the example environment file, set the information specific for the alarm, and run the script. It handles the rest.

```shell
cp .env.example .env
# change the env file ^^
./set_alarm.sh
```

Now get some sleep knowing you won't miss that important block.
