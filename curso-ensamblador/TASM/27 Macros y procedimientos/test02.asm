.model small
.stack
.data
.code
main proc far
     mov ax, @data
     mov ds, ax
     
     call limpiar_pantalla

     SALIR:
          mov ah, 4ch
          int 21h

     limpiar_pantalla proc near
          mov ah, 06h    ; desplazar las lineas hacia abajo
          mov al, 00h    ; 
          mov cx, 0000h
          mov dx, 184fh
          int 10h   
     limpiar_pantalla endp
.exit
main endp
end main