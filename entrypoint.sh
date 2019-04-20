#! /bin/sh

# The emulator's entrypoint script
set -e

# 1: Specify a default command, in case it wasn't issued:
if [ -z "$1" ]; then set -- start; fi

# 2: Complete the command in case it's a pubsub emulator command
if [ "$1" == "start" ] || [ "$1" == "env-init" ]
then
  set -- gcloud beta emulators pubsub "$@"
fi

# 3: Add default flags for "gcloud beta emulators pubsub start":
if [ "$5" == "start" ]
then
  mkdir -p /data

  set -- "$@" --data-dir=/data
  set -- "$@" --host-port=0.0.0.0:8085
  set -- "$@" --log-http
  set -- "$@" --verbosity=debug
  set -- "$@" --user-output-enabled
fi

# 4: Execute the given or default command:
exec "$@"
