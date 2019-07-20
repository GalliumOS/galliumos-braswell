#!/bin/sh
#
# /etc/acpi/jack.sh
#

event="$*"
export PULSE_SERVER="tcp:localhost"

headphones_in() {
  pactl set-sink-port @DEFAULT_SINK@ "[Out] Headphones"
}

headphones_out() {
  pactl set-sink-port @DEFAULT_SINK@ "[Out] Speaker"
}

case "$event" in
  '') ;;
  'jack/headphone HEADPHONE plug')
    logger "jackdetect: handling $event"
    headphones_in
    ;;
  'jack/headphone HEADPHONE unplug')
    logger "jackdetect: handling $event"
    headphones_out
    ;;
  *) logger "jackdetect: ignoring $event" ;;
esac

