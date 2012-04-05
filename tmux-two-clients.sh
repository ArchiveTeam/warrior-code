#!/bin/bash

project=$1
stopfile=$2
client=$3

if builtin type -p nload &> /dev/null
then

  tmux new true \; \
       set status off \; \
       set set-remain-on-exit on \; \
       new-window "/home/warrior/warrior-code/touch-stop-dialog.sh '$project' '$stopfile'" \; \
       split-window -h "$client" \; \
       split-window "$client" \; \
       split-window -t 0 -l 9 "nload -m -u H -U H eth0" \; \
       select-pane -t 0 \; \
       attach

else

  tmux new true \; \
       set status off \; \
       set set-remain-on-exit on \; \
       new-window "/home/warrior/warrior-code/touch-stop-dialog.sh '$project' '$stopfile'" \; \
       split-window -h "$client" \; \
       split-window "$client" \; \
       select-pane -t 0 \; \
       attach

fi

