#define CL_HPP_TARGET_OPENCL_VERSION 300
#define CL_TARGET_OPENCL_VERSION 300

#include <iostream>
#include <CL/cl.hpp>

int main(int, char**){
    std::vector<cl::Platform> platforms;
	cl::Platform::get(&platforms);
    
    std::cout << "Dostępne platformy:" << std::endl;
    for (const auto& platform : platforms) {
        std::string platformName;
        platform.getInfo(CL_PLATFORM_NAME, &platformName);
        std::cout << "- " << platformName << std::endl;
    }
}
