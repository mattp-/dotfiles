#!/bin/bash
OUTPUT=""
WLANDEV='wlan0'
ESSID=`/sbin/iwconfig $WLANDEV | grep ESSID | sed -e 's/.*ESSID:\"//; s/\".*$//'`
SIGQUAL=`cat /proc/net/wireless | perl -ne 'next unless /^\s*wlan.*?\s+\d+\s+(\d+)/; print $1'`
OUTPUT="$TEST [$OUTPUT $ESSID:$SIGQUAL% ]  ["
PWRDIR=/sys/class/power_supply
for i in `ls --indicator-style=none -1 $PWRDIR \
          | grep BAT \
          | sed -e 's/BAT//'`;
do
  if [ "$i" != 0 ]; then
    OUTPUT="$OUTPUT |"
  fi
  THISBATT="$PWRDIR/BAT$i"
  CAP=`cat $THISBATT/energy_full`
  CUR=`cat $THISBATT/energy_now`
  DRN=`cat $THISBATT/power_now`
  STS=`cat $THISBATT/status`
  PRC=`echo $CUR 100 \* $CAP / p | dc`
  if [ "$STS" = "Discharging" ]; then
    HRS=`echo $CUR $DRN / p | dc`
    MIN=`echo 2 k $CUR $DRN / p | dc`
      MIN=`echo 2 k $MIN $HRS - 60 \* p | dc`
      MIN=`echo $MIN 1 / p | dc`
      MIN=`printf %02d $MIN`
    TIME=$HRS:$MIN
    OUTPUT="$OUTPUT -$TIME"
  elif [ "$STS" = "Charging" ]; then
    OUTPUT="$OUTPUT +$PRC%"
  elif [ "$STS" = "Full" ]; then
    OUTPUT="$OUTPUT [+]"
  elif [ "$STS" = "Unknown" ]; then
    OUTPUT="$OUTPUT $PRC%"
  fi
done
OUTPUT="$OUTPUT ]"
CLOCK=`date +"%a %d %b %l:%M:%S %P"`
echo $OUTPUT $CLOCK
