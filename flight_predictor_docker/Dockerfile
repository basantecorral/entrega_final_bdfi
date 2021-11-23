FROM ubuntu:latest
COPY /practica_big_data_2019 /practica_big_data_2019

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV SPARK_HOME=/spark/spark-3.1.2-bin-hadoop3.2

RUN apt-get update \
    && apt-get upgrade \
    && apt-get install -y git curl python3 python3-pip openjdk-8-jdk-headless wget apt-utils apt-transport-https curl gnupg -yqq \
    && echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list \
    && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import \
    && chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg \
    && apt-get update \
    && apt-get install sbt \
    && wget "https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz" -O spark-3.1.2-bin-hadoop3.2.tgz \
    && mkdir spark \
    && tar -xzvf spark-3.1.2-bin-hadoop3.2.tgz -C spark 

WORKDIR /practica_big_data_2019
RUN pip install -r requirements.txt
# && python3 resources/train_spark_mllib_model.py .
WORKDIR /practica_big_data_2019/flight_prediction
RUN sbt compile \
    && sbt package
COPY start.sh .

#CMD ["/spark/spark-3.1.2-bin-hadoop3.2/bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master local --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar"]
#CMD ["/spark/spark-3.1.2-bin-hadoop3.2/bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction","--master local", "--packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar"]
CMD [ "./start.sh"]