#!/usr/bin/env bash
# Prints colors to command line.
function colors() {
    local COLS=$(tput cols)
    local MESSAGE=${1:-"-Poopy"}
    local WIDTH=$(( ${#MESSAGE} + 4 )) # 3 for number length, 1 for a space.
    local COLN=$(($( python -c "print int(float(${COLS})/float($WIDTH))") - 1))
    local ROWN=$(($( python -c "print int(256./float($COLN))" ) ))
    for i in $(eval "echo {0..${ROWN}}"); do
        for j in $(eval "echo {0..${COLN}}"); do
            local c=$(( $i * $COLN + $j ))
            local str=$(printf "%.3d%s " $c $MESSAGE)
            eval 'echo -ne "\033[38;05;${c}m${str}\033[m"'
            [[ $c -ge 255 ]] && echo '' && return
        done
        echo ''
    done
    echo ''
}

colors $1
