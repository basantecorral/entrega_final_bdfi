#!/bin/bash

#Creacion de imágenes a partir de los Dockerfile

docker build -t kafka_bdfi kafka_docker

cp -r practica_big_data_2019 flight_predictor_docker/
docker build -t flight_predictor_bdfi flight_predictor_docker

cp -r practica_big_data_2019 web_docker/
docker build -t web_bdfi web_docker

echo "Created Images"
docker images