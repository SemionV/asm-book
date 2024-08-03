set(BUILD_TOOLS_REQUIRED_VERSION 3.22)
cmake_minimum_required(VERSION ${BUILD_TOOLS_REQUIRED_VERSION})
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "gcc <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES> -no-pie")
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
project(nasm-book LANGUAGES ASM_NASM)

add_compile_options(-g)

add_subdirectory(common-lib)

enable_language(ASM_NASM)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(AddExercise)

AddExercise(ex-hello-world hello-world/hello.asm)
AddExercise(ex-jump chapter07/jump.asm)
AddExercise(ex-loop chapter07/loop.asm)
AddExercise(ex-memory chapter08/memory.asm)
AddExercise(ex-icalc chapter09/icalc.asm)
AddExercise(ex-stack chapter10/stack.asm)
AddExercise(ex-fcalc chapter11/fcalc.asm)
AddExercise(ex-func5 chapter15/function5.asm)
AddExercise(ex-bitops "chapter16/bitops.asm;chapter16/printb.asm")
AddExercise(ex-read-console chapter19/read-console.asm)
AddExercise(ex-file-io chapter20/file.asm common-lib)
AddExercise(ex-cmdline chapter21/cmdline.asm common-lib)
AddExercise(ex-strings chapter24/strings.asm common-lib)