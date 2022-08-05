
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
     v1   db 8
     v2   db ?
     v3   db 20
     resul db 0
     unidades db ?
     decenas  db ?
.code
     main proc far
          mov ax, @data
          mov ds, ax

          OPERACION:
               ; OBTENER EL -15
               mov al, 0
               sub al, 15d
               mov v2, al

               neg al         ;  -(-15) ...

               add resul, al  ; 0 =+ 15 = 15

               add resul, 7d     ;  -(-15) + 7  = 22
               
               sub resul, 20     ;  -(-15) + 7 - (20) = 2

               add resul, 8     ;  -(-15) + 7 - (20) + 8

               ;mov resul, v2  ;  r =  -(-15) + 7 - (20) + 8

          AJUSTE:
               mov al, resul  
               aam  ; ajuste 

               mov decenas, ah
               mov unidades, al

          IMPRIMIR_R:
               imprimir formula
               
               ; imprimir decenas
               mov ah, 02h
               mov dl, decenas
               add dl, 30h
               int 21h
               ;imprimir unidades
               mov ah, 02h
               mov dl, unidades
               add dl, 30h
               int 21h

          
          
          mov ah, 4ch
          int 21h
     main endp
end main