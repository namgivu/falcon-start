A very simple RESTful API with Falcon framework code base
ref. https://falcon.readthedocs.io/en/stable/user/quickstart.html

# prerequisite
python --version  # should be 3.6.9 - you may need to install this with pyenv ref. bit.ly/nnpipenv
pipenv --version  # should be available - you may need to install pipenv ref. bit.ly/nnpipenv

# quick start - direct run 
```bash
: you@your-machine:/path/to/git-cloned/ $
    # install packages
    pipenv --rm; pipenv sync
    
    # run api
    ./run-api.sh

    # run test
    ./run-test.sh

: you@your-machine $ # on 2nd console prompt, after having `run-api.sh` executed
    http :6000/something

    http :6000/health
    http :6000/hi
```

# quick start - with docker
```bash
: you@your-machine:/path/to/git-cloned/ $
    # run the api 
    ./docker-run-api.sh

    # view log
    watch docker logs nn_falcon_start
```

#TODO quick start - with docker-compose
```bash
: you@your-machine:/path/to/git-cloned/ $
    # run container from the built image namgivu/falcon_start
                              docker-compose up  -d --force-recreate  # start api at default port ie 6000
    PORT_nn_falcon_start=6666 docker-compose up  -d --force-recreate  # start api at custom  port eg 6666 here

    # aftermath check
    docker ps | grep -E 'falcon_start|IMAGE'


    # stop the container ie stop the api app
    cn='nn_falcon_start'; docker stop $cn && docker rm $cn  # cn aka CONTAINER_NAME
```