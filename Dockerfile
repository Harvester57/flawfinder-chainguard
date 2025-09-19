# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:36d6d83b9141616b1595ed179dc6a4bc6966e3c17142d461dedf72125791628a AS builder

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

FROM chainguard/python:latest@sha256:7a17326be63f9a7c4f1f7bda460e50c2123c18508afdbb6634e0f24085680425

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
