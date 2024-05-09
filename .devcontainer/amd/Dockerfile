FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install git iproute2 procps lsb-release \
    && apt-get -y install build-essential cmake cppcheck valgrind ocl-icd-* opencl-headers
    
RUN amdgpu_version="amdgpu-pro-19.30-855429-ubuntu-18.04" \
	&& url="http://support.amd.com https://drivers.amd.com/drivers/linux/${amdgpu_version}.tar.xz" \
    && cd \
    && dpkg --add-architecture i386 \
    && apt-get --no-install-recommends install -y ca-certificates curl xz-utils clinfo \
    && curl -L -O --referer ${url} \
    && tar -Jxvf ${amdgpu_version}.tar.xz \
    && rm ${amdgpu_version}.tar.xz \
    && bash ./${amdgpu_version}/amdgpu-pro-install -y \
    && rm -fR ${amdgpu_version} \
    && apt-get install -y opencl-amdgpu-pro

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=dialog