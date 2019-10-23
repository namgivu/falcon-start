#region ubuntu 16.04 with python ref. https://gist.github.com/monkut/c4c07059444fd06f3f8661e13ccac619
FROM ubuntu:16.04

# install python 3.6.x
RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv

# make binary python linked to python3.6
RUN ln -s /usr/bin/python3.6 /usr/bin/python

# update pip
RUN python -m pip install pip --upgrade
RUN python -m pip install wheel

#endregion ubuntu 16.04 with python ref. https://gist.github.com/monkut/c4c07059444fd06f3f8661e13ccac619


#region install THIS_APP

# create THIS_APP folder
WORKDIR /app

# install pipenv
RUN python -m pip install pipenv

# copy pip packages
COPY ./Pipfile      .
COPY ./Pipfile.lock .

# .venv tag - change _a to new value to invalidate .venv/ and force a rerun
RUN echo 191020_b

# set utf8 to fix error > Click will abort further execution because Python 3 was configured to use ASCII as encoding for the environment  # ref. https://github.com/docker-library/python/issues/13#ref-pullrequest-164133459
ENV LANG=C.UTF-8

# install app packages
RUN pipenv --rm; \
    pipenv sync;

# bundle app source
COPY . .

# for documentation on port
EXPOSE 6000

# Default command when running container
#CMD ['/app/run-api.sh']
CMD tail -F `mktemp`
#endregion
