```bash
# run api 
./docker/stoprm.sh ; ./docker/build.sh ; ./docker/run.sh 
    should_see='
        IMAGE                     PORTS                    NAMES
        namgivu/flask-start:2020  0.0.0.0:20730->5000/tcp  nn_flaskstart2020
    '

    # then can query api log
    http  :20730/grepapilog/                      # all log
    http ':20730/grepapilog/2020-07-30 15:59:37'  # filtered log
    #                       shellgrepalike regex
