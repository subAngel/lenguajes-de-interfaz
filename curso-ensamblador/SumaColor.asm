TITLE cColor
.286
Spila SEGMENT STACK 
	DB 32 dup('stack___')
Spila ENDS
Sdatos SEGMENT
	Dato DB(0)
	espacio db 0dh, 0ah, '$'
	; 0dh enter
	; 0ah alinear cursos creo
	; centinela
Sdatos ENDS 
Scodigo SEGMENT 'CODE'
	Assume ss:Spila, ds:Sdatos,cs:Scodigo
Main PROC FAR
	Push ds 
	Push 0 
	Mov ax, sdatos 
	Mov ds, ax 
	;leer dos números
	Mov ah, 01h 
	Int 21h 
	Mov dato, al 
	Mov ah, 01h 
	Int 21h 


	;sumar los dos nuemros 
	Add al,dato  
	Sub al,30h

	;imprime el resutado de la suma 
	;Mov dl, al 
	;Mov ah, 02h 
	;Int 21h 

	Mov ah,9h		; mover a ah rutina 9h 
	Mov bh,0		; pantalla sobre la que se imprime
	Mov bl,12 	; color del caracter
	Mov cx,1		; Numero de veces a imprimir
	int 10h		; int: controla los servicios de pantalla del pc

	Ret 
	Main ENDP
	Scodigo ENDS 
	END main  

	; llamamos a un procedimiento con > call procedimiento

	;