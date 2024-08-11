#!/bin/bash

# dmenu script to controll brightnessctl

# Define brightness level options
OPTIONS="25%\n50%\n75%\n100%"

# Use dmenu to prompt the user for a choice
CHOICE=$(echo -e $OPTIONS | dmenu -i -p "Set Brightness Level:")

# Set the brightness to the chosen level
case "$CHOICE" in
  25%)
    brightnessctl set 25%
    ;;
  50%)
    brightnessctl set 50%
    ;;
  75%)
    brightnessctl set 75%
    ;;
  100%)
    brightnessctl set 100%
    ;;
  *)
    # Do nothing if canceled or invalid choice
    ;;
esac
