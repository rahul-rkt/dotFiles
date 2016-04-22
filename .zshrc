# -----------------------------------------------------------------------------
#          FILE:  .zshrc
#   DESCRIPTION:  ZSH configuration file
#        AUTHOR:  Rahul Thakur < rahulthakur.me | r@rahulthakur.me >
#       VERSION:  1.0.0
# -----------------------------------------------------------------------------


# OH-MY-ZSH -------------------------------------------------------------------
# Path to your oh-my-zsh installation.
export ZSH=/Users/rahulthakur/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(atom brew bundler osx git github git-flow tmux tmuxinator zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nano'
# else
#   export EDITOR='nano'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
# -----------------------------------------------------------------------------


# Config ----------------------------------------------------------------------
# term
export TERM=xterm-256color

# locale
export LANG=en_IN.UTF-8
export LANGUAGE=en_IN.UTF-8
export LC_ALL=en_IN.UTF-8

# editors
export EDITOR="nano"
export VISUAL="atom"

# timezone
export TZ=Asia/Kolkata

# path
export PATH=$PATH:/usr/local/heroku/bin:~/.composer/vendor/bin

# homebrew fix
export HOMEBREW_GITHUB_API_TOKEN=1a76bc4e652e9f2e9109a6cb527fcf8920fe5ec5

# ls colours
export LSCOLORS=ExFxcxdxbxexexabagacad
# -----------------------------------------------------------------------------


# Aliases ---------------------------------------------------------------------
# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"

# ls
alias ls="ls -G"
alias l="ls -aG"
alias ll="ls -aGl"

# essentials
alias rc="sudo nano ~/.zshrc"
alias nrc="sudo nano ~/.nanorc"
alias s="sudo -s"
alias rm="sudo rm -rf"
alias rr="exec $SHELL -l"
alias q="exit"
alias c="clear"
alias culprit="lsof | grep"
alias r="cd ~/Documents/Work/Workspaces/R; jekyll build --destination ~/Documents/Work/Workspaces/rahulthakur.me --config _config_live.yml; cd ~/Documents/Work/Workspaces/rahulthakur.me; git add .; git commit -m 'Updated --auto-deploy'; git push;"

# update os (osx)
alias osu="sudo softwareupdate -i -a"

# update os (ubuntu)
# alias osv="lsb_release -a"
# alias osu="do-release-upgrade -d -f DistUpgradeViewNonInteractive"

# brew
alias bri="brew install"
alias brs="brew search"
alias bru="brew update; brew upgrade --all; brew cleanup"

# apt
# alias apti="sudo apt-get install -y"
# alias apts="sudo apt-cache search"
# alias aptl="sudo dpkg --get-selections | grep -v deinstall"
# alias aptu="sudo apt-get update; apt-get upgrade -y; apt-get clean; apt-get autoclean -y"

# composer
alias compi="composer global install"
alias comps="composer search"
alias compl="composer global show -i"
alias compu="composer global self-update; composer global update; composer global clear-cache"

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
alias update="sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; sudo composer global self-update; sudo composer global update; sudo composer global clear-cache; sudo npm install npm -g; sudo npm update -g; sudo npm cache clean; sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U; sudo rm -rf ~/.pip/cache/; sudo gem update --system; sudo gem update; sudo gem cleanup"

# update everything (ubuntu)
# alias update="do-release-upgrade -d -f DistUpgradeViewNonInteractive; apt-get update; apt-get upgrade -y; apt-get clean; apt-get autoclean -y; composer global self-update; composer global update; composer global clear-cache; npm install npm -g; npm update -g; npm cache clean; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U; rm -rf ~/.pip/cache/; gem update --system; gem update; gem cleanup"

# find large files
alias ffat="sudo find -x / -type f -size +100M"
alias ffatx="sudo find -x / -type f -size +250M"
alias ffatxx="sudo find -x / -type f -size +500M"
alias ffatxxx="sudo find -x / -type f -size +1G"

# git
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push --all origin"
alias gs="git status"
alias gb="git checkout"
alias gh="git push origin master; git checkout gh-pages; git rebase master;
git push origin gh-pages; git checkout master"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# dev
alias jb="jekyll build -w"
alias js="jekyll serve -w"
alias bdi="bundle install"
alias pw="cd ~/.pow"
alias vs="vagrant global-status"
alias vu="vagrant up 4f83841"
alias vh="vagrant halt 4f83841"
alias vr="vagrant reload 4f83841"
alias ve="vagrant ssh 4f83841"
alias vp="vagrant reload 4f83841 --provision"
alias linode="ssh developer@139.162.17.199"
# -----------------------------------------------------------------------------


# External --------------------------------------------------------------------
source ~/.profile
source ~/.tmuxinator/tmuxinator.zsh
source ~/z.sh
# -----------------------------------------------------------------------------

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
