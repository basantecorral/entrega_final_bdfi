# Práctica final BDFI

**Alumnos:** Álvaro Basante Corral y Raphaël Benoit

## Para desplegar la práctica en local:

Este despliegue en local se ha realizado en MacOs y para estas instrucciones se supone que Java, Python3, pip, sbt, MongoDB y scala están ya instalados.

***Clonar el repositorio***
> git clone https://github.com/ging/practica_big_data_2019.git
> cd practica_big_data_2019

***Descargar los datos***
>resources/download_data.sh

***Descargar kafka***
>wget "https://dlcdn.apache.org/kafka/3.0.0/kafka_2.12-3.0.0.tgz"
>tar -xvzf kafka_2.12-3.0.0.tgz

***Descargar spark***
> wget "https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz"
> tar -xvzf spark-3.1.2-bin-hadoop3.2.tgz

***Descargar Zookeeper***
>wget "https://dlcdn.apache.org/zookeeper/zookeeper-3.6.3/apache-zookeeper-3.6.3-bin.tar.gz"
>tar -xvzf apache-zookeeper-3.6.3-bin.tar.gz

***Instalar librerías de python***
> pip install -r requirements.txt

***Iniciar Zookeeper***
Ir al directorio de kafka y ejecutar:
>bin/zookeeper-server-start.sh config/zookeeper.properties

***Iniciar Kafka***
Ir al directorio de kafka y ejecutar:
>  bin/kafka-server-start.sh config/server.properties

Crear un topic:
>bin/kafka-topics.sh \
>--create \
> --bootstrap-server localhost:9092 \
> --replication-factor 1 \
>--partitions 1 \
>--topic flight_delay_classification_request

***Importar distancias a MongoDB***
>./resources/import_distances.sh

***Entrenar el modelo***
Configurar la variable de entorno JAVA_HOME
>  export JAVA_HOME=/usr/local/opt/openjdk@8

Configurar la variable de entorno SPARK_HOME
> export SPARK_HOME=/Users/alvarobc/bdfi_final/practica_big_data_2019/spark-3.1.2-bin-hadoop3.2

Ejecutar el script de entrenamiento
>python3 resources/train_spark_mllib_model.py .

***Ejecutar Flight Predictor***
Cambiar base_path en MakePrediction scala class
>val base_path= "/Users/alvarobc/bdfi_final/practica_big_data_2019"

## Mejora 1: Utilización de Spark-submit para ejecutar el modelo

>./spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master local --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /Users/alvarobc/bdfi_final/practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar

***Ejecutar el servidor web***
Configar la variable de entorno PROJECT_HOME
>export PROJECT_HOME=/Users/alvarobc/bdfi_final/practica_big_data_2019

Ejecutar el servidor
>python3 resources/web/predict_flask.py

La aplicación está disponible en http://localhost:5000/flights/delays/predict_kafka

## Mejora 2: Dockerización de los servicios y Docker Compose

Se han dockerizado los distintos servicios que componen la aplicación.
Para zookeeper y mongodb se han utilizado imágenes ya desarrolladas:
>zookeeper: https://hub.docker.com/r/wurstmeister/zookeeper
>mongodb: https://hub.docker.com/_/mongo

Se ha contruido una imagen para kafka, otra para la predicción de vuelos y otra para el servidor web, y se ha desarrollado un docker-compose.yml para su despliegue.

Adicionalmente, se han desarrollado unos scripts que facilitan su despliegue

***Crear el escenario***

Crea las imágenes a partir de los Dockerfile
>./create.sh

***Para arrancar la aplicación***
>./start.sh

***Parar la aplicación***
>./stop.sh

***Eliminar el escenario***
Elimina las imágenes creadas
>./delete.sh







