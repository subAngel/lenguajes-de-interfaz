.286
pila segment stack  ; segmento pila
     db 32 dup('stack--')
pila ends ; end

datos segment  ; segmentos de datos
     letrero01 db 13,'Ingresa un numero de un digito: $'
     letrero02 db 10, 13, 'El numero es: $'
datos ends 

codigo segment 'code'    ; segmento de codigo
main proc far 
     assume ss:pila, ds:datos, cs:codigo ; le indico a ensamblador que segmento es tal

     mov ax, datos
     mov ds, ax

     mov ah, 09h
     lea dx, letrero01
     int 21h

     mov ah, 01h
     int 21h
     ;sub al, 30h

     mov cl, al

     mov ah, 09h    ; imprimo el letrero 2
     lea dx, letrero02
     int 21h

     mov ah, 02h    ; imprimo el caracter en pantalla
     mov dl, cl     ; lo guardo en dl
     ;add dl, 30h
     int 21h
     
     mov ah, 4ch    ; funcion que finaliza el programa
     int 21h

     ret  ; retorna el procedimiento
main ENDP
codigo ends
end main