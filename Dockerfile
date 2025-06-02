# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:f2b953c1a251a4da0473a234f387c0cd75358ec5e2ef01daccfd87265ca9ef4b AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/flawfinder/venv/bin:$PATH"

WORKDIR /flawfinder
RUN python -m venv /flawfinder/venv

# Cf. https://pypi.org/project/flawfinder/
RUN pip install flawfinder==2.0.19

FROM chainguard/python:latest@sha256:333fdfd22fd214412c71b407a4d16d4e2aba41e5b34e683c81ecdb917f7d070a

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