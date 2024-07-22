extern printf
extern createFile
extern writeFile
extern printString
section .data
    fileName        db      "test-file",0
    data            db      "Hello wrold!",0
    dataLength      equ     $ - data
    NL              db      0xA,0

    fmtPrintFD      db      "FD: %ld",0xA,0
    strFileCreated  db      "File created, ",0
section .bss
section .text
global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, data
    call    printString
    mov     rdi, NL
    call    printString

    mov     rdi, fileName
    call    createFile
    cmp     rax, 0
    jge     .file_created
    mov     rdi, fmtPrintFD
    mov     rsi, rax
    xor     rax, rax
    call    printf
    jmp     .done
    .file_created:
    mov     rdi, strFileCreated
    call    printString
    mov     rdi, fmtPrintFD
    mov     rsi, rax
    xor     rax, rax
    call    printf

    .done:

    leave
    ret

