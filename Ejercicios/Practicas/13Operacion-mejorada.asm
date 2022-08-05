
; Formula: - valor2 + 7 - valor3 + valor1

.model small 

posicionar macro x, y    ; macro para posicionar el cursor
     mov ah, 02h    
     mov bh, 00h    ; pagina de video
     mov dh, y      ; linea del cursor
     mov dl, x      ; columna del cursor
     int 10h
ENDM

limpiar macro color  ; macro para limpiar pantalla
     mov ax, 0600h  ; 
     mov bh, color
     mov cx, 0000h
     mov dx, 184fh
     int 10h
endm
imprimir macro texto
     mov ah, 09h
     lea dx, texto
     int 21h
endm
printf macro char, color
     mov ah, 09h
     mov al, char
     mov bh, 0d
     mov bl, color
     mov cx, 1d
     int 10h
endm

.stack
.data
     formula db 10, 13,'Formula -> - V2 + 7 - V3 + V1: $'
     nombre db 'angel$'
     inputv1 db 10, 13, 'Ingrese V1: $'
     inputv2 db 10, 13, 'Ingrese V2: $'
     inputv3 db 10, 13, 'Ingrese v3: $'
     v1   db ?
     v2   db ?
     v3   db ?
     resul db 0
     unidades db ?
     decenas  db ?
.code
     main proc far
          mov ax, @data
          mov ds, ax
          
          imprimir inputv2
          call read 
          mov v2, al
          sub v2, 30h
          imprimir inputv3
          call read
          mov v3, al
          sub v3, 30h
          imprimir inputv1
          call read
          mov v1, al
          sub v1, 30h

          OPERACION:
               mov al, v2
               neg al    ; - V2 

               add resul, al  ; resul = -v2

               add resul, 7d    ; resul = -v2 + 7

               mov bl, v3
               sub resul, bl  ; resul = -v2 + 7 - v3 

               mov cl, v1
               add resul, cl  ; resul = -v2 + 7 - v3 + v1
               mov bh, resul
               add bh, 30h
               ; add bh, 30h

               

          IMPRIMIR_R:
               imprimir formula
               mov ah, 02h
               mov dl, bh
               ;mov dl, 52d
               int 21h

          
          
          mov ah, 4ch
          int 21h
     main endp
     read proc near 
          mov ah, 01h
          int 21h
          ret
     read endp
end main