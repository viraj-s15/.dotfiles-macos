#!/bin/bash

next ()
{
  osascript -e 'tell application "Spotify" to play next track'
}

back () 
{
  osascript -e 'tell application "Spotify" to play previous track'
}

play () 
{
  osascript -e 'tell application "Spotify" to playpause'
}

repeat () 
{
  REPEAT=$(osascript -e 'tell application "Spotify" to get repeating')
  if [ "$REPEAT" = "false" ]; then
    sketchybar -m --set spotify.repeat icon.highlight=on
    osascript -e 'tell application "Spotify" to set repeating to true'
  else 
    sketchybar -m --set spotify.repeat icon.highlight=off
    osascript -e 'tell application "Spotify" to set repeating to false'
  fi
}

shuffle () 
{
  SHUFFLE=$(osascript -e 'tell application "Spotify" to get shuffling')
  if [ "$SHUFFLE" = "false" ]; then
    sketchybar -m --set spotify.shuffle icon.highlight=on
    osascript -e 'tell application "Spotify" to set shuffling to true'
  else 
    sketchybar -m --set spotify.shuffle icon.highlight=off
    osascript -e 'tell application "Spotify" to set shuffling to false'
  fi
}

update ()
{
  PLAYER_STATE="$(osascript -e 'tell application "Spotify" to get player state as string' 2>/dev/null)"
  if [ "$PLAYER_STATE" = "playing" ] || [ "$PLAYER_STATE" = "paused" ]; then
    TRACK="$(osascript -e 'tell application "Spotify" to get name of current track' 2>/dev/null | sed 's/\(.\{24\}\).*/\1.../')"
    ARTIST="$(osascript -e 'tell application "Spotify" to get artist of current track' 2>/dev/null | sed 's/\(.\{24\}\).*/\1.../')"
    ALBUM="$(osascript -e 'tell application "Spotify" to get album of current track' 2>/dev/null | sed 's/\(.\{28\}\).*/\1.../')"
    SHUFFLE=$(osascript -e 'tell application "Spotify" to get shuffling')
    REPEAT=$(osascript -e 'tell application "Spotify" to get repeating')
    COVER=$(osascript -e 'tell application "Spotify" to get artwork url of current track')
    curl -s --max-time 20 "$COVER" -o /tmp/cover.jpg
    args=()
    if [ "$ARTIST" == "" ]; then
      args+=(--set spotify.title label="$TRACK"
             --set spotify.album label="Podcast"
             --set spotify.artist label="$ALBUM"  )
    else
      args+=(--set spotify.title label="$TRACK"
             --set spotify.album label="$ALBUM"
             --set spotify.artist label="$ARTIST")
    fi
    play_icon=􀊄
    [ "$PLAYER_STATE" = "playing" ] && play_icon=􀊆
    args+=(--set spotify.play icon=$play_icon
           --set spotify.shuffle icon.highlight=$SHUFFLE
           --set spotify.repeat icon.highlight=$REPEAT
           --set spotify.cover background.image="/tmp/cover.jpg"
                               background.color=0x00000000 )
  else
    args=()
    args+=(--set spotify_anchor popup.drawing=off
           --set spotify.play icon=􀊄                         )
  fi
  sketchybar -m "${args[@]}"
}

scrubbing() {
  DURATION_MS=$(osascript -e 'tell application "Spotify" to get duration of current track')
  DURATION=$((DURATION_MS/1000))

  TARGET=$((DURATION*PERCENTAGE/100))
  osascript -e "tell application \"Spotify\" to set player position to $TARGET"
  sketchybar --set spotify.state slider.percentage=$PERCENTAGE
}

scroll() {
  DURATION_MS=$(osascript -e 'tell application "Spotify" to get duration of current track')
  DURATION=$((DURATION_MS/1000))

  FLOAT="$(osascript -e 'tell application "Spotify" to get player position')"
  TIME=${FLOAT%.*}
  
  sketchybar --animate linear 10 \
             --set spotify.state slider.percentage="$((TIME*100/DURATION))" \
                                 icon="$(date -r $TIME +'%M:%S')" \
                                 label="$(date -r $DURATION +'%M:%S')"
}

mouse_clicked () {
  case "$NAME" in
    "spotify.next") next
    ;;
    "spotify.back") back
    ;;
    "spotify.play") play
    ;;
    "spotify.shuffle") shuffle
    ;;
    "spotify.repeat") repeat
    ;;
    "spotify.state") scrubbing
    ;;
    *) exit
    ;;
  esac
}

routine() {
  case "$NAME" in
    "spotify.state") scroll
    ;;
    *) update
    ;;
  esac
}

if [ "$1" = "anchor" ]; then
  update
  sketchybar --set spotify_anchor popup.drawing=toggle
  exit 0
fi

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "routine") routine
  ;;
  "forced") exit 0
  ;;
  *) update
  ;;
esac
