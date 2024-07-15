; hello.asm
extern printf
section .data
    number1         db  101
    number2         db  101
    lesserString    db "number1 < number2",10,0
    greaterString   db "number1 >= number2",10,0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax
    mov     al, [number1]
    xor     rbx, rbx
    mov     bl, [number2]
    cmp     rax, rbx
    jge     greater
lesser:
    mov     rdi, lesserString
    mov     rax, 0
    call    printf
    jmp     exit

greater:
    mov     rdi, greaterString
    mov     rax, 0
    call    printf

exit:
    mov     rsp, rbp
    pop     rbp
    ret

