#!/usr/bin/env bash

tmux new -s openBPT -d -c ~/Projects/OpenBPT/lola-service/ -n editor "nvim README.md; bash"
tmux neww -d -c ~/Projects/OpenBPT/openbpt/backend -n backend "npm run dev; bash"
tmux neww -d -c ~/Projects/OpenBPT/openbpt/backend -n database "docker rm openbpt_postgresql; docker run --name openbpt_postgresql -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -e POSTGRES_DB=openbpt -p 5432:5432 -d postgres"
tmux neww -d -c ~/Projects/OpenBPT/openbpt/frontend -n frontend "npm run dev; bash"
tmux neww -d -c ~/Projects/OpenBPT/lola-api -n lola-API "make renew; bash"
tmux neww -d -c ~/Projects/OpenBPT/lola-service -n lola-service "npm run dev; bash"
tmux a -t openBPT
