.286
pila segment stack
     db 32 dup('stack--')
pila ends

datos segment 
     letrero01 db 13, 'Ingrese un numero de un digito: $'
     letrero02 db 10, 13, 'El resultado es: $'

     n1 db 3   ; n1 = 3
     n2 db 4   ; n2 = 4
datos ends

codigo segment 'code'
main proc far
     assume ss:pila, ds:datos, cs:codigo

     mov ax, datos
     mov ds, ax

     mov al, n1     ; al = n1
     mov bl, n2

     add al, n2     ; al += n2     SUMA

     mov ah, 02h
     mov dl, al
     add dl, 30h
     int 21h

     mov ah, 4ch    ; funcion que finaliza el programa
     int 21h

     ret  ; retorna el procedimiento

     pedirN proc near
          mov ah, 09h
          lea dx, letrero01
          int 21h

          mov ah, 01h
          int 21h        ; se guarda en al

          mov cl, al     ; mover lo que hay en al a cl

          ret
     pedirN endp
main ENDP
codigo ends
end main