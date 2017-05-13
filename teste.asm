;assembly de test para calcular a distancia entre dois pontos
;para ajudar no aprendizado

message:    db "zero", 10, 0 ; The printf format, "\n",'0'

print_string:
	lodsb        ; grab a byte from SI
 
	or al, al  ; logical or AL by itself
	jz .done   ; if the result is zero, get out
 
	mov ah, 0x0E
	mov bl, 15
	int 0x10      ; otherwise, print out the character!
 
	jmp print_string
 
	.done:
  ret

SECTION .data
	x dq 1.0
	y dq 2.0
	x1 dq 3.0
	y1 dq 4.0

SECTION .text
global main
main:
	fld qword[x]
	fld qword[x1]
	fsubp st1, st0
	fst st1 	;armazena o topo da pilha em st1
	fmulp st1, st0
	fxch st1
	fld qword[y]
	fld qword[y1]
	fsubp st1, st0 ;st1 (no final que é o destino) vira st0, pois o valor antigo é desimpilhado
	fst st2
	fmul st0, st2
	fadd st1, st0
	fsqrt
	ftst
	je zero
	jmp fim


	zero:
	mov si, message
	call print_string


	fim:
	mov	eax,0		;  normal, no error, return value
	ret			; return