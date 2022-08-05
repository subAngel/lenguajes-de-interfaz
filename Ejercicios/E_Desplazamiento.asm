.model small
.stack

imprimir macro texto
     mov ah, 09h
     lea dx, texto
     int 21h
endm

.data
     desp      db 10, 13, 'Desplazamiento a la derecha: $'
     rota      db 10, 13, 'Rotacion a la izquierda: $'
.code
     main proc far
          mov ax, @data
          mov ds, ax

          imprimir desp
          mov bl, 1000B  ; bl = 1000 = 8
          SHR bl, 1d     ; bl = 0100 = 4
          
          add bx, 30h    ; ajusto para mostrarlo en pantalla
          mov ah, 02h    ; opcion para imprimir un carater
          mov dx, bx     
          int 21h

          imprimir rota
          mov al, 40h    ; al = 01000000 = 64
          rol al, 1      ; al = 10000000  128
          rol al, 1      ; al = 00000001   1
          rol al, 1      ; al = 00000010 = 2

          add al, 30h    ; ajustamos el caracter
          mov ah, 02h
          mov dl, al
          int 21h

          mov ah, 4ch    ; terminar proceso
          int 21h

     main endp
end main