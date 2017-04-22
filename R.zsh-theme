#!/usr/bin/env zsh
# -----------------------------------------------------------------------------
#          FILE:  R.zsh-theme
#   DESCRIPTION:  ZSH Prompt theme
#        AUTHOR:  R
# -----------------------------------------------------------------------------


# prelude ---------------------------------------------------------------------
# enable parameter expansion, command substitution and arithmetic expansion
setopt prompt_subst

# autoloads
autoload -Uz add-zsh-hook # adds zsh hook support
autoload -Uz vcs_info # adds zsh vcs support

# configurables
R_PROMPT_CODE="❯" # the prompt
R_PROMPT_CODE_PRIVILEGED="$" # the privileged prompt
R_GIT_MARKER="●" # the marker for git status changes
R_SEPARATOR_FILLER="-" # the separator line filler
R_MAX_PWD_DEPTH=5 # max number of dir to show before shortening the path, ~ excluded!
R_USE_TERMINAL_COLOURS=true # true = default colours; false = set custom colours if supported
# -----------------------------------------------------------------------------


# aesthetics ------------------------------------------------------------------
# colours
if [ "$R_USE_TERMINAL_COLOURS" = false && $terminfo[colors] -ge 256 ]; then
    R_C_BLACK="%F{238}"
    R_C_RED="%F{124}"
    R_C_GREEN="%F{71}"
    R_C_YELLOW="%F{208}"
    R_C_BLUE="%F{87}"
    R_C_MAGENTA="%F{135}"
    R_C_CYAN="%F{87}"
    R_C_WHITE="%F{246}"
else
    R_C_BLACK="%F{black}"
    R_C_RED="%F{red}"
    R_C_GREEN="%F{green}"
    R_C_YELLOW="%F{yellow}"
    R_C_BLUE="%F{blue}"
    R_C_MAGENTA="%F{magenta}"
    R_C_CYAN="%F{cyan}"
    R_C_WHITE="%F{white}"
fi

# reset colours
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
R_GIT_ACTION_FORMAT="${R_C_YELLOW}ongoing-%a${R_C_BLACK}::"
R_GIT_INFO_OPEN="${R_C_BLACK}("
R_GIT_INFO_CLOSE="${R_C_BLACK})${R_C_RESET}"

# set formats
zstyle ':vcs_info:git:prompt:*' unstagedstr "${R_GIT_UNSTAGED_FORMAT}"
zstyle ':vcs_info:git:prompt:*' stagedstr "${R_GIT_STAGED_FORMAT}"
zstyle ':vcs_info:git:prompt:*' formats "${R_GIT_INFO_OPEN}${R_GIT_BRANCH_FORMAT}${R_GIT_INFO_CLOSE}"
zstyle ':vcs_info:git:prompt:*' actionformats "${R_GIT_INFO_OPEN}${R_GIT_ACTION_FORMAT}${R_GIT_BRANCH_FORMAT}${R_GIT_INFO_CLOSE}"
zstyle ':vcs_info:git:prompt:*' nvcsformats ""
# -----------------------------------------------------------------------------


# zsh hooks -------------------------------------------------------------------
# preexec : Executed just after a command has been read and is about to be executed. If the history mechanism is active (regardless of whether the line was discarded from the history buffer), the string that the user typed is passed as the first argument, otherwise it is an empty string. The actual command that will be executed (including expanded aliases) is passed in two different forms: the second argument is a single-line, size-limited version of the command (with things like function bodies elided); the third argument contains the full text that is being executed.
# function r_preexec
# {
# }
# add-zsh-hook preexec r_preexec

# chpwd : Executed whenever the current working directory is changed.
r_chpwd()
{
    local pwd="${PWD/#$HOME/~}"
    local -a pwd_list;pwd_list=(${(ps:/:)pwd})
    local pwd_count="${#pwd_list[@]}"
    local s="${R_C_YELLOW}/"

    pwd="${R_C_GREEN}${pwd_list[${pwd_count}]}"
    for (( i=${pwd_count}-1; i>${pwd_count}-${R_MAX_PWD_DEPTH} && i>0; i-- )); do
        pwd="${R_C_BLACK}${pwd_list[${i}]}${s}${pwd}"
    done
    if [[ ${pwd_count} -ge ${R_MAX_PWD_DEPTH}+2 ]]; then
        pwd="${R_C_BLACK}${pwd_list[1]}${s}${R_C_BLACK}...${s}${pwd}"
    elif [[ ${pwd_count} -ge ${R_MAX_PWD_DEPTH}+1 ]]; then
        pwd="${R_C_BLACK}${pwd_list[1]}${s}${pwd}"
    fi

    R_PWD="${R_S_BOLD}${pwd}${R_S_NORMAL}"
}
add-zsh-hook chpwd r_chpwd

# precmd : Executed before each prompt. Note that precommand functions are not re-executed simply because the command line is redrawn, as happens, for example, when a notification about an exiting job is displayed.
function r_precmd
{
    # update separator line : for terminal width change
    # check if the width has actually changed
    local this_width="(${COLUMNS} - 4)"
    if [[ -z ${R_TERMINAL_WIDTH} || ${this_width} != ${R_TERMINAL_WIDTH} ]]; then
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
    R_PROMPT_INFO_LINE="${R_C_BLACK}${R_PROMPT_CODE} ${R_C_RED}%n ${R_C_BLACK}at ${R_C_MAGENTA}%m ${R_C_BLACK}in ${R_PWD} ${R_S_BOLD}${vcs_info_msg_0_}${R_S_NORMAL}"
}
add-zsh-hook precmd r_precmd
# -----------------------------------------------------------------------------


# make prompt -----------------------------------------------------------------
r_chpwd # builds R_PWD for R_PROMPT_INFO_LINE
r_precmd # builds R_PROMPT_SEPARATOR_LINE & R_PROMPT_INFO_LINE
R_PROMPT_LINE="%(?.${R_C_GREEN}.${R_C_YELLOW})%(!.${R_PROMPT_CODE_PRIVILEGED}.${R_PROMPT_CODE})${R_C_RESET} "
R_RPROMPT_TIMESTAMP="${R_C_BLACK}${R_S_BOLD}%D{%a %d %b}, ${R_C_WHITE}%D{%L:%M:%S%p}${R_C_RESET}${R_S_NORMAL}"

# set left prompt
PROMPT=$'${R_PROMPT_SEPARATOR_LINE}
${R_PROMPT_INFO_LINE}
${R_PROMPT_LINE}'

# set right prompt
RPROMPT=$'${R_RPROMPT_TIMESTAMP} '
# -----------------------------------------------------------------------------
