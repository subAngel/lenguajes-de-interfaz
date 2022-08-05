.286
pila segment stack
     db 32 dup('stack--')
pila ends

datos segment 
     letrero01 db 13, 10, 'Ingrese un numero de un digito   : $'
     letrero02 db 10, 13, 'El resultado es                  : $'

     n1 db 3   ; n1 = 3
     n2 db 3   ; n2 = 4
     r  db ?   ; resultado
datos ends

codigo segment 'code'
main proc far
     assume ss:pila, ds:datos, cs:codigo

     mov ax, datos
     mov ds, ax

     ; Multiplicacion
     mov al, n1
     mov bl, n2
     mul bl    ; MUL multiplica el registro que se le da con AL
     ; el resultado se queda guardado en AL

     mov ah, 02h
     add al, 30h    ; AJUSTE
     mov dl, al
     int 21h

     ; cerrar el programa
     mov ah, 4ch
     int 21h


     ret  ; retorna el procedimiento

main ENDP
codigo ends
end main