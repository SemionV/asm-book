extern printf
extern printBits
extern printString
section .data
    strArgsCount        db "CLI arguments count: %ld",0xA,0
    strArg              db "%s",0xA,0
    strNL               db 0xA,0
section .bss
section .text
global main
main:
    push    rbp
    mov     rbp, rsp

    mov     r12, rdi
    mov     r13, rsi

    mov     rdi, strArgsCount
    mov     rsi, r12
    xor     rax, rax
    call    printf

    xor     r14, r14
    .loop:
            cmp     r14, r12
            je      .end_loop
            mov     rdi, strArg
            mov     rsi, qword [r13 + r14*8]
            xor     rax, rax
            call    printf
            inc     r14
            jmp     .loop

    .end_loop:

    mov     rdi, 128
    mov     rsi, 16
    call    printBits

    mov     rdi, strNL
    call    printString

    leave
    ret