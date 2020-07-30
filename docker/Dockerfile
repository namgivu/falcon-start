# ubuntu 20.04 with python 3.8 w/ pipenv ref. https://github.com/namgivu/ubuntu-pipenv
FROM namgivu/ubuntu-pipenv:20.04-3.8

WORKDIR /app
EXPOSE 5000

COPY ./Pipfile.lock ./
RUN pipenv sync

RUN echo 200730_x
COPY . .

CMD PYTHONPATH=`pwd`  pipenv run  gunicorn  -b 0.0.0.0:5000   src.app:api 2>&1  | tee -a ./tmp/log
