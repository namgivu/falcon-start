#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SH="$s";  # get SH=executed script's path, containing folder, cd & pwd to get container path
DOCKER_TEST_HOME="$SH/.."

source "$DOCKER_TEST_HOME/config.sh"

# testee
method='GET'; endpoint='customers/1'
testee="$method :$API_PORT/$endpoint"

# get actual
status_code=`http --print=h  $testee | head -n1 | cut -d ' ' -f2`
       body=`http --print=b  $testee`

# get PASS / FAIL
python 1>/dev/null 2>&1 << EOF
# run multi-line python code in bash script ref. https://stackoverflow.com/a/40143212/12300953

# define expected values
EXP_status = 200
EXP_body ={"id": 1, "name": "Name01", "dob": "2018-01-02", "updated_at": "2019-08-12 04:05:01"}

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

has_error="$?"; if [[ $has_error == '1' ]]; then echo 'FAIL'; else echo 'PASS'; fi

# print testee
echo "$testee"      | xargs
echo "$status_code" | xargs
echo "$body"        | xargs
