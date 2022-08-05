; Menu para leer caracteres 
; con opcion de entrada y salir 
; 
.286
.model small

;---------------------MACROS----------------------
mouse macro 
     mov ax, 01h    ; activa el cursor
     int 33h

     mov ax, 03h    ; ESTADO DEL MOUSE 
     INT 33h
endm
posicionar macro x, y, texto
     mov ah, 02h
     mov bh, 00h
     mov dh, y
     mov dl, x
     int 10h

     mov ah, 09h
     lea dx, texto
     int 21h
endm
asignar_pixel macro registro, eje    ; asignar las coordenadas al espacio de memoria
     mov ax, registro    ; la posicion en el registro
     mov bl, 8
     div bl    ; dividir entre 8
     mov eje, al    ; asigna el pixel al registro de memoria
ENDM
rango macro inicio, fin, etiqueta
     cmp ejeX, inicio
     jb CLICK
     cmp ejeX, fin
     ja CLICK
     JMP etiqueta
endm
capturar macro string
          mov ah, 3fh
          mov bx, 00h
          mov cx, 5d    ; valor definido en ds
          lea dx, string
          int 21h
endm
color macro caracter
     mov ah 09h
     mov al, caracter
     mov bh, 0
     mov bl, 1101B
     mov cx, 1
     int 10h
ENDM
; -------------------------END MACROS-----------------------
.stack
.data
     letrero1  db '[------Menu------]$'
     letrero2  db '[   Leer cadena  ]$'
     letrero3  db '[     Salir      ]$'
     entrada   db 'Ingrese una cadena: $'
     espacio   db 'Oprima espacio para volver al menu: $'
     saliendo  db 'SALIENDO....$'
     cadena    db 5 dup (' '),'$'
     ejeX      db ?, '$'
     ejeY      db ?, '$'
     char      db 0
.code
     main proc far
          push ds
          push 0
          mov ax, @data
          mov ds, ax
          
          call cls
          MENU:
               posicionar 27d, 10d, letrero1
               posicionar 27d, 11d, letrero2
               posicionar 27d, 12d, letrero3

          CLICK:
               mouse     ; macro del mouse
               cmp bx, 1 ; si el btn izq fue presionado
               je COORDENADAS
               cmp bx, 2 ; si el btn der fue presionado
               jmp CLICK

          COORDENADAS:
               asignar_pixel  cx, ejeX
               asignar_pixel  dx, ejeY

               cmp ejeY, 11d  ; compara si esta en la opcion 1 (leer cadena)
               je OP1    ; leer cadena

               cmp ejeY, 12d ; salir 
               je OP2 
               jmp CLICK

               cmp ejeX, 27d
          OP1:
               rango 27d, 51d, LLENAR_CADENA
               mov si, 0
          OP2:
               rango 27d, 51d, SALIR
          LLENAR_CADENA:
               posicionar 23d, 13d, entrada
               
               capturar cadena
               jmp PINTAR_CHAR
          
          PINTAR_CHAR:
               posicionar 34d, 15d, cadena
               jmp COORDENADAS

               

               call regresar ; OPRIMA ESPACIO

               JMP MENU
          P1:  ; pintar el caracter 1
               mov ah, 09h
               mov al, cadena[0]
               mov bh, 0h
               mov bl, 1101B
               mov cx, 1
               int 10h
          


          OPRIMA_ESP:
               posicionar 0d,0d, espacio
               call read


          SALIR:
               call cls
               posicionar 0,0, saliendo
               call esperar
               mov ah, 4ch
               int 21h
;-------------------PROCEDIMIENTOS------------------------
     cls proc near
          mov ax, 0600h
          mov bh, 00001010B
          mov cx, 0000h
          mov dx, 184fh
          int 10h
          ret
     cls endp
     read proc near
          mov ah, 01h
          int 21h
          ret
     read endp
     regresar proc near 
          mov ah, 09h
          lea dx, espacio
          int 21h
          mov ah, 01h
          int 21h
          ret
     regresar endp
     esperar proc near 
          mov ah, 02h
          mov dl, 32
          int 21h
          ret
     esperar endp
.exit
main endp
end main