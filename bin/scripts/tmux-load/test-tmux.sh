#!/usr/bin/env bash

tmux new -s test-session -d
tmux neww -d -n test1 "echo test1; bash"
tmux neww -d -c $PATH/.config -n test2 "echo test2; bash"
tmux neww -d -n test3 "echo test3; bash"
tmux a -t test-session
