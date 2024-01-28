FROM ubuntu:22.04

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV SPARK_HOME /opt/spark-3.5.0-bin-hadoop3
ENV PATH $PATH:$SPARK_HOME/bin

RUN apt update && apt full-upgrade -y

RUN apt install -y \
    openjdk-11-jdk \
    python3 python3-pip \
    wget 

RUN wget -q https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz && \
    tar -xf spark-3.5.0-bin-hadoop3.tgz -C /opt/ && \
    rm spark-3.5.0-bin-hadoop3.tgz

RUN pip3 install notebook pyspark matplotlib

WORKDIR /app

COPY . .

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root"]