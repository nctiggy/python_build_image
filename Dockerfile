FROM python:3.11

RUN apt update && apt install -y --no-install-recommends \
            git && \
            pip install tox && \
            git config --global --add safe.directory '*'

RUN apt-get clean && \
            rm -rf /var/lib/apt/lists/*

