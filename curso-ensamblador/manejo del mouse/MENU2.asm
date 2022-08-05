.model small 
; PROCEDIMIENTOS
write macro texto     ; macro para escribir la palabra
     mov ah, 09h
     lea dx, texto
     int 21h
ENDM
posicionar macro x, y    ; macro para posicionar el cursor
     mov ah, 02h
     mov bh, 00h
     mov dh, y
     mov dl, x
     int 10h
ENDM
limpiar macro  ; macro para limpiar pantalla
     mov ax, 0600h
     mov bh, 03h
     mov cx, 0000h
     mov dx, 184fh
     int 10h
ENDM
; CX para EjeX ; DX para EjeY
asignar_pixel macro registro, eje    ; asignar las coordenadas al espacio de memoria
     mov ax, registro    ; la posicion en el registro
     mov bl, 8
     div bl    ; dividir entre 8
     mov eje, al    ; asigna el pixel al registro de memoria
ENDM

asignar_num macro numero
     mov ah, 01h    ; leer un numero del teclado
     mov numero, al
     
     int 21h
ENDM

suma macro 
     posicionar 0d, 15d
     write input
     call read
     mov num1, al
     posicionar 0d, 16d
     write input
     call read
     mov num2, al
     posicionar 0d, 17d
     write respuesta
     mov al, num1
     add al, num2
     sub al, 30h
     mov resultado, al
     mov ah, 02h
     mov dl, resultado
     int 21h
ENDM
resta macro 
     posicionar 0d, 15d
     write input
     call read
     sub al, 30h
     mov num1, al
     posicionar 0d, 16d
     write input
     call read
     sub al, 30h
     sub num1, al
     add num1, 30h
     posicionar 0d, 17d
     write respuesta
     mov ah, 02h
     mov dl, num1
     int 21h
ENDM
rango macro inicio, fin, letrero
     cmp ejeX, inicio
     jb CLICK
     cmp ejeX, fin
     ja CLICK
     jmp letrero
ENDM

.stack
.data
     ejeX      db ?, '$'
     ejeY      db ?, '$'
     opcion01  db        '[  SUMAR DOS NUMEROS   ]$'
     opcion02  db        '[  RESTAR DOS NUMEROS  ]$'
     opcion03  db        '[       SALIR          ]$'
     saliendo  db 13,    'SALIENDO....$'
     input     db        'Ingrese un numero de un digito   : $'
     respuesta db        'El resultado es                  : $'
     espacio   db        'Oprima espacio para volver al menu: $'
     num1      db ?
     num2      db ?
     resultado db ?
.code
main proc far
     mov ax, @data
     mov ds, ax

     MENU:
          posicionar 27d, 11d
          limpiar
          write opcion01
          posicionar 27d, 12d
          write opcion02
          posicionar 27d, 13d
          write opcion03
     CLICK:
          mov ah, 01h    ; activar el cursor
          int 33h

          mov ax, 03h    ; estado del mouse(boton presionado)
          int 33h
          
          cmp bx, 1      ; si el btn izq fue presionado
          je COORDENADAS ; verifica las coordenadas
          cmp bx, 2      ; si el btn der es presionado
          jmp CLICK 
     COORDENADAS:
          asignar_pixel cx, ejeX
          asignar_pixel dx, ejeY

          ; comparar coordenadas
          cmp ejeX, 27d
          ja CLICK       ; si valor > 0 vuelve a comprobar el click
          cmp ejeY, 11d    ; comparar si esta en la fila 0(opcion 1)
          je SUMAR

          cmp ejeY, 12d    ; fila 1 (opcion2) : Restar numeros
          je RESTAR

          cmp ejeY, 13d    ; fila 2 (opcion3) : salir
          je EXIT  ; se sale del programa
          jmp CLICK ; regresa a click
     SUMAR:
          suma

          posicionar 79d, 0d
          mov ah, 01h
          int 21h
          call esperar   ; esperar un caracter del teclado
          jmp MENU
     RESTAR:
          resta
          
          posicionar 40d, 0d
          mov ah, 09h
          lea dx, espacio
          int 21h

          mov ah, 01h
          int 21h

          call esperar
          jmp MENU
     EXIT:
          posicionar 0d, 0d
          limpiar
          write saliendo
          call esperar
          mov ah, 4ch
          int 21h
     ret
     esperar proc near
          mov ah, 02h
          mov dl, 32     ; ascii de espacio
          int 21h
          ret
     esperar endp
     read proc near
          mov ah, 01h
          int 21h
          ret
     read endp
.exit
main endp
end main
