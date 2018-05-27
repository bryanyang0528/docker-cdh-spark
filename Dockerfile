FROM cloudera/quickstart:latest

WORKDIR /workspace
ENV SPARK_HOME=/workspace/spark

## update java and install spark
RUN yum -y install java-1.8.0-openjdk openssh-server kafka kafka-server || true &&\
    yum -y groupinstall development || true &&\
    yum -y install https://centos6.iuscommunity.org/ius-release.rpm java-1.8.0-openjdk || true &&\
    curl -O http://ftp.tc.edu.tw/pub/Apache/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz &&\
    tar zxvf spark-2.2.1-bin-hadoop2.7.tgz && mv spark-2.2.1-bin-hadoop2.7 spark &&\
    cd spark &&\ 
    rm -rf conf &&\
    ln -s /usr/lib/spark/conf conf &&\
    ln -s /usr/lib/hadoop/etc/hadoop/core-site.xml conf/ &&\
    ln -s /usr/lib/hive/conf/hive-site.xml conf/

RUN cd ${SPARK_HOME}/jars/ &&\
    curl -O http://central.maven.org/maven2/org/apache/kafka/kafka-clients/1.0.0/kafka-clients-1.0.0.jar &&\
    curl -O http://central.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_2.11/2.2.0/spark-sql-kafka-0-10_2.11-2.2.0.jar &&\ 
    curl -O http://central.maven.org/maven2/org/apache/spark/spark-streaming-kafka-0-8-assembly_2.11/2.2.0/spark-streaming-kafka-0-8-assembly_2.11-2.2.0.jar &&\
    curl -O http://central.maven.org/maven2/org/apache/spark/spark-streaming-kafka-0-8_2.11/2.2.0/spark-streaming-kafka-0-8_2.11-2.2.0.jar
## update python
RUN curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh &&\
    chmod +x Miniconda3-latest-Linux-x86_64.sh &&\
    ./Miniconda3-latest-Linux-x86_64.sh -b -p ~/miniconda3 &&\
    echo "export PATH=${HOME}/miniconda3/bin:${PATH}" >> ~/.bash_profile


## install python packages
RUN ~/miniconda3/bin/conda install ipython jupyter virtualenv

## ssh
RUN ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys

EXPOSE 4040 8080 8081 8888 18080

COPY bootstrap/docker-quickstart /etc/profile.d/zz_docker-quickstart.sh
COPY bootstrap/spark.sh /etc/profile.d/spark.sh
COPY bootstrap/0_pyspark.py .
