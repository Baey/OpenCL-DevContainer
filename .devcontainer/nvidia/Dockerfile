# Bazowy obraz z NVIDIA CUDA
FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

# Instalacja podstawowych narzędzi i zależności
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    gpg-agent\
    gnupg2 \
    lsb-release \
    software-properties-common \
    apt-utils \
    dialog \
    iproute2 \
    procps \
    git \
    cmake \
    cppcheck

# Instalacja bibliotek OpenCL i LLVM
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && add-apt-repository "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main" \
    && apt-get update
    
RUN apt-get install -y \
    ocl-icd-libopencl1\
    libclang-17-dev \
    clang-17\
    llvm-17 \
    make \
    ninja-build \
    ocl-icd-dev \
    ocl-icd-opencl-dev \
    libhwloc-dev \
    zlib1g \
    zlib1g-dev \
    dialog \
    libxml2-dev \
    libclang-cpp17-dev \
    libclang-cpp17 \
    llvm-17-dev \
    pocl-opencl-icd \
    opencl-headers \
    clinfo

# Ustawienie repozytorium Intel oneAPI
RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list \
    && apt-get update

# Instalacja Intel oneAPI Base Toolkit i HPC Toolkit
RUN apt-get install -y intel-basekit intel-hpckit

# Ustawienie ścieżki do bibliotek oneAPI
ENV PATH=/opt/intel/oneapi/compiler/latest/linux/bin/intel64:/opt/intel/oneapi/opencl/latest/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin:/opt/intel/oneapi/opencl/latest/lib:$LD_LIBRARY_PATH

# Instalacja Intel Graphics Compute Runtime for oneAPI Level Zero
RUN wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg \
    && echo 'deb [arch=amd64,i386 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/graphics/ubuntu jammy arc' | tee  /etc/apt/sources.list.d/intel.gpu.jammy.list \
    && apt-get update

RUN apt-get install -y intel-opencl-icd intel-level-zero-gpu level-zero

RUN wget -qO - https://developer.codeplay.com/apt/public.key | gpg --dearmor | tee /usr/share/keyrings/codeplay-keyring.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/codeplay-keyring.gpg] https://developer.codeplay.com/apt all main" | tee /etc/apt/sources.list.d/codeplay.list \
    && apt-get update

RUN apt-get install -y oneapi-nvidia-12.0

# Ustawienie plików ICD dla sterowników OpenCL
RUN mkdir -p /etc/OpenCL/vendors \
    && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd \
    && rm -f /etc/OpenCL/vendors/mesa.icd

# Ustawienie zmiennych środowiskowych NVIDIA
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Ustawienie zmiennych środowiskowych Intel oneAPI
RUN echo "source /opt/intel/oneapi/setvars.sh" >> ~/.bashrc

# Komenda startowa
CMD ["clinfo"]