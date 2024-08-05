extern printf
extern setSemanticVersion
extern setWord64
extern getSSEVersion
section .data
    strSSEVersion       db "SSE version: %ld.%ld",0xA,0
    strSSENotSupported  db "SSE is not supported",0xA,0
section .bss
section .text
global main
main:
    push    rbp
    mov     rbp, rsp

    call    getSSEVersion

    mov     rdi, strSSEVersion

    mov     r12, rax
    shr     r12, 48
    mov     rsi, r12

    cmp     rsi, 0
    jg      .sse_supported
    mov     rdi, strSSENotSupported
    .sse_supported:
    mov     rdi, strSSEVersion

    mov     r12, rax
    shr     r12, 32
    and     r12, 0x000000000000ffff
    mov     rdx, r12

    xor     rax, rax

    call    printf

    leave
    ret