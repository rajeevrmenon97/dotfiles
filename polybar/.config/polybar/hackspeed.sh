#!/bin/sh

KEYBOARD_ID="18"

METRIC=cpm
FORMAT="# %d $METRIC"

INTERVAL=20

LAYOUT=qwerty

case "$LAYOUT" in
	qwerty) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 24 && $3 <= 33) || ($3 >= 37 && $3 <= 53) || ($3 >= 52 && $3 <= 58)'; ;;
	azerty) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 24 && $3 <= 33) || ($3 >= 37 && $3 <= 54) || ($3 >= 52 && $3 <= 57)'; ;;
	dontcare) CONDITION='1'; ;;
	*) echo "Unsupported layout \"$LAYOUT\""; exit 1; ;;
esac

multiply_by=60
divide_by=$INTERVAL

case "$METRIC" in
	wpm) divide_by=$((divide_by * 5)); ;;
	cpm) ;;
	*) echo "Unsupported metric \"$METRIC\""; exit 1; ;;
esac

hackspeed_cache="$(mktemp -p '' hackspeed_cache.XXXXX)"
trap 'rm "$hackspeed_cache"' EXIT

printf '' > "$hackspeed_cache"
xinput test "$KEYBOARD_ID" | \
	stdbuf -o0 awk '$1 == "key" && $2 == "press" && ('"$CONDITION"') {printf "."}' >> "$hackspeed_cache" &

while true; do

	lines=$(stat --format %s "$hackspeed_cache")

	printf '' > "$hackspeed_cache"

	value=$((lines * multiply_by / divide_by))

	printf "$FORMAT\\n" "$value"

	sleep $INTERVAL
done
