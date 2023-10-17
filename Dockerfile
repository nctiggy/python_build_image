FROM python:3.12

RUN apt update && apt install -y --no-install-recommends \
            git && \
            pip install tox && \
            pip install pre-commit && \
            pip install pytest && \
            git config --global --add safe.directory '*' && \
            curl https://keybase.io/codecovsecurity/pgp_keys.asc | gpg --no-default-keyring --import && \\
            curl -Os https://uploader.codecov.io/latest/linux/codecov && \
            curl -Os https://uploader.codecov.io/latest/linux/codecov.SHA256SUM && \
            curl -Os https://uploader.codecov.io/latest/linux/codecov.SHA256SUM.sig && \
            gpg --verify codecov.SHA256SUM.sig codecov.SHA256SUM && \
            shasum -a 256 -c codecov.SHA256SUM && \
            chmod +x codecov && \
            mv codecov /usr/local/bin


RUN apt-get clean && \
            rm -rf /var/lib/apt/lists/* && \
            rm codecov.SHA256SUM && \
            rm codecov.SHA256SUM.sig

