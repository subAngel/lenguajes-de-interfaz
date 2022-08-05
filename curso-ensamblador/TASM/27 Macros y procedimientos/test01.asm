     ; INICIO DE LA MACRO
print MACRO cadena, posX, posY
     mov ah, 02h
     mov bh, 00h
     mov dh, posY
     mov dl, posX
     int 10h
     
     mov ah, 09h
     lea dx, cadena
     int 21h


ENDM

.model small
.stack
.data
     frase     db 13, 'Hola Mundo$'
.code
     main proc far
          mov ax, @data
          mov ds, ax

          print frase, 70, 20

          mov ah,06h      ; funcion que dezplaza lineas hacia arriba (limpiar pantalla)
          mov al,00h      ; modo de video
          mov bh,06h      ; atributo a usar: el primer digito es el color de la pantalla el segundo el del texto
          mov cx,0000h    ; filas y columnas donde empezara 
          mov dx,184fh    ; filas y columnas donde acabara la limpieza de pantalla
          int 10h

          print frase, 12h, 00h

          print frase, 12h, 01h

          print frase, 10h, 02h

          mov ah, 4ch
          int 21h

.exit
main endp
end main