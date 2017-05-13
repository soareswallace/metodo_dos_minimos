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
