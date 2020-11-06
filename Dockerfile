FROM tensorflow/tensorflow:latest-gpu

WORKDIR /tmp

COPY omnizart ./omnizart
COPY scripts ./scripts
COPY Makefile ./
COPY pyproject.toml ./
COPY poetry.lock ./
COPY README.md ./

RUN apt-get update
RUN apt-get install libsndfile1 libgl1-mesa-glx --assume-yes
RUN scripts/install.sh

# Upgrade this for avoiding mysterious import module not found 'keyrings'
RUN pip install --upgrade keyrings.alt

WORKDIR /home
RUN mv /tmp/omnizart /usr/local/lib/python3.6/dist-packages
RUN rm -rf /tmp
COPY README.md ./
