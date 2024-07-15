set(BUILD_TOOLS_REQUIRED_VERSION 3.22)
cmake_minimum_required(VERSION ${BUILD_TOOLS_REQUIRED_VERSION})
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
project(nasm-book LANGUAGES ASM_NASM)

enable_language(ASM_NASM)

add_executable(hello-world hello-world/hello.asm)
target_compile_options(hello-world PRIVATE -f elf64)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(hello-world PRIVATE -g -Fdwarf)
endif()

install(TARGETS hello-world RUNTIME)