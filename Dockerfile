# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:d8bacad8da41bec3b7fcff09837568c8de604c2fd761a0250d2af35119b1c328

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-05-21"
LABEL author="Florian Stosse"
LABEL description="Flawfinder v2.0.19, built using Python Chainguard based image"
LABEL license="MIT license"

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV TZ="Europe/Paris"

WORKDIR /flawfinder
COPY requirements.txt .
RUN python -m venv /flawfinder/venv
ENV PATH="/flawfinder/venv/bin:$PATH"

# Cf. https://pypi.org/project/flawfinder/
RUN pip install -r requirements.txt --no-cache-dir
RUN flawfinder

ENTRYPOINT [ "flawfinder" ]
