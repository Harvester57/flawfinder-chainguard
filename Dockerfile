# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:2386eaddcd7d8ba5299b30043b9f3dc077ebe96342e39b9f6ac2c5da5f774e01

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
