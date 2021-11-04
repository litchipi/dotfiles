#!/bin/bash

rm -rf ./global
mkdir ./global/
cd global
cp $HOME/.tmux/tmux_theme ./
cp $HOME/.tmux.conf ./tmux.conf
cp $HOME/.config/nvim/init.vim ./
cp $HOME/.config/nvim/coc-settings.json ./
cp $HOME/.bashrc ./bashrc
cp $HOME/.aliases.sh ./aliases.sh
cp $HOME/.git-completion ./git-completion
cp $HOME/.ssh/config ./ssh_config
cp $HOME/.gitconfig ./gitconfig
cp $HOME/.backup/Makefile ./memory_backup_makefile
cp $HOME/.config/git/gitk ./gitk
cp $HOME/.config/htop/htoprc ./htoprc
cd ..

## Machine specific files: POSSIBLE SENSIBLE INFORMATIONS
MACHINE=./machines/$HOSTNAME

rm -rf $MACHINE
mkdir $MACHINE
cp $HOME/.backup/locations.mk $MACHINE/memory_backup_locations.mk

mkdir -p $MACHINE/ssh
cp $HOME/.ssh/id_rsa* $MACHINE/ssh/
cp $HOME/.ssh/known_hosts $MACHINE/ssh/
cp $HOME/.ssh/authorized_keys $MACHINE/ssh/

mkdir -p $MACHINE/moc/ $MACHINE/moc/themes
cp $HOME/.moc/config $MACHINE/moc/
cp $HOME/.moc/themes/* $MACHINE/moc/themes/

if [ -d $HOME/.config/FreeTube/ ]; then
	mkdir -p $MACHINE/FreeTube/
	cp $HOME/.config/FreeTube/profiles.db $MACHINE/FreeTube/
	cp $HOME/.config/FreeTube/playlists.db $MACHINE/FreeTube/
	cp $HOME/.config/FreeTube/settings.db $MACHINE/FreeTube/
fi

cp $HOME/.config/jrnl/jrnl.yaml $MACHINE/jrnl.yaml
cp $HOME/.config/monitors.xml $MACHINE/
cp $HOME/.config/user-dirs.* $MACHINE/
