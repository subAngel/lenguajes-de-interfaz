.model small
.stack
imprimir macro txt
     mov ah, 09h
     lea dx, txt
     int 21h
ENDM

.data
     palabra   db 'Programa ejecutado correctamente$'
     p db ?
.code
     main proc far
     mov ax, @data
     mov ds, ax

     mov ax, 200    ; ax = 255
     mov bx, 43     ; bx = 43
     mov cx, 12     ; cx = 12
     mov dx, 2      ; dx = 2

     ; colocamos los valores de los registros a la pila
     push ax   ; ax
     push bx   ; ax, bx
     push cx   ; ax, bx, cx
     push dx   ; dx, bx, cx, dx

     ; sacamos los valores de la pila
     ; por cada instruccion push debe haber una instruccion pop
     pop ax    ; 8
     pop ax    ; 12
     pop ax    ; 43
     pop ax    ; 200

     mov ah, 09h
     mov p, ax
     lea dx, p
     int 21h

     mov ah, 4ch
     int 21h


     main endp
end main