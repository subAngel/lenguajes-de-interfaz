; MENU USANDO MOUSE EN TASM
.model small
.stack 64

.data
     coordX    db ?, '$'
     coordY    db ?, '$'
     pazul     db '1. Pantalla azul$'
     pverde    db 10, 13, 7, '2. Pantalla verde$'
     ehola     db 10, 13, 7, '3. Mostrar Hola$'
     eadios    db 10, 13, 7, 'Salir del programa$'
     msj       db 10, 13, 7, 'Hola$'
     msj2      db 10, 13, 7, 'Adios$'

.code
main proc far 
     mov ax, @data
     mov ds, ax

     MENU:
          mov ah, 02h
          mov dx, 0000h
          mov bh, 00h
          int 10h

          mov ax, 0600h
          mov bh, 10
          mov cx, 0000h
          mov dx, 184fh
          int 10h

          mov ah, 09h
          lea dx, pazul
          int 21h
          lea dx, pverde
          int 21h
          lea dx, ehola
          int 21h
          lea dx, eadios
          int 21h

     CLICK:
          mov ax, 01h    ; funcion que activa el click del mouse
          int 33h        ; int que maneja el mouse

          mov ax, 03h
          int 33h

          cmp bx, 1      ; btn izq
          je COORDENADAS
          cmp bx, 2
          jmp CLICK
     
     COORDENADAS:
          mov ax, cx
          mov bl, 8
          div bl
          mov coordX, al

          mov ax, dx
          mov bl, 8
          div bl
          mov coordY, al

          cmp coordX, 0
          je PANTALLA_AZUL
          cmp coordY, 1
          je PANTALLA_VERDE
          cmp coordY, 2
          je HELLO
          cmp coordY, 3
          je SALIR
          jmp CLICK

     PANTALLA_AZUL:
          mov ax, 0600h
          mov bh, 9fh    ; 2 color verde y f es el color blanco
          mov cx, 0000h
          mov dx, 184fh  ; finaliza en las ultimas coordenadas de la pantalla
          int 10h

          mov ah, 01h    ; espera una tecla para salir 
          int 21h
          jmp MENU
     PANTALLA_VERDE:
          mov ax, 0600h
          mov bh, 2fh
          mov cx, 0000h
          mov dx, 184fh
          int 10h

          mov ah, 01h
          int 21h
          jmp MENU
     HELLO:
          mov ax, 0600h
          mov bh, 10
          mov cx, 0000h
          mov dx, 184fh
          int 10h

          mov ah, 09h
          lea dx, msj
          int 21h

          mov ah, 01h
          int 21h
          jmp MENU
     
     SALIR:
          mov ah, 09h
          lea dx, msj2
          int 21h

          mov ah, 01h
          int 21h

          mov ah, 4ch
          int 10h
main endp
end main