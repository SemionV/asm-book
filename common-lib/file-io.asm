section .data
    ; POSIX syscall symbols
    NR_read  	    equ 	0
    NR_write 	    equ 	1
    NR_open 	    equ 	2
    NR_close 	    equ 	3
    NR_lseek 	    equ 	8
    NR_create 	    equ 	85
    NR_unlink 	    equ 	87

    ; creation and status flags
    O_CREAT 	    equ 	00000100q
    O_APPEND 	    equ 	00002000q

    ; access mode
    O_RDONLY 	    equ 	000000q
    O_WRONLY 	    equ 	000001q
    O_RDWR 		    equ 	000002q

    ; create mode (permissions)
    S_IRUSR 	    equ 	00400q  ;user read permission
    S_IWUSR 	    equ 	00200q 	;user write permission

    bufferLength  	equ 	64
section .bss
section .text

global createFile
createFile:
    push    rbp
    mov     rbp, rsp

    mov     rax, NR_create
    mov     rsi, S_IRUSR | S_IWUSR
    syscall

    leave
    ret

;params:
;   rdi     FD
;   rsi     address of data
;   rdx     bytes count
global writeFile
writeFile:
    push    rbp
    mov     rbp, rsp

    mov     rax, NR_write
    syscall

    leave
    ret

;params
;rdi        FD
global  closeFile
closeFile:
    push    rbp
    mov     rbp, rsp
    mov     rax, NR_close
    syscall
    leave
    ret