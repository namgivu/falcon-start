#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SH="$s";  # get SH=executed script's path, containing folder, cd & pwd to get container path
DOCKER_TEST_HOME="$SH/../"

source "$DOCKER_TEST_HOME/config.sh"

# testcase arguments
method='PUT'; endpoint='customers/3'; params=`cat << EOF
name='Son'
EOF`

# get actual
status_code=`http --print=h  $method :$API_PORT/$endpoint  $params | head  -n1 | cut -d' ' -f2`
       body=`http --print=b  $method :$API_PORT/$endpoint  $params | head  -n1`


python 1>/dev/null 2>&1 << EOF
# run multi-line python code in bash script ref. https://stackoverflow.com/a/40143212/12300953

# define expected values
EXP_status = 200
EXP_body ={"id": 3, "name": "Son", "dob": "2018-03-04", "updated_at": "2019-08-14 06:07:01"}

# compare with the actual
status_code=$status_code
body=$body
try:
    assert EXP_status == status_code
    assert EXP_body == body
    print('PASS')
except:
    print('FAIL')

EOF

has_error="$?"; if [[ $has_error == '0' ]]; then echo 'PASS'; else echo 'FAIL'; fi
