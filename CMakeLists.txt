set(BUILD_TOOLS_REQUIRED_VERSION 3.22)
cmake_minimum_required(VERSION ${BUILD_TOOLS_REQUIRED_VERSION})
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "gcc <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES> -no-pie")
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
project(nasm-book LANGUAGES ASM_NASM)

enable_language(ASM_NASM)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(AddExercise)

AddExercise(ex-hello-world hello-world/hello.asm)
AddExercise(ex-jump chapter07/jump.asm)
AddExercise(ex-loop chapter07/loop.asm)
AddExercise(ex-memory chapter08/memory.asm)
AddExercise(ex-icalc chapter09/icalc.asm)
AddExercise(ex-stack chapter10/stack.asm)