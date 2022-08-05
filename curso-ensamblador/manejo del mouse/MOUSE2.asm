.model small
.stack

.data
     der db 10, 13, 'Derecho$'
     izq db 10, 13, 'Haz pulsado izquierda, se finalizara el programa$'
.code
main proc far
     mov ax, @data
     mov ds, ax

     ; activamos el driver del mouse
     mov ax, 00h
     int 33h

     ; hacemos visible el cursor
     mov ax, 01h
     int 33h

     ; aqui posicionamos el cursor en pantalla
     mov ah, 02h
     mov bh, 00
     mov dl, 79d
     mov dh, 00h
     int 10h

     ; imprimo el caracter x
     mov ah, 02h
     mov dl, 'X'
     int 21h

     ; Aqui empieza el manejo a profundidad del mouse
     ; consultamos con esta funcion que nos devuelve 
     ; el valor de las coordenadas y el click que se uso 
     ; 1 es el click izquierdo, 2 es el click derecho
     CONSUlTAR: 
          mov ax, 03h
          int 33h

          ; comprobamos si se hizo click derecho, por defecto esta activado
          cmp bx, 2
          je DERECHO
          ; si no compara ahora si tiene presionado el click izquierdo
          cmp bx, 1
          je IZQUIERDO

          DERECHO:
               mov ah, 09h
               lea dx, der
               int 21h
               jmp CONSUlTAR
          
          ; aqui esta el mensaje para cuando pulse el boton izquierdo
          IZQUIERDO:
               mov ah, 09h
               lea dx, izq
               int 21h
               jmp SALIR ; cuando presione el boton izquierdo se sale del programa

          SALIR:
               mov ah, 4ch
               int 21h
          
     
.exit
main endp
end main
