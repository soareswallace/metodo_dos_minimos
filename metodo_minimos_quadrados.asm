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
SECTION .text
global  main
main:
	fld qword[m1] ;empilha m1 
	fld st0 ; empilha o que esta em st0
	fmulp st1,st0 ;multiplica st1, st0 e empilha o resultado, desimpilhando um deles
	fld qword[m2] ;empilha m2
	fld st0 ;empilha o que esta em st0
	fmulp st1,st0 ;multiplica st1, st0 e empilha o resultado, desimpilhando um deles
	faddp st1,st0 ;soma st0, st1 e empilha o resultado
	fsqrt ;tira a raiz do top
	fst qword[m3] ;empilha m3
	mov 
	mov eax,1
  	mov ebx,0
  	int 80h