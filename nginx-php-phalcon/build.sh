#!/bin/sh

# enviroment
export $(cat .env)
# default parameter
FORCE=false
DOCKER_NAME=$DOCKER_NAME

# parsing parameter
while [ "$1" != "" ]; do
  if [ $1 == "-f" ]; then 
    FORCE=true
  fi
  shift
done

# if any exist docker container then stop it
if docker ps -a | grep $DOCKER_NAME | grep Up; then
  docker stop $DOCKER_NAME
fi

# if any exists docker container then remove it
if docker ps -a | grep $DOCKER_NAME; then
  docker rm $DOCKER_NAME
fi

# docker image exists and force then remove existing image
if docker images | grep rcl/$DOCKER_NAME && $FORCE; then
  docker rmi rcl/$DOCKER_NAME
fi

# not docker image exists or force then build docker
if ! docker images | grep rcl/$DOCKER_NAME || $FORCE; then
  docker build -t rcl/$DOCKER_NAME .
fi

docker run -tid -p $PORT:80 --name $DOCKER_NAME rcl/$DOCKER_NAME