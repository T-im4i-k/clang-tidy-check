add_library(math_lib SHARED
        "${CMAKE_CURRENT_SOURCE_DIR}/include/math_lib/sqr.hpp"
        "${CMAKE_CURRENT_SOURCE_DIR}/src/sqr.cpp")

target_include_directories(math_lib PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include/")