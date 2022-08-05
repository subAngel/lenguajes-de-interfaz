.model small

; macros
posicionar macro x, y    ; POSICIONAR EL CURSOR
     mov ah, 02h    ; pocisionar el cursor
     mov bh, 00h
     mov dl, x
     mov dh, y

     int 10h
ENDM

write macro etiqueta     ; MACRO PARA ESCRIBIR
     mov ah, 09h
     lea dx, etiqueta
     int 21h
ENDM

iniciar macro 
     push ds
     push a
     mov ax, @data
     mov ds, ax
ENDM
.stack 64
.data 
     ejeX      db ?, '$'
     ejeY      db ?, '$'
     opcion01  db 13,    '[  SUMAR DOS NUMEROS   ]$'
     opcion02  db 13,    '[  RESTAR DOS NUMEROS  ]$'
     opcion03  db 13,    '[       SALIR          ]$'
     saliendo  db 13, 'SALIENDO....$'
     input     db 13, 'Ingrese un numero de un digito   : $'
     resultado db 13, 'El resultado es                  : $'
     num1      db ?, '$'
     num2      db ?, '$'
     r         db ?, '$'

.code
main proc far
     mov ax, @data
     mov ds, ax

     call cls
     
     posicionar 4fh, 12d
     write opcion01

     posicionar 22h, 13d
     write opcion02

     posicionar 22h, 14d
     write opcion03


     

     

; 1 saber que boton del mouse fue presionado
; 2. catchar la posicion del mouse
; 3. 
     SALIR:
          mov ah, 4ch
          int 21h

     cls proc near  ; limpiar pantalla
          mov ax, 0600h
          mov bh, 0Dh
          mov cx, 0000h
          mov dx, 184fh
          int 10h

          ret
     cls endp
.exit
main endp
end main