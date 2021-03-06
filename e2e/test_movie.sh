#!/bin/bash

MACOS_LOAD=$(ps -A -o %cpu | awk '{s+=$1} END {print s "%"}')
echo "CPU load: $MACOS_LOAD"
vlc --noaudio --width=300 --no-repeat --quiet --play-and-exit ./e2e/60fps_test.mov &
sleep 0.5s # give time VLC to open, would be better to handle this inside the app
SCORE=$(node cli/videotape.js --target=VLC --autorun=true | node e2e/extractScores.js)
echo "Score tests comparison result: $SCORE"
if [ "true" == "$SCORE" ]; then
    exit 0;
fi
exit 1;
