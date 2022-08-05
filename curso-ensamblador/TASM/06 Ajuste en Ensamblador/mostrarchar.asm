.286
pila segment stack  ; segmento pila
     db 32 dup('stack--')
pila ends ; end

datos segment  ; segmentos de datos
     letra db 7,'A$'
datos ends 

codigo segment 'code'    ; segmento de codigo
main proc far 
     assume ss:pila, ds:datos, cs:codigo ; le indico a ensamblador que segmento es tal

     mov ax, datos
     mov ds, ax

     mov ah, 02h
     mov dl, 0 ; el caracter '0'
     add dl, 48 ; se le suma 48 para imprimir el caracter 0
     int 21h

     mov ah, 02h
     mov dl, letra
     int 21h
     
     mov ah, 4ch    ; funcion que finaliza el programa
     int 21h

     ret  ; retorna el procedimiento
main ENDP
codigo ends
end main