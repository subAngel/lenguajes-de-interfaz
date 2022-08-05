.model small

.stack

.data
     opcion01 db 10, 13, '[ Sumar dos numeros  ]$'
     opcion02 db 10, 13, '[ Restar dos numeros ]$'
     opcion03 db 10, 13, '[        SALIR       ]$'
     msgexit  db 10, 13, 'SALIENDO...$'

.code
     main proc far

     mov ax, @data
     mov ds, ax

     ; LIMPIAR PANTALLA 
     ;limpiar pantalla usando scroll
     mov ah, 06h ;funcion para hacer scroll tambien con 7h
     mov al,0h ;cantidad de filas a enrollar
     mov bh, 07h;atributos de color fondo y texto
     mov CX,00h;fila inicial en ch, columna inicial en cl
     mov DX, 184fh;fila final en dh, columna final en cl
     int 10h;ejecuta las interrupciones de video

     ; dibujar la x en la pantalla
     mov ah, 02h
     mov bh, 00     ; pagina de video
     mov dl, 79d    ; columna donde situar el cursor
                    ; 79 pq TASM tiene 80 columnas y empieza en 0
     mov dh, 0d     ; fila donde situar el cursor
     int 10h

     mov ah, 02h    ; instruccion para diburar un char
     mov dl, 'X'    ; dibujar la x
     int 21h

     ; dibujar la primer opcion en pantalla
     mov ah, 02h    ; posicionar el cursor
     mov bh, 00
     mov dl, 10d    ; cursor en la columna 10
     mov dh, 0d     ; en el segundo renglon
     int 10h
     mov ah, 09h
     lea dx, opcion01
     int 21h
     ; DIBUJAR LA SEGUNDA OPCION EN PANTALLA
     mov ah, 02h
     mov bh, 00
     mov dl, 10d
     mov dh, 1d
     int 10h
     mov ah, 09h
     lea dx, opcion02    ; imprimir la segunda opcion
     int 21h
     ; DIBUJAR LA TERCERA OPCION 'salir'
     mov ah, 02h
     mov bh, 00
     mov dl, 10d
     mov dh, 2d
     int 10h
     mov ah, 09h    ; imprimir la opcion 3
     lea dx, opcion03
     int 21h

     ; activar drivers del mouse
     mov ax, 00h
     int 33h

     CONSULTAR:
          mov ah, 01h    ; muestra el cursor del mouse
          int 33h
          mov ah, 03h    ; leer posicion y estado de los botones
          int 33h

          cmp bx, 1      ; SI boton izquierdo pulsado
          je IZQUIERDO

          cmp bx, 2      ; SI boton derecho es pulsado
          je CONSULTAR   ; volver a comprobar

     IZQUIERDO:
          ; obtengo las coordenadas del cursor
          mov ax, cx     ; cx = pos horizontal
          mov bl, 8
          div bl         ; dividir entre 8
          mov ejeX, al
          mov ax, dx     ; dx = pos vertical
          mov bl, 8
          div bl         ; dividir entre 8
          mov ejeY, al

          cmp ejeY, 0    ; si ejeY es 0                                                                                                                                            






     SALIR: 
          mov ah, 4ch
          int 21h



.exit
main endp
end main