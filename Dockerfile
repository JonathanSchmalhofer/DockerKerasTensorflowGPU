FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    git \
    software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.7 \
    python-pip \
    python-setuptools

RUN pip install --upgrade pip

RUN pip install tensorflow-gpu==1.8.0

RUN apt-get update