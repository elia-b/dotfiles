
#!/usr/bin/env bash

tmux new -s comp-stats -d -c ~/Uni/ss25/computational-statistics/ -n editor "echo editor; bash"
tmux neww -d -c ~/Uni/ss25/computational-statistics/ -n R-interactive "R; bash"
tmux a -t comp-stats
