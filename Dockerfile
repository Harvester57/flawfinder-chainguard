# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:49a37f101ac0949a3a5dd5ca94bb93de9637aa001e2218ad51cad21062e01207 AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/flawfinder/venv/bin:$PATH"

WORKDIR /flawfinder
RUN python -m venv /flawfinder/venv

# Cf. https://pypi.org/project/flawfinder/
RUN pip install flawfinder==2.0.19

FROM chainguard/python:latest@sha256:f849a6e62a8f2d7d2a0231949fb92a5e70765ad3adb585410a3497b691d77e7b

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