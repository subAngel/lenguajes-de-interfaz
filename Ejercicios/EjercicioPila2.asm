.model small
.stack
imprimir macro txt
     mov ah, 09h
     lea dx, txt
     int 21h
ENDM

.data
     palabra   dw ?
     n1   dw ?
     n2   dw ?
.code
     main proc far
          mov ax, @data
          mov ds, ax

          mov ah, 01h    ; leemos un caracter
          int 21h
          mov bl, al     ; lo guardamos en bl
          push bx   ; push y pop aceptan datos de 16 bits por eso lo paso completo

          mov bx, 0 ; limpiamos el registro bx

          mov ah, 01h    ; leemos un caracter
          int 21h

          mov bl, al     ; lo guardamos en bl
          push bx        ; lo guardamos en la pila

          pop bx    ; ahora empezamos a sacarlos

          mov ah, 02h    
          mov dl, bl
          int 21h

          pop bx    ; ahora empezamos a sacarlos

          mov ah, 02h    
          mov dl, bl
          int 21h



          mov ah, 4ch    ;  teminamos proceso
          int 21h


     main endp
end main