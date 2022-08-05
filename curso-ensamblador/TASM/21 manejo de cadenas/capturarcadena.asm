.model small 
.stack

limpiar macro color  ; macro para limpiar pantalla
     mov ax, 0600h  ; 
     mov bh, color
     mov cx, 0000h
     mov dx, 184fh
     int 10h
endm
print macro texto
     mov ah, 09h
     lea dx, texto
     int 21h
endm

.data
     cadena    db 10 dup (' '), '$'
.code
     main proc far
          mov ax, @data
          mov ds, ax

          mov ah, 3fh
          mov bx, 00h
          mov cx, 10
          lea dx, [cadena]
          int 21h

          print cadena


          SALIR:
               mov ah, 4ch
               int 21h
     main endp
end main