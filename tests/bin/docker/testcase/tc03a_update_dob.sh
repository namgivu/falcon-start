#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SH="$s";  # get SH=executed script's path, containing folder, cd & pwd to get container path
DOCKER_TEST_HOME="$SH/.."

source "$DOCKER_TEST_HOME/config.sh"

# testee
method='PUT'; endpoint='customers/4'; params=`cat << EOF
dob='2011-11-11'
EOF`
testee=" $method :$API_PORT/$endpoint  $params"

# get actual
status_code=`http --print=h $testee | head -n1 | cut -d' ' -f2`
       body=`http --print=b $testee`

# get PASS / FAIL
python 1>/dev/null 2>&1 << EOF
# run multi-line python code in bash script ref. https://stackoverflow.com/a/40143212/12300953

# define expected values
EXP_status = 200
EXP_body ={"id": 4, "name": "Name04", "dob": "2011-11-11", "updated_at": "2019-08-15 07:08:01"}

# compare with the actual
status_code=$status_code
if status_code!=200:
    print('FAIL')
    import sys; sys.exit(1)

body=$body
try:
    assert EXP_status == status_code
    assert EXP_body == body
    print('PASS')
except:
    print('FAIL')

EOF

has_error="$?"; if [[ $has_error == '0' ]]; then echo 'PASS'; else echo 'FAIL'; fi

# print testee
echo "$testee"      | xargs
echo "$status_code" | xargs
echo "$body"        | xargs
