.286
pila segment stack
     db 32 dup('stack--')
pila ends

datos segment 
     letrero01 db 13, 10, 'Ingrese un numero de un digito   : $'
     letrero02 db 10, 13, 'El resultado es                  : $'

     n1 db ?   ; n1 = 3
     n2 db ?   ; n2 = 4
     r  db ?   ; resultado
datos ends

codigo segment 'code'
main proc far
     assume ss:pila, ds:datos, cs:codigo

     mov ax, datos
     mov ds, ax

     ; imprimir el primer mensaje para ingresar un digito
     mov ah, 09h
     lea dx, letrero01
     int 21h 

     ; leo el caracter
     mov ah, 01h
     int 21h

     mov n1, al     ; guardo el caracter en n1
     ; pedir el numero
     mov ah, 09h
     lea dx, letrero01
     int 21h

     mov ah, 01h
     int 21h

     mov n2, al     ; guardar el caracter en 21
     
     ;RESTA
     mov cl, n1
     sub cl, al     ; guardo el resultado en cl
     add cl, 30h    ; ajuste de caracteres

     ; cadena resultado
     mov ah, 09h
     lea dx, letrero02
     int 21h
     ; resultado de la resta
     mov ah, 02h
     mov dl, cl     ; imprimo cl para ver el resultado
     int 21h

     ; cerrar el programa
     mov ah, 4ch
     int 21h


     ret  ; retorna el procedimiento

main ENDP
codigo ends
end main