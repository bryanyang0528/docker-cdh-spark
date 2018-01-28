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
   curl -O http://search.maven.org/remotecontent?filepath=org/apache/spark/spark-streaming-kafka-0-10-assembly_2.11/2.2.1/spark-streaming-kafka-0-10-assembly_2.11-2.2.1.jar

## update python
RUN yum -y install python36u python36u-pip &&\
    yum clean all

## install python packages
RUN pip3.6 install ipython jupyter virtualenv

## ssh
RUN ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys

EXPOSE 4040 8080 8081 8888 18080

COPY bootstrap/docker-quickstart /etc/profile.d/zz_docker-quickstart.sh
COPY bootstrap/spark.sh /etc/profile.d/spark.sh
COPY bootstrap/0_pyspark.py .
