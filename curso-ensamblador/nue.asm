TITLE suma2
.286
Spila SEGMENT STACK 
	DB 32 dup('stack___')
Spila ENDS
Sdatos SEGMENT
	Dato DB(0)
	Espacio DB 0DH,0Ah,'$'
Sdatos ENDS 
Scodigo SEGMENT 'CODE'
	Assume ss:Spila, ds:Sdatos,cs:Scodigo
Main PROC FAR
	Push ds 
	Push 0 
	Mov ax, sdatos 
	Mov ds, ax 
	CALL Read

	Mov ah, 01h 
	Int 21h 

	Mov dato, al 
	Mov ah, 09h
	Mov dx,offset espacio
	Int 21h 
	CALL Read
	Mov ah, 01h
	int 21h
	Mov ah,09h
	Mov dx,offset espacio 
	int 21h

	Mov ah,9h
	Mov bh,0
	Mov bl,13
	Mov cx,1
	int 10h 

	add al, dato
	sub al,30h
	mov dl,al
	mov ah,02h
	int 21h
	Ret 
Main ENDP

Read PROC NEAR
	Mov ah,01h
	RET
Read ENDP
Scodigo ENDS 
END main  