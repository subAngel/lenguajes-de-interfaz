.model small

.stack 64

posicionar macro x, y    ; POSICIONAR EL CURSOR
     mov ah, 02h    ; pocisionar el cursor
     mov bh, 00h
     mov dl, x
     mov dh, y

     int 10h
ENDM

write macro letrero
     mov ah, 09h
     lea dx, letrero
     int 21h
ENDM
.data
     ejeX      db ?, '$'
     ejeY      db ?, '$'
     opcion01  db         '[  SUMAR DOS NUMEROS   ]$'
     opcion02  db 10, 13, '[  RESTAR DOS NUMEROS  ]$'
     opcion03  db 10, 13, '[       SALIR          ]$'
     saliendo  db 10, 13, 'SALIENDO....$'
     input     db 10, 13, 'Ingrese un numero de un signo    : $'
     resultado db 10, 13, 'El resultado es                  : $'
     num1      db ?, '$'
     num2      db ?, '$'
     r         db ?, '$'

.code
     main proc far
          mov ax, @data
          mov ds, ax

          mov ax, 0600h  ; funcion para desplegar linea arriba (limpiar pantalla)
          mov bh, 14     ; el primer digito indica el color de la pantalla, el segundo el color de la letra
          mov cx, 0000h  ; coordenadas donde empieza
          mov dx, 184fh  ; coordenadas donde acaba, se le pone este si es a toda la pantalla
          int 10h

          MENU:     
               ; POSICIONAR EL CURSOR EN PANTALLA
               mov ah, 02h    ; funcion para posicionar el cursor en pantalla
               mov dx, 0h  ; cursor renglon y columna

               mov dl, 0d    ; 0 a 70 (decimal)
               mov dh, 0d     ; 0 a 24 (decimal)
              
               
               mov bh, 00     ; pagina a imprimir
               int 10h

               ; mostrar las opciones
               mov ah, 09h
               lea dx, opcion01    ; opcion 1: SUMAR DOS NUMEROS
               int 21h

               lea dx, opcion02    ; opcion 2: RESTAR DOS NUMEROS
               int 21h
               lea dx, opcion03    ; opcion 3: SALIR
               int 21h
          CLICK:
               ; VER QUE CLICK ES PRECIONADO
               mov ax, 01h    ; funcion que activa el cursor del mouse
               int 33h

               mov ax, 03h      ; funcion para saber que boton del mouse es precionado
               int 33h

               cmp bx, 1      ; SI el boton izq fue presionado
               je COORDENADAS ; salta a la etiqueta COORDENADAS
               cmp bx, 2      ; si el boton derecho fue precionado (siempre esta por defecto)
               jmp CLICK
          COORDENADAS:
               ; ASIGNAR COORDENADAS
               mov ax, cx     ; La posicion en el ejeX(horizontal) se guarda en CX
               mov bl, 8      ; bl = 8
               div bl         ; dividir ax entre 8
               mov ejeX, al   ; el resultado de la division se guarda en al, ejeX = al

               mov ax, DX     ; EjeY (vertical) se guarda dx y se guarda en pixeles
               mov bl, 8
               div bl
               mov ejeY, al   

               ; COMPARAR COORDENADAS
               cmp ejeX, 0
               ja CLICK       ; si el valor es mayor a 0 vuelve a verificiar el boton del mouse

               cmp ejeY, 0    ; comparar si esta en la fila 0(opcion 1)
               je SUMAR

               cmp ejeY, 1    ; fila 1 (opcion2) : Restar numeros
               je RESTAR

               cmp ejeY, 2    ; fila 2 (opcion3) : salir
               je SALIR  ; se sale del programa
               jmp CLICK ; regresa a click

          SUMAR: 
               mov ah, 09h
               lea dx, input  ; imprimir mensaje de entrada
               int 21h

               mov ah, 01h    ; leer el caracter del teclado
               int 21h   ; llamamos al procedimiento para hacer la entrada

               mov num1, al   ; num1 = al

               mov ah, 09h
               lea dx, input  ; imprimir mensaje de entrada
               int 21h

               mov ah, 01h    ; leer el caracter del teclado
               int 21h   ; llamamos al procedimiento otra vez xd

               mov num2, al
               ;SUMA
               mov cl, num1   ; guardo el num1 en un registro
               add cl, num2   ; sumamos 
               mov r, cl   ; guardamos el resultado
               sub r, 30h  ; ajuste de caracter
               ; IMPRIMIR EL RESULTADO DE LA SUMA
               mov ah, 09h
               lea dx, resultado
               int 21h

               mov ah, 02h
               mov dl, r
               int 21h
               call esperar   ; esperar una tecla para salir
               jmp MENU  ; Regresa al menu

          RESTAR: 
               mov ah, 09h
               lea dx, input  ; imprimir mensaje de entrada
               int 21h

               mov ah, 01h    ; leer el caracter del teclado
               int 21h   ; llamamos al procedimiento 
               mov num1, al

               mov ah, 09h
               lea dx, input  ; imprimir mensaje de entrada
               int 21h

               mov ah, 01h    ; leer el caracter del teclado
               int 21h
               mov num2, al
               ; RESTA
               mov cl, num1
               sub cl, num2
               mov r, cl
               add r, 30h  ; ajuste de caracter
               
               mov ah, 09h    ; imprimir una cadena
               lea dx, resultado
               int 21h

               mov ah, 02h    ; imprimir un caracter en pantalla
               mov dl, r
               int 21h

               call esperar

               jmp MENU
               
          SALIR:
               call limpiar        ; llamar el proc para limpiar la pantalla

               mov ah, 09h
               lea dx, saliendo    ; imprimir el mensaje
               int 21h

               call esperar        ; 

               mov ah, 4ch
               int 21h


     esperar proc near
          mov ah, 02h
          mov dl, 32     ; espacio
          int 21h

          ret
     esperar endp 

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


