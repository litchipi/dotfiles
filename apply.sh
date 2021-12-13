#!/bin/bash

set -e

BACKUP_DIR=$HOME/.dotfiles_bck/
mkdir -p $BACKUP_DIR

if [ ! -d $BACKUP_DIR/.git ]; then
	git init $BACKUP_DIR 1>/dev/null
fi

function bcpr() {
    for f in $(ls $1); do
        srcfile=$1/$f
        mkdir -p $2
        if [ -f $srcfile ]; then
                bcp $srcfile $2/$f
        fi
        if [ -d $srcfile ]; then
                bcpr $srcfile $2/$(basename $f)/
        fi
    done
}

function bcp() {
    sfile=$(realpath $1)
    dfile=$(realpath $2)
    if [ -f $2 ] ; then
            backup_version $2
    fi
    if [ -f $1 ] ; then
            cp $1 $2 2>/dev/null
            backup_version $2
    fi
}

function backup_version() {
	dfile=$(realpath $1)
	cd $BACKUP_DIR
	mkdir -p $BACKUP_DIR/$(dirname $dfile)
	cp $dfile $BACKUP_DIR/$dfile
	git add $BACKUP_DIR/$dfile
	if git status --porcelain | grep $(basename $dfile) 1>/dev/null ; then
		echo "Backup file $dfile"
		git commit -m "Backup file '$dfile'" 1>/dev/null
		git gc --aggressive --prune --quiet
	fi
	cd - 1>/dev/null
}

cd global
bcp ./tmux_theme $HOME/.tmux/tmux_theme
bcp ./tmux.conf $HOME/.tmux.conf
bcp ./init.vim $HOME/.config/nvim/init.vim
bcp ./coc-settings.json $HOME/.config/nvim/coc-settings.json
bcpr ./aliases $HOME/.aliases/
bcp ./git-completion $HOME/.git-completion
bcp ./ssh_config $HOME/.ssh/config
bcp ./gitconfig $HOME/.gitconfig
bcp ./memory_backup_makefile $HOME/.backup/Makefile
bcp ./gitk $HOME/.config/git/gitk
bcp ./htoprc $HOME/.config/htop/htoprc
bcp ./vpn_creds.gpg $HOME/.vpn_creds.gpg
cd ..

## Machine specific files: POSSIBLE SENSIBLE INFORMATIONS
MACHINE=./machines/$HOSTNAME
if [ ! -d $MACHINE ] ; then
	echo "No configuration saved for machine $HOSTNAME"
	exit 0;
fi

bcp $MACHINE/bashrc $HOME/.bashrc
bcp $MACHINE/memory_backup_locations.mk $HOME/.backup/locations.mk
bcp $MACHINE/gogs_token $HOME/.gogs_token

bcpr $MACHINE/ssh/ $HOME/.ssh/
bcp $MACHINE/moc/config $HOME/.moc/config
bcpr $MACHINE/moc/themes/ $HOME/.moc/themes/

if [ -d $MACHINE/FreeTube/ ]; then
	bcpr $MACHINE/FreeTube/ $HOME/.config/FreeTube/
fi

bcp $MACHINE/jrnl.yaml $HOME/.config/jrnl/jrnl.yaml
bcp $MACHINE/user-dirs.dirs $HOME/.config/user-dirs.dirs
bcp $MACHINE/user-dirs.locale $HOME/.config/user-dirs.locale
echo "Done"
