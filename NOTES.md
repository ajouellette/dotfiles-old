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
### Hibernation problems ####
For some reason hibernation on newer kernels is very unreliable. LTS kernel works.
Possible solution: use shutdown mode instead of platform mode (does not always work??).

To make systemd use a specific mode for hibernate put

    [Sleep]
    HibernateMode=<mode>

in `/etc/systemd/sleep.conf`.

## General notes

### Lock screen on suspend
Put the following in `/etc/systemd/system/suspend@.service` and enable suspend@*user*.service.
```
[Unit]
Description=User suspend actions
Before=sleep.target

[Service]
User=%I
Type=simple
Environment=DISPLAY=:0
ExecStart=/home/aaron/.local/bin/i3lock.sh    # path to lock program
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target
```

### Power saving
- tlp
- powertop
- boot options:
    - Intel graphics power saving options (might cause problems)

### Improve performance
**Don't use swap:**

Create file `/etc/sysctl.d/fs.conf` with the following contents:
    
    vm.swappiness=5
    vm.vfs_cache_pressue=50

**To measure boot time:**
    
    systemd-analyze
    systemd-analyze blame
    systemd-analyze critical-chain

**Optimize initrd:**

See [this](http://blog.falconindy.com/articles/optmizing-bootup-with-mkinitcpio.html), or just use faster compression algorithms.
lz4 is much better than gzip, cat is even faster.


### Security
**Use full disk encryption**: dm-crypt

**Set up a firewall**: ufw

**SSH**

### Fancy login screen on tty
See [this](https://wiki.archlinux.org/index.php/Configure_virtual_console_colors) wiki page and [this](https://bbs.archlinux.org/viewtopic.php?pid=386429#p386429) forum post.

### Miscellaneous
**Pacman:**

Add `ILoveCandy` to `/etc/pacman.conf`

**Sudo:**

Add `Defaults insults` to `/etc/sudoers`.

**Shell:**

Use zsh instead of bash. Enable completions and spell-corrections.

## Programs used
- **vim** *(the one true text editor)*
- **zsh** *(the shell that I use)*
    - zsh-completions
    - zsh-syntax-highlighting
- **pacaur** *(AUR helper, much better than yaourt)*
- **pacmatic** *(pacman wrapper to avoid problems)*
- **cava** *(music visualizer)*
- **rtv** *(terminal reddit viewer)*
- **compton** *(a display compositor)*
- **i3-gaps** *(window manager)*
    - i3status
    - i3blocks *(more customizable than i3status)*
        - acpi *(for battery monitoring)*
        - xtitle *(to get title of active window)*
    - rofi *(more features than dmenu)*
    - j4-dmenu-desktop *(looks for .desktop files)*
    - i3lock (xss-lock can be used to lock on suspend) *(screen locker)*
    - i3style *(easy theme switching)*
- **mutt** *(best email client)*
    - urlview *(launch url's in browser)*
    - sidebar patch *(easy folder switching)*
    - elinks *(for html emails and browsing in the terminal)*
- **termite** *(great terminal emulator)*
- **irssi** *(terminal IRC client)*
- **mpd** + **ncmpcpp** *(music player)*
    - playerctl *(music player controller, although not for mpd)*
