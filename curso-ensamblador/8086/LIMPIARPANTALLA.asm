.model small
.stack
.data
.code
.startup
;limpiar pantalla usando scroll
        mov ah, 06h ;funcion para hacer scroll tambien con 7h
        mov al,0h ;cantidad de filas a enrollar
        mov bh, 07h;atributos de color fondo y texto
        mov CX,00h;fila inicial en ch, columna inicial en cl
        mov DX, 184fh;fila final en dh, columna final en cl
        int 10h;ejecuta las interrupciones de video
       
        mov ah,02h
        mov dl, 31h
        int 21h
.exit
end