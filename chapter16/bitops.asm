;bitops
extern printb
section .data
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, 8
    call    printb

    mov     rdi, 127
    call    printb

    mov     rdi, 43545435
    call    printb

    leave
    ret