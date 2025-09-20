cmake_minimum_required(VERSION 3.28)

project(good_project
        DESCRIPTION "A test project containing good quality code, that should pass quality checks"
        LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

add_executable(good_project main.cpp)