A very simple RESTful API with Falcon framework code base
ref. https://falcon.readthedocs.io/en/stable/user/quickstart.html

# prerequisite
python --version  # should be 3.6.9 - you may need to install this with pyenv ref. bit.ly/nnpipenv
pipenv --version  # should be available - you may need to install pipenv ref. bit.ly/nnpipenv

# quick start 

## run test 
```bash
: you@your-machine:/path/to/git-cloned/ $
    # install packages
    pipenv --rm; pipenv sync
    
    # run test
    ./bin/run-test.sh
```

## run api directly
```bash
: you@your-machine:/path/to/git-cloned/ $
    # install packages
    pipenv --rm; pipenv sync
    
    # run api - log will be printed to your console; ctrl-C to stop
    ./bin/run-api.sh
```

## run api via docker
similar with run directly, but now we run the api as a docker container
```bash
: you@your-machine:/path/to/git-cloned/ $
    # run the api via docker-compose (recommended)
    ./bin/docker-compose-run-api.sh

    # run the api via docker run (NOT recommended)
    ./bin/docker-run-api.sh

    # view log of the running container - useful when operating  
    watch docker logs nn_falcon_start
```

## run endpoints (after api been run)
```bash
: you@your-machine $ # on 2nd console prompt, after having `run-api.sh` executed
    pipenv shell

    http :6000/something

    http :6000/health
    http :6000/health/

    http :6000/hi

    http :6000/hello/some_name  # with name
    http :6000/hello/           # without name

    http :6000/hola/some_name   # with name   
    http :6000/hola/            # without name
```
