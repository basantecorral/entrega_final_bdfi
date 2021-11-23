#!/bin/bash

#Elimina las imagenes del proyecto

cd flight_predictor_docker
rm -r -f practica_big_data_2019
cd ../web_docker
rm -r -f practica_big_data_2019

#docker image rm wurstmeister/zookeeper kafka_bdfi mongo:4.2.17 flight_predictor_bdfi web_bdfi

echo "Deleted images"