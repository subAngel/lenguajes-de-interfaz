pila segment stack

pila ends

data segment   ; segmentos de datos
     labelinput db 10, 13, 'Ingrese un numero del 0 al 9: ','$'
     enter db 10,13,'$'
data ends 

code segment 'code'      ;segmento de codigo
main proc FAR
     assume ss:pila, ds:data, cs:code

     mov ax, data
     mov ds, ax

     mov ah, 09h    ; para mostrar datos en pantalla
     lea dx, labelinput
     int 21h        ; interrupcion para imprimir 

     mov ah, 01h    ; capturar un caracter en pantalla
     int 21h 

     ; imprimir el digito anterior
     mov cl, al     ;mover el caracter a cl

     ;funcion para dar un enter
     mov ah, 09h    
     lea dx, enter  
     int 21h

     mov ah, 02     ; el registro dl tuviera el valor del registro que le voy a pasar
     mov dl, cl
     int 21h
     ; funcion que finaliza el programa 
     mov ah, 4ch
     int 21h 

     ret

     
main endp
code ends
end main
