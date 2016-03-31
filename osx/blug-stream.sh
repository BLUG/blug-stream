#!/bin/bash
set -v
FFMPEG="./ffmpeg"
$FFMPEG -f avfoundation -list_devices true -i ""
read -p "source video device index > " SCREEN
read -p "source audio device index > " AUDIO
read -p "target host:port > " HOSTPORT

echo $FFMPEG -f avfoundation -i "${SCREEN}:${AUDIO}" -an -vcodec mpeg2video -b:v 5000k -f mpegts "udp://${HOSTPORT}"
