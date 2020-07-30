#!/bin/bash
SH=`cd $(dirname $BASH_SOURCE) && pwd`
AH=`cd "$SH/.." && pwd`

docker build  --file "$SH/Dockerfile"  -t "namgivu/flask-start:2020"  $AH
#      .      Dockerfile path          image tag                      app source
