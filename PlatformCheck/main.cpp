#define CL_HPP_TARGET_OPENCL_VERSION 300
#define CL_TARGET_OPENCL_VERSION 300

#include <iostream>
#include <CL/opencl.hpp>

int main(int, char**){
    std::vector<cl::Platform> platforms;
	cl::Platform::get(&platforms);
    
    std::cout << "Wykryte platformy OpenCL:" << std::endl;
    for (const auto& platform : platforms) {
        std::string platformName;
        platform.getInfo(CL_PLATFORM_NAME, &platformName);
        std::cout << "|---- " << platformName << std::endl;

        std::vector<cl::Device> devices;
        platform.getDevices(CL_DEVICE_TYPE_ALL, &devices);

        // std::cout << "Urządzenia dostępne na tej platformie:" << std::endl;
        for (const auto& device : devices) {
            std::string deviceName;
            device.getInfo(CL_DEVICE_NAME, &deviceName);
            std::cout << "        |---- " << deviceName << std::endl;
        }
    }
}
