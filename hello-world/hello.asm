; hello.asm
section .data
    msg db  "Hello, world!",10,0
section .bss
section .text
    global main
main:
    mov     rax, 1      ; syscall code
    mov     rdi, 1      ; param to syscall: output stream id
    mov     rsi, msg    ; param to syscall: adress of a string
    mov     rdx, 14     ;
    syscall
    mov     rax, 60
    mov     rdi, 0
    syscall