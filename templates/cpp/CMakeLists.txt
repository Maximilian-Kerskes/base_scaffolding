cmake_minimum_required(VERSION 3.20)

project(project_name
    VERSION 0.1.0
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

add_executable(${PROJECT_NAME}
    src/main.cpp
)

target_compile_options(${PROJECT_NAME} PRIVATE
    -Wall
    -Wextra
    -Wpedantic
)

target_include_directories(${PROJECT_NAME} PRIVATE
    include
)

# Testing

enable_testing()

add_executable(${PROJECT_NAME}_test
    tests/test.cpp)

add_test(
    NAME ${PROJECT_NAME}_test
    COMMAND ${PROJECT_NAME}_test
)
