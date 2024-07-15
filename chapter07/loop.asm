; loop.asm
extern printf
section .data
    count       db  5
    message     db  "Sum result: %ld(count = %ld)"
section .bss
section .text
        global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rbx, 0
    mov     rax, 0

sum_loop:
    add     rax, rbx
    inc     rbx
    cmp     bl, [count]
    jle     sum_loop

    mov     rdi, message
    mov     rsi, rax
    xor     rdx, rdx
    mov     dl, [count]
    mov     rax, 0
    call    printf
    mov     rsp, rbp
    pop     rbp
    ret

