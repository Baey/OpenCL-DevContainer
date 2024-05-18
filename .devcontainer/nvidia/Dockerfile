# Bazowy obraz z NVIDIA CUDA
FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

# Instalacja podstawowych narzędzi i zależności
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    gnupg2 \
    lsb-release \
    software-properties-common \
    apt-utils \
    dialog

# Instalacja narzędzi sieciowych i systemowych
RUN apt-get install -y \
    iproute2 \
    procps \
    git

# Instalacja narzędzi do analizy kodu i debuggowania
RUN apt-get install -y \
    cmake \
    cppcheck \
    valgrind

# Instalacja bibliotek OpenCL
RUN apt-get install -y \
    clinfo \
    ocl-icd-opencl-dev \
    pocl-opencl-icd \
    opencl-headers

# Ustawienie repozytorium Intel oneAPI
RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list \
    && apt-get update

# Instalacja Intel oneAPI Base Toolkit i HPC Toolkit
RUN apt-get install -y intel-basekit intel-hpckit

# Ustawienie ścieżki do bibliotek oneAPI
ENV PATH=/opt/intel/oneapi/compiler/latest/linux/bin/intel64:/opt/intel/oneapi/opencl/latest/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin:/opt/intel/oneapi/opencl/latest/lib:$LD_LIBRARY_PATH

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