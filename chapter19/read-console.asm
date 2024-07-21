section .data
    strHello        db  "Hello!",0
    strPrompt       db  "Message(max 10 chars): ",0
    strOutput       db  "Your message: ",0
    NL              db  0xA
    inputLength     equ 10
section .bss
    inputBuffer     resb    inputLength + 1
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
        mov     rdi, strHello
        call    prints
        mov     rdi, NL
        call    prints

        mov     rdi, strPrompt
        call    prints

        mov     rdi, inputBuffer
        mov     rsi, inputLength
        call    reads

        mov     rdi, strOutput
        call    prints

        mov     rdi, inputBuffer
        call    prints
        mov     rdi, NL
        call    prints
    leave
    ret

prints:
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

reads:
section .data
section .bss
    .inputChar      resb    1
section .text
    push    rbp
    mov     rbp, rsp
        push    r12
        push    r13
        push    r14
        and     rsp, 0xfffffffffffffff0

        mov     r12, rdi
        mov     r13, rsi
        xor     r14, r14

        .read_loop:
        mov     rax, 0
        mov     rdi, 0
        lea     rsi, [.inputChar]
        mov     rdx, 1
        syscall
        mov     al, [.inputChar]
        cmp     al, byte[NL]
        je      .done
        mov     byte[r12], al
        inc     r12
        inc     r14
        cmp     r14, r13
        jb      .read_loop

        .done:
        mov     r12, 0

        add     rsp, 0x8
        pop     r14
        pop     r13
        pop     r12
    leave
    ret