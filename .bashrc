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
  if [ -f /etc/arch-release ]; then
    [ -f "$HOME/.bash_aliases_arch" ] && source "$HOME/.bash_aliases_arch"
  elif [ -f /etc/void-release ]; then
    [ -f "$HOME/.bash_aliases_void" ] && source "$HOME/.bash_aliases_void"
  elif [ -f /etc/debian_version ]; then
    [ -f "$HOME/.bash_aliases_debian" ] && source "$HOME/.bash_aliases_debian"
  fi
}

# Load custom aliases based on the distribution
include_aliases

# Colors
BLUE="\033[0;34m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
RESET="\033[0m"

# Function to get the current git branch
function parse_git_branch {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# Function to check for updates using pacman (only if Arch Linux)
if [ -f /etc/arch-release ]; then
  function check_updates_pacman {
    if command -v checkupdates &> /dev/null; then
      echo -n "$(checkupdates | wc -l) updates available in pacman."
    else
      echo -n "checkupdates not installed."
    fi
  }

  # Function to check for updates using yay (only if Arch Linux)
  function check_updates_yay {
    if command -v yay &> /dev/null; then
      echo -n "$(yay -Qu | wc -l) updates available in aur."
    else
      echo -n "yay not installed."
    fi
  fi
fi

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
echo -e "${GREEN}Welcome, $USER!${RESET}"

# Check and show package updates (only if Arch Linux)
if [ -f /etc/arch-release ]; then
  echo -e "${YELLOW}$(check_updates_pacman) $(check_updates_yay)${RESET}"
fi

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
PROMPT_COMMAND='echo -e "\e[0;36m$(date +%H:%M:%S)\e[0m $(($(date +%s) - $(date +%s -r /proc/$$/stat)))s"'

# Load Starship prompt if available
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Function to run havamal script with red output
function run_havamal {
  ~/.config/havamal/havamal | while IFS= read -r line; do
    echo -e "${RED}${line}${RESET}"
  done
}
run_havamal
