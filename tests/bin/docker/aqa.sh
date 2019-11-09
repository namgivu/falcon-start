#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s";# get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
TESTCASE_HOME="$SCRIPT_HOME/testcase"

# load config
source "$SCRIPT_HOME/config.sh"
source "$SCRIPT_HOME/util.color.sh"

# load testcase
tc_files=`find $TESTCASE_HOME  -type f  -name 'tc*.sh' `  # tc_files aka testcase_files

# run testcase
r_all=()  # r aka tc_run_result_all
for tc_file in ${tc_files[@]}; do
    tc_name=`echo $tc_file | rev | cut -d'/' -f1 | rev | cut -d'.' -f1`
    pass_or_fail=`eval $tc_file`

    b=`if [[ "$pass_or_fail" == "PASS" ]]; then echo "1"; else echo "0"; fi`  # b aka boolean_of_$pass_or_fail
    r_all+=$b


    printf "%-55s" "Running testcase $tc_name... "
    printf "$GR$pass_or_fail$EC"; echo
done

echo "${r_all[@]}"
exit

# test report
  testcase='Summary Ticket Result'
  summary_result=$(($testcase2a & $testcase2b & $testcase2c & $testcase3 & $testcase4 & testcase6a & testcase6b & testcase6c1 & testcase6c2))
  ticket_result=`if [[ "$summary_result" == "1" ]]; then echo "PASS"; else echo 'FAIL'; fi`; echo "$testcase $ticket_result"

