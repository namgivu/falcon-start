#!/bin/bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SH="$s";  # get SH=executed script's path, containing folder, cd & pwd to get container path
DOCKER_TEST_HOME="$SH/.."

source "$DOCKER_TEST_HOME/config.sh"

# testee
method='PUT'; endpoint='customers/4'; params=`cat << EOF
dob='2011-11-11'
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
EXP_body ={"id": 4, "name": "Name04", "dob": "2011-11-11", "updated_at": "2019-08-15 07:08:01"}

# compare with the actual
status_code=$status_code
if status_code!=200:
    import sys; sys.exit(1)

body=$body
try:
    assert EXP_status == status_code
    assert EXP_body == body
    import sys; sys.exit(0)
except Exception as e:
    import sys; sys.exit(1)

EOF

has_error="$?"; if [[ $has_error == '0' ]]; then echo 'PASS'; else echo 'FAIL'; fi

# print testee
echo "$testee"      | xargs
echo "$status_code" | xargs
echo "$body"        | xargs
