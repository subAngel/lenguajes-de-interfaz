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

     letraA:
          mov ah, 02h
          mov dl, 'A'
          int 21h

          mov ah, 02h
          mov dl, 32
          int 21h

          jmp numero3    

     
     
     numero3:
          mov ah, 02h
          mov dl, '3'
          int 21h

          mov ah, 02h
          mov dl, 10
          int 21h

          jmp numero5

     numero5:
          mov ah, 02h
          mov dl, '5'
          int 21h

     ; cerrar el programa
     mov ah, 4ch
     int 21h

     
     ret  ; retorna el procedimiento


main ENDP
codigo ends
end main