#!/usr/bin/env zsh
# -----------------------------------------------------------------------------
#          FILE:  R.zsh-theme
#   DESCRIPTION:  ZSH Prompt theme
#        AUTHOR:  R <rahulthakur.me>
#       VERSION:  1.0.0
# -----------------------------------------------------------------------------


# prelude ---------------------------------------------------------------------
# enable parameter expansion, command substitution and arithmetic expansion
setopt prompt_subst

# autoloads
autoload -Uz add-zsh-hook # adds zsh hook support
autoload -Uz vcs_info # adds zsh vcs support

# configurables
R_PROMPT_CODE="❯" # the prompt
R_GIT_MARKER="●" # the marker for git status changes
R_SEPARATOR_FILLER="-" # the separator line filler
# -----------------------------------------------------------------------------


# aesthetics ------------------------------------------------------------------
# colours based on available range
if [ $terminfo[colors] -ge 256 ]; then
    R_C_BLACK="%F{237}"
    R_C_GREY="%F{242}"
    R_C_RED="%F{124}"
    R_C_GREEN="%F{71}"
    R_C_BLUE="%F{27}"
    R_C_YELLOW="%F{214}"
    R_C_MAGENTA="%F{175}"
    R_C_CYAN="%F{81}"
    R_C_ORANGE="%F{208}"
    R_C_PURPLE="%F{167}"
    R_C_AQUA="%F{112}"
else
    R_C_BLACK="%F{black}"
    R_C_GREY="%F{white}"
    R_C_RED="%F{red}"
    R_C_GREEN="%F{green}"
    R_C_BLUE="%F{blue}"
    R_C_YELLOW="%F{yellow}"
    R_C_MAGENTA="%F{magenta}"
    R_C_CYAN="%F{blue}"
    R_C_ORANGE="%F{yellow}"
    R_C_PURPLE="%F{red}"
    R_C_AQUA="%F{cyan}"
fi

# foreground background reset
R_C_RESET="%f"

# styles
R_S_BOLD="%B"
R_S_NORMAL="%b"
# -----------------------------------------------------------------------------


# git -------------------------------------------------------------------------
# enable git
zstyle ':vcs_info:*' enable git
# enable checking for changes; caveat: slow for large repos
zstyle ':vcs_info:git:prompt:*' check-for-changes true

# define formats
# %b = branchname # %u = unstagedstr # %c = stagedstr # %a = action
R_GIT_STAGED_FORMAT="${R_C_GREEN}${R_GIT_MARKER}"
R_GIT_UNSTAGED_FORMAT="${R_C_RED}${R_GIT_MARKER}"
R_GIT_UNTRACKED_FORMAT="${R_C_MAGENTA}${R_GIT_MARKER}"
R_GIT_BRANCH_FORMAT_REFERENCE="${R_C_CYAN}%b%c%u"
R_GIT_BRANCH_FORMAT=${R_GIT_BRANCH_FORMAT_REFERENCE}
R_GIT_ACTION_FORMAT="${R_C_AQUA}%a:u${R_C_GREY}::"
R_GIT_INFO_OPEN="${R_C_GREY}("
R_GIT_INFO_CLOSE="${R_C_GREY})${R_C_RESET}"

# set formats
zstyle ':vcs_info:git:prompt:*' unstagedstr "${R_GIT_UNSTAGED_FORMAT}"
zstyle ':vcs_info:git:prompt:*' stagedstr "${R_GIT_STAGED_FORMAT}"
zstyle ':vcs_info:git:prompt:*' formats "${R_GIT_INFO_OPEN}${R_GIT_BRANCH_FORMAT}${R_GIT_INFO_CLOSE}"
zstyle ':vcs_info:git:prompt:*' actionformats "${R_GIT_INFO_OPEN}${R_GIT_ACTION_FORMAT}${R_GIT_BRANCH_FORMAT}${R_GIT_INFO_CLOSE}"
zstyle ':vcs_info:git:prompt:*' nvcsformats ""
# -----------------------------------------------------------------------------


# make prompt -----------------------------------------------------------------
R_TERMINAL_WIDTH="(${COLUMNS} - 4)"
local separator="\${(l.(${R_TERMINAL_WIDTH})..${R_SEPARATOR_FILLER}.)}"
R_PROMPT_SEPARATOR_LINE="  ${R_C_BLACK}${(e)separator}${R_C_RESET}"

R_PROMPT_INFO_LINE="${R_C_BLACK}${R_PROMPT_CODE} ${R_C_PURPLE}%n ${R_C_GREY}at ${R_C_MAGENTA}%m ${R_C_GREY}in ${R_C_AQUA}%~${R_C_RESET} $vcs_info_msg_0_"

R_PROMPT_LINE="%(?.${R_C_GREEN}.${R_C_RED})${R_PROMPT_CODE}${R_C_RESET} "

# set left prompt
PROMPT=$'${R_PROMPT_SEPARATOR_LINE}
${R_PROMPT_INFO_LINE}
${R_PROMPT_LINE}'

R_RPROMPT_TIMESTAMP="${R_C_BLACK}${R_S_BOLD}%D{%a %d %b},${R_S_NORMAL} ${R_C_GREY}%D{%L:%M:%S%p}${R_C_RESET}"

# set right prompt
RPROMPT=$'${R_RPROMPT_TIMESTAMP} '
# -----------------------------------------------------------------------------


# zsh hooks -------------------------------------------------------------------
# preexec : Executed just after a command has been read and is about to be executed. If the history mechanism is active (regardless of whether the line was discarded from the history buffer), the string that the user typed is passed as the first argument, otherwise it is an empty string. The actual command that will be executed (including expanded aliases) is passed in two different forms: the second argument is a single-line, size-limited version of the command (with things like function bodies elided); the third argument contains the full text that is being executed.
# function r_preexec
# {
# }
# add-zsh-hook preexec r_preexec

# chpwd : Executed whenever the current working directory is changed.
# r_chpwd()
# {
# }
# add-zsh-hook chpwd r_chpwd

# precmd : Executed before each prompt. Note that precommand functions are not re-executed simply because the command line is redrawn, as happens, for example, when a notification about an exiting job is displayed.
function r_precmd
{
    # update separator line : for terminal width change
    # check if the width has actually changed
    local this_width="(${COLUMNS} - 4)"
    if [ ${this_width} != ${R_TERMINAL_WIDTH} ]; then
        R_TERMINAL_WIDTH=${this_width}
        local separator="\${(l.(${R_TERMINAL_WIDTH})..${R_SEPARATOR_FILLER}.)}"
        R_PROMPT_SEPARATOR_LINE="  ${R_C_BLACK}${(e)separator}${R_C_RESET}"
    fi

    # update info line : for git info
    # check if we are inside a git work tree
    if $(git rev-parse --is-inside-work-tree 2> /dev/null); then
        # explicitly check for untracked files since vcs_info will not
        local is_untracked="$(git status --porcelain | grep "^??" | wc -l)"
        if [ ${is_untracked} -ge 1 ]; then
            R_GIT_BRANCH_FORMAT="${R_GIT_BRANCH_FORMAT_REFERENCE}${R_GIT_UNTRACKED_FORMAT}"
        else
            R_GIT_BRANCH_FORMAT="${R_GIT_BRANCH_FORMAT_REFERENCE}"
        fi
        zstyle ':vcs_info:git:prompt:*' formats "${R_GIT_INFO_OPEN}${R_GIT_BRANCH_FORMAT}${R_GIT_INFO_CLOSE}"
    fi
    vcs_info 'prompt'
    R_PROMPT_INFO_LINE="${R_C_BLACK}${R_PROMPT_CODE} ${R_C_PURPLE}%n ${R_C_GREY}at ${R_C_MAGENTA}%m ${R_C_GREY}in ${R_C_AQUA}%~${R_C_RESET} ${vcs_info_msg_0_}"
}
add-zsh-hook precmd r_precmd
# -----------------------------------------------------------------------------
