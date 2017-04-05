#!/usr/bin/env zsh
# -----------------------------------------------------------------------------
#          FILE:  .zshrc
#   DESCRIPTION:  ZSH configuration file
#        AUTHOR:  R <rahulthakur.me>
#       VERSION:  1.0.0
# -----------------------------------------------------------------------------


# OH-MY-ZSH -------------------------------------------------------------------
# Path to your oh-my-zsh installation.
export ZSH=/home/r/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="R"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*) Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/ Example format: plugins=(rails git textmate ruby
# lighthouse) Add wisely, as too many plugins slow down shell startup.
plugins=(git redis-cli colored-man-pages command-not-found web-search safe-paste history-substring-search last-working-dir extract dircycle colorize battery compleat zsh-syntax-highlighting zsh-256color zsh-completions zsh-autosuggestions)
# atom brew bundler osx git github git-flow tmux tmuxinator zsh-syntax-highlighting zsh-completions

source $ZSH/oh-my-zsh.sh
# -----------------------------------------------------------------------------


# Config ----------------------------------------------------------------------
# term
export TERM=xterm-256color

# locale
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# editors
export EDITOR="vim"
# export VISUAL="atom"

# timezone
export TZ=Asia/Kolkata

# path
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/local/heroku/bin:$HOME/.composer/vendor/bin:$HOME/.rvm/bin:$(npm bin)"

# ls colours
export LSCOLORS=ExFxcxdxbxexexabagacad
(( $+commands[gdircolors] )) && eval $(gdircolors ~/.dir_colors)

# grep colours
export GREP_COLOR="1;32"

# display usage statistics for commands running > 5 sec.
REPORTTIME=5

# zsh autosuggest
bindkey '^\' autosuggest-execute
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242"
# -----------------------------------------------------------------------------


# Completion ------------------------------------------------------------------
autoload -U compinit &&
{
    # init completion, ignoring security checks
    compinit -C

    # force rehash to have completion picking up new commands in path
    _force_rehash() { (( CURRENT == 1 )) && rehash; return 1 }
    zstyle ':completion:::::' completer _force_rehash \
                                        _complete \
                                        _ignored \
                                        _gnu_generic \
                                        _approximate
    zstyle ':completion:*'    completer _complete \
                                        _ignored \
                                        _gnu_generic \
                                        _approximate

    # speed up completion by avoiding partial globs
    zstyle ':completion:*' accept-exact '*(N)'
    zstyle ':completion:*' accept-exact-dirs true

    # cache setup
    zstyle ':completion:*' use-cache on

    # default colors for listings
    zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==1;30=1;32}:${(s.:.)LS_COLORS}")'

    # separate directories from files
    zstyle ':completion:*' list-dirs-first true

    # turn on menu selection only when selections do not fit on screen
    zstyle ':completion:*' menu true=long select=long

    # separate matches into groups
    zstyle ':completion:*:matches' group yes
    zstyle ':completion:*' group-name ''

    # always use the most verbose completion
    zstyle ':completion:*' verbose true

    # treat sequences of slashes as single slash
    zstyle ':completion:*' squeeze-slashes true

    # describe options
    zstyle ':completion:*:options' description yes

    # completion presentation styles
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*:descriptions' format $'\e[0;37m --- %d ---\e[0;0m'
    zstyle ':completion:*:messages'     format $'\e[0;37m --- %d ---\e[0;0m'
    zstyle ':completion:*:warnings'     format $'\e[0;33m --- no matches ---\e[0;0m'

    # ignore hidden files by default
    zstyle ':completion:*:(all-|other-|)files'  ignored-patterns '*/.*'
    zstyle ':completion:*:(local-|)directories' ignored-patterns '*/.*'
    zstyle ':completion:*:cd:*'                 ignored-patterns '*/.*'

    # don't complete completion functions/widgets
    zstyle ':completion:*:functions' ignored-patterns '_*'

    # don't complete uninteresting users
    zstyle ':completion:*:*:*:users' ignored-patterns adm amanda apache avahi \
      beaglidx bin cacti canna clamav daemon dbus distcache dovecot junkbust  \
      games gdm gkrellmd gopher hacluster haldaemon halt hsqldb ident ftp fax \
      ldap lp mail mailman mailnull mldonkey mysql nagios named netdump news  \
      nfsnobody nobody nscd ntp nut nx openvpn operator pcap postfix postgres \
      privoxy pulse pvm quagga radvd rpc rpcuser rpm shutdown squid sshd sync \
      uucp vcsa xfs www-data avahi-autoipd gitblit http rtkit sabnzbd usbmux  \
      sickbeard

    # Show ignored patterns if needed.
    zstyle '*' single-ignored show

    # cd style
    zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd never selects the parent directory (e.g.: cd ../<TAB>)
    zstyle ':completion:*:*:cd:*' tag-order local-directories path-directories

    # kill style
    zstyle ':completion:*:*:kill:*' command 'ps -a -w -w -u $USER -o pid,cmd --sort=-pid'
    zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=1;31=1;33"

    # rm/cp/mv style
    zstyle ':completion:*:(rm|mv|cp):*' ignore-line yes

    # hostnames completion
    zstyle -e ':completion:*:hosts' hosts 'reply=(
    ${${${${(f)"$(<~/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}
    ${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*[*?]*}
    ${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}#*[[:blank:]]}}
    )'
    zstyle ':completion:*:*:*:hosts' ignored-patterns 'ip6*' 'localhost*'

    # use zsh-completions if available
    [[ -d ~/.oh-my-zsh/plugins/zsh-completions ]] && fpath=(~/.oh-my-zsh/plugins/zsh-completions/src $fpath)

    # Completion debugging
    bindkey '^Xh' _complete_help
    bindkey '^X?' _complete_debug
}

# composer
_composer_get_command_list () {
    $_comp_command1 --no-ansi 2>/dev/null | sed "1,/Available commands/d" | awk '/^[ \t]*[a-z]+/ { print $1 }'
}

_composer_get_required_list () {
    $_comp_command1 show -s --no-ansi 2>/dev/null | sed '1,/requires/d' | awk 'NF > 0 && !/^requires \(dev\)/{ print $1 }'
}

_composer () {
  local curcontext="$curcontext" state line
  typeset -A opt_args
  _arguments \
    '1: :->command'\
    '*: :->args'

  case $state in
    command)
      compadd $(_composer_get_command_list)
      ;;
    *)
      compadd $(_composer_get_required_list)
      ;;
  esac
}

compdef _composer composer
compdef _composer composer.phar

# npm
(( $+commands[npm] )) && {
    __NPM_COMPLETION_FILE="${ZSH_CACHE_DIR}/npm_completion"

    if [[ ! -f $__NPM_COMPLETION_FILE ]]; then
        npm completion >! $__NPM_COMPLETION_FILE 2>/dev/null
        [[ $? -ne 0 ]] && rm -f $__NPM_COMPLETION_FILE
    fi

    [[ -f $__NPM_COMPLETION_FILE ]] && source $__NPM_COMPLETION_FILE

    unset __NPM_COMPLETION_FILE
}
# -----------------------------------------------------------------------------


# Aliases ---------------------------------------------------------------------
# navigation
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# ls
alias ls="ls -AFt --group-directories-first --color=auto"
alias lss="ls -AFtS --group-directories-first --color=auto"
alias ll="ls -AFtGhl --group-directories-first --color=auto"
alias lls="ls -AFtGhlS --group-directories-first --color=auto"

# essentials
alias -g s="sudo"
alias ss="sudo service"
alias rm="sudo rm -rf"
alias rr="exec $SHELL -l"
alias q="exit"
alias c="clear"
alias -g g="grep"
alias t="tail -F"
alias h="history | grep"
alias ct="cat"
alias -g l="less"
alias n="sudo nano"
alias -g v="sudo vim"
alias a="atom"
alias rc="sudo vim ~/.zshrc"
alias prc="cat ~/.zshrc"
alias grc="cat ~/.zshrc | grep"
alias pp="cat ~/.profile"
alias nrc="sudo vim ~/.nanorc"
alias pnrc="cat ~/.nanorc"
alias gnrc="cat ~/.nanorc | grep"
alias vrc="sudo vim ~/.vimrc"
alias pvrc="cat ~/.vimrc"
alias gvrc="cat ~/.vimrc | grep"
alias op="nautilus"
alias boot="sudo reboot"
alias culprit="lsof | grep"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# alias restartDock="killall Dock"
alias lazy="history | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl | head -n20"
# alias r="cd ~/Documents/Work/Workspaces/R; jekyll build --destination ~/Documents/Work/Workspaces/rahulthakur.me --config _config_live.yml; cd ~/Documents/Work/Workspaces/rahulthakur.me; git add .; git commit -m 'Updated --auto-deploy'; git push;"

# find
alias f="find"
alias ff="sudo find . -name"
alias ffat="sudo find -x / -type f -size +100M"
alias ffatx="sudo find -x / -type f -size +250M"
alias ffatxx="sudo find -x / -type f -size +500M"
alias ffatxxx="sudo find -x / -type f -size +1G"
alias frcd="sudo rm -rf /System/Library/Caches/com.apple.coresymbolicationd/data"
alias frcg="sudo find /private/var/tmp -name \"cachegrind*\" -exec rm -rf {} \;"
alias frt="sudo rm -rf /System/Library/Caches/com.apple.coresymbolicationd/data; sudo find /private/var/tmp -name \"cachegrind*\" -exec rm -rf {} \;"

# update os (osx)
# alias osu="sudo softwareupdate -i -a"

# update os (ubuntu)
alias osv="lsb_release -a"
alias osu="do-release-upgrade -d -f DistUpgradeViewNonInteractive"

# brew
# alias b="brew"
# alias bri="brew install"
# alias brs="brew search"
# alias brl="brew leaves"
# alias brll="brew list"
# alias bru="brew update; brew upgrade --all; brew cleanup"

# apt
alias apti="sudo apt install -y"
alias apts="sudo apt search"
alias aptl="sudo apt list --installed"
alias aptu="sudo apt update; sudo apt upgrade -y; sudo apt clean; sudo apt autoclean -y; sudo apt autoremove -y"

# composer
alias pcomp="cat composer.json"
alias gcomp="cat composer.json | grep"
alias compr="composer require"
alias comprd="composer require --dev"
alias compi="composer install"
alias compgi="composer global install"
alias comps="composer search"
alias compl="composer global show -i"
alias compu="composer update"
alias compgu="composer global self-update; composer global update; composer global clear-cache"
alias dump="composer dump-autoload -o"

# npm
alias npmi="npm install -g"
alias npms="npm search"
alias npml="npm ls -g"
alias npmu="npm install npm -g; npm update -g; npm cache clean"

# pip
alias pipi="pip install"
alias pips="pip search"
alias pipl="pip list"
alias piplo="pip list -o"
alias pipu="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U; rm -rf ~/.pip/cache/"

# gems
alias gemi="yes | gem install"
alias gems="gem search -r"
alias geml="gem search -a -l"
alias gemu="gem update --system; gem update; gem cleanup"

# update everything (osx)
# alias update="sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; sudo composer global self-update; sudo composer global update; sudo composer global clear-cache; sudo npm install npm -g; sudo npm update -g; sudo npm cache clean; sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U; sudo rm -rf ~/.pip/cache/; sudo gem update --system; sudo gem update; sudo gem cleanup"

# update everything (ubuntu)
alias update="do-release-upgrade -d -f DistUpgradeViewNonInteractive; apt-get update; apt-get upgrade -y; apt-get clean; apt-get autoclean -y; composer global self-update; composer global update; composer global clear-cache; npm install npm -g; npm update -g; npm cache clean; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U; rm -rf ~/.pip/cache/; gem update --system; gem update; gem cleanup"

# git
alias pgc="cat .git/config"
alias egc="vim .git/config"
alias pggc="cat ~/.gitconfig"
alias eggc="vim ~/.gitconfig"
alias ggcc="git clone"
alias gre="git remote"
alias grev="git remote -v"
alias grea="git remote add"
alias grer="git remote rm"
alias greall="git_remote_all"
alias gs="git status"
alias gb="git branch"
alias gch="git checkout"
alias gchp="git checkout -p"
alias gchd="git checkout -- ."
alias gcb="git checkout -b"
alias gchb="git checkout -b"
alias ga="git add"
alias gaa="git add ."
alias gap="git add -p"
alias gc="git commit"
alias gcp="git commit -i"
alias gcm="git commit -m"
alias gr="git reset"
alias grp="git reset -p"
alias grs="git reset --soft"
alias grh="git reset --hard"
alias gf="git fetch"
alias gfa="git fetch --all"
alias gp="git pull"
alias gpl="git pull"
alias gpll="git pull"
alias pll="git pull"
alias pull="git pull"
alias gph="git push"
alias gps="git push"
alias gpsh="git push"
alias psh="git push"
alias push="git push"
alias gpp="git pull; git push"
alias gd="git diff"
alias gdt="git difftool"
alias gm="git merge"
alias gmt="git mergetool"
alias gk="gitk"
alias gsl="git stash list"
alias gssp="git stash save -p"
alias gss="git add .; git stash save"
alias gsp="git stash pop"
alias gsa="git stash apply"
alias gsd="git stash drop"
alias grm="git rm -r --cached"
alias gdcl="git clean -f --dry-run"
alias gdcld="git clean -fd --dry-run"
alias gcl="git clean -f"
alias gcld="git clean -fd"
alias gclp="git clean --interactive"
alias glog="git log --decorate --all --oneline --graph"
alias gloga="git log --all --pretty=format:'%C(yellow)%h%Creset %C(bold cyan)%<(18)%an%Creset %C(bold black)%<(12)%cr%Creset %C(bold red)%d%Creset %<(50,trunc)%s'"

# dev
alias eh="sudo vim /etc/hosts"
# alias jb="jekyll build -w"
# alias js="jekyll serve -w"
# alias bdi="bundle install"
# alias pw="cd ~/.pow"
alias art="php artisan"
alias node="nodejs"
alias nn="npm run clean && npm start"
alias es="eslint client server --fix --ignore-path .gitignore"

# vagrant
# alias hs="sudo vim ~/.homestead/Homestead.yaml"
# alias vs="vagrant global-status"
# alias vu="vagrant up 4f83841"
# alias vh="vagrant halt 4f83841"
# alias vr="vagrant reload 4f83841"
# alias ve="vagrant ssh 4f83841"
# alias vp="vagrant reload 4f83841 --provision"
# -----------------------------------------------------------------------------


# Functions -------------------------------------------------------------------
# git
git_remote_all()
{
    while read -r name url method
    do git config --add remote.all.url "$url"
    done < <(git remote -v | awk '!/^all/ && /push/')
}
# -----------------------------------------------------------------------------


# External --------------------------------------------------------------------
source ~/.profile
source ~/.tmuxinator/tmuxinator.zsh
source ~/z.sh
# -----------------------------------------------------------------------------


# Performance -----------------------------------------------------------------
# recompile if needed
autoload -U zrecompile && zrecompile -p ~/.{zcompdump,zshrc} > /dev/null 2>&1
# -----------------------------------------------------------------------------
