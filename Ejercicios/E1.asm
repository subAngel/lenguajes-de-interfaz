; Realizar un programa que despliegue en pantalla su nombre
; 2 realizar un programa que te solicite el ingreso de una cadena y que lo imprima


.model small
.stack
.data
     nombre db 'Angel$'

.code 
     main proc far
          mov ax, @data
          mov ds, ax

          mov ah, 09h
          lea dx, nombre
          int 21h

          mov ah, 4ch
          int 21h
     main endp
end main