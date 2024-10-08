#!/bin/bash

pgrep -x simple-bar-server > /dev/null

if [ $? -eq 1 ]; then
  cd ~/.config/uebersicht/simple-bar-server-go || exit
  nohup ./bin/simple-bar-server . 1>/dev/null 2>&1 &
  exit 1
fi

port=7776
kind=$1

if [[ -z $kind ]]; then
  echo "Usage: ./uebersicht.sh <kind>"
  exit 0
elif [[ $kind == "spaces" ]]; then
  payload="{\"focusedSpace\": $AEROSPACE_FOCUSED_WORKSPACE, \"prevSpace\": $AEROSPACE_PREV_WORKSPACE}"
else
  payload=$(aerospace list-windows --focused \
    --format '{"windowId": "%{window-id}", "appName": "%{app-name}", "workspace": %{workspace} }'
  )
fi


url="http://localhost:$port/aerospace/$kind/refresh"
curl -X POST "$url" -H "Content-Type: application/json" -d "$payload"
