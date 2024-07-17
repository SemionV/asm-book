; stack.asm
extern printf
section .data
    res         db  "ABCDE",0
    count       dq  $ - res - 1
    dst         db  "ABCDE",0
    fmt         db  "Source: %s, Destination: %s",10,0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rbx, 0
    xor     rax, rax
push_loop:
    mov     al, byte [res + rbx]
    push    rax
    inc     rbx
    cmp     rbx, [count]
    jl      push_loop

    mov     rbx, 0
    xor     rax, rax
pop_loop:
    pop     rax
    mov     byte [dst + rbx], al
    inc     rbx
    cmp     rbx, [count]
    jl      pop_loop

    mov     rdi, fmt
    mov     rsi, res
    mov     rdx, dst
    mov     rax, 0
    call    printf

    mov     rsp, rbp
    pop     rbp
    ret