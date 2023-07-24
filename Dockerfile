FROM python:3.10-slim
    MAINTAINER William Oquendo <woquendo@gmail.com>
ARG CACHEBUST=0 # reset cache at this point, change to 1 to reset cache
USER root

# Fix timezone
ENV TZ=America/Bogota
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies for psutil
RUN apt-get update \
    && apt-get install -y gcc libffi-dev python3-dev

# From binder docs: Install jupyterlab and notebook
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab


# From binder docs: Setup user for binder
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# From binder docs: Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}


# Install c/c++ compilers and other dev utils
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    make \
    cmake \
    clang \
    libeigen3-dev \
    bat \
    emacs-nox \
    vim \
    gnuplot-nox \
    nano \
    git \
    htop \
    curl \
    unzip \
    sudo \
    links \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install additional packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    libssl-dev \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libhdf5-dev \
    libzmq3-dev \
    pkg-config \
    graphviz \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER ${NB_USER}
WORKDIR ${HOME}

# Install Python packages
RUN python3 -m pip install --user --no-cache-dir -r requirements.txt

# Run matplotlib config to generate the font cache
RUN MPLBACKEND=Agg python3 -c "import matplotlib.pyplot"

# Fix jupyter notebook
RUN pip install --upgrade notebook
