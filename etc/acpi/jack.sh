#!/bin/sh
#
# /etc/acpi/jack.sh
#

event="$*"

headphones_in() {
  #pacmd set-sink-port "alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5650__sink" "[Out] Headphones"
  /usr/bin/amixer -c 0 cset name='Speaker Channel Switch' off
  /usr/bin/amixer -c 0 cset name='Headphone Channel Switch' on
}

headphones_out() {
  #pacmd set-sink-port "alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5650__sink" "[Out] Speaker"
  /usr/bin/amixer -c 0 cset name='Headphone Channel Switch' off
  /usr/bin/amixer -c 0 cset name='Speaker Channel Switch' on
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

