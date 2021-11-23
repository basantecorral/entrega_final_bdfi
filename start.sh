#!/bin/bash
docker compose up -d
sleep 7
docker exec kafka_bdfi bin/kafka-topics.sh \
      --create \
      --bootstrap-server localhost:9092 \
      --replication-factor 1 \
      --partitions 1 \
      --topic flight_delay_classification_request

docker exec kafka_bdfi bin/kafka-topics.sh --bootstrap-server localhost:9092 --list

docker exec mongo_bdfi ./practica_big_data_2019/resources/import_distances.sh
echo "App is running: go to http://localhost:5000/flights/delays/predict_kafka to start the prediction"