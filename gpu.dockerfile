FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -yqq --no-install-recommends software-properties-common \
  && add-apt-repository ppa:deadsnakes/ppa \
  && apt-get update \
  && apt-get install -y --no-install-recommends python3.12 python3-pip

RUN apt-get update -qq \
  && apt-get install -yqq \
  git \
  gcc \
  graphviz \
  graphviz-dev

RUN pip install -U pip

WORKDIR /assignment

COPY ./requirements-gpu.txt .
RUN pip install --no-cache-dir -r requirements-gpu.txt
RUN rm ./requirements-gpu.txt

ENTRYPOINT ["jupyter", "lab", "--allow-root", "--no-browser", "--ip=0.0.0.0", "--notebook-dir", "/assignment"]
