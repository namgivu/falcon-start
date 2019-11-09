#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SH="$s";  # get SH=executed script's path, containing folder, cd & pwd to get container path
DOCKER_TEST_HOME="$SH/../"

source "$DOCKER_TEST_HOME/config.sh"

# testcase arguments
method='GET'; endpoint='customers'

# get actual
status_code=`http --print=h $method ":$API_PORT/$endpoint" | head -n1 | cut -d ' ' -f2`
       body=`http --print=b $method ":$API_PORT/$endpoint" | head -n1`

python 1>/dev/null 2>&1 << EOF
# run multi-line python code in bash script ref. https://stackoverflow.com/a/40143212/12300953

# define expected values
EXP_status = 200
EXP_body=[
    {"id": 1, "name": "Name01", "dob": "2018-01-02", "updated_at": "2019-08-12 04:05:01"},
    {"id": 2, "name": "Name02", "dob": "2018-02-03", "updated_at": "2019-08-13 05:06:01"},
    {"id": 3, "name": "Name03", "dob": "2018-03-04", "updated_at": "2019-08-14 06:07:01"},
    {"id": 4, "name": "Name04", "dob": "2018-04-05", "updated_at": "2019-08-15 07:08:01"},
    {"id": 5, "name": "Name05", "dob": "2018-05-06", "updated_at": "2019-08-16 08:09:01"},
]

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
