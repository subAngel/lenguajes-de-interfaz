.model small
.stack

posicionar macro x, y    ; macro para posicionar el cursor
     mov ah, 02h    
     mov bh, 00h    ; pagina de video
     mov dh, y      ; linea del cursor
     mov dl, x      ; columna del cursor
     int 10h
ENDM
imprimir macro texto
     mov ah, 09h
     lea dx, texto
     int 21h
endm

.data
     asterisco      db '*', '$'
     x              db 28h    ; se encargan del control de las filas
     y              db 0h     ; y las columnas
     aux            db 9      ; modifiicar aqui para establecer la cantidad de filas
     cant           db 01h
     c1             db        254,' ',254, '$'
     c2             db   254, '     ', 254, '$'
     c3             db 254,'           ', 254, '$'
.code
     main proc far
          mov ax, @data
          mov ds, ax

          mov ah,06h      ; funcion que dezplaza lineas hacia arriba (limpiar pantalla)
          mov al,00h      ; modo de video
          mov bh,03h      ; atributo a usar: el primer digito es el color de la pantalla el segundo el del texto
          mov cx,0000h    ; filas y columnas donde empezara 
          mov dx,184fh    ; filas y columnas donde acabara la limpieza de pantalla
          int 10h

     mov cx, 0000h
     primerC:  ; primer condicional
          mov ah, 02h
          mov bh, 00h
          mov dh, y
          mov dl, x
          int 10h

          mov bx, cx

          mov cx, 0000h ; limpiar registro cx
          segundoC:
               mov ah, 02h    ; imprimir un asterisco
               mov dl, asterisco
               int 21h

               inc cl    ; incrementar el registro cl
               cmp cl, cant
               jb segundoC    ; Jump Below: salta si es menor 

          mov cx, bx

          sub x, 1  ; retroceder una columna hacia atras
          add y, 1  ; una fila hacia abajo

          add cant, 2    ; sumar a la cantidad 2

          inc cl
          cmp cl, aux    ; cmp cuantas filas para ver el alto de la piramide
          ; si fuera menor 
          jb primerC     ; para repetir todo


          CIRCULO:
               posicionar 37d, 11d
               imprimir c1
               posicionar 35d, 12d
               imprimir c2
               posicionar 35d, 13d
               imprimir c2
               posicionar 37d, 14d
               imprimir c1

          SALIR:
               mov ah, 4ch
               int 21h     

     main endp
end main