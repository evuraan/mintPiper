#!/bin/bash 

set -eo pipefail

dir="$(dirname $0)"
input="/tmp/toplay.$RANDOM-$RANDOM"
wav="/tmp/toplay.$RANDOM-$RANDOM.wav"

data=$(xclip -out selection)
if [ ${#data} -gt 2 ]; then
    echo $data > $input
    echo "$(date) data: $input" >> /tmp/piper.log &
    "$dir"/piper --model "$dir"/en_US-amy-low.onnx --output_file $wav < $input &
    wait
    aplay $dir/silence.wav $wav
    rm $input $wav || : 
fi
