extern printf
extern printString
extern copyBlock
extern initBlock
extern subBlock
extern compareData
section .data
    strSubStringFmt db  "Substring position: %ld",0xA,0
    strCmpResultFmt db  "Compare result: %ld",0xA,0
    strData         db  "Hardangervidda",0xA,0
    strDataCmp      db  "Hardangervidha",0xA,0
    strDataLength   equ $ - strData
    NL              db  0xA,0
    strSubString    db  "anger"
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
    mov     rsi, strDataCopy
    mov     rdx, strDataLength
    call    compareData

    mov     rdi, strCmpResultFmt
    mov     rsi, rax
    xor     rax, rax
    call    printf

    mov     rdi, strData
    mov     rsi, strDataCmp
    mov     rdx, strDataLength
    call    compareData

    mov     rdi, strCmpResultFmt
    mov     rsi, rax
    xor     rax, rax
    call    printf

    mov     rdi, strData
    mov     rsi, strSubString
    mov     rdx, subStrLength
    mov     rcx, strDataLength
    call    subBlock

    mov     rdi, strSubStringFmt
    mov     rsi, rax
    xor     rax, rax
    call    printf

    xor     rax, rax

    .return:
    leave
    ret