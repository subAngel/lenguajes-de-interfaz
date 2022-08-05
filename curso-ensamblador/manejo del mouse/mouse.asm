.model small 
.stack

.data
     hola db  13, 'Hola$'
     der db 10, 13, 'Derecho$'
     izq db 10, 13, 'Izquierdo$'
     msg db 10, 13, 'saliendo$'
.code
     main proc far

     mov ax, @data
     mov ds, ax

     ; poner el registro completo para controlar el mouse
     mov ax, 00h    ; RESETEA EL DRIVER DEL MOUSE 
     int 33h        ; PARA VER SI HAY MOUSE

     mov ax, 01h    ; MUESTRA EL CURSOR 
     int 33h        ; NO DEVUELVE NADA

     CONSULTAR:
     mov ax, 03h    ; leer posicion y estado del mouse
     int 33h

     cmp bx, 2      ; Comprueba si el boton pulsado es el derecho
     je DERECHO
     cmp bx, 1      ; comprueba si el boton pulsado es el izquierdo
     je IZQUIERDA

     DERECHO:
          mov ah, 09h
          lea dx, der
          int 21h

          jmp CONSULTAR
     IZQUIERDA:
          mov ah, 09h
          lea dx, izq
          int 21h

          jmp CONSULTAR

     SALIR:
          mov ah, 09h
          lea dx, msg
          int 21h 

          mov ah, 4ch
          int 21h
.exit
main endp
end main