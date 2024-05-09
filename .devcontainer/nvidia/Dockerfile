FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install iproute2 procps lsb-release \
    && apt-get -y install build-essential cmake cppcheck clinfo valgrind ocl-icd-opencl-dev pocl-opencl-icd opencl-headers

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN rm -f /etc/OpenCL/vendors/mesa.icd

CMD ["clinfo"]