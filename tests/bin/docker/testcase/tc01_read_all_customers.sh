#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SH="$s";  # get SH=executed script's path, containing folder, cd & pwd to get container path
DOCKER_TEST_HOME="$SH/.."

source "$DOCKER_TEST_HOME/config.sh"

# testee
method='GET'; endpoint='customers'
testee="$method :$API_PORT/$endpoint"

# get actual
status_code=`http --print=h $testee | head -n1 | cut -d ' ' -f2`
       body=`http --print=b $testee`

# get PASS / FAIL
#cat << EOF                     # use this when you want to debug below python code
python 1>/dev/null 2>&1 << EOF  # use this to run
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
if status_code!=200:
    import sys; sys.exit(1)

body=$body
try:
    assert EXP_status == status_code
    assert EXP_body == body
    import sys; sys.exit(0)
except:
    import sys; sys.exit(1)

EOF

has_error="$?"; if [[ $has_error == '0' ]]; then echo 'PASS'; else echo 'FAIL'; fi

# print testee
echo "$testee"      | xargs
echo "$status_code" | xargs
echo "$body"        | xargs
