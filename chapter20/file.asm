extern printf
extern createFile
extern writeFile
extern closeFile
extern printString
section .data
    FD              dq      0
    fileName        db      "test-file",0
    data            db      "Hello wrold!",0xA,0
    dataLength      dq      $ - data
    NL              db      0xA,0

    fmtPrintFD      db      "FD: %ld",0xA,0
    strFileError    db      "File error, ",0s
    strFileCreated  db      "File created, ",0
    strFileWritten  db      "File written, ",0
    strFileClosed   db      "File closed, ",0
section .bss
section .text
global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, fileName
    call    createFile
    mov     qword [FD], rax
    cmp     rax, 0
    jge     .file_created
    mov     rdi, strFileError
    jmp     .createDone
    .file_created:
    mov     rdi, strFileCreated
    .createDone:
    mov     rsi, rax
    call    printFileOperationResult

    mov     rdi, qword [FD]
    mov     rsi, data
    mov     rdx, qword [dataLength]
    call    writeFile
    cmp     rax, 0
    jge     .file_written
    mov     rdi, strFileError
    jmp     .writeDone
    .file_written:
    mov     rdi, strFileWritten
    .writeDone:
    mov     rsi, rax
    call    printFileOperationResult

    mov     rdi, qword [FD]
    call    closeFile
    cmp     rax, 0
    jge     .file_closed
    mov     rdi, strFileError
    jmp     .closeDone
    .file_closed:
    mov     rdi, strFileClosed
    .closeDone:
    mov     rsi, rax
    call    printFileOperationResult

    leave
    ret

printFileOperationResult:
    push    rbp
    mov     rbp, rsp
    push    rsi
    and     rsp, 0xfffffffffffffff0
    call    printString
    add     rsp, 0x8
    pop     rsi
    mov     rdi, fmtPrintFD
    xor     rax, rax
    call    printf
    leave
    ret

