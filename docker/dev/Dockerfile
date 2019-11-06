FROM python:3.8
USER root

RUN apt-get update
RUN apt-get install -y vim less
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install matplotlib
RUN apt-get install -y libx11-dev
RUN export DISPLAY=host.docker.internal:0.0
