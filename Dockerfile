FROM jenkins/ssh-slave

LABEL "org.label-schema.vendor"="OPOTEL Ltd" \
    version="1.0" \
    maintainer="dev@opotel.com" \
    description="Docker Jenkins Slave; Build, Test and Deploy Node.js + Python Machine Learning projects and build Docker images from Dockerfile"

RUN apt-get update --fix-missing  && \
    apt-get upgrade -y && \
    apt-get install -y wget git libhdf5-dev g++ graphviz openssh-server bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 && \
    apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh && bash nodesource_setup.sh
RUN apt-get install -y wget git libhdf5-dev g++ graphviz nodejs
RUN curl -sSL https://get.docker.com/ | sh

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

RUN conda install -y python=3.7 && \
    pip install --upgrade pip && \
    pip install tensorflow==1.14 && \
    pip install keras==2.2.4



