#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
TESTCASE_HOME="$SCRIPT_HOME/testcase"

docstring="

# get docker-compose up
cd /path/to/falcon-start/
    ./bin/docker/docker-build.sh
    ./bin/docker/docker-compose-up.sh

# after docker-compose is up
    bash prompt 01 - monitor psql
    docker logs -t -f nn_falcon_start_postgres

    bash prompt 02 - monitor api
    docker logs -t -f nn_falcon_start

    bash prompt 03 - monitor db rows
    watch http --print=b GET :8888/customers

    bash prompt 04 - run aQA aka automation QA on the api endpoints
    : /path/to/falcon-start /tests/bin/docker
    ./aqa.sh
"

if [[ ! -f "$SCRIPT_HOME/config.sh" ]]; then echo "File not found config.sh"; exit; fi

# load config
source "$SCRIPT_HOME/config.sh"
source "$SCRIPT_HOME/util.color.sh"
source "$SCRIPT_HOME/util.func.sh"

# load testcase
select_testcase='tcXYX*.sh'  # select tcXYZ
select_testcase='tc01*.sh'   # select tc01
select_testcase='tc*.sh'     # select all tc

tc_files=`find $TESTCASE_HOME  -type f  -name $select_testcase | sort`  # tc_files aka testcase_files


# run testcase
b_all=()  # b_all aka boolean_testcase_run_result_all
for tc_file in ${tc_files[@]}; do
    # reset test fixture
    "$SCRIPT_HOME/reset_db.sh"
    s=3; echo "Sleep $s seconds to get db ready..."; sleep $s

    # run testcase aka tc
    tc_run=`eval $tc_file`
    pass_or_fail=`echo "$tc_run" | cut -d$'\n' -f1`  # cut by newline ref. https://stackoverflow.com/a/21757210/248616
          testee=`echo "$tc_run" | cut -d$'\n' -f2`

    tc_name=`echo $tc_file | rev | cut -d'/' -f1 | rev | cut -d'.' -f1`
    echo; printf "%-55s" "Running testcase $tc_name... "

    # print pass/fail
    b=`if [[ "$pass_or_fail" == "PASS" ]]; then echo "1"; else echo "0"; fi`  # b aka boolean_of_$pass_or_fail
    b_all+="$b "
    printf "$GR`printPF $b`$EC"; echo

    # print testee
    if [[ ! -z $testee ]]; then echo "$testee"; echo; fi

    # rerun again to get verbose output  #TODO add verbose param
    echo "[VERBOSE DEBUG]"; eval $tc_file
    if [[ $pass_or_fail == 'FAIL' ]]; then
        echo "
More error detail by below command
docker logs $API_CONTAINER 2>&1 | grep -iE 'error' -A6
"
    fi
done

# test report
r=1
for b in ${b_all[@]}; do
    r=$(($r & $b))
done

echo -e "
---------------
aQA result $GR`printPF $r`$EC  ${b_all[@]}
"
