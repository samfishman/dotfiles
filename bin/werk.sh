#!/bin/bash

id=$1
if [ "$id" = "" ]; then
    id="werk"
fi

if ! tmux has-session -t "$id" 2> /dev/null; then
    tmux new-session -s "$id" -d
    tmux send-keys "vim ." C-m
    tmux split-window -v
    tmux resize-pane -y 15
    tmux split-window -h
    tmux new-window
    tmux split-window -h
    tmux split-window -v
    tmux resize-pane -y 15
    tmux select-pane -t 0
    tmux select-window -t 0
    tmux select-pane -t 0
fi

tmux attach-session -t "$id"

