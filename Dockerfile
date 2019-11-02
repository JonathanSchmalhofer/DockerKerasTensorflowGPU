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

RUN pip install tensorflow-gpu

RUN apt-get update

ADD https://repo.continuum.io/miniconda/Miniconda3-4.4.10-Linux-x86_64.sh tmp/Miniconda3-4.4.10-Linux-x86_64.sh
RUN bash tmp/Miniconda3-4.4.10-Linux-x86_64.sh -b
ENV PATH $PATH:/root/miniconda3/bin/

COPY environment-gpu.yml  ./environment-gpu.yml
RUN conda env create -f=environment-gpu.yml --name keras-tensorflow-gpu --debug -v -v

# cleanup tarballs and downloaded package files
RUN conda clean -tp -y

# TensorBoard
EXPOSE 6006

COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]