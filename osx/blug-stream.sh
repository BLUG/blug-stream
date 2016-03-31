#!/bin/bash
set -v
FFMPEG="$(dirname $0)/ffmpeg"
BITRATE="8000k"
$FFMPEG -f avfoundation -list_devices true -i ""
read -p "source video device index > " SCREEN
read -p "source audio device index > " AUDIO
read -p "target host:port > " HOSTPORT

$FFMPEG -f avfoundation -i "${SCREEN}:${AUDIO}" -an -vcodec mpeg2video -b:v $BITRATE -f mpegts "udp://${HOSTPORT}"
