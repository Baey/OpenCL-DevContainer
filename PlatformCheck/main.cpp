#define CL_HPP_TARGET_OPENCL_VERSION 300
#define CL_TARGET_OPENCL_VERSION 300

#include <iostream>
#include <vector>
#include <CL/opencl.hpp>

// Funkcja do drukowania możliwości atomic fence
void printAtomicFenceCapabilities(cl_device_atomic_capabilities capabilities) {
    std::cout << "        Atomic Fence Capabilities: ";
    if (capabilities & CL_DEVICE_ATOMIC_ORDER_RELAXED) {
        std::cout << "RELAXED ";
    }
    if (capabilities & CL_DEVICE_ATOMIC_ORDER_ACQ_REL) {
        std::cout << "ACQ_REL ";
    }
    if (capabilities & CL_DEVICE_ATOMIC_ORDER_SEQ_CST) {
        std::cout << "SEQ_CST ";
    }
    if (capabilities & CL_DEVICE_ATOMIC_SCOPE_WORK_ITEM) {
        std::cout << "WORK_ITEM ";
    }
    if (capabilities & CL_DEVICE_ATOMIC_SCOPE_WORK_GROUP) {
        std::cout << "WORK_GROUP ";
    }
    if (capabilities & CL_DEVICE_ATOMIC_SCOPE_DEVICE) {
        std::cout << "DEVICE ";
    }
    if (capabilities & CL_DEVICE_ATOMIC_SCOPE_ALL_DEVICES) {
        std::cout << "ALL_DEVICES ";
    }
    std::cout << std::endl;
}

int main(int, char**) {
    std::vector<cl::Platform> platforms;
    cl::Platform::get(&platforms);
    
    if (platforms.empty()) {
        std::cout << "Nie wykryto żadnych platform OpenCL." << std::endl;
        return 1;
    }
    
    std::cout << "Wykryte platformy OpenCL:" << std::endl;
    for (const auto& platform : platforms) {
        std::string platformName;
        platform.getInfo(CL_PLATFORM_NAME, &platformName);
        std::cout << "|---- " << platformName << std::endl;

        std::vector<cl::Device> devices;
        platform.getDevices(CL_DEVICE_TYPE_ALL, &devices);
        
        if (devices.empty()) {
            std::cout << "        Brak dostępnych urządzeń na tej platformie." << std::endl;
        } else {
            for (const auto& device : devices) {
                std::string deviceName;
                device.getInfo(CL_DEVICE_NAME, &deviceName);
                std::cout << "        |---- " << deviceName << std::endl;

                cl_device_atomic_capabilities atomicFenceCapabilities;
                device.getInfo(CL_DEVICE_ATOMIC_FENCE_CAPABILITIES, &atomicFenceCapabilities);

                printAtomicFenceCapabilities(atomicFenceCapabilities);
            }
        }
    }
    return 0;
}
