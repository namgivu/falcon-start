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
    ./bin/run-api.sh

    # run test
    ./bin/run-test.sh

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

# quick start - with docker
```bash
: you@your-machine:/path/to/git-cloned/ $
    # run the api 
    ./docker-run-api.sh

    # view log
    watch docker logs nn_falcon_start
```
