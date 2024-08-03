extern printf
extern printString
extern copyBlock
extern initBlock
extern subBlock
section .data
    strSubStringFmt db  "Substring position: %ld",0xA,0
    strData         db  "Hardangervidda",0xA,0
    strDataLength   equ $ - strData
    NL              db  0xA,0
    strSubString    db  "dda"
    subStrLength    equ $ - strSubString
section .bss
    strDataCopy     resb    strDataLength
section .text
global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, strDataCopy
    mov     rsi, 48 ;ASCII '0'
    mov     rdx, strDataLength
    call    initBlock

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, strDataCopy
    mov     rdx, strDataLength
    syscall

    mov     rdi, NL
    call    printString

    mov     rdi, strDataCopy
    mov     rsi, strData
    mov     rdx, strDataLength
    call    copyBlock

    mov     rdi, strDataCopy
    call    printString

    mov     rdi, strData
    mov     rsi, strSubString
    mov     rdx, strDataLength
    mov     rcx, subStrLength
    call    subBlock

    mov     rdi, strSubStringFmt
    mov     rsi, rax
    xor     rax, rax
    call    printf

    xor     rax, rax

    leave
    ret