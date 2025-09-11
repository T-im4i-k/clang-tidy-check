cmake_minimum_required(VERSION 3.28)

project(poor_project
        DESCRIPTION "A test project containing poor quality code, that should not pass quality checks"
        LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

add_executable(poor_project test.cpp)