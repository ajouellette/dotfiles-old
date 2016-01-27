# i3status configuration file.
# see "man i3status" for documentation.

# It is important that this file is edited as UTF-8.
# The following line should contain a sharp s:
# ß
# If the above line is not correctly displayed, fix your editor first!

general {
    output_format = "i3bar"
    colors = true
    interval = 3

    color_bad = "#cf6a4c"
    color_degraded = "#f9ee98"
    color_good = "#8f9d6a"

    separator = " | "
}

order += "disk /"
order += "cpu_usage"
order += "cpu_temperature 0"
#order += "wireless _first_"
order += "battery 0"
order += "volume master"
order += "tztime local"

wireless _first_ {
        format_up = "  %essid"
        format_down = " ---"
}

ethernet _first_ {
        # if you use %speed, i3status requires root privileges
        format_up = " %ip"
        format_down = " ---"
}

battery 0 {
        hide_seconds = true
        integer_battery_capacity = true
        low_threshold = 15
        threshold_type = "percentage"
        format = "%status %percentage %remaining"
        status_chr = "CHR"
        status_bat = "BAT"
        status_full = "FULL"
}

tztime local {
        format = "%a %d %b  %I:%M %p"
}

disk "/" {
        format = "%used/%total"
        threshold_type = "percentage"
        low_threshold = 10
}

cpu_usage {
    format = "CPU %usage"
}

volume master {
    format = "VOL %volume"
    format_muted = "MUT %volume"
    device = "default"
    mixer = "Master"
    mixer_idx = 0
}

cpu_temperature 0 {
    format = "TEMP %degrees°C"
    max_threshold = 65
}

