#!/bin/bash

set -e

mkdir -p ~/.dotfiles_bck/
touch ~/.dotfiles_bck/filenames_sum_list

function bcpr() {
	for f in $(ls $1); do
		mkdir -p $2
		if [ -f $f ]; then
			bcp $f $2/$f
		fi
		if [ -d $f ]; then
			bcpr $f $2/$(basename $f)/
		fi
	done
}

function bcp() {
	sfile=$(realpath $1)
	dfile=$(realpath $2)

	filesum=$(shasum $dfile | cut -d " " -f 1)
	new_version_sum=$(shasum $sfile | cut -d " " -f 1)

	if [ "$filesum" != "$new_version_sum" ]; then #"$new_version_sum" ]; then
		fnamesum=$(echo $dfile | shasum | cut -d " " -f 1)
		mkdir -p ~/.dotfiles_bck/$fnamesum/$filesum/
		echo "Backing up file $dfile in $HOME/.dotfiles_bck/$fnamesum/$filesum/$(basename $dfile)"

		if ! no_output grep $fnamesum ~/.dotfiles_bck/filenames_sum_list; then
			echo "$dfile: $fnamesum" >> ~/.dotfiles_bck/filenames_sum_list
		fi

		echo -e "$(date "+%d/%m/%y %H:%M:%S") |\t$filesum" >> ~/.dotfiles_bck/$fnamesum/versions
		cp $dfile ~/.dotfiles_bck/$fnamesum/$filesum/$(basename $dfile)
	fi

	mkdir -p $(dirname $sfile)
	cp $sfile $dfile
}

bcp ./tmux_theme $HOME/.tmux/tmux_theme
bcp ./tmux.conf $HOME/.tmux.conf
bcp ./init.vim $HOME/.config/nvim/init.vim
bcp ./coc-settings.json $HOME/.config/nvim/coc-settings.json
bcp ./bashrc $HOME/.bashrc
bcp ./aliases.sh $HOME/.aliases.sh
bcp ./ssh_config $HOME/.ssh/config
bcp ./gitconfig $HOME/.gitconfig
bcp ./memory_backup_makefile $HOME/.backup/Makefile
bcp ./gitk $HOME/.config/git/gitk
bcp ./htoprc $HOME/.config/htop/htoprc

## Machine specific files: POSSIBLE SENSIBLE INFORMATIONS
MACHINE=./machines/$HOSTNAME
if [ ! -d $MACHINE ] ; then
	echo "No configuration saved for machine $HOSTNAME"
	exit 0;
fi

bcp $MACHINE/memory_backup_locations.mk $HOME/.backup/locations.mk

bcp $MACHINE/dconf_user $HOME/.config/dconf/user

bcpr $MACHINE/ssh/ $HOME/.ssh/
bcp $MACHINE/moc/config $HOME/.moc/
bcpr $MACHINE/moc/themes/ $HOME/.moc/themes/

if [ -d $MACHINE/FreeTube/ ]; then
	bcpr $MACHINE/FreeTube/ $HOME/.config/FreeTube/
fi

bcp $MACHINE/jrnl.yaml $HOME/.config/jrnl/jrnl.yaml
bcp $MACHINE/monitors.xml $HOME/.config/monitors.xml
bcp $MACHINE/user-dirs.dirs $HOME/.config/user-dirs.dirs
bcp $MACHINE/user-dirs.locale $HOME/.config/user-dirs.locale
