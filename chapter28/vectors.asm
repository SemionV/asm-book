extern printf
extern fflush
extern printString
extern printVector4f

section .data
    NL      db  0xA,0
    dummy   db  13
align 16
    vector1 dd  0.34, 0.67, 0.0, 0.913
    vector2 dd  0.1, 0.2, 0.3, 0.4
section .bss
alignb 16
        vector_res resd 4
section .text
global  main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, vector1
    call    printVector4f
    mov     rdi, NL
    call    printString

    mov     rdi, vector2
    call    printVector4f
    mov     rdi, NL
    call    printString

    movaps  xmm0, [vector1]
    addps 	xmm0, [vector2]
    movaps 	[vector_res], xmm0

    mov     rdi, vector_res
    call    printVector4f
    mov     rdi, NL
    call    printString

    xor     rax, rax

    leave
    ret