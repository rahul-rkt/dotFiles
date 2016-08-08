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
PROMPT_CODE="❯" # the prompt
GIT_MARKER="●" # the marker for git status changes
SEPARATOR_FILLER="-" # the separator line filler
# -----------------------------------------------------------------------------


# aesthetics ------------------------------------------------------------------
# colours based on available range
if [ $terminfo[colors] -ge 256 ]; then
    black="%F{237}"
    grey="%F{242}"
    red="%F{124}"
    green="%F{71}"
    blue="%F{27}"
    yellow="%F{214}"
    magenta="%F{175}"
    cyan="%F{81}"
    orange="%F{208}"
    purple="%F{167}"
    aqua="%F{112}"
else
    black="%F{black}"
    grey="%F{white}"
    red="%F{red}"
    green="%F{green}"
    blue="%F{blue}"
    yellow="%F{yellow}"
    magenta="%F{magenta}"
    cyan="%F{blue}"
    orange="%F{yellow}"
    purple="%F{red}"
    aqua="%F{cyan}"
fi

# styles
bold="%B"
normal="%b"

# reset
reset="%f"
# -----------------------------------------------------------------------------


# git -------------------------------------------------------------------------
# enable git
zstyle ':vcs_info:*' enable git
# enable checking for changes; caveat: slow for large repos
zstyle ':vcs_info:git:prompt:*' check-for-changes true

# define formats
# %b = branchname # %u = unstagedstr # %c = stagedstr # %a = action
GIT_STAGED_FORMAT="${green}${GIT_MARKER}"
GIT_UNSTAGED_FORMAT="${red}${GIT_MARKER}"
GIT_UNTRACKED_FORMAT="${magenta}${GIT_MARKER}"
GIT_BRANCH_FORMAT_REFERENCE="${cyan}%b%c%u"
GIT_BRANCH_FORMAT=${GIT_BRANCH_FORMAT_REFERENCE}
GIT_ACTION_FORMAT="${aqua}%a:u${grey}::"
GIT_INFO_OPEN="${grey}("
GIT_INFO_CLOSE="${grey})${reset}"

# set formats
zstyle ':vcs_info:git:prompt:*' unstagedstr "${GIT_UNSTAGED_FORMAT}"
zstyle ':vcs_info:git:prompt:*' stagedstr "${GIT_STAGED_FORMAT}"
zstyle ':vcs_info:git:prompt:*' formats "${GIT_INFO_OPEN}${GIT_BRANCH_FORMAT}${GIT_INFO_CLOSE}"
zstyle ':vcs_info:git:prompt:*' actionformats "${GIT_INFO_OPEN}${GIT_ACTION_FORMAT}${GIT_BRANCH_FORMAT}${GIT_INFO_CLOSE}"
zstyle ':vcs_info:git:prompt:*' nvcsformats ""
# -----------------------------------------------------------------------------


# make prompt -----------------------------------------------------------------
TERMINAL_WIDTH="(${COLUMNS} - 4)"
local separator="\${(l.(${TERMINAL_WIDTH})..${SEPARATOR_FILLER}.)}"
PROMPT_SEPARATOR_LINE="  ${black}${(e)separator}${reset}"

PROMPT_INFO_LINE="${black}${PROMPT_CODE} ${purple}%n ${grey}at ${magenta}%m ${grey}in ${aqua}%~${reset} $vcs_info_msg_0_"

PROMPT_LINE="%(?.${green}.${red})${PROMPT_CODE}${reset} "

RPROMPT_TIMESTAMP="${black}${bold}%D{%a %d %b},${normal} ${grey}%D{%L:%M:%S%p}${reset}"

PROMPT=$'${PROMPT_SEPARATOR_LINE}
${PROMPT_INFO_LINE}
${PROMPT_LINE}'

RPROMPT=$'${RPROMPT_TIMESTAMP} '
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
    if [ ${this_width} != ${TERMINAL_WIDTH} ]; then
        TERMINAL_WIDTH=${this_width}
        local separator="\${(l.(${TERMINAL_WIDTH})..${SEPARATOR_FILLER}.)}"
        PROMPT_SEPARATOR_LINE="  ${black}${(e)separator}${reset}"
    fi

    # update info line : for git info
    # check if we are inside a git work tree
    if $(git rev-parse --is-inside-work-tree 2> /dev/null); then
        # explicitly check for untracked files since vcs_info will not
        local is_untracked="$(git status --porcelain | grep "^??" | wc -l)"
        if [ ${is_untracked} -ge 1 ]; then
            GIT_BRANCH_FORMAT="${GIT_BRANCH_FORMAT_REFERENCE}${GIT_UNTRACKED_FORMAT}"
        else
            GIT_BRANCH_FORMAT="${GIT_BRANCH_FORMAT_REFERENCE}"
        fi
        zstyle ':vcs_info:git:prompt:*' formats "${GIT_INFO_OPEN}${GIT_BRANCH_FORMAT}${GIT_INFO_CLOSE}"
    fi
    vcs_info 'prompt'
    PROMPT_INFO_LINE="${black}${PROMPT_CODE} ${purple}%n ${grey}at ${magenta}%m ${grey}in ${aqua}%~${reset} ${vcs_info_msg_0_}"
}
add-zsh-hook precmd r_precmd
# -----------------------------------------------------------------------------
