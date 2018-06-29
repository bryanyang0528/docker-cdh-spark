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

### Option 1: docker

`docker build -t docker-cdh-spark:latest .`

`docker run --hostname=quickstart.cloudera --privileged=true -ti --rm docker-cdh-spark:latest /bin/bash`

### Option 2: docker compose (*recommend*)

`docker-compose build`

`docker-compose up -d`

`docker-compose exec docker-cdh-spark /bin/bash`

## Colab (If you do not have docker environment.)
* !apt-get install openjdk-8-jdk-headless -qq > /dev/null

* !pip install pyspark


