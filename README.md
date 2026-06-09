# GROMACS GPU Docker Image

CUDA-enabled GROMACS 2025.x Docker image built from source.

## Features

* GROMACS 2025.x
* CUDA support
* OpenMPI support
* FFTW support

## Build

```bash
docker build -t gromacs-gpu:v1 .
```

## Run

```bash
docker run -it --gpus all gromacs-gpu:v1
```

## Verify

```bash
gmx --version
```
