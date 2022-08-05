pila segment stack

pila ends

data segment   ; segmentos de datos
     labelinput db 10, 13, 'Ingrese un numero del 0 al 9: ','$'
     enter db 10,13,'$'
data ends 

code segment 'code'      ;segmento de codigo
main proc FAR
     assume ss:pila, ds:data, cs:code

     call impInput  ; llamada al procedimiento
     call impEnter
     call impOutput

     call impInput ; llamada al proc 
     call impEnter
     call impOutput

     call impInput
     call impEnter
     call impOutput

     ; imprimir el digito anterior
     ;mov cl, al     ;mover el caracter a cl

     ;funcion para dar un enter
     ; mov ah, 09h    
     ; lea dx, enter  
     ; int 21h

     ; imprimir el caracter
     ; mov ah, 02     ; el registro dl tuviera el valor del registro que le voy a pasar
     ; mov dl, cl
     ; int 21h
     ; funcion que finaliza el programa 
     mov ah, 4ch
     int 21h 

     ret

     

main endp
     ; imprimir un salto de linea
     impEnter PROC near
          mov ah, 09h
          lea dx, enter
          int 21h 
          ret
     impEnter endp 
     ; imprimir la salida
     impOutput PROC near
          mov cl, al

          mov ah, 02
          mov dl, cl 
          int 21h

          ret
     impOutput endp
     ; imprimir mensaje para input
     impInput PROC near   ; procedimiento para imprimir el input
          mov ah, 09h     ; para mostrar datos en pantalla
          lea dx, labelinput ; lee la etiqueta
          int 21h        ; interrupcion

          mov ah, 01h    ; capturar un caracter del teclado
          int 21h
     ret
     impInput ENDP
code ends
end main
