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
     nombre   db 'ANGEL$'
.code
     main proc far
          mov ax, @data
          mov ds, ax

          limpiar 00001010B

          posicionar 0d, 0d   ; esquina superior izquierda
          imprimir nombre

          posicionar 74d, 0d 
          imprimir nombre

          posicionar 0d, 23d
          imprimir nombre

          posicionar 74d, 23d
          imprimir nombre


          mov ah, 4ch    ; SALIR
          int 21h


     main endp
end main