; Ajustes en ensamblador
; 

.286
pila segment stack  ; segmento pila
     db 32 dup('stack--')
pila ends ; end

datos segment  ; segmentos de datos
     letrero01 db 13, 'Hola mundo$' ; 10 y 13 hacen referencia al codigo ascii, con 10 es salto de linea
     letrero02 db 10, 13, 'Adios mundo$' ; 13 es el retorno de carro
datos ends 

codigo segment 'code'    ; segmento de codigo
main proc far 
     assume ss:pila, ds:datos, cs:codigo ; le indico a ensamblador que segmento es tal

     mov ax, datos
     mov ds, ax

     mov ah, 09h    ; funcion para imprimir en pantalla
     lea dx, letrero01
     int 21h

     mov ah, 09h
     lea dx, letrero02
     int 21h

     mov ah, 4ch    ; funcion que finaliza el programa
     int 21h

     ret  ; retorna el procedimiento
main ENDP
codigo ends
end main