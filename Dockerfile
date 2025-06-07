# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:105ab40fb09c89f1794a09e3a97dd53f56837f5ae2c59278841c3956c2ebfd38 AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/flawfinder/venv/bin:$PATH"

WORKDIR /flawfinder
RUN python -m venv /flawfinder/venv

# Cf. https://pypi.org/project/flawfinder/
RUN pip install flawfinder==2.0.19

FROM chainguard/python:latest@sha256:3814a4c4b3f1d2929007782bbc5cfcf0d7934986c07806d9952db0d3d9288d64

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