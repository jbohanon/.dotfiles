# Requires https://github.com/caarlos0/timer
# Requires spd-say

declare -A pomo_options
pomo_options["work"]="45"
pomo_options["break"]="10"

pomodoro () {
    if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
        val=$1
        echo $val
        timer ${pomo_options["$val"]}m
        spd-say "'$val' session done"
    fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"
