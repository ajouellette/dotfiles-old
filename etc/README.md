# /etc
These are some system wide configuration files. They will not work on every system.

## Files included:
- issue - display Arch logo on tty login screen
- vconsole.conf - tty font and colors
- pacman.conf - pacman settings
- pacman.d
    - hooks - pacman hooks
        - pacdiff.hook - deal with .pacnew files when upgrading packages
        - etckeeper-[post|pre].hook - track changes in `/etc`
- mkinitcpio.conf - settings for mkinitcpio

