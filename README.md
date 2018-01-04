# docker-cdh-spark

The version of Spark in the original Cloudera image is still 1.6.1.

This image upgrade it to 2.2 by hacking methods, so I CAN NOT promise 100% compatible with the original CDH.

## Prerequisite

### install docker

OSX: [https://docs.docker.com/docker-for-mac/install/](https://docs.docker.com/docker-for-mac/install/)

Others: [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/)

### install docker-compose

[https://docs.docker.com/compose/install/#install-compose](https://docs.docker.com/compose/install/#install-compose)

## Usage

### clone this repo

`git clone https://github.com/bryanyang0528/docker-cdh-spark`

`cd docker-cdh-spark`

### docker

`docker build -t cdh-spark:2.2 .`

`docker run --hostname=quickstart.cloudera --privileged=true -ti --rm cdh-spark:2.2 /bin/bash`

### docker compose (*recommend*)

`docker-compose build`

`docker-compose up -d`

`docker-compose exec cdh-spark /bin/bash`


