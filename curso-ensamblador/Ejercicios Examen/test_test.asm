.286
.model small
.stack
.data
     cadena    db 5 dup (' '),'$'
     aux       db ?
.code
     main proc far

     

     limpiar proc near
          mov ah, 06h ;funcion para hacer scroll tambien se puede con 7h
          mov al,0h ;cantidad de filas a enrollar
          mov bh, 07h;atributos de color fondo y texto
          mov CX,00h;fila inicial en ch, columna inicial en cl
          mov DX, 184fh;fila final en dh, columna final en cl
          int 10h;ejecuta las interrupciones de video
          ret
     limpiar endp
.exit
main endp
end main