#!/bin/bash 

set -eo pipefail

dir="$(dirname $0)"
input="/tmp/toplay.$RANDOM-$RANDOM"

data=$(xclip -out selection)
if [ ${#data} -gt 2 ]; then
    echo $data > $input
    echo "$(date) data: $input" >> /tmp/piper.log &
    cat $input | "$dir"/piper --model "$dir"/en_US-amy-low.onnx --output_file -  | aplay -
    rm $input || : 
fi

