
extern printf


section .data
    r dq 3.0
    h dq 4.0
    resposta dq 0.0
    str_resposta: db 'Volume eh = %f' , 10,0
section .text
    global main
main:
    fld qword[r]
    fld qword[r]
    fmulp
    fld qword[h]
    fmulp
    fldpi
    fmulp
    fst qword [resposta]
    push dword [resposta+4]
    push dword [resposta]
    push dword str_resposta
    call printf
    add esp, 12
    call fim


fim:
    mov eax, 1
    mov ebx, 0
    int 80h