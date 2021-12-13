#!/bin/bash

git add global/ machines/ 1>/dev/null 2>/dev/null
git commit --signoff -m "$(date "+%d/%m/%y %H:%M:%S") | Backing up dotfiles of machine '$HOSTNAME'" 1>/dev/null 2>/dev/null
for remote in $(git remote); do
    git push $remote 1>/dev/null 2>/dev/null
done
git gc --prune=now 1>/dev/null 2>/dev/null
