org 0x7c00
jmp 0x0000:main
extern printf


section .data
    r dq 3.0
    h dq 4.0
section .text
global main
main:
    fld qword[r]
    fld qword[r]
    fmulp st1, st0
    fld qword[h]
    fmulp st1, st0
    fldpi
    fmulp st1, st0


fim:
times 510-($-$$) db 0
dw 0xAA55