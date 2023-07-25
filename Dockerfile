# See docs : https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
FROM python:3.11-slim
    MAINTAINER William Oquendo <woquendo@gmail.com>
#ARG CACHEBUST=0 # reset cache at this point, change to 1 to reset cache

# Install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc libffi-dev\
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
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Fix timezone
ENV TZ=America/Bogota
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --shell /bin/bash \
    --uid ${NB_UID} \
    ${NB_USER}

# Copy only the requirements file first
COPY requirements.txt ${HOME}/

# Copy the rest of the files
COPY . ${HOME}

# Set ownership of files
USER root
RUN chown -R ${NB_UID} ${HOME}

# install the notebook package
#RUN pip install --no-cache --upgrade pip && \
#    pip install --no-cache jupyterlab
RUN pip install --upgrade pip && \
    pip install jupyterlab

# Install extra Python packages
RUN python3 -m pip install --no-cache-dir -r ${HOME}/requirements.txt

# Insall starship to show git branch in prompt plus some other stuff
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# Set the SHELL environment variable to /bin/bash
ENV SHELL=/bin/bash

WORKDIR ${HOME}
USER ${USER}

# Run matplotlib config to generate the font cache
RUN MPLBACKEND=Agg python3 -c "import matplotlib.pyplot"
# Setup starship
RUN echo 'eval "$(starship init bash)"' >> ${HOME}/.bashrc

WORKDIR ${HOME}
USER ${USER}
