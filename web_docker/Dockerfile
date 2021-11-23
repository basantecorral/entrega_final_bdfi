FROM ubuntu:latest
COPY /practica_big_data_2019 /practica_big_data_2019

ENV PROJECT_HOME=/practica_big_data_2019

RUN apt-get update \
    && apt-get upgrade \
    && apt-get install -y curl software-properties-common apt-utils \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt install -y python3.7 python3-pip
WORKDIR /practica_big_data_2019
RUN pip install -r requirements.txt
CMD [ "python3","/practica_big_data_2019/resources/web/predict_flask.py" ]

