#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s";# get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
TESTCASE_HOME="$SCRIPT_HOME/testcase"

# load config
source "$SCRIPT_HOME/config.sh"
source "$SCRIPT_HOME/util.color.sh"
source "$SCRIPT_HOME/util.func.sh"

# load testcase
tc_files=`find $TESTCASE_HOME  -type f  -name 'tc*.sh' | sort`  # tc_files aka testcase_files

# run testcase
b_all=()  # b_all aka boolean_testcase_run_result_all
for tc_file in ${tc_files[@]}; do
    # run testcase aka tc
    tc_run=`eval $tc_file`
    pass_or_fail=`echo "$tc_run" | cut -d$'\n' -f1`  # cut by newline ref. https://stackoverflow.com/a/21757210/248616
          testee=`echo "$tc_run" | cut -d$'\n' -f2`

    tc_name=`echo $tc_file | rev | cut -d'/' -f1 | rev | cut -d'.' -f1`
    printf "%-55s" "Running testcase $tc_name... "

    # print pass/fail
    b=`if [[ "$pass_or_fail" == "PASS" ]]; then echo "1"; else echo "0"; fi`  # b aka boolean_of_$pass_or_fail
    b_all+="$b "
    printf "$GR`printPF $b`$EC"; echo

    # print testee
    if [[ ! -z $testee ]]; then echo "  $testee"; echo; fi
done

# test report
r=1
for b in ${b_all[@]}; do
    r=$(($r & $b))
done
echo -e "
---------------
aQA result $GR`printPF $r`$EC

"
