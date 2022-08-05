.286
.model small
.stack

.data
     array     db 3 dup(?)
     array2    db 3 dup(?)
     letrero01 db        'Ingrese 3 ditos: $'
     letrero02 db 10, 13, 'Los digitos ordenados son: $'
.code
main proc far
     push ds
     push 0
     mov ax, @data
     mov ds, ax

     mov ah, 09h
     lea dx, letrero01
     int 21h

     mov si, 0
     CICLO:
          call input
          mov array[si], al
          add si, 1
          cmp si, 2
          jbe CICLO ; Si aun si no llega a 2 (0,1,2) se vuelve a repetir el ciclo
     
     
     mov ah, 09h
     lea dx, letrero02
     int 21h

     mov si, 0     ; valor inicial de si
     mov ah, array[si]
     
     ORDENAR:
          cmp ah, array[si+1]   ; comparar la primera posicion del arreglo con la primera
          ja ALMACENA   ; si la primera es mayor, salto a almacenar
          mov ah, array[si+1] ;
     ALMACENA:
          inc si    ; incrementa SI una unidad
          cmp si, 2 ; hasta que sea igual a 2
          mov array2[si], ah
          jbe ORDENAR    ; Si es menor a 2 entonces vuelve a cmparar y almacenarlo en el arreglo

     mov ah, 09h 
     lea dx, array2
     int 21h

     
     

     ; salir
     mov ah, 4ch
     int 21h

     input proc near     ; retorna el caracter en al
          mov ah, 01h
          int 21h
          ret
     input endp
     output proc near
          mov ah, 02h
          int 21h
          ret
     output endp
     
.exit
main endp
end main