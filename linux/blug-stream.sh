#!/bin/bash
set -v

if [ ! -f "ffmpeg" ]
then
  wget https://github.com/BLUG/blug-stream/raw/ddd65038c6828d86f87177225db9d04eb15f3e68/linux/ffmpeg
fi

BITRATE="8000k"
read -p "target host:port > " HOSTPORT
getResolution(){
  xrandr|sed -n 's/\(.*\) connected primary \([0-9]*\)x\([0-9]*\)+.*/\2x\3/p'|head -n 1
}
getResolution
./ffmpeg -video_size $(getResolution) -framerate 25 -f x11grab -i :0.0+0,0 \
  -video_size 1280x720 -an -vcodec mpeg2video -b:v $BITRATE -f mpegts "udp://${HOSTPORT}"
