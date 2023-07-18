FROM python:3.11

RUN apt update && apt install -y --no-install-recommends \
            git && \
            pip install tox

RUN apt-get clean && \
            rm -rf /var/lib/apt/lists/*

