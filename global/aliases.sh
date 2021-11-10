# Directory navigation
alias tmpdir='cd $(mktemp -d)'

alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias ....='cd ../../.. && ls'
alias .....='cd ../../../../ && ls'

alias ls=$(which exa)
alias lh='ls -lh'
alias ll='ls -alF'
alias la='ls -a'
alias l='/bin/ls -CF'

# FZF
alias fnvim='nvim $(fzf)'

alias grep='grep --color=auto'

# Network-related
alias pingt='ping -c 1 www.google.fr 1> /dev/null 2> /dev/null && echo -e "'${GREEN_BOLD}'Connected'${RESET}'" || echo -e "'${RED_BOLD}'No connection'${RESET}'"'


# Jrnl
alias djrnl='__djrnl'
function __djrnl {
    jrnl "$@" -1500 | less +G -r
}

complete -F _jrnl_autocomplete jrnl
function _jrnl_autocomplete {
    COMPREPLY=($(compgen -W "$(jrnl --ls | grep "*" | awk '{print $2}')" -- "${COMP_WORDS[COMP_CWORD]}"))
}

complete -F _djrnl_autocomplete djrnl
function _djrnl_autocomplete {
    COMPREPLY=($(compgen -W "$(jrnl --ls | grep "*" | awk '{print $2}')" -- "${COMP_WORDS[COMP_CWORD]}"))
}


# Some git aliases
source $HOME/.git-completion
alias ga="git add ."
alias gcm="git commit -s -m"
alias gts="git status"
alias gitclean="git fetch -p && git gc --prune=now"

alias gb="git branch --list"
alias gba="git branch --list --all"
alias gbc="git checkout -B "
alias gbd="git branch -D"
__git_complete gbd _git_branch

alias gck="git checkout"
__git_complete gck _git_checkout

alias gl="git log --oneline -30"
__git_complete gl git_log
alias gla="gl --all"
__git_complete gla git_log

alias gdf="git diff --staged && echo -e '\n\n\n\n' && git diff"
alias grs="git restore --staged"

alias grh="git reset --hard"
__git_complete grh  _git_reset
alias grm="git reset --mixed"
__git_complete grm  _git_reset
alias gcp="git cherry-pick"
__git_complete gcp  _git_cherry_pick

alias gpsh="git push"
__git_complete gpsh _git_push

function __get_current_branch() {
	git branch |grep "*"| cut -d " " -f 2
}
alias gkeep='git branch $(__get_current_branch).$(git rev-parse --short HEAD)'

alias gg="git gui &"
alias gitka="gitk --all --max-count=5000"
alias ggk="git gui & gitk &"
alias ggka="git gui & gitka &"


alias gsave="__gsave"
function __gsave() {
	if [ $# -ne 1 ] ; then
		echo "Usage: $0 <branch name>. Will create a temporary commit and checkout to the given branch"
		exit 1;
	fi
	set -e
	git add .
	git commit -m "TMP COMMIT"
	git checkout $1
}
__git_complete gsave _git_checkout

alias gload="__gload"
function __gload() {
	if [ $# -ne 1 ] ; then
		echo "Usage: $0 <branch name>. Will create a temporary commit and checkout to the given branch"
		exit 1;
	fi
	set -e
	git checkout $1
	git reset --mixed HEAD~1
}
__git_complete gload _git_checkout

ALIAS_COLOR="\033[1;96m"
RESET="\033[0m"
function __gh() {
	echo -e "$ALIAS_COLOR $1:   $RESET $2"
}

function __ghelp() {
	echo "Aliases defined for git:"
	echo ""
	__gh "ga" "Add everything to repo"
	__gh "gcm" "Commit signed with a message (arg: message)"
	__gh "gts" "Get status of repository"
	__gh "gpsh" "Push the repository to remote"
	__gh "gitclean" "Clean the repository, garbage collect, prune"
	echo ""
	__gh "gb" "List the local branches"
	__gh "gba" "List all the branches"
	__gh "gbc" "Create a new branch if doesn't exist, checkout on it"
	__gh "gbd" "Delete a branch"
	__gh "gck" "Checkout to a branch"
	echo ""
	__gh "gl" "Commit log of current branch"
	__gh "gla" "Commit log of every branches"
	__gh "gdf" "Print the diff since last commit"
	__gh "grs" "Remove file from staged state"
	echo ""
	__gh "grh" "Reset HARD the branch to a given ref (default: HEAD)"
	__gh "grm" "Reset MIXED the branch to a given ref (default: HEAD)"
	__gh "gcp" "Cherry pick a commit from the given ref"
	echo ""
	__gh "gg" "Starts git gui in the background"
	__gh "ggk" "Starts git gui with gitk, both in background"
	__gh "gitka" "Starts gitk for with all branches displayed"
	__gh "ggka" "Starts git gui with gitka, both in background"
	echo ""
	__gh "gkeep" " Create a temporary branch on the given commit to keep the ref"
	__gh "gsave" "Create a temporary commit with the ongoing changes, and checkout the given branch"
	__gh "gload" "Checkout the given branch, and restore the last commit made into ongoing changes"
	echo ""
}

alias ghelp="__ghelp"

# Youtube-dl
if [ -d $HOME/Musique ]; then
	MUSIC_DIR=$HOME/Musique
elif [ -d $HOME/Music ]; then
	MUSIC_DIR=$HOME/Music
else
	echo "Music dir not found, downloading music to $HOME/"
	MUSIC_DIR=$HOME
fi

YTDL_ARGS='-x --add-metadata -o "'$MUSIC_DIR'/%(title)s.%(ext)s"'
alias dl_mp3="youtube-dl $YTDL_ARGS --audio-format mp3"
alias dl_mp3_hq="dl_mp3 --audio-quality 0"
alias dl_search_mp3="dl_mp3 --default-search \"ytsearch\""
alias dl_search_mp3_hq="dl_mp3_hq --default-search \"ytsearch\""

alias dl_flac="youtube-dl $YTDL_ARGS --audio-format flac"
alias dl_flac_hq="dl_flac --audio-quality 0"
alias dl_search_flac="dl_flac --default-search \"ytsearch\""
alias dl_search_flac_hq="dl_flac_hq --default-search \"ytsearch\""

# defaults
alias zik="dl_mp3_hq"
alias ziksearch="dl_search_mp3_hq"


# Converting
alias webtopdf="wkhtmltopdf"


# Backup
alias backup="memory all && cd ~/.backup/ && make -j$(nproc) && cd -"


# Nix aliases
function _nixfiles() {
    COMPREPLY=($(compgen -W "$(ls *.nix)" -- "${COMP_WORDS[COMP_CWORD]}"))
}

alias nix_refbuild='__nixbuilddeps $@'
complete -F _nixfiles nix_refbuild
function __nixbuilddeps() {
	nix-store -q --references $(nix-instantiate $1)
}

alias nix_refrun='__nixrundeps $@'
complete -F _nixfiles nix_refrun
function __nixrundeps() {
	drvfile=$(nix-instantiate $1)
	nix-store -q --references $(nix-store -r $drvfile)
}

