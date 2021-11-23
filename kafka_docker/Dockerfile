FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y openjdk-8-jdk-headless

COPY kafka_2.12-3.0.0 /kafka
WORKDIR /kafka
CMD ["bin/kafka-server-start.sh","config/server.properties"]
