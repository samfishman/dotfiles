#!/bin/bash

if ! tmux has-session -t werk; then
    echo hi
    tmux new-session -s werk -d 'vim .'
    tmux split-window -v
    tmux resize-pane -y 15
    tmux new-window
    tmux split-window -h
    tmux select-pane -t 0
    tmux select-window -t 0
    tmux select-pane -t 0
fi

tmux attach-session -t werk

