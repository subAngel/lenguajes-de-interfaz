.model small 

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
printf macro char, color
     mov ah, 09h
     mov al, char
     mov bh, 0d
     mov bl, color
     mov cx, 1d
     int 10h
endm

.stack
.data
     linea db 219,219,219,219,219,219,219,219,219,219,219,219,219, '$'
     uno   db 219,219, '$'
     nombre db 'angel$'
.code
     main proc far
          mov ax, @data
          mov ds, ax

          limpiar 00001001B
          posicionar 30d, 11d
          imprimir linea
          posicionar 30d, 15d
          imprimir linea

          posicionar 30d, 11d
          imprimir uno
          posicionar 30d, 12d
          imprimir uno
          posicionar 30d, 13d
          imprimir uno
          posicionar 30d, 14d
          imprimir uno

          posicionar 41d, 11d
          imprimir uno
          posicionar 41, 12d
          imprimir uno
          posicionar 41d, 13d
          imprimir uno
          posicionar 41d, 14d
          imprimir uno

          ; nombre
          posicionar 34d, 13d
          printf 'a', 00001111B
          posicionar 35d, 13d
          printf 'n', 00001011B
          posicionar 36d, 13d
          printf 'g', 00001010B
          posicionar 37d, 13d
          printf 'e', 00001101B
          posicionar 38d, 13d
          printf 'l', 00001110B

          ; fin 
          posicionar 76d, 25d
          mov ah, 4ch
          int 21h
     main endp
end main