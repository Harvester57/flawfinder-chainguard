# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:6d464044cd4e56e31cfd29899dcc119eb87c3f806283194388f1c75bdaeca6fd AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/flawfinder/venv/bin:$PATH"

WORKDIR /flawfinder
RUN python -m venv /flawfinder/venv

# Cf. https://pypi.org/project/flawfinder/
RUN pip install flawfinder==2.0.19

FROM chainguard/python:latest@sha256:118cb4e86dd4277423720b67003cccea887a1fc6c99007466492c2119bc4d60a

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