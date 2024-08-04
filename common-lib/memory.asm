;init memory
;copy block
;find sub-block
;compare blocks
global initBlock
initBlock:
    push    rbp
    mov     rbp, rsp

    mov     rax, rsi
    mov     rcx, rdx
    rep     stosb

    leave
    ret

global copyBlock
copyBlock:
    push    rbp
    mov     rbp, rsp

    mov     rcx, rdx
    rep     movsb

    leave
    ret

global subBlock
subBlock:
    push    rbp
    mov     rbp, rsp

    mov     r12, rdx
    mov     r13, rcx
    mov     r15, rdi
    mov     r8, rsi

    .loop:
    ;search for first letter of the substring
    mov     rcx, r12
    lodsb
    cld
    repne   scasb
    jne     .not_found
    mov     r14, rdx
    sub     r14, rcx
    sub     r14, 1

    mov     rax, rdx
    sub     rax, r14
    cmp     rax, r13
    jl      .not_found

    ;compare substrings
    mov     r12, rax
    mov     rax, r14
    mov     rdi, r15
    add     rdi, r14
    add     rdi, 1
    sub     r12, 1
    mov     r15, rdi
    mov     rcx, r13
    sub     rcx, 1
    cld
    repe    cmpsb
    je      .return
    mov     rdi, r15
    mov     rsi, r8
    jmp     .loop

    .not_found:
    mov     rax, -1

    .return:
    leave
    ret