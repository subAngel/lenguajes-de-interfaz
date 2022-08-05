.model small
.stack
; --------------------MACROS-----------------------
imprimir macro texto
     mov ah, 09h
     lea dx, texto
     int 21h
endm
; --------------------CODIGO--------------------------------
.data
     titulo1   db 10, 13, '----  MCM y MCD ----$'
     titulo2   db 10, 13, '----  MCD ----$'
     resMCM    db 10, 13, 'MCM ---> $'
     resMCD    db 10, 13, 'MCD ---> $'
     num1      db 10,13, 'Ingrese el primer numero: $'
     num2      db 10, 13, 'Ingrese el segundo numero: $'
     n1        db ?
     n2        db ?
     mcm       db ?
     mcd       db ?

     cont      db 0


.code
     main proc far
          mov ax, @data
          mov ds, ax
          
          @@MCM:
               imprimir titulo1

               imprimir num1
               call read
               mov n1, al
               sub n1, 30h

               imprimir num2
               call read
               mov n2, al
               sub n2, 30h

               mov cont, 1
               BUCLE:
                    mov ah, 0
                    mov al, cont
                    mov bl, n1
                    div bl
                    cmp ah, 0 ; si el resto de la division del contador con el numero es 0 es igual a 0
                    je PARTE1
                    BC:
                         INC cont; incrementa el contador
                         jmp BUCLE
               PARTE1:   ; si no1 es multiplo del contador
                    mov ah, 0
                    mov al, cont
                    mov bl, n2
                    div bl
                    cmp ah, 0 ; compara si el residuo es 0 
                    je PARTE2
                    jmp BC    ; SI EL n2 no es multiplo del contador regresa al bucle
               PARTE2:   ; si el n1 y n2 son multiplos del contador
                    mov al, cont
                    mov mcm, al ; guarda el mcm
                    jmp PARTE3
               PARTE3:   ; Multiplicar el n1 * n2
                    mov al, n1     ; con ese resultado, dividir por el mcm de n1 y n2 tenemos el MCD
                    mov bl, n2
                    mul bl
                    mov bl, mcm
                    div bl
                    mov mcd, al

                    imprimir resMCM
                    mov ah, 02h
                    mov dl, mcm
                    add dl, 30h
                    int 21h
                    imprimir resMCD
                    mov ah, 02h
                    mov dl, mcd
                    add dl, 30h
                    int 21h
               






          
          

          SALIR:
               mov ah, 4ch
               int 21h
     main endp

     read proc near 
          mov ah, 01h
          int 21h
          ret
     read endp
end main