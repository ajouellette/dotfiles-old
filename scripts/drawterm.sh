#!/usr/bin/env bash
# select a rectangle and launch a floating terminal
# needs slop

# specify terminal on cmd line (default urxvt)
term=${1:-urxvt}

REC=$(slop -t 0 -b 2 -c 1,1,1,1 -f "%w %h %x %y" ) || exit 1

IFS=' ' read -r W H X Y <<< "$REC"

aX=$(( $X - $M )) && aY=$(( $Y - $M ))
aW=$(( $W + ( $M * 2 ) )) && aH=$(( $H + ( $M * 2 ) ))

if [ "$W" -gt "1" ]; then
    # Calculate width and height to block/font size
    let W=$(( $W / 7 ))-2
    let H=$(( $H / 15 ))-1

    eval "$term --geometry $W\"x\"$H\"+\"$X\"+\"$Y -T \"floating (Terminal)\"" &
fi

exit 0
