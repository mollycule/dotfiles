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

PASSWORD_CMD=$(su $USER -c "DISPLAY=:0 pass ${BLUETOOTH_DEVICE} | head -n 1")

if [ "$#" -ne 1 ]; then
  usage
fi

if ! sudo systemctl start bluetoothctl; then
  if ! sudo systemctl restart bluetoothctl; then
    notify-send -u normal "BLU" "Restarting bluetooth service." &
  fi
else
  notify-send -u normal "BLU" "Starting bluetooth service." &
fi
  
sudo bluetoothctl power on
sudo bluetoothctl agent on

passed=false
for n in {1..5}; do
  if sudo bluetoothctl connect $DEVICE; then
    if sudo bluetoothctl info $DEVICE | grep -q 'Connected: yes'; then
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
