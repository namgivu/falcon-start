# ubuntu 20.04 with python 3.8 w/ pipenv ref. https://github.com/namgivu/ubuntu-pipenv
FROM namgivu/ubuntu-pipenv:20.04-3.8

# set timezone ref. https://askubuntu.com/a/182536/22308
RUN ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime

WORKDIR /app
EXPOSE 5000

COPY ./Pipfile.lock ./
RUN pipenv sync

RUN echo 200730_x
COPY . .

CMD PYTHONPATH=`pwd`  pipenv run  gunicorn  -b 0.0.0.0:5000   src.app:api   --log-level debug   2>&1  | tee -a ./tmp/log
#   .                 .           .         serve at port     api instance  .                   store std+err stream to log file
