.model small
.stack

imprimir macro texto
     mov ah, 09h
     lea dx, texto
     int 21h
endm

write macro registro
     mov ah, 02h
     mov dl, registro
     add dl, 30h
     int 21h
endm

.data     
     pedirbase      db 10, 13, 'Ingrese la base: $'
     pediraltu      db 10, 13, 'Ingrese la altura: $'
     mensaje        db 10, 13, 'El area del rectangulo es: $'
     base           db ?
     altura         db ?
     area           db ?
     decenas        db ?
     unidades       db ?
.code
     main proc far
          mov ax, @data
          mov ds, ax

          imprimir pedirbase
          call read      ; pedir base
          sub al, 30h
          mov base, al

          imprimir pediraltu
          call read
          sub al, 30h
          mov altura, al
          
          ; calcular AREA

          mov al, base
          mul altura     ; multiplica la base por la altura 
          ; el resultado se guarda en al
          aam
          mov decenas, ah     ; guardo las decenas
          mov unidades, al    ; guardo las unidades

          imprimir mensaje
          write decenas
          write unidades
          

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