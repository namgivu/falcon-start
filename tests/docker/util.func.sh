#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd)
source "$s/util.color.sh"

function printPF() {  # printPF aka print_pass_or_fail ie 1-PASS, 2-FAIL
    one_or_zero=$1
    if [[ "$one_or_zero" == "1" ]]; then
        printf "${GR}PASS$EC";
    else
        printf "${ER}FAIL$EC";
    fi
}

