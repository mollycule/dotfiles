#!/bin/bash

usage() {
  echo -e "Usage: $0 [-e|--ear|-h|--help|-s|--speaker]"
  exit 2
}


case "$1" in
  -e | --ear)
    BLUETOOTH_DEVICE="${BLUETOOTH_EARPHONES}"
    ;;
  -h | --help)
    usage
    ;;
  -s | --speaker)
    BLUETOOTH_DEVICE="${BLUETOOTH_SPEAKER}"
    ;;
esac

if [ "$#" -ne 1 ]; then
  usage
fi

if ! sudo systemctl start bluetooth; then
  if ! sudo systemctl restart bluetooth; then
    notify-send -u normal "BLU" "Restarting bluetooth service." &
  fi
else
  notify-send -u normal "BLU" "Starting bluetooth service." &
fi
  
sudo bluetoothctl power on
sudo bluetoothctl agent on

passed=false
for n in {1..5}; do
  if sudo bluetoothctl connect ${BLUETOOTH_DEVICE}; then
    if sudo bluetoothctl info ${BLUETOOTH_DEVICE} | grep -q 'Connected: yes'; then
      notify-send -u normal "BLU" "Successfully started bluetooth profile." &
      passed=true
      break
    fi
  fi
  sleep 1s
done

if [ "$passed" = false ]; then
  notify-send -u normal "BLU" "Unable to start bluetooth profile." &
  exit 1
fi
