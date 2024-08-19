#!/bin/bash

# nirufetch.sh - A *fetch-style system information script
# Version: 0.1
# Author: Nicklas Rudolfsson
# License: Free

#==================== Configuration ====================#
# Colors (for easier customization)
BOLD="\033[1m"
NORMAL="\033[0m"
DARK="\033[38;5;240m"  # Dark grey
WHITE="\033[38;5;15m"  # White for highlights
GREY="\033[38;5;250m"  # Light grey for labels

#==================== Functions ====================#

# Function to print aligned information
function print_info() {
  label=$1
  info=$2
  printf "${GREY}%-15s${WHITE}%s${NORMAL}\n" "$label" "$info"
}

# Display Hostname
function print_hostname() {
  print_info "Hostname:" "$(cat /etc/hostname)"
}

# Display Operating System
function print_os() {
  print_info "OS:" "$(grep -oP '^PRETTY_NAME="\K[^"]+' /etc/os-release) $(uname -m)"
}

# Display Kernel Version
function print_kernel() {
  print_info "Kernel:" "$(uname -sr)"
}

# Display System Uptime
function print_uptime() {
  uptime_formatted=$(uptime -p | sed 's/up //')
  print_info "Uptime:" "$uptime_formatted"
}

# Display Number of Installed Packages
function print_packages() {
  packages_count=$(pacman -Qq | wc -l)
  print_info "Packages:" "$packages_count (pacman)"
}

# Display Default Shell
function print_shell() {
  shell_version=$($SHELL --version | head -n 1 | awk '{print $1 " " $2}' | sed 's/,$//')
  print_info "Shell:" "$shell_version"
}

# Display Screen Resolution(s)
function print_resolution() {
  if xrandr > /dev/null 2>&1; then
    xrandr --query | grep ' connected' | while read -r line; do
      display_name=$(echo $line | awk '{print $1}')
      resolution=$(echo $line | awk '{print $3}' | sed 's/+.*//')
      print_info "Display (${display_name}):" "${resolution}"
    done
  fi
}

# Display Window Manager and Desktop Environment
function print_de_wm() {
  DE="${XDG_CURRENT_DESKTOP:-$DESKTOP_SESSION}"
  WM=$(xprop -root _NET_SUPPORTING_WM_CHECK | grep -oP '"\K[^"]+' | xargs -I{} xprop -id {} _NET_WM_NAME | grep -oP '"\K[^"]+')

  if [ ! -z "$DE" ]; then
    print_info "DE:" "$DE"
  fi

  if [ ! -z "$WM" ]; then
    print_info "WM:" "$WM"
  fi
}

# Display CPU Information
function print_cpu() {
  cpu_info=$(grep -m 1 'model name' /proc/cpuinfo | cut -d ':' -f 2 | xargs)
  print_info "CPU:" "$cpu_info"
}

# Display Memory Usage
function print_memory() {
  memory=$(free -h | grep Mem | awk '{print $3 " / " $2}')
  print_info "Memory:" "$memory"
}

# Display Disk Usage
function print_disk() {
  disk_info=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
  print_info "Disk (/):" "$disk_info"
}

# Display GPU Information
function print_gpu() {
  gpu_info=$(lspci | grep -i 'vga\|3d\|2d' | cut -d ':' -f3 | xargs)
  print_info "GPU:" "$gpu_info"
}

# Display Network Information
function print_network() {
  local_ip=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1')
  public_ip=$(curl -s ifconfig.me)

  if [ ! -z "$local_ip" ]; then
    print_info "Local IP:" "$local_ip"
  fi

  if [ ! -z "$public_ip" ]; then
    print_info "Public IP:" "$public_ip"
  fi
}

#==================== Main Execution ====================#
clear

print_hostname
print_os
print_kernel
print_uptime
print_packages
print_shell
#print_resolution
print_de_wm
print_cpu
print_memory
print_disk
print_gpu
print_network

#==================== End of Script ====================#
