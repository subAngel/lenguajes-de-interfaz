.model small
.stack

posicionar macro x, y    ; macro para posicionar el cursor
     mov ah, 02h    
     mov bh, 00h    ; pagina de video
     mov dh, y      ; linea del cursor
     mov dl, x      ; columna del cursor
     int 10h
ENDM

limpiar macro color  ; macro para limpiar pantalla
     mov ax, 0600h  ; 
     mov bh, color
     mov cx, 0000h
     mov dx, 184fh
     int 10h
endm
imprimir macro texto
     mov ah, 09h
     lea dx, texto
     int 21h
endm
printf macro color
     mov ah, 09h
     mov al, 90d    ; caraacter 
     mov bh, 0d     ; pagina
     mov bl, color  ; color 
     mov cx, 1d     ; veces 
     int 10h
endm

.data

.code
     main proc far
          mov ax, @data
          mov ds, ax

          @@WHILE:
               printf 1101B
               mov ah, 01h    ; leer un caracter 
               int 21h
               cmp al, 19
               je SALIR
               jne @@WHILE
               

          SALIR:
               mov ah, 4ch
               int 21h
     main endp
     
end main