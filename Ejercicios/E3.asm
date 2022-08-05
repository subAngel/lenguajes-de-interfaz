; 16 de julio
; Realiza un programa en el cual se comparen dos numeros y se despliegue si son iguales, mayor que, menor que
; y agregue comentarios en cada linea

.model small
.stack
.data
     num1      db 7      ; num1 = 7
     num2      db 5      ; num2 = 5
     iguales   db 'Son iguales$'
     mayorque  db 'n1 es mayor que n2$'
     menorque  db 'n1 es menor que n2$'

.code
     main proc far
          mov ax, @data
          mov ds, ax

          sub bx, bx     ; para que bx tenga 0
          mov bl, num1   ; bl = num1
          mov bh, num2   ; bh = num2
          cmp bl, bh     ; comparo los registros
          ja MAYOR
          je IGUAL
          jb MENOR

          MAYOR:         ; si num1 es mayor al numero 2
               mov ah, 09h         ; se imprime que es mayor
               lea dx, mayorque
               int 21h

               jmp SALIR      ; despues salta a sailr
          MENOR:         ; si num1 es menor al num 2
               mov ah, 09h    
               lea dx, menorque    ; imprime que es menor
               int 21h

               jmp SALIR      ; se sale del programa
          IGUAL:         ; si los dos numeros son iguales 
               MOV AH, 09h
               lea dx, iguales     ; imprime que son iguales
               int 21h

               jmp SALIR           ; y sale del programa
          SALIR:    
               MOV AH, 4ch    ; termina el proceso
               int 21h
     main endp
end main