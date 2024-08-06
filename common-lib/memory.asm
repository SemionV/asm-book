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

;params:
;rdi - string
;rsi - sub-string
;rdx - length of substring
;rcx - length of string
global subBlock
subBlock:
    push    rbp
    mov     rbp, rsp

    mov     r12, -1 ;r12 - current match position(starting from 0)
    mov     r13, rcx ;r13 - string length
    mov     r14, rdi ;r14 - address of string
    mov     r15, rsi ;r15 - address of substring

    .loop:

    ;search for first letter of the substring
    lodsb ;load sil to al
    cld ;clear DF
    repne   scasb ;iterate rcx times until match al and byte [rdi]
    jne     .return
    ;calculate current match position
    mov     r12, r13
    sub     r12, rcx
    sub     r12, 1

    ;check if there any charakters left to comapre
    mov     rax, rdx
    cmp     rax, 1
    je      .return

    ;check if the rest of the string including matched symbol is greather or equal to the length of the substring
    mov     rax, r13
    sub     rax, r12
    cmp     rax, rdx
    jl      .not_found

    ;compare substrings
    mov     rcx, rdx
    sub     rcx, 1
    cld
    repe    cmpsb
    je      .return
    mov     rdi, r14
    add     rdi, r12
    add     rdi, 1
    mov     rcx, r13
    sub     rcx, r12
    sub     rcx, 1
    mov     rsi, r15
    jmp     .loop

    .not_found:
    mov     r12, -1

    .return:
    mov     rax, r12
    leave
    ret

;params:
;rdi - block1
;rsi - block2
;rdx - block length
global compareData
compareData:
    push    rbp
    mov     rbp, rsp

    mov     rcx, rdx
    cld
    repe    cmpsb
    je      .found
    mov     rax, rdx
    sub     rax, rcx
    sub     rax, 1
    jmp     .return

    .found:
    mov     rax, -1

    .return:
    leave
    ret

;params:
;rdi - value
;rsi - word position
;rdx - word
;rcx - bits count in a word
global  packWord64
packWord64:
    push    rbp
    mov     rbp, rsp

    mov     r12, rcx
    mov     r13, rsi
    imul    r13, r12

    ;clear bits of the word
    mov     rax, rdi
    ;clear bits to the left of the word
    mov     rcx, 64
    sub     rcx, r13
    sub     rcx, r12
    shl     rax, cl
    shr     rax, cl
    ;clear bits to the right of the word
    mov     rcx, r13
    shr     rax, cl
    shl     rax, cl
    ;clear the bits in the word
    xor     rdi, rax

    xor     rax, rax
    mov     rax, rdx
    shl     rax, cl
    or      rdi, rax

    mov     rax, rdi

    leave
    ret

;params:
;rdi - value
;rsi - word position
;rdx - word
global  setWord64
setWord64:
    push    rbp
    mov     rbp, rsp

    mov     rcx, 16
    call    packWord64

    leave
    ret