alias tmpdir='cd $(mktemp -d)'

alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias ....='cd ../../.. && ls'
alias .....='cd ../../../../ && ls'

alias grep='grep --color=auto'

alias pingt='ping -c 1 www.google.fr 1> /dev/null 2> /dev/null && echo -e "'${GREEN_BOLD}'Connected'${RESET}'" || echo -e "'${RED_BOLD}'No connection'${RESET}'"'

function _jrnl_autocomplete {
    COMPREPLY=($(compgen -W "$(jrnl --ls | grep "*" | awk '{print $2}')" -- "${COMP_WORDS[COMP_CWORD]}"))
}

complete -F _jrnl_autocomplete jrnl

alias ls=$(which exa)
alias fnvim='nvim $(fzf)'
alias lh='ls -lh'
alias ll='ls -alF'
alias la='ls -a'
alias l='/bin/ls -CF'

function _djrnl_autocomplete {
    COMPREPLY=($(compgen -W "$(jrnl --ls | grep "*" | awk '{print $2}')" -- "${COMP_WORDS[COMP_CWORD]}"))
}

function __djrnl {
    jrnl "$@" -1500 | less +G -r
}

alias djrnl='__djrnl'
complete -F _djrnl_autocomplete djrnl

alias tomp3='__tomp3'
alias webtopdf="wkhtmltopdf"
alias backup="memory all; cd ~/.backup/; make -j$(nproc); cd -"

# Some git aliases
alias gcm="git commit -s -m"
alias gts="git status"
alias gl="git log --oneline -30"
alias gla="gl --all"
alias gdf="git diff --staged && git diff"
alias gcp="git cherry-pick"
alias gg="git gui &"
alias gitka="gitk --all --max-count=5000"
alias ggk="git gui & gitk &"
alias ggka="git gui & gitka &"
alias ga="git add ."
alias grs="git restore --staged"
alias grh="git reset --hard"
alias gpsh="git push"

YTDL_ARGS='-x --add-metadata -o "~/Music/%(title)s.%(ext)s"'
alias dl_mp3="youtube-dl $YTDL_ARGS --audio-format mp3"
alias dl_mp3_hq="dl_mp3 --audio-quality 0"
alias dl_search_mp3="dl_mp3 --default-search \"ytsearch\""
alias dl_search_mp3_hq="dl_mp3_hq --default-search \"ytsearch\""

alias dl_flac="youtube-dl $YTDL_ARGS --audio-format flac"
alias dl_flac_hq="dl_flac --audio-quality 0"
alias dl_search_mp3="dl_flac --default-search \"ytsearch\""
alias dl_search_flac_hq="dl_flac_hq --default-search \"ytsearch\""

# defaults
alias zik="dl_mp3_hq"
alias ziksearch="dl_search_mp3_hq"
