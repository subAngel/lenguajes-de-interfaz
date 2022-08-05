; realice un programa que realice operaciones aritmeticas 
; Suma, resta, multiplicacion y division
.286
.model medium
.stack

imprimir MACRO param   ; macro para imprimir
     mov ah, 09h
     lea dx, param
     int 21h
ENDM
.data
     ;  el 13 es el ascii del enter
     txtsuma   db 10, 'Suma (2+4):  $'
     txtresta  db 10, 13, 'Resta (5-3): $'
     txtmul    db 10, 13, 'Multiplicacion (2*4): $'
     txtdiv    db 10, 13, 'Division (6/2): $'
     ;enter     db 10, 13, '$'
     n1        db 2
     n2        db 1

     n3        db 5
     n4        db 3

     n5        db 6


.code
     main proc far
          mov ax, @data
          mov ds, ax

          imprimir txtsuma    ; llamo a la macro para imprimir
          jmp SUMA       ;    ; salto a la operacion para hacer la suma

          ;imprimir enter ; hace un enter
     IMPRIMIR_S:    ; etiqueta para imprimir la resta
          imprimir txtresta
          jmp RESTA
     IMP_M:
          imprimir txtmul
          jmp MULTI
     IMP_D:
          imprimir txtdiv
          jmp D
     SALIDA:
          jmp SALIR

     SUMA: 
          mov al, n1     ; al = n1
          add al, n2     ; al += n2
          add al, 30h    ; ajuste de caracteres

          mov ah, 02h    ; imprimir el caracter
          mov dl, al
          int 21h
          JMP IMPRIMIR_S
     RESTA:
          sub al, al     ; dejo a al en 0
          mov al, n3     ; al = n3
          sub al, n4     ; al -= n4
          add al, 30h    ; ajuste

          mov ah, 02h
          mov dl, al
          int 21h   
          JMP IMP_M
     MULTI:
          mov al, n1
          mov bl, n2
          mul bl

          mov ah, 02h    ; imprimir el caracter
          add al, 30h
          mov dl, al
          int 21h
          jmp IMP_D

     D:
          sub al, al     ; dejamos al y bl a 0
          sub bl, bl

          mov al, n2
          ;mov bl, n1
          div n1
          
          mov ah, 09h
          add al, 30h
          mov dl, al
          int 21h

          mov ah, 4ch
          int 21h

     SALIR:
          mov ah, 4ch
          int 21h

     main endp
end main

