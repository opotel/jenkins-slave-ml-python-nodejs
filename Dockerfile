FROM jenkins/ssh-slave

LABEL "org.label-schema.vendor"="OPOTEL Ltd" \
    version="1.0" \
    maintainer="dev@opotel.com" \
    description="Docker Jenkins Slave; Build, Test and Deploy Node.js + Python Machine Learning projects and build Docker images from Dockerfile"

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ARG PY_VER=3.7
ARG TENSORFLOW_VER=1.14
ARG KERAS_VER=2.2.4

RUN apt-get update && \
    apt-get upgrade -y

RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh && bash nodesource_setup.sh
RUN apt-get install -y wget git libhdf5-dev g++ graphviz nodejs
RUN curl -sSL https://get.docker.com/ | sh

RUN mkdir -p $CONDA_DIR && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet --output-document=anaconda.sh  https://repo.anaconda.com/archive/Anaconda2-2019.07-Linux-x86_64.sh && \
    /bin/bash /anaconda.sh -f -b -p $CONDA_DIR && \
    rm anaconda.sh


RUN mkdir -p $CONDA_DIR && \
    chown keras $CONDA_DIR -R && \
    mkdir -p /py_src && \
    chown keras /py_src

RUN conda install -y python=${PY_VER} && \
    pip install --upgrade pip && \
    pip install tensorflow==${TENSORFLOW_VER} && \
    pip install keras==${KERAS_VER} && \
    conda clean -yt




