#!/bin/bash

function gather_dir() {
    mkdir -p $1
    cp -r $1 $2
}

function find_and_copy() {
    src=$1
    dst=$2
    mkdir -p $dst
    shift 2;
    find $src $@ -print0 | 
    while IFS= read -r -d '' file; do
        d=$dst/$(basename $(dirname $file))
        mkdir -p $d
        cp $file $d/
    done
}

rm -rf ./global
mkdir ./global/
cd global
cp $HOME/.tmux/tmux_theme ./ 2>/dev/null
cp $HOME/.tmux.conf ./tmux.conf 2>/dev/null
cp $HOME/.config/nvim/init.vim ./ 2>/dev/null
cp $HOME/.config/nvim/coc-settings.json ./ 2>/dev/null
gather_dir $HOME/.aliases ./aliases 2>/dev/null
cp $HOME/.git-completion ./git-completion 2>/dev/null
cp $HOME/.ssh/config ./ssh_config 2>/dev/null
cp $HOME/.gitconfig ./gitconfig 2>/dev/null
cp $HOME/.backup/Makefile ./memory_backup_makefile 2>/dev/null
cp $HOME/.config/htop/htoprc ./htoprc 2>/dev/null
cp $HOME/.vpn_creds.gpg ./vpn_creds.gpg 2>/dev/null
cp $HOME/.memory_pwd ./memory_pwd 2>/dev/null
gather_dir $HOME/.gnupg/ ./gnupg/ 2>/dev/null
cd ..

## Machine specific files: POSSIBLE SENSIBLE INFORMATIONS
MACHINE=./machines/$HOSTNAME

rm -rf $MACHINE
mkdir $MACHINE
cp $HOME/.backup/locations.mk $MACHINE/memory_backup_locations.mk  2>/dev/null

mkdir -p $MACHINE/ssh
cp $HOME/.bashrc $MACHINE/bashrc 2>/dev/null
cp $HOME/.ssh/id_rsa* $MACHINE/ssh/ 2>/dev/null
cp $HOME/.gogs_token $MACHINE/gogs_token 2>/dev/null
cp $HOME/.ssh/known_hosts $MACHINE/ssh/ 2>/dev/null
cp $HOME/.ssh/authorized_keys $MACHINE/ssh/ 2>/dev/null
find_and_copy $HOME/.nix_shells/ $MACHINE/nix_shells/ -name "flake.*"

mkdir -p $MACHINE/moc/ $MACHINE/moc/themes
cp $HOME/.moc/config $MACHINE/moc/ 2>/dev/null
cp $HOME/.moc/themes/* $MACHINE/moc/themes/ 2>/dev/null

if [ -d $HOME/.config/FreeTube/ ]; then
	mkdir -p $MACHINE/FreeTube/
	cp $HOME/.config/FreeTube/profiles.db $MACHINE/FreeTube/ 2>/dev/null
	cp $HOME/.config/FreeTube/playlists.db $MACHINE/FreeTube/ 2>/dev/null
fi

cp $HOME/.config/jrnl/jrnl.yaml $MACHINE/jrnl.yaml 2>/dev/null
cp $HOME/.config/user-dirs.* $MACHINE/ 2>/dev/null

cp /etc/hosts $MACHINE/ 2>/dev/null     # Gather only, apply manually
echo "Done"
