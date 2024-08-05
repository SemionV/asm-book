extern setWord64
global getSSEVersion
getSSEVersion:
    push    rbp
    mov     rbp, rsp

    mov     eax,1     	    ;request CPU feature flags
    cpuid

    xor     rax, rax

    ;test for SSE
    test    edx, 2000000h	;test bit 25 (SSE)
    jz      .sse2     		;SSE available
    push    rcx
    push    rdx
    mov     rdi, rax
    mov     rsi, 3
    mov     rdx, 1
    ;call    setWord64
    pop     rdx
    pop     rcx
    .sse2:
    test    edx, 4000000h   ;test bit 26 (SSE 2)
    jz      .sse3           ;SSE 2 available
    push    rcx
    push    rdx
    mov     rdi, rax
    mov     rsi, 3
    mov     rdx, 2
    call    setWord64
    pop     rdx
    pop     rcx
    .sse3:
    test    ecx, 1         	;test bit 0 (SSE 3)
    jz      .ssse3          ;SSE 3 available
    push    rcx
    push    rdx
    mov     rdi, rax
    mov     rsi, 3
    mov     rdx, 3
    call    setWord64
    pop     rdx
    pop     rcx
    .ssse3:
    test    ecx,9h         	;test bit 0 (SSE 3)
    jz      .sse41          ;SSSE 3 available
    push    rcx
    push    rdx
    mov     rdi, rax
    mov     rsi, 3
    mov     rdx, 3
    call    setWord64
    mov     rdi, rax
    mov     rsi, 2
    mov     rdx, 1
    call    setWord64
    pop     rdx
    pop     rcx
    .sse41:
    test    ecx,80000h    	;test bit 19 (SSE 4.1)
    jz      .sse42          ;SSE 4.1 available
    push    rcx
    push    rdx
    mov     rdi, rax
    mov     rsi, 3
    mov     rdx, 4
    call    setWord64
    mov     rdi, rax
    mov     rsi, 2
    mov     rdx, 1
    call    setWord64
    pop     rdx
    pop     rcx
    .sse42:
    test    ecx,100000h    	;test bit 20 (SSE 4.2)
    jz      .exit           ;SSE 4.2 available
    push    rcx
    push    rdx
    mov     rdi, rax
    mov     rsi, 3
    mov     rdx, 4
    call    setWord64
    mov     rdi, rax
    mov     rsi, 2
    mov     rdx, 2
    call    setWord64
    pop     rdx
    pop     rcx

    .exit:

    leave
    ret