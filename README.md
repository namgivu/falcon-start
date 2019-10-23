Install pyenv, pipenv ref. bit.ly/nnpipenv

# set up python binary
pyenv install 3.7.5
pyenv local 3.7.5
cat .python-version 

# set up .venv/
pipenv install

# build api using Falcon
ref. https://falconframework.org/
ref. https://falcon.readthedocs.io/en/stable/

pipenv install falcon

create /hello endpoint 

run it
```bash
gunicorn src.app:api
```