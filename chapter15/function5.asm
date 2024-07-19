; function5.asm
extern printf
section .data
    p1          db  "A",0
    p2          db  "B",0
    p3          db  "C",0
    p4          db  "D",0
    p5          db  "E",0
    p6          db  "F",0
    p7          db  "G",0
    p8          db  "H",0
    p9          db  "I",0
    p10         db  "J",0
    pi          dq  3.14
    message1    db "The string is: %s%s%s%s%s%s%s%s%s%s",10,0
    message2    db "Pi = %f",10,0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

        mov     rdi, message1
        mov     rsi, p1
        mov     rdx, p2
        mov     rcx, p3
        mov     r8, p4
        mov     r9, p5
        push    p10
        push    p9
        push    p8
        push    p7
        push    p6
        mov     rax, 0
        call    printf

        and     rsp, 0xfffffffffffffff0 ;align stack at 16 byte because printf will use floating numbers(SIMD)
        mov     rdi, message2
        movsd   xmm0, [pi]
        mov     rax, 1
        call    printf

    leave
    ret