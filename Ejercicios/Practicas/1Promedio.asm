.model small
.stack
ajuste macro num
     sub num, 30h    ; ajusta el numer
endm

sumar macro num
     add suma, num
endm
.data
     num       db ?
     suma      db ?
     promedio  db ?
     it        dw 8
.code
     main proc far
          mov ax, @data
          mov ds, ax

          mov si, 0
          mov cx, it     ; numero de veces que se repite el ciclo
          PEDIR:
               call read      ; lee el numero
               SUB AL, 30h
               add bl, al
               aaa  
               ;inc si
               loop PEDIR     ; repite ciclo de pedir 
               jmp PROM

          PROM:
               mov ax, bx     ; el total de la suma se pasa en ax
               mov bl, 8d     ; divisor
               div bl         ; divide lo que tiene ax en bl

               aad  ; ajuste de la division

               mov bl, al     ; se muestra el caracter
               mov ah, 02h
               mov dl, bh
               add dl, 30h
               int 21h

               mov dl, bl
               ;add dl, 30h
               int 21h
               jmp SALIR

          

          SALIR:
               mov ax, 4ch
               int 21h

     
     main endp
     read proc near 
          mov ah, 01h
          int 21h
          ret
     read endp
end main 