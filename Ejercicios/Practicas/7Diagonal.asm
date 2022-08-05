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
     mov al, 47d
     mov bh, 0d
     mov bl, color
     mov cx, 1d
     int 10h
endm



.data
     diagonal  db '/$'

.code
     main proc far
          mov ax, @data
          mov ds, ax

          limpiar 00001010B
          posicionar 16d, 10d
          printf 1010B
          posicionar 15d, 11d
          printf 1011B
          posicionar 14d, 12d
          printf 1100B
          posicionar 13d, 13d
          printf 1101B
          posicionar 12d, 14d
          printf 1001B
          posicionar 11d, 15d
          printf 1110B
          posicionar 10d, 16d
          printf 1111B


          SALIR:
               mov ah, 4ch
               int 21h
     main endp
end main