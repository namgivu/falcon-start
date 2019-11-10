#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SH="$s";  # get SH=executed script's path, containing folder, cd & pwd to get container path
DOCKER_TEST_HOME="$SH/.."

source "$DOCKER_TEST_HOME/config.sh"

# testee
endpoint='customers'
method='POST'; endpoint='customers'; params=`cat << EOF
name='Trang' dob='2018-10-10'
EOF`
testee="$method :$API_PORT/$endpoint  $params"

# get actual
          r=`http --print=bh $testee`
status_code=`echo "$r" | head -n1 | cut -d ' ' -f2`
       body=`echo "$r" | tail -n1`

# get PASS / FAIL
#cat << EOF                     # use this when you want to debug below python code
python 1>/dev/null 2>&1 << EOF  # use this to run
# run multi-line python code in bash script ref. https://stackoverflow.com/a/40143212/12300953

# define expected values
EXP_status = 200
EXP_body ={"id": 6}

# compare with the actual
status_code=$status_code
if status_code!=200:
    print('FAIL')
    import sys; sys.exit(1)

body=$body
try:
    assert EXP_status == status_code
    assert EXP_body == body
    #TODO Trang more deeper assert for newly inserted row ref. https://github.com/namgivu/falcon-start/blob/gc-intern-1910/tests/controller/test_customer.py#L53
    import sys; sys.exit(0)
except Exception as e:
    import sys; sys.exit(1)

EOF

has_error="$?"; if [[ $has_error == '0' ]]; then echo 'PASS'; else echo 'FAIL'; fi

# print testee
echo "$testee"      | xargs
echo "$status_code" | xargs
echo "$body"        | xargs
