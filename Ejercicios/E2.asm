; 2 realizar un programa que te solicite el ingreso de una cadena y que lo imprima

.model small
.stack
.data
     cadena    db 40 dup (' '), '$'
     letrero1  db 'Ingrese una cadena: $'
.code
     main proc far
          mov ax, @data
          mov ds, ax

          mov ah, 09h         ; opcion para imprimir una cadena
          lea dx, letrero1    ; pasar la cadena a imprimir
          int 21h

          mov ah, 3fh    ; lectura desde un archivo 
          mov bx, 00h    ; manejador de archivo 
          mov cx, 40d    ; numero de bytes 
          lea dx, cadena ; pasar la cadena
          int 21h

          mov ah, 09h
          lea dx, cadena
          int 21h

          mov ah, 4ch    ; para salir / terminar proceso
          int 21h
     main endp
end main

