;Como compilar no mac
;nasm -f macho metodo_minimos_quadrados.asm
;ld -o metodo_minimos_quadrados -e main metodo_minimos_quadrados.o
;./metodo_minimos_quadrados


;OBS:(apagar dps) 
;acho que tem q usar fstp para dar pop no topo depois que manda pra memoria

extern printf


SECTION .data 
	n dq 5.0 ; suponho que seja o numero de pontos...
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
	somatorio_xy dq 0.0 ;55 ok
	somatorio_xx dq 0.0 ;55 ok
	delta dq 0.0 ;50 ok
	A dq 0.0; 1 ok
	B dq 0.0; 0 ok
	x_test dq 6.0
	y_test dq 6.5
	y_x dq 0.0
	erro dq 100.0
	comp dq 50.0
	;teste dq 0.0
	str_t: db 'ERRO = %f 		Logo, o erro foi toleravel', 10,0		;string para printf
	str_nt: db 'ERRO = %f 		Logo, o erro nao foi toleravel', 10,0		;string para printf


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
	fstp qword [somatorio_x] ; guarda o resultado em meomoria
	;---------------------------------------------------------------;
	fld qword[y1] ;empilha y1
	fld qword[y2] ;empilha y2
	fld qword[y3] ;empilha y3
	fld qword[y4] ;empilha y4
	fld qword[y5] ;empilha y5
	faddp
	faddp
	faddp
	faddp ; fez o somatorio dos y
	fstp qword [somatorio_y] ; guarda o resultado em memoria
	
	;----------------Somatorio Xn*Yn-----------------------------------------------;
	fld qword[x1] ;empilha x1
	fld qword[y1] ;empilha y1
	fmulp ; multiplica x1 por y1, resultado em st1 e pop

	fld qword[x2] ;empilha x2
	fld qword[y2] ;empilha y2
	fmulp ; multiplica x2 por y2, resultado em st1 e pop

	fld qword[x3] ;empilha x3
	fld qword[y3] ;empilha y3
	fmulp ; multiplica x3 por y3, resultado em st1 e pop

	fld qword[x4] ;empilha x4
	fld qword[y4] ;empilha y4
	fmulp ; multiplica x4 por y4, resultado em st1 e pop

	fld qword[x5] ;empilha x5
	fld qword[y5] ;empilha y5
	fmulp ; multiplica x5 por y5, resultado em st1 e pop

	faddp
	faddp
	faddp
	faddp ; fez o somatorio dos xy
	fstp qword [somatorio_xy] ; guarda o resultado em memoria

	;------------------somatorio Xn*Xn--------------------------;

	fld qword[x1] ;empilha x1
	fld st0	;empilha x1 dnv
	fmulp st1, st0 ;multiplica x1 por x1, e da pop no st0

	fld qword[x2] ;empilha x2
	fld st0 ;empilha x2 dnv
	fmulp st1, st0 ; multiplica x2 por x2 e da pop no st0

	fld qword[x3] ;empilha x3
	fld st0 ;empilha x3 dnv
	fmulp st1, st0 ; multiplica x3 por x3 e da pop no st0

	fld qword[x4] ;empilha x4
	fld st0 ;empilha x2 dnv
	fmulp st1, st0 ; multiplica x4 por x4 e da pop no st0

	fld qword[x5] ;empilha x5
	fld st0 ;empilha x5 dnv
	fmulp st1, st0 ; multiplica x5 por x5 e da pop no st0

	faddp
	faddp
	faddp
	faddp ; fez o somatorio dos x*x
	fstp qword[somatorio_xx] ; guarda o resultado em memoria

	;--------------calculando Delta---------------------;
	fld qword[n] ;empilha N
	fld qword[somatorio_xx]
	fmulp st1, st0 ;Multiplica N por Sx², poe em st1 e da pop

	fld qword[somatorio_x] ;empilha Sx
	fld st0 ;empilha Sx dnv
	fmulp st1, st0 ;faz (S²x), poe em st1 e da pop

	fchs ;troca o sinal de S²x
	faddp st1, st0; adciona N*Sx² - S²x, poe em st1 e da pop
	fstp qword[delta] ;guarda na memoria

	;-----------------Calculando A------------------------;

	fld qword[n] ;empilha N 
	fld qword[somatorio_xy] ;empilha Sxy 
	fmulp st1, st0 ;empilho N*Sxy 

	fld qword[somatorio_x] ;empilho Sx 
	fld qword[somatorio_y] ;empilho Sy 
	fmulp st1, st0 ;empilho Sx*Sy 
	fchs ;mudo o sinal de Sx*Sy 

	faddp st1, st0 ;empilho N*Sxy - Sx*Sy 

	fld qword[delta] ;empilho delta no topo
	fdivp st1, st0 ;empilho (N*Sxy - Sx*Sy)/delta
	fstp qword[A] ;salvo na memoria

	;-------------------Calculando B------------------------;

	fld qword[somatorio_xx] ;empilha Sx²
	fld qword[somatorio_y] ;empilha Sy
	fmulp st1, st0 ;empilha Sx²*Sy 

	fld qword[somatorio_x] ;empilha Sx 
	fld qword[somatorio_xy] ;empilha Sxy 
	fmulp st1, st0 ;empilha Sx*Sxy 
	fchs ;muda o sinal de Sx*Sxy 

	faddp st1, st0 ;empilha (Sx²*Sy) -(Sx*Sxy)

	fld qword[delta] ;empilha delta
	fdivp st1, st0
	fstp qword[B];

	;------------Calculando Y(x)------------------------;

	fld qword[A] ;empilhando A
	fld qword[x_test] ;empilhando o x de teste
	fmulp st1, st0 ; empilhando A*x
	fld qword[B] ;empilhando B
	faddp st1, st0 ;empilhando Y(x) = A*x + B
	fstp qword[y_x] ;salvando na memoria

	;--------------Calculo ERRO-------------------------;

	fld qword[y_x] ;empilha y_fornecido --st1
	fld qword[y_test] ;empilha o y(x) --st0
	fsubp st1, st0 ;empilha (y(x) - y_fornecido)
	fabs
	fld qword[y_x]
	fdivp ;empilha |y(x) - y_fornecido|/y_x 

	;fstp qword[teste]

	fld qword[erro] ;empilha 100
	fmulp st1, st0
	fstp qword[erro] ;salva o erro na memoria

	;---------------calcula se erro é toleravel--------------;
	fld qword[comp] ;empilha 50 em st1
	fld qword[erro] ;empilha o erro em st0
	fcomi st0, st1 ;compara erro com 50
	ja ntol ;pula se o erro é nao toleravel

	push dword [erro+4]				;empilhando o valor double
	push dword [erro]				;em duas partes de 32 bits
	push dword str_t					;empilhando endereco da string
	call printf						;chamada de printf, que irá utilizar os valores empilhados
	add esp, 12
	call fim


	ntol:
	push dword [erro+4]				;empilhando o valor double
	push dword [erro]				;em duas partes de 32 bits
	push dword str_nt				;empilhando endereco da string
	call printf						;chamada de printf, que irá utilizar os valores empilhados
	add esp, 12


	fim:
	mov eax,1
  	mov ebx,0
  	int 80h