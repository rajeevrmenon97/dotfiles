#!/bin/bash
wallpaper=$(ls ~/Pictures/DailyPic | shuf -n 1)
image_path=$(echo "/home/r2m/Pictures/DailyPic/$wallpaper")
echo $image_path
wal -i "$image_path" -g
