global printString
printString:
    push    rbp
    mov     rbp, rsp
        ;save registers
        push    r12
        and     rsp, 0xfffffffffffffff0

        ;calculate lenth of the input string
        xor     rdx, rdx
        mov     r12, rdi
        .loop_length_count:
        cmp     byte[r12], 0
        je      .length_calculated
        inc     r12
        inc     rdx
        jmp     .loop_length_count

        .length_calculated:
        cmp     rdx, 0
        je      .done

        ;output to sdt out
        mov     rsi, rdi
        mov     rax, 1
        mov     rdi, 1
        syscall

        .done:
        ;pop the saved registers
        add     rsp, 0x8
        pop     r12
    leave
    ret

global printNumber64
printNumber64:
section .data
    .str1Bit     db "1",0
    .str0Bit     db "0",0
    .strSpace    db " ",0
    .strDot      db ".",0
    .strNewline  db 10,0
section .text
    push    rbp
    mov     rbp, rsp

        xor     rcx, rcx
        mov     rcx, 63

        .loop:
        mov     rax, rdi
        shr     rax, cl

        push    rdi
        push    rcx

        and     rax, 1
        cmp     rax, 1
        jne     .print0
        mov     rsi, .str1Bit
        jmp     .print

        .print0:
        mov     rsi, .str0Bit

        .print:
        mov     rax, 1
        mov     rdi, 1
        mov     rdx, 1
        syscall

        pop     rcx
        pop     rdi

        dec     rcx
        cmp     rcx, 0
        jge     .loop

        mov     rax, 1
        mov     rdi, 1
        mov     rsi, .strNewline
        mov     rdx, 1
        syscall

    leave
    ret