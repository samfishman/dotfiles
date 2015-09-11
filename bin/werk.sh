#!/bin/bash

if ! tmux has-session -t werk 2> /dev/null; then
    tmux new-session -s werk -d "bash -c 'vim .'"
    tmux split-window -v
    tmux resize-pane -y 15
    tmux new-window
    tmux split-window -h
    tmux split-window -v
    tmux resize-pane -y 15
    tmux select-pane -t 0
    tmux select-window -t 0
    tmux select-pane -t 0
fi

tmux attach-session -t werk

