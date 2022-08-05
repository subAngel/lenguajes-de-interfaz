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


.stack
.data
     linea db 219,219,219,219,219,219,219,219,219,219,219,219,219,219, '$'
     uno   db 219,219, '$'
.code
     main proc far
          mov ax, @data
          mov ds, ax

          limpiar 00001011B
          posicionar 30d, 10d
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

          posicionar 42d, 11d
          imprimir uno
          posicionar 42, 12d
          imprimir uno
          posicionar 42d, 13d
          imprimir uno
          posicionar 42d, 14d
          imprimir uno

          posicionar 76d, 25d
          mov ah, 4ch
          int 21h
     main endp
end main