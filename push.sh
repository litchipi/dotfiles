#!/bin/bash

git add global/ machines/ 1>/dev/null 2>/dev/null
git commit --signoff -m "$(date "+%d/%m/%y %H:%M:%S") | Backing up dotfiles of machine '$HOSTNAME'" 1>/dev/null 2>/dev/null
git push 1>/dev/null 2>/dev/null
git gc --prune=now 1>/dev/null 2>/dev/null
