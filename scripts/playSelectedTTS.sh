#!/bin/bash

set -eo pipefail

data=$(xclip -out selection)
if [[ ${#data} -gt 2 ]]; then
	dir="$(dirname $0)"
	input="/tmp/toplay.$RANDOM-$RANDOM"
	wav="$input.wav"
	trap 'rm -f "$input" "$wav"' EXIT SIGINT

	echo "$data" >"$input"
	"$dir"/piper --model "$dir"/en_US-amy-low.onnx --output_file "$wav" <"$input" &
	echo "$(date) data: $input" >>/tmp/piper.log &
	wait
	aplay "$dir"/silence.wav "$wav"
fi
