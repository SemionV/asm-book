;printp.asm
section .data
section .bss
section .text
    global printb
printb:
    section .data
        str1Bit     db "1",0
        str0Bit     db "0",0
        strSpace    db " ",0
        strDot      db ".",0
        strNewline  db 10,0
    section .text
    push    rbp
    mov     rbp, rsp

        xor     rcx, rcx
        mov     rcx, 63
    loop:
            mov     rax, rdi
            shr     rax, cl

            push    rdi
            push    rcx

            and     rax, 1
            cmp     rax, 1
            jne     print0
                mov     rsi, str1Bit
                jmp     print
            print0:
                mov     rsi, str0Bit
        print:
            mov     rax, 1
            mov     rdi, 1
            mov     rdx, 1
            syscall

            pop     rcx
            pop     rdi

            dec     rcx
            cmp     rcx, 0
            jge     loop

        mov     rax, 1
        mov     rdi, 1
        mov     rsi, strNewline
        mov     rdx, 1
        syscall

    leave
    ret