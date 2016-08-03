#!/usr/bin/env zsh
# -----------------------------------------------------------------------------
#          FILE:  R.zsh-theme
#   DESCRIPTION:  ZSH Prompt theme
#        AUTHOR:  R <rahulthakur.me>
#       VERSION:  1.0.0
# -----------------------------------------------------------------------------

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f') '
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

# use extended color pallete if available
if [[ $terminfo[colors] -ge 256 ]]; then
    vlow="%F{237}"
    low="%F{242}"
    turquoise="%F{81}"
    orange="%F{208}"
    purple="%F{175}"
    hotpink="%F{167}"
    limegreen="%F{112}"
    pgreen="%F{71}"
    pred="%F{124}"
else
    vlow="%F{black}"
    low="%F{white}"
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
    pgreen="%F{green}"
    pred="%F{red}"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%}●"
FMT_STAGED="%{$limegreen%}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

function steeef_preexec {
    case "$(history $HISTCMD)" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="(%{$turquoise%}%b%u%c%{$hotpink%}●${PR_RST})"
        else
            FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

# make prompts
PROMPT_CODE="%B%(?:%{$pgreen%}❯${PR_RST} :%{$pred%}❯${PR_RST}%b )"
TIMESTAMP="%{$vlow%}%B%D{%a %d %b},%b${PR_RST} %{$low%}%D{%L:%M:%S%p}${PR_RST}"
TERM_WIDTH="(${COLUMNS} - 4)"
FILLER="-"
SEPARATOR="\${(l.($TERM_WIDTH)..${FILLER}.)}"

PROMPT='  %{$vlow%}${(e)SEPARATOR}${PR_RST}
%{$vlow%}%B❯%b${PR_RST} %{$hotpink%}%n${PR_RST} %{$low%}at${PR_RST} %{$purple%}%m${PR_RST} %{$low%}in${PR_RST} %{$limegreen%}%~${PR_RST} $vcs_info_msg_0_$(virtualenv_info)
${PROMPT_CODE}'

RPROMPT='${TIMESTAMP} '
