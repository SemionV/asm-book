extern setSemanticVersion
extern setWord64
extern getSSEVersion
section .data
section .bss
section .text
global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, 4
    mov     rsi, 2
    mov     rdx, 3
    mov     rcx, 127
    call    setSemanticVersion

    xor     r12, r12
    mov     r12, rax
    shr     r12, 48

    xor     r13, r13
    mov     r13, rax
    shr     r13, 32
    and     r13, 0x000000000000ffff

    xor     r14, r14
    mov     r14, rax
    shr     r14, 16
    and     r14, 0x000000000000ffff

    xor     r15, r15
    mov     r15, rax
    and     r15, 0x000000000000ffff

    mov     rdi, rax
    mov     rsi, 0
    mov     rdx, 6
    call    setWord64

    call    getSSEVersion

    leave
    ret