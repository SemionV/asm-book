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

global printBits
printBits:
section .data
    .str1Bit     db "1",0
    .str0Bit     db "0",0
    .strSpace    db " ",0
    .strDot      db ".",0
    .strNewline  db 10,0
    .byteBitCount dq 8
    .halfBitCount dq 4
section .text
    push    rbp
    mov     rbp, rsp

    mov     r12, rdi
    xor     rcx, rcx
    sub     rsi,1
    mov     rcx, rsi

    .loop:
        mov     rax, r12
        shr     rax, cl

        push    rcx
        and     rsp, 0xFFFFFFFFFFFFFFF0

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

        add     rsp, 0x8
        pop     rcx

        push    rcx
        and     rsp, 0xFFFFFFFFFFFFFFF0

        mov     rax, rcx
        xor     rdx, rdx
        idiv    qword [.halfBitCount]
        cmp     rdx, 0
        jne     .loop_inc
        mov     rsi, .strDot
        mov     rax, rcx
        xor     rdx, rdx
        idiv    qword [.byteBitCount]
        cmp     rdx, 0
        jne     .loop_print_del
        mov     rsi, .strSpace
        cmp     rax, 0
        je      .loop_inc
        .loop_print_del:
        mov     rax, 1
        mov     rdi, 1
        mov     rdx, 1
        syscall

        add     rsp, 0x8
        pop     rcx

        .loop_inc:
        dec     rcx
        cmp     rcx, 0
        jge     .loop

    leave
    ret

global printBits64
printNumber64:
section .data
section .text
    push    rbp
    mov     rbp, rsp

    mov     rsi, 64
    call    printBits

    leave
    ret