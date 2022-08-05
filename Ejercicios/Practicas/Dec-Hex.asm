.model small
.stack
imprimir macro texto     ; macro para imprimir
     mov ah, 09h
     lea dx, texto
     int 21h
endm
ajuste_letra macro n
     add n, 65D
endm
ajuste macro r, n   ; macro que hace un ajuste y lo pasa 
     sub r, 30h    ; a su respectivo numero
     mov n, r
endm
imprimir_n macro n
     mov ax, n ; al = n
     aam       ; ajuste de suma
     mov bx, ax ; registro completo para al
     mov ah, 02h; imprimir caracter
     mov dx, bx
     add dx, 30h
     int 21h

     mov ah, 02h    ; imprimir segundo digito
     mov dx, bx
     add dx, 30h    ; ajuste
     int 21h
endm
.data
     entrada   db 10, 13, 'Ingrese un numero hexadecimal: $'
     salida db 10, 13, 'conversion Hexadecimal: $'
     unidad    dw 0
     decena    dw 0
     numero    dw 0
     n_hex     dw 0
     l_hex     dw 0 ; letra hex
.code
     main proc far
          mov ax, @data
          mov ds, ax

          mov bx, 4Dh
          
          add bl, 55d
          add bh, 30h
          
          mov ah, 02H
          mov dl, bh
          int 21

          mov ah, 02H
          mov dl, bl
          int 21H


          


          SALIR:    ; Etiqueta que termina el proceso
               mov ah, 4ch
               int 21h
     main endp
     
     read proc near      ; procedimiento para leer un caracter
          mov ah, 01h
          int 21h
          ret
     read endp
end main

