FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install iproute2 procps lsb-release git\
    && apt-get -y install build-essential cmake cppcheck clinfo valgrind ocl-icd-opencl-dev pocl-opencl-icd opencl-headers

ARG INTEL_DRIVER=opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz
ARG INTEL_DRIVER_URL=http://registrationcenter-download.intel.com/akdlm/irc_nas/9019

# ADD http://registrationcenter-download.intel.com/akdlm/irc_nas/11396/SRB5.0_linux64.zip /tmp/intel-opencl-driver
RUN mkdir -p /tmp/opencl-driver-intel
WORKDIR /tmp/opencl-driver-intel
# COPY $INTEL_DRIVER /tmp/opencl-driver-intel/$INTEL_DRIVER
# RUN curl -O $INTEL_DRIVER_URL/$INTEL_DRIVER 
# SRB 5 uses a zip file; older drivers use .tgz
RUN echo INTEL_DRIVER is $INTEL_DRIVER; \
    curl -O $INTEL_DRIVER_URL/$INTEL_DRIVER; \
    if echo $INTEL_DRIVER | grep -q "[.]zip$"; then \
        unzip $INTEL_DRIVER; \
        mkdir fakeroot; \
        for f in intel-opencl-*.tar.xz; do tar -C fakeroot -Jxvf $f; done; \
        cp -R fakeroot/* /; \
        ldconfig; \
    else \
        tar -xzf $INTEL_DRIVER; \
        for i in $(basename $INTEL_DRIVER .tgz)/rpm/*.rpm; do alien --to-deb $i; done; \
        dpkg -i *.deb; \
        rm -rf $INTEL_DRIVER $(basename $INTEL_DRIVER .tgz) *.deb; \
        mkdir -p /etc/OpenCL/vendors; \
        echo /opt/intel/*/lib64/libintelocl.so > /etc/OpenCL/vendors/intel.icd; \
    fi; \
    rm -rf /tmp/opencl-driver-intel;

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN rm -f /etc/OpenCL/vendors/mesa.icd

CMD ["clinfo"]