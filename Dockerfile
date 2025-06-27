# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:d447718eb6e6ab2f0f4c9bd41e7559e3f6a67a66536dec6b103239c8beb04ceb AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/flawfinder/venv/bin:$PATH"

WORKDIR /flawfinder
RUN python -m venv /flawfinder/venv

# Cf. https://pypi.org/project/flawfinder/
RUN pip install flawfinder==2.0.19

FROM chainguard/python:latest@sha256:9ae93505cca87c6ea679ef7b1c61ec33a86e89329067c059d54e8a585313098e

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-05-21"
LABEL author="Florian Stosse"
LABEL description="Flawfinder v2.0.19, built using Python Chainguard based image"
LABEL license="MIT license"

ENV TZ="Europe/Paris"

WORKDIR /flawfinder

ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /flawfinder/venv /venv