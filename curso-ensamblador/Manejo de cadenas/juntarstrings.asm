.286
.model small

.stack
.data
     cadena1   db 'hola$'
     cadena2   db 'adiosmundo$'
.code
main proc far
     push ds
     push 0
     mov ax, @data
     mov ds, ax
     mov es, ax

     mov si, offset cadena2
     mov di, offset cadena1

     mov cx, 4
     rep movsb

     mov ah, 4ch
     int 21h
     

.exit
main endp
end main