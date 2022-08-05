.MODEl small
.stack 286

.data
     ; etiqueta tipo inicializacion
     label1 db 10h
     label2 db 01FH
     label3 dw 10h, 20h, 30h, 40h
     array dw 5 dup(?)

.code
main proc
     mov ax, @data
     mov ds, ax

     mov bl, label2
     mov cx, label3


     mov ah, 04ch
     mov al, 0 
     int 21h
main endp
     end main