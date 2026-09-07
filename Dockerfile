# Cf. https://hub.docker.com/r/chainguard/python/
ARG BUILDKIT_SBOM_SCAN_STAGE=true
FROM chainguard/python:latest-dev@sha256:b626eb5bcedda38d96dc1415d2967c007d1ea95b2d72a682c3e5ccecd222641d AS builder

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

FROM chainguard/python:latest@sha256:1f37785e5cdb70151f36aaa15e1e3cef4571424dbefbf4b0d8a9222535cb13ff

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-08-03"
LABEL author="Florian Stosse"
LABEL description="Flawfinder v2.0.19, built using Python Chainguard based image"
LABEL license="MIT license"

WORKDIR /venv

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV TZ="Europe/Paris"
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /flawfinder/venv /venv

ENTRYPOINT [ "python3", "/venv/bin/flawfinder" ]
