# note: choose a pair of cuda/ubuntu versions that actually have a tag: https://hub.docker.com/r/nvidia/cuda/tags?page=1&name=base-ubuntu
ARG CUDA_VERSION=12.1.1
ARG UBUNTU_VERSION=22.04

FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu${UBUNTU_VERSION}

# install Python
ARG _PY_SUFFIX=3.10
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip3

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update
RUN apt-get install -y \
    ${PYTHON} python3-pip git libsndfile1

RUN ${PIP} --no-cache-dir install --upgrade pip setuptools

RUN ln -s $(which ${PYTHON}) /usr/local/bin/python

RUN mkdir -p /opt/colab

WORKDIR /opt/colab

RUN pip install jupyterlab jupyter_http_over_ws ipywidgets && \
    jupyter serverextension enable --py jupyter_http_over_ws && \
    jupyter nbextension enable --py widgetsnbextension

ARG COLAB_PORT=8888
EXPOSE ${COLAB_PORT}
ENV COLAB_PORT ${COLAB_PORT}

CMD jupyter notebook --log-level=DEBUG --NotebookApp.allow_origin='https://colab.research.google.com' --allow-root --port $COLAB_PORT --NotebookApp.port_retries=0 --ip 0.0.0.0 --no-browser

