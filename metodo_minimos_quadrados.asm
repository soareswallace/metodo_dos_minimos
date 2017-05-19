;Como compilar no mac
;nasm -f macho metodo_minimos_quadrados.asm
;ld -o metodo_minimos_quadrados -e main metodo_minimos_quadrados.o
;./metodo_minimos_quadrados

SECTION .data 
	x1 dq 1.0 
	y1 dq 1.0 
	x2 dq 2.0 
	y2 dq 2.0 
	x3 dq 3.0 
	y3 dq 3.0 
	x4 dq 4.0 
	y4 dq 4.0 
	x5 dq 5.0 
	y5 dq 5.0 
	testex dq 6
	testey dq 6.5
	somatorio_x dq 0.0 ; declarei aqui para previnir que precisacemos maninupular a 
	somatorio_y dq 0.0 ; pilha sem necessidade
SECTION .text
global  main
main:
	fld qword[x1] ;empilha x1
	fld qword[x2] ;empilha x2
	fld qword[x3] ;empilha x3
	fld qword[x4] ;empilha x4
	fld qword[x5] ;empilha x5
	faddp
	faddp
	faddp
	faddp ; fez o somatorio dos x
	fst qword [somatorio_x] ; guarda o resultado em meomoria
	

	fim:
	mov eax,1
  	mov ebx,0
  	int 80h