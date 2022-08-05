.model small
.stack
imprimir macro texto
     mov ah, 09h
     lea dx, texto
     int 21H
endm

.data
     txt_suma  db 10, 13, '1. Suma$'
     txt_resta db 10, 13, '2. Resta$'
     txt_salir db 10, 13, '3. Salir$'
     opcion    db 10, 13, 'Ingrese una opcion [1/2/3]: $'
     entrada   db 10, 13, 'Ingrese un numero hexadecimal [0 -> F]: $'
     incorrect db 10, 13, 'NUmero incorrecto.$'
     resul     db 10, 13, 'Resultado = $'
     n1        db ?
     n2        db ?
     rsuma     db ?
     rresta    db ?
.code
     main proc far
          mov ax, @data
          mov ds, ax

          INICIO:     
               imprimir txt_suma   ; Imprimir el menu
               imprimir txt_resta  ; imprimir el menu
               imprimir txt_salir
               imprimir opcion     ; imprimir la opcion
               call read           ; leer un digito
               cmp al, 49d
               je OP1
               cmp al, 50d
               je OP2
               cmp al, 51d
               je SALIR
          OP1:     
               imprimir entrada    ; input
               call read           ; obtengo el digito
               mov n1, al          ; asigno el primer numero
               mov bl, n1
               imprimir entrada    ; input
               call read           ; obtengo el digito
               mov n2, al          ; asigno el numero
               mov bh, n2

               cmp bl, 39h    ; comparar n1 
               ja LETRA       ; si es mayor a 9 ascii, entonces es una letra
               sub bl, 30h    ; si no, es un numero y se ajusta
               jmp Num2         ; despues se pasa a pedir el numero 2

          LETRA:
               sub bl, 55d    ; ajuste de letra
          Num2:
               cmp bh, 39h    ; si n2 es mayor a 9 ascii
               ja LETRA1      ; si se pasa entonces es una letra

               sub bh, 30h    ; si no se ajusta el numero
               jmp SUMAR
          LETRA1:
               SUB n2, 55d    ; SI ES LETRA SE AJUSTA
          SUMAR:
               add bh, bl
               mov rsuma, bh  ; se hace la suma
               mov bl, bh

               mov cl, 04h    ; veces que voy a mover los bytes
               shr bh, cl     ; muevo los bytes para leer el numero

               cmp bh, 09h
               JA HEXA

               add bh, 30h
               imprimir resul ; imprimiendo el resultado
               jmp PRINT
          HEXA:
               add bh, 55D    ; se ajusta la letra
          PRINT:
               mov ah, 02h
               mov dl, bh
               int 21h

               and bl, 0fh

               cmp bl, 09h
               ja HEXA2
               add bl, 30h
               jmp PRINT1
          HEXA2:
               add bl, 55D    ; ajustamos la letra
          PRINT1:
               mov ah, 02H
               mov dl, bl
               int 21H
               jmp INICIO



          OP2:
               sub bl, bl
               sub bh, bh
               imprimir entrada    ; input
               call read           ; leo el primer numero
               mov bl, al          ; guardo el numero
               imprimir entrada
               call read
               mov bh, al

               
               sub bh, 55D    ; ajuste de la letra
               sub bl, 55d
               SUB bl, bh     ; realizo la resta
               
               imprimir resul
               mov ah, 02H
               add bl, 30h    ; ajuste del resultado
               mov dl, bl
               int 21H

               jmp INICIO
          SALIR:
               mov ah, 4ch
               int 21H
               

     main endp

     read proc near
          mov ah, 01h
          int 21h
          ret
     read endp

     
end main