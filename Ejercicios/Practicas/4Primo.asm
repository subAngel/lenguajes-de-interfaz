.model small 

.stack

imprimir macro texto     ; macro para imprimir 
     mov ah, 09h
     lea dx, texto
     int 21h
endm

.data
     entrada   db 10, 13, 'Ingresa un numero: $'
     numeros   db 2, 5, 7, 6, 8, 45, 51, 12, 82, 41, 1
     esprimo   db 10, 13, 'Es primo$'
     noprimo   db 10, 13, 'No es primo$'
     num       db ?
     cont      db 0

.code
     main proc far
          mov ax, @data
          mov ds, ax

          imprimir entrada    ; pido el numero 
          call read           ; leo el caracter
          sub al, 30h         ; ajusto

          mov num, al    ; numero es al
          mov cx, 0d     ; limpiar el registro cx
          mov cl, num    ; numero de veces de iteracion en el ciclo
          mov si, 0d

          CICLO:
               inc cont  ; incrementar contador
               ; primero hacer la divisin y comparar el residuo
               mov ax, 0000h  ; limpio ax
               mov al, num
               mov bl, cont
               div bl

               cmp ah, 0      ; comparar si el residuo es 0
               je SI_ES_PRIMO     ; si es igual es un primo
               jne NO_ES_PRIMO    ; si no entonces no es primo


               SI_ES_PRIMO:  
                    inc si
               NO_ES_PRIMO:
                    ; si no es primo no incrementa el indice
               loop CICLO

          cmp si, 2 ; si tiene sus dos divisores
          jz SI_PRIMO    ; si tiene dos divisores es primo
          jnz NO_PRIMO

          SI_PRIMO:
               imprimir esprimo
               jmp SALIR
          NO_PRIMO:
               imprimir noprimo
               jmp SALIR

          SALIR:
               mov ah, 4ch
               int 21h

     main endp

     read proc near      ; procedimiento para leer un caracter
          mov ah, 01h
          int 21h
          ret
     read endp

end main