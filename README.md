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
in brief
```bash
# refresh image and run it
./bin/docker/docker-build.sh ; ./bin/docker/docker-compose-up.sh 

# stop the api container
./bin/docker/stop-api.sh
```

similar with run directly, but now we run the api as a docker container
```bash
: you@your-machine:/path/to/git-cloned/ $
    # build the docker image for this api app i.e. local image namgivu/falcon_start
    ./bin/docker-build.sh

    # run the api as container via docker-compose (recommended) - require local image namgivu/falcon_start
    ./bin/docker-compose-up.sh

    # run the api as container via docker run (NOT recommended) - require local image namgivu/falcon_start
    ./bin/docker-run.sh

    # view log of the running container - useful when monitor/debug the running api  
    $ docker logs -t -f nn_falcon_start

    # stop the api container
    ./bin/docker/stop-api.sh
```

## run endpoints (after api been run)

no data endpoints
```bash
: you@your-machine $ # on 2nd console prompt, after having `run-api.sh` executed
    pipenv shell

    http :8000/something

    http :8000/health
    http :8000/health/

    http :8000/hi

    http :8000/hello/some_name  # with name
    http :8000/hello/           # without name

    http :8000/hola/some_name   # with name   
    http :8000/hola/            # without name
```

with data+json endpoints
```bash
# GET customers
http :8888/customers

# GET customers/:id
http :8888/customers/1

# POST customers
curl -X POST localhost:8888/customers -d '{"name": "nnn", "dob": "1999-11-22"}' -H 'Content-Type: application/json'

# PUT customers/:id
curl -X PUT localhost:8888/customers/1 -d '{"name": "uuu"}' -H 'Content-Type: application/json'

```
