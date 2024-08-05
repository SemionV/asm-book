;parems:
;rdi - major
;rsi - minor
;rdx - patch
;rcx - build
global setSemanticVersion
setSemanticVersion:
    push    rbp
    mov     rbp, rsp

    xor     r12, r12
    xor     rax, rax

    mov     r12, rdi
    shl     r12, 48
    or      rax, r12

    xor     r12, r12
    mov     r12, rsi
    shl     r12, 32
    or      rax, r12

    xor     r12, r12
    mov     r12, rdx
    shl     r12, 16
    or      rax, r12

    xor     r12, r12
    mov     r12, rcx
    or      rax, r12

    leave
    ret