.model small 
.stack

limpiar macro color  ; macro para limpiar pantalla
     mov ax, 0600h  ; 
     mov bh, color
     mov cx, 0000h
     mov dx, 184fh
     int 10h
endm

.data
     asterisco db '*$'
     x db ?
     y db ?
     cant db 01h
.code
     main proc far
          mov ax, @data
          mov ds, ax

          limpiar 00001011B

          mov cx, 005h
          PRIMERFOR:
               mov ah, 02h
               mov bh, 00h
               mov dh, y
               mov dl, x
               int 10h

               mov bx, cx

               mov ch, 00h
               mov cl, cant

               SEGUNDOFOR:
                    mov ah, 02h
                    mov dl, asterisco
                    int 21h
               loop SEGUNDOFOR

               mov cx, bx
               inc y
               inc cant
          loop PRIMERFOR

          ; TRIANGULO 2
          mov cx, 0005h

          dec y
          dec cant

          PRIMERFOR_2:
               mov ah, 02h
               mov bh, 00h
               mov dh, y
               mov dl, x
               int 10h

               mov bx, cx
               mov ch, 00h
               mov cl, cant

               SEGUNDOFOR_2:
                    mov ah, 02h
                    mov dl, asterisco
                    int 21h
               loop SEGUNDOFOR_2

               mov cx, bx
               inc y
               dec cant
          loop PRIMERFOR_2

          SALIR:
               mov ah, 4ch
               int 21h
     main endp
end main