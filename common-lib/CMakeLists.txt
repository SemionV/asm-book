cmake_minimum_required(VERSION ${BUILD_TOOLS_REQUIRED_VERSION})
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "gcc <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES> -no-pie")
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
project(common-lib)

enable_language(ASM_NASM)

add_library(${PROJECT_NAME} STATIC
        file-io.asm
        print.asm
        memory.asm
        version.asm
        cpuid.asm)