cmake_minimum_required(VERSION 3.0)
project(PlatformCheck VERSION 0.1.0 LANGUAGES C CXX)

# # Ustawienie standardu C++ (opcjonalne)
# set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_STANDARD_REQUIRED True)

include(CTest)
enable_testing()

# Znajdowanie plików nagłówkowych OpenCL
find_package(OpenCL REQUIRED)

# Dodanie pliku źródłowego
add_executable(PlatformCheck main.cpp)

# Dołączenie plików nagłówkowych OpenCL
target_include_directories(PlatformCheck PUBLIC ${OpenCL_INCLUDE_DIRS})
message(OpenCL headers: ${OpenCL_INCLUDE_DIRS})

# Dołączenie bibliotek OpenCL
target_link_libraries(PlatformCheck OpenCL::OpenCL)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)