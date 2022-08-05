.286
pila segment stack
     db 32 dup('stack--')
pila ends

datos segment 
     txt_no_iguales db 13, 10, 'No son iguales$'
     txt_iguales db 10, 13, 'Son iguales$'

     n1 db 2  ; n1 = 3
     n2 db 2   ; n2 = 4
     r  db ?   ; resultado
datos ends

codigo segment 'code'
main proc far
     assume ss:pila, ds:datos, cs:codigo

     mov ax, datos
     mov ds, ax

     mov bl, n1
     mov bh, n2

     cmp bl, bh
     je iguales
     jne noiguales

     iguales: 
          mov ah, 09h
          lea dx, txt_iguales
          int 21h
          jmp salida

     noiguales: 
          mov ah, 09h
          lea dx, txt_no_iguales
          int 21h
          jmp salida
          

     ; cerrar el programa
     salida:
          mov ah, 4ch
          int 21h

     
     ret  ; retorna el procedimiento


main ENDP
codigo ends
end main