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
     mov al, n ; al = n
     aam       ; ajuste de suma
     mov bx, ax ; registro completo para al
     mov ah, 02h; imprimir caracter
     mov dl, bh
     add dl, 30h
     int 21h

     mov ah, 02h    ; imprimir segundo digito
     mov dl, bl
     add dl, 30h    ; ajuste
     int 21h
endm
.data
     entrada   db 10, 13, 'Ingrese un numero [00-99]: $'
     salida db 10, 13, 'conversion Decimal-Hexadecimal: $'
     unidad    dw 0
     decena    dw 0
     numero    dw 0
     n_hex     dw 0
     l_hex     dw ? ; letra hex
.code
     main proc far
          mov ax, @data
          mov ds, ax

          imprimir entrada    ; llamar a la macro para imprimir
          call read           ; llamada al procedimiento de leer un caracter    
          ajuste ax, decena   ; ajustamos el digito y lo paso al numero

          call read           ; leer digito
          ajuste ax, unidad   ; ajustar digito y asignarlo

          ; multiplicar la decena por 10
          mov ax, decena ; al = decena
          mov bx, 10     ; bl = 10
          mul bx         ; decena * 10
          add ax, unidad ; decena + unidad = numero completo
          mov numero, ax ; numero completo

          imprimir salida; imprimo el texto de salida
          ;imprimir_n numero
          
          ; Decimal a Hexadecimal
          mov ax, numero ; dividendo
          mov dx, 0      ; dx = 0
          mov cx, 16     ; divisor
          div cx         ; ax/cx y se guarda en ax
          ; residuo se guarda en dx
          mov n_hex, ax  ; ugardo la letra
          sub n_hex, 128d
          mov l_hex, dx
          add l_hex, 55D    ; ajusto la letra 

          mov ah, 02H
          mov dx, n_hex
          int 21H
          mov ah, 02H
          mov dx, l_hex
          int 21h


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

