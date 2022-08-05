TITLE procedimientos
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

;description
main PROC FAR
     push ds
     push 0
     mov ax, sdatos
     mov ds, ax
     
     call read ; push sgte instruction jump label
     mov dato, al
     mov ah, 09h 
     mov dx, offset espacio
     Int 21h 
     call read
     mov ah, 09h
     mov dx, offset espacio
     Int 21h 
     ; sumar numeros
     add al,dato
     add al, 30h
     Mov dl, al 
     Mov ah, 02h 
     int 21h
     Ret 
main ENDP

read PROC near 
     mov ah, 01h
     Int 21h 
     ret ; pop siguiente instruccion
read ENDP

scodigo ENDS 
     END main