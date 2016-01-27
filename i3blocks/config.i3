# i3blocks config file for i3
#
# Please see man i3blocks for a complete reference!
# The man page is also hosted at http://vivien.github.io/i3blocks
#
# List of valid properties:
#
# align
# color
# command
# full_text
# instance
# interval
# label
# min_width
# name
# separator
# separator_block_width
# short_text
# signal
# urgent

# Global properties
#
# The top properties below are applied to every block, but can be overridden.
# Each block command defaults to the script name to avoid boilerplate.
command=~/.config/i3blocks/scripts/$BLOCK_NAME
markup=pango
separator_block_width=15
separator=false
align=center

# window title
[window]
command=xtitle -s | ~/.config/i3blocks/scripts/truncate.py
interval=persist

# Key indicators
#
# Add the following bindings to i3 config file:
#
# bindsym --release Caps_Lock exec pkill -SIGRTMIN+11 i3blocks
#[keyindicator]
#instance=CAPS
#interval=once
#signal=11

# Email
#
# Displays number of new emails
# mail icon \uF3EB
[email]
interval=120
min_width=M 10

# Backlight
#
# Display percent backlight use
[backlight]
label=
interval=once
signal=12

# Disk usage
#
# The directory defaults to $HOME if the instance is not specified.
# The script may be called with a optional argument to set the alert
# (defaults to 10 for 10%).
# disk icon \uF0A0
#[disk]
#label=
#interval=30

# CPU usage
#
# The script may be called with -w and -c switches to specify thresholds,
# see the script for details.
# gauge icon \uF38F
#[cpu_usage]
#label=
#interval=5
#min_width=C 100.0%

# Battery indicator
#
# The battery instance defaults to 0.
[battery]
interval=5
min_width=B 100%

# Temperature
#
# Support multiple chips, though lm-sensors.
# The script may be called with -w and -c switches to specify thresholds,
# see the script for details.
# thermometer icon \uF3B6
#[temperature]
#label=
#min_width=T 100dC
#interval=5

# Volume indicator
#
# The first parameter sets the step (and units to display)
# The second parameter overrides the mixer selection
# See the script for details.
# volume icon \uF027
[volume]
label=
min_width=V MUTE
instance=Master
interval=once
signal=10

# Date and time
# clock icon \uF36E, calendar icon \uF073
[date]
label=
command=date '+%a %b %d'
interval=3600

[time]
label=
command=date '+%I:%M %p'
interval=30

# vim: filetype=config
