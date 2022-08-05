pila segment 
pila ends 

data segment 
     arreglo db 3 dup(?)
     labelInput db 10, 13, 'Ingrese un numero (0-9): ','$'
     enter db 10,13, '$'
data ends

code segment 'code'
     ;description
main PROC FAR
     assume ss:pila, ds:data, cs:code
     
     mov ax, data
     mov ds, ax

     call input     ; llamar al input

     ; almacenar el digito en el arreglo
     mov si, 0 ; si = 0
     mov cx, 3 ; el ciclo se repite 3 veces, lo que mide el arreglo

     CICLO: ; aqui se llena nuestro arrelgo
          mov arreglo[si], cl ; mover el caracter a la posicion del arreglo
          inc si
          call input
          LOOP CICLO
          ; FIN DEL CICLO


    


     ; finalizar el programa
     mov ah, 4ch
     int 21h 

     ; procedimiento donde se piden los numeros
        
main ENDP

input PROC near
     mov ah, 09h         ; funcion que imprime en pantalla
     lea dx, labelInput
     int 21h

     mov ah, 01h         ; capturar un caracter en pantalla
     int 21h
     ; imprimir el digito anterior
     mov cl, al     ;mover el digito
     mov ah, 09h    ; imprimir el numero
     lea dx, enter  ; escribir el numero en la siguiente linea
     int 21h

     mov ah, 02h
     mov dl, cl
     int 21h

     ret
input ENDP 

code ends
end main