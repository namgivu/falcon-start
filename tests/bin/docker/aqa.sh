#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s";# get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
TESTCASE_HOME="$SCRIPT_HOME/testcase"

# load config
source "$SCRIPT_HOME/config.sh"
source "$SCRIPT_HOME/util.color.sh"
source "$SCRIPT_HOME/util.func.sh"

# load testcase
tc_files=`find $TESTCASE_HOME  -type f  -name 'tc*.sh' `  # tc_files aka testcase_files

# run testcase
b_all=()  # b_all aka boolean_testcase_run_result_all
for tc_file in ${tc_files[@]}; do
    pass_or_fail=`eval $tc_file`
    b=`if [[ "$pass_or_fail" == "PASS" ]]; then echo "1"; else echo "0"; fi`  # b aka boolean_of_$pass_or_fail
    b_all+="$b "

    tc_name=`echo $tc_file | rev | cut -d'/' -f1 | rev | cut -d'.' -f1`
    printf "%-55s" "Running testcase $tc_name... "
    printf "$GR`printPF $b`$EC"; echo
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
