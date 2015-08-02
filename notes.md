# Configuration Notes
These are some notes detailing the configuration of my Arch Linux system, just in case I forget and need to reinstall.

## Thinkpad E440 specific notes

### Blinking power light on resume
fix by running ```# echo '0 on' > /proc/acpi/ibm/led```.

To automate using systemd put the following in ```/usr/lib/systemd/system-sleep/led-fix.sh``` and make it executable

```
 #!/bin/bash
 case $1/$2 in
     pre/*) 
         exit 0;;
     post/*)
         echo '0 on' > /proc/acpi/ibm/led;;
 esac
```

## General notes

### Power saving
- tlp
- powertop
- boot options

### Improve performance
Don't use swap:

### Security


### Fancy login screen on tty


### Miscellaneous
Pacman: ILoveCandy

Sudo: insults

## Programs used
- zsh
    - zsh-completions
    - zsh-syntax-highlighting
- pacaur
- cava
- rtv
- compton
- i3-gaps
    - i3blocks
    - i3lock + xss-lock

