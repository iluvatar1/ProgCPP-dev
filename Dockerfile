FROM python:3.9-slim

# Install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc libffi-dev\
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache jupyterlab
#    pip install --no-cache notebook jupyterlab

# create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}



# FROM python:3.11-slim
# ENV HOME=/tmp

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     gcc libffi-dev\
#     && apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# RUN pip install --no-cache notebook jupyterlab

# # create user with a home directory
# ARG NB_USER=jovyan
# ARG NB_UID=1000
# ENV USER ${NB_USER}
# ENV NB_UID ${NB_UID}
# ENV HOME /home/${NB_USER}

# RUN adduser --disabled-password \
#     --gecos "Default user" \
#     --uid ${NB_UID} \
#     ${NB_USER}
# WORKDIR ${HOME}


# # See docs : https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
# FROM python:3.10-slim
#     MAINTAINER William Oquendo <woquendo@gmail.com>
# ARG CACHEBUST=0 # reset cache at this point, change to 1 to reset cache

# USER root

# # Install c/c++ compilers and other dev utils
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     gcc libffi-dev \
#     g++ \
#     make \
#     cmake \
#     clang \
#     libeigen3-dev \
#     bat \
#     emacs-nox \
#     vim \
#     gnuplot-nox \
#     nano \
#     git \
#     htop \
#     curl \
#     unzip \
#     sudo \
#     links \
#     libpq-dev \
#     libxml2-dev \
#     libxslt1-dev \
#     libffi-dev \
#     libssl-dev \
#     libblas-dev \
#     liblapack-dev \
#     libatlas-base-dev \
#     gfortran \
#     libfreetype6-dev \
#     libpng-dev \
#     libjpeg-dev \
#     libhdf5-dev \
#     libzmq3-dev \
#     pkg-config \
#     graphviz \
#     && apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# # From binder docs: Install jupyterlab and notebook
# RUN pip install --no-cache --upgrade pip && \
#     pip install --no-cache notebook jupyterlab

# # From binder docs: Setup user for binder
# ARG NB_USER=jovyan
# ARG NB_UID=1000
# ENV USER ${NB_USER}
# ENV NB_UID ${NB_UID}
# ENV HOME /home/${NB_USER}

# RUN adduser --disabled-password \
#     --gecos "Default user" \
#     --uid ${NB_UID} \
#     ${NB_USER}
# # From binder docs: Make sure the contents of our repo are in ${HOME}
# COPY . ${HOME}
# USER root
# RUN chown -R ${NB_UID} ${HOME}
# # Fix timezone
# ENV TZ=America/Bogota
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# # Install extra Python packages
# RUN python3 -m pip install --no-cache-dir -r ${HOME}/requirements.txt

# USER ${NB_USER}
# WORKDIR ${HOME}

# # Run matplotlib config to generate the font cache
# RUN MPLBACKEND=Agg python3 -c "import matplotlib.pyplot"

# ## Fix jupyter notebook
# #USER root
# RUN pip3 install --upgrade jupyterlab
