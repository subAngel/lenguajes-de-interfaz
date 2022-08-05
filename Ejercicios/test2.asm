.model tiny
	.stack 64
	.386

	.data
	gacPerin	db	...
	iStart 		dw 0
	iStop 		dw 0
	
	.code
	org 100h
	.startup
	
	;Segmento ES apuntando a framebuffer
	mov ax, 0A000h
	mov es, ax

	;Modo 13
	mov ax, 13h
	int 10h

	;Asignar toda la paleta
	xor cx, cx
	lea si, gacPerin[64000]
	.repeat
		mov dx, 3c8h
		mov al, cl
		out dx, al
		
		;El DAC espera los valores en el rango 0..63,  por lo que debemos dividir cada uno por 4 (0..255).
		mov dx, 3c9h
		rept 3
			lodsb
			shr al, 2
			out dx, al
		endm
		inc cx
	.until cx >= 256				;cmp cx, 256; jb setpal
	
	;Contador de inicio
	xor ah, ah
	int 1ah
	mov iStart, dx
	
	xor bp, bp						;frames en bp
	.repeat
		;Volcar al framebuffer 320x200 pixeles
		lea si, gacPerin
		xor di, di
		mov cx, 64000/4
		rep movsd
		inc bp						;frames++

		;Comprobar pulsación de tecla
		mov ah, 1
		int 16h
	.until !zero?					;jz

	;Leer tecla del buffer
	xor ah, ah
	int 16h
	
	;Contador de fin
	xor ah, ah
	int 1ah
	mov iStop, dx
	
	;Modo texto
	mov ax, 3h
	int 10h

	;Escribir frames
	mov ax, bp
	lea di, gacPerin
	call itoa
	mov ah, 09h
	lea dx, gacPerin
	int 21h	

	;Escribir FPS
	mov ax, bp
	mov bx, 18
	mul bx						;ax=frames*18
	
	xor dx, dx
	mov bx, iStop
	sub bx, iStart
	div bx						;dx:ax=ax/(iStop-iStart
	
	lea di, gacPerin
	call itoa
	mov ah, 09h
	lea dx, gacPerin
	int 21h	
	
	;Salir a DOS
    .exit						;mov ah, 4ch; int 21h