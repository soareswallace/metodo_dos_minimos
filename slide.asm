extern printf

section .data
	value: dq 1.41					;valor float para imprimir
	str1: db 'Valor = %f' , 10,0		;string para printf

section .text
	global main

main:
	push dword [value+4]			;empilhando o valor double
	push dword [value]				;em duas partes de 32 bits
	push dword str1 					;empilhando endereco da string
	call printf						;chamada de printf, que irá utilizar os valores empilhados
	add esp, 12
	call FIM

FIM:
	MOV EAX, 1 ; exit syscall
	MOV EBX, 0 ; program return
	INT 80H ; syscall interruption
