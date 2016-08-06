#!/usr/bin/env zsh
# -----------------------------------------------------------------------------
#          FILE:  R.zsh-theme
#   DESCRIPTION:  ZSH Prompt theme
#        AUTHOR:  R <rahulthakur.me>
#       VERSION:  1.0.0
# -----------------------------------------------------------------------------


# prelude ---------------------------------------------------------------------
# enable parameter expansion, command substitution and arithmetic expansion
setopt          prompt_subst

# autoloads
autoload -Uz    add-zsh-hook # adds zsh hook support
autoload -Uz    vcs_info # adds zsh vcs support

# flag for checking if firing a git status update is required
# do_git_update=1

# current terminal width
local terminal_width="(${COLUMNS} - 4)"
# -----------------------------------------------------------------------------


# aesthetics ------------------------------------------------------------------
# colours based on available range
if [[ $terminfo[colors] -ge 256 ]]; then
    local black="%F{237}"
    local grey="%F{242}"
    local red="%F{124}"
    local green="%F{71}"
    local blue="%F{27}"
    local yellow="%F{214}"
    local magenta="%F{175}"
    local cyan="%F{81}"
    local orange="%F{208}"
    local purple="%F{167}"
    local aqua="%F{112}"
else
    local black="%F{black}"
    local grey="%F{white}"
    local red="%F{red}"
    local green="%F{green}"
    local blue="%F{blue}"
    local yellow="%F{yellow}"
    local magenta="%F{magenta}"
    local cyan="%F{blue}"
    local orange="%F{yellow}"
    local purple="%F{red}"
    local aqua="%F{cyan}"
fi

# styles
local bold="%B"
local normal="%b"

# reset
local reset="%f"
# -----------------------------------------------------------------------------


# git -------------------------------------------------------------------------
# only git is configured, not interested in using anything else
# key
#       %b = branchname
#       %u = unstagedstr
#       %c = stagedstr
#       %a = action

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# define formats
local git_mark="●"
local git_staged_format="${green}${git_mark}${reset}"
local git_unstaged_format="${red}${git_mark}${reset}"
local git_untracked_format="${magenta}${git_mark}${reset}"
local git_branch_format="${cyan}%b%c%u${reset}"
local git_action_format="${aqua}%a:u${reset}${grey}::${reset}"
local git_info_open="${grey}(${reset}"
local git_info_close="${grey})${reset}"

# explicitly check for untracked files since vcs_info will not
local is_untracked="$(git ls-files --other --exclude-standard)"
if [ -n "$is_untracked" ]; then
    git_branch_format="${git_branch_format}${git_untracked_format}"
fi

# enable git
zstyle ':vcs_info:*'     enable              git

# enable checking for changes; caveat: slow for large repos
zstyle ':vcs_info:*:*'   check-for-changes   true

# set formats
zstyle ':vcs_info:*:*'   unstagedstr         "${git_unstaged_format}"
zstyle ':vcs_info:*:*'   stagedstr           "${git_staged_format}"
zstyle ':vcs_info:*:*'   formats             "${git_info_open}${git_branch_format}${git_info_close}"
zstyle ':vcs_info:*:*'   actionformats       "${git_info_open}${git_action_format}${git_branch_format}${git_info_close}"
zstyle ':vcs_info:*:*'   nvcsformats         ""
# -----------------------------------------------------------------------------


# zsh hooks -------------------------------------------------------------------
# preexec : Executed just after a command has been read and is about to be executed. If the history mechanism is active (regardless of whether the line was discarded from the history buffer), the string that the user typed is passed as the first argument, otherwise it is an empty string. The actual command that will be executed (including expanded aliases) is passed in two different forms: the second argument is a single-line, size-limited version of the command (with things like function bodies elided); the third argument contains the full text that is being executed.
# r_preexec()
# {
#     local is_last_command_git="%{fc -lr $(($HISTCMD - 1)) | grep g}"
#     if [[ $is_last_command_git ]]; then
#         do_git_update=1
#     fi
# }
# add-zsh-hook preexec r_preexec

# chpwd : Executed whenever the current working directory is changed.
# r_chpwd()
# {
#     do_git_update=1
# }
# add-zsh-hook chpwd r_chpwd

# precmd : Executed before each prompt. Note that precommand functions are not re-executed simply because the command line is redrawn, as happens, for example, when a notification about an exiting job is displayed.
# r_precmd()
# {
#     # recalculate width; useful for auto updating the separator length on resize
#     terminal_width="(${COLUMNS} - 4)"
#
#     # check for untracked files or updated submodules, since vcs_info doesn't
#     if [[ -n "$do_git_update" ]]; then
#         local is_untracked="%{git ls-files --other --exclude-standard 2> /dev/null | grep -q "."}"
#
#         if [[ $is_untracked ]]; then
#             git_branch_format="${git_branch_format}${purple}●${reset}"
#         fi
#         zstyle ':vcs_info:git:prompt:*' formats "${git_info_open}${git_branch_format}${git_info_close}"
#
#         vcs_info 'prompt'
#         do_git_update=
#     fi
# }
# add-zsh-hook precmd vcs_info
# -----------------------------------------------------------------------------


# make prompt -----------------------------------------------------------------
# ref: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
local buffer=" "
local prompt_code="❯"

local filler="-"
local separator="\${(l.($terminal_width)..${filler}.)}"
local prompt_separator_line="  ${black}${(e)separator}${reset}"

# local info_line_path='%{$(dirs|grep --color=always /)%${#DIRS}G%}'
local prompt_info_line="${black}${prompt_code}${reset} ${purple}%n${reset} ${grey}at${reset} ${magenta}%m${reset} ${grey}in${reset} ${aqua}%~${reset} $vcs_info_msg_0_"

local prompt_line="%(?.${green}.${red})${prompt_code}${reset} "

local rprompt_timestamp="${black}${bold}%D{%a %d %b},${reset}  ${grey}%D{%L:%M:%S%p}${reset}"
# -----------------------------------------------------------------------------


# set prompt ------------------------------------------------------------------
PROMPT="${prompt_separator_line}
${prompt_info_line}
${prompt_line}"

RPROMPT="${rprompt_timestamp}${buffer}"
# -----------------------------------------------------------------------------
