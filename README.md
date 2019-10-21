A very simple RESTful API with Falcon framework code base
ref. https://falcon.readthedocs.io/en/stable/user/quickstart.html

# prerequisite
python --version  # should be 3.6.9 - you may need to install this with pyenv ref. bit.ly/nnpipenv
pipenv --version  # should be available - you may need to install pipenv ref. bit.ly/nnpipenv

# quick start
```
: you@your-machine:/path/to/git-cloned/
pipenv sync
PORT=8000; pipenv run  gunicorn  app:api                        -b "0.0.0.0:$PORT"  --reload                          
                                 #path to falcon api instance   #bind to address    #auto reload api if code changed
```
