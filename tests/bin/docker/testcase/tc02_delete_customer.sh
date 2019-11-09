#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SH="$s";  # get SH=executed script's path, containing folder, cd & pwd to get container path
DOCKER_TEST_HOME="$SH/../"

source "$DOCKER_TEST_HOME/config.sh"

# testcase arguments
method='DELETE'; endpoint='customers/2'

# get actual
status_code=`http --print=h $method :$API_PORT/$endpoint | head -n1 | cut -d ' ' -f2`
       body=`http --print=b $method :$API_PORT/$endpoint | head -n1`

python 1>/dev/null 2>&1 << EOF
# run multi-line python code in bash script ref. https://stackoverflow.com/a/40143212/12300953

# define expected values
EXP_status = 200
EXP_body ={"id": 2}

# compare with the actual
status_code=$status_code
body=$body
try:
    assert EXP_status == status_code
    assert EXP_body == body
    #TODO Trang more deeper assert ref. https://github.com/namgivu/falcon-start/blob/gc-intern-1910/tests/controller/test_customer.py#L88
    print('PASS')
except:
    print('FAIL')

EOF

has_error="$?"; if [[ $has_error == '0' ]]; then echo 'PASS'; else echo 'FAIL'; fi
