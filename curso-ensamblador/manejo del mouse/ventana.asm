.model small 

.stack

.data
     der db 10, 13, 'Derecho$'
     izq db 10, 13, 'Izquierdo$'
     msg db 10, 13, 'SALIENDO...$'
     ejeX db ? ; coordenadas en el eje X     CX
     ejeY db ? ; coordenadas en el eje Y     DX

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

     ; DIBUJAR LA X EN LA PANTALLA
     mov ah, 02h
     mov bh, 00     ; pagina de video
     mov dl, 79d    ; columna donde situar el cursor
                    ; 79 pq TASM tiene 80 columnas y empieza en 0

     mov dh, 0d     ; fila donde situar el cursor
     int 10h

     mov ah, 02h    ; instruccion para diburar un char
     mov dl, 'X'    ; dibujar la x
     int 21h

     ; ACTIVAR/COMPROBAR EL DRIVER DEL MOUSE
     mov ax, 00h
     int 33h

     ; COMPROBAR QUE BOTON ES PULSADO
     CONSULTAR:
          ; MOSTRAR EL CURSOR DEL MOUSE
          MOV AH, 01h
          int 33h

          mov ax, 03h    ; 
          int 33h

          cmp bx, 1      ; click IZQUIERDO
          je IZQUIERDA
          cmp bx, 2      ; click DERECHO
          jmp CONSULTAR

          IZQUIERDA:
               ; dividir las filas y columnas entre 8
               mov ax, cx     ; posicion vertical
               mov bl, 8
               div bl
               mov ejeX, al   ; Guardar el resultado en ejeX

               mov ax, dx     ; coordenadas en Y
               mov bl, 8
               div bl
               mov ejeY, al   ; aqui ya tenemos los valores de nuestras coordenadas

               ; comparar las coordenadas
               cmp ejeY, 0    ; si es 0
               je COMPROBAR_VERTICAL    ; SALTAMOS A OTRA ETIQUETA
               jmp CONSULTAR  ; VOLVEMOS A REPETIR EL PROCESO

               COMPROBAR_VERTICAL:
                    cmp ejeX, 79d  ; comprobamos si esta en la columna final
                    ; imprimir mensaje de salir
                    mov ah, 09h
                    lea dx, msg
                    int 21h
                    
                    je SALIR
                    JMP CONSULTAR


     
     SALIR:
          mov ah, 4ch
          int 21h

.exit
     main endp
     end main