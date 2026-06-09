FROM nvidia/cuda:12.8.1-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    libfftw3-dev \
    openmpi-bin \
    libopenmpi-dev \
    python3 \
    python3-pip \
    vim \
    nano

WORKDIR /opt

RUN wget https://ftp.gromacs.org/gromacs/gromacs-2025.2.tar.gz

RUN tar -xzf gromacs-2025.2.tar.gz

WORKDIR /opt/gromacs-2025.2

RUN mkdir build

WORKDIR /opt/gromacs-2025.2/build

RUN cmake .. \
    -DGMX_BUILD_OWN_FFTW=ON \
    -DGMX_MPI=ON \
    -DGMX_GPU=CUDA \
    -DGMX_SIMD=AVX2_256 \
    -DCMAKE_INSTALL_PREFIX=/usr/local/gromacs

RUN make -j4
RUN make install

RUN echo "source /usr/local/gromacs/bin/GMXRC" \
>> /etc/bash.bashrc

RUN ln -s \
/usr/local/gromacs/bin/gmx_mpi \
/usr/local/gromacs/bin/gmx
