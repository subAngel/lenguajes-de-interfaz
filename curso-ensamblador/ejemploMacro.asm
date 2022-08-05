pila segment stack
     db 64 dup('PILA')
pila ends 

data segment
     msj db 10, 13, 'Mi primer procedimiento','$'
     msgInput db 10, 13, 'Ingrese un numero del 0 al 9: ', '$'
data ends 

code segment

main proc FAR
     assume ss:pila, ds:data, cs:code

main endp

input MACRO 
     Mov ah, 09h 
     lea dx, msgInput
     int 21h

     mov ah, 01h 
     int 21h
     ret
ENDM

code ends 
end main