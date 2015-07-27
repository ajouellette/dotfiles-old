#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is mostly copied from:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.py
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
#

import sys
import json
import os

"""
    Functions to get system info
"""
def get_governor():
    """ Get the current governor for cpu0, assuming all CPUs use the same. """
    with open('/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor') as fp:
        return fp.readlines()[0].strip()

def get_kernel():
    return os.uname()[0] + " " + os.uname()[2]

def get_brightness():
    """ Get the current screen brightness as a percent. This will not work on all systems. """
    with open('/sys/class/backlight/intel_backlight/brightness') as br:
        brightness = br.readlines()[0].strip()
    with open('/sys/class/backlight/intel_backlight/max_brightness') as mx:
        maximum = mx.readlines()[0].strip()
    return int(int(brightness)*100/int(maximum))

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # display brightness as a percentage
        j.insert(0, {'full_text' : ' %s%%' % get_brightness(), 'name' : 'bright'})
        # kernel version
        #j.insert(0, {'full_text' : ' %s' % get_kernel(), 'name' : 'kernel'})
        # and echo back new encoded json
        print_line(prefix+json.dumps(j))
