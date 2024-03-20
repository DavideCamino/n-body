cmake_minimum_required(VERSION 3.28)
project(n_body)

set(CMAKE_CXX_STANDARD 17)

add_executable(n_body main.cpp
        vector3D.cpp
        vector3D.h
        body.cpp
        body.h
        solarSystem.cpp
        solarSystem.h
)
