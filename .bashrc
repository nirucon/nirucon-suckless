# .bashrc by Nicklas Rudolfsson
# https://github.com/nirucon

# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
  *) return;;
esac

# Ensure home directory is the default directory when starting a new shell
cd $HOME

# Function to include the appropriate alias file based on the Linux distribution
function include_aliases {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      arch)
        [ -f "$HOME/.bash_aliases_arch" ] && source "$HOME/.bash_aliases_arch"

# -------------------------------------
# Prompt with colors
# -------------------------------------
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
MAGENTA='\[\e[0;35m\]'
CYAN='\[\e[0;36m\]'
RESET='\[\e[0m\]'

PS1="${CYAN}[\u${RESET}@${GREEN}\h ${YELLOW}\W${CYAN}]\$ ${RESET}"

        ;;
      void)
        [ -f "$HOME/.bash_aliases_void" ] && source "$HOME/.bash_aliases_void"
        ;;
      debian|ubuntu)
        [ -f "$HOME/.bash_aliases_debian" ] && source "$HOME/.bash_aliases_debian"
        ;;
      *)
        ;;
    esac
  fi
}

# Load custom aliases based on the distribution
include_aliases

# Colors
BLUE="\[\033[0;34m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
RED="\[\033[0;31m\]"
RESET="\[\033[0m\]"

# Function to get the current git branch
function parse_git_branch {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# Enhanced prompt with Git branch
PS1="${BLUE}\u${GREEN}@\h ${YELLOW}\w${RED}\$(parse_git_branch)${RESET}\$ "

# Enable case-insensitive completion
bind 'set completion-ignore-case on'

# Enable auto-correction
shopt -s cdspell

# Enable colored output for ls
export LS_OPTIONS='--color=auto'
eval "`dircolors`"

# Welcome message (no color codes here)
echo -e "\033[0;32mWelcome, $USER!\033[0m"

# Colored output for ls
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Load Autojump if available
if [ -f /usr/share/autojump/autojump.sh ]; then
    . /usr/share/autojump/autojump.sh
fi

# Use bat for syntax highlighting
if command -v bat &> /dev/null; then
    alias cat='bat'
fi

# Command execution time
#PROMPT_COMMAND='echo -e "\[\e[0;36m\]$(date +%H:%M:%S)\[\e[0m\] $(($(date +%s) - $(date +%s -r /proc/$$/stat)))s"'

# Load Starship prompt if available
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Function to run havamal script with red output
function run_havamal {
  ~/.config/havamal/havamal | while IFS= read -r line; do
    echo -e "\033[0;31m${line}\033[0m"
  done
}
run_havamal

# -------------------------------------
# LS_COLORS setup for colored output
# -------------------------------------
if command -v vivid >/dev/null 2>&1; then
  export LS_COLORS="$(vivid generate dracula)"
elif command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi

# -------------------------------------
# Colored ls aliases
# -------------------------------------
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
