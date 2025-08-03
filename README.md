# Flawfinder Docker Image (Chainguard Based)

This repository provides a Dockerfile to build a minimal and secure Docker image for **Flawfinder v2.0.19**. The image is built using Chainguard's Python base images, which are designed for a reduced attack surface and optimized performance.

Flawfinder is a program that examines C/C++ source code and reports possible security weaknesses ("flaws") sorted by risk level.

## Features

*   **Minimal & Secure**: Built on `chainguard/python:latest` for a significantly reduced footprint and attack surface.
*   **Specific Version**: Includes Flawfinder version `2.0.19`.
*   **Multi-stage Build**: Optimized for a small final image size by using a builder stage for compilation/installation.
*   **Non-Root Execution**: Leverages Chainguard's non-root default user for enhanced security.

## Image Details

Information extracted from the Dockerfile:

*   **Base Image**: `chainguard/python:latest` (Final stage)
*   **Flawfinder Version**: `2.0.19`
*   **Maintainer**: florian.stosse@gmail.com
*   **Last Update Label**: 2025-08-03
*   **Author**: Florian Stosse
*   **Description Label**: Flawfinder v2.0.19, built using Python Chainguard based image
*   **License Label (for Dockerfile)**: MIT license

## Build Instructions

To build the Docker image locally, navigate to the directory containing the `Dockerfile` and run:

```bash
docker build -t flawfinder-chainguard .
```

You can choose a different tag if you prefer, for example: `yourusername/flawfinder:2.0.19-chainguard`.

## How to Use

The `flawfinder` executable is installed and available in the container's `PATH`. To use it, you will typically mount your source code directory into the container and then specify this mounted directory as the target for Flawfinder.

Since the base `chainguard/python` image has `ENTRYPOINT ["python"]`, you need to specify `flawfinder` as the command to run.

### Basic Scan

To scan a local directory (e.g., `my_c_project` located in your current working directory):

```bash
# Ensure 'my_c_project' exists in your current directory
docker run --rm -v "$(pwd)/my_c_project:/scan" flawfinder-chainguard flawfinder /scan
```

*   `--rm`: Automatically removes the container when it exits.
*   `-v "$(pwd)/my_c_project:/scan"`: Mounts the local directory `my_c_project` (from your current working directory) to the `/scan` directory inside the container.
    *   **Windows Users (Command Prompt)**: You might need to use `%cd%` instead of `$(pwd)`:
        `docker run --rm -v "%cd%\my_c_project:/scan" flawfinder-chainguard flawfinder /scan`
    *   **Windows Users (PowerShell)**: You can use `$(Resolve-Path .)` or `${PWD}`:
        `docker run --rm -v "$(Resolve-Path .)/my_c_project:/scan" flawfinder-chainguard flawfinder /scan`

### Scanning Specific Files

You can also target specific files within the mounted directory:

```bash
docker run --rm -v "$(pwd)/my_c_project:/scan" flawfinder-chainguard flawfinder /scan/main.c /scan/utils.c
```

### Using Flawfinder Options

Pass any Flawfinder command-line options directly after the `flawfinder` command.

**Example: Generate an HTML report and save it to `flawfinder_report.html` in your current directory:**

```bash
docker run --rm -v "$(pwd)/my_c_project:/scan" flawfinder-chainguard flawfinder --html /scan > flawfinder_report.html
```

**Example: Set a minimum risk level (e.g., show flaws with risk level 4 and above):**

```bash
docker run --rm -v "$(pwd)/my_c_project:/scan" flawfinder-chainguard flawfinder --minlevel=4 /scan
```

### Getting Help

To see all available Flawfinder options:

```bash
docker run --rm flawfinder-chainguard flawfinder --help
```

## License

*   The Dockerfile in this repository is licensed under the MIT License (as per the `license` label in the Dockerfile).
*   Flawfinder itself is licensed under the GNU General Public License v2.0 or later (GPL-2.0-or-later).

## Contributing

Contributions, issues, and feature requests are welcome. Please feel free to check the issues page.
