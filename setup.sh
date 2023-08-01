#!/bin/bash
#
set -eo pipefail

# based on https://github.com/rhasspy/piper#installation
supportedArchs="amd64|arm64|armv7"

function usage() {
	echo "setup mintPiper, usage:"
	echo "$0 foldername arch"
	echo "supported archs: $supportedArchs"
	echo -e "example:\n$0 $HOME/someFolder-$RANDOM amd64"
}

if [ $# -ne 2 ]; then
	echo "Invalid usage"
	usage
	exit 1
fi

weneed="wget aplay tar xclip date xterm base64"
for i in $weneed; do
	command -v $i 1>/dev/null 2>/dev/null || {
		echo "Failed. We need $i"
		exit 2
	}
done

egrep -q $2 <<<$supportedArchs || {
	echo "Unsupported architecture $2"
	echo "We expect one of these: $supportedArchs"
	exit 1
}

runFolder=$(pwd)
mkdir $1
cd $1

echo "🙂 Downloading piper"
# based on https://github.com/rhasspy/piper#installation
wget https://github.com/rhasspy/piper/releases/download/v1.1.0/piper_${2}.tar.gz
tar -xvzf piper_${2}.tar.gz
rm -v piper_${2}.tar.gz

cd piper

# some pulseaudio may need to wake up from idle.
# play a silence wav
# generated thusly:
# sox -n -r 44100 -c 2 silence.wav trim 0.0 5.0
echo "UklGRlixAgBXQVZFZm10ICgAAAD+/wIARKwAACBiBQAIACAAFgAgAAMAAAABAAAAAAAQAIAAAKoAOJtxZmFjdAQAAAAiVgAAZGF0YRCxAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" | base64 -d >silence.wav

echo "🙂 Downloading piper voices"
wget https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/amy/low/en_US-amy-low.onnx https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/amy/low/en_US-amy-low.onnx.json

echo "🙂 Copying mintTTS items"
cp $runFolder/scripts/playSelectedTTS.sh $runFolder/scripts/mintPiper.py $runFolder/images/orange_piper.png . -v
chmod -v +x playSelectedTTS.sh mintPiper.py
echo "✅ ... Complete"
echo "🟢 For keyboard shortcut: xterm -e \"$(pwd)/playSelectedTTS.sh\""
echo "🟢 For panel startup application: $(pwd)/mintPiper.py"
