.model small
.stack

.data
     palabra db 10 dup (' '), '$'

.code
     main proc far

     mov ax, @data
     mov ds, ax

     mov ah, 3fh
     mov bx, 00h
     mov cx, 10d
     lea dx, palabra
     int 21h

     mov ah, 09h
     lea dx, palabra
     int 21h

     mov ah, 4ch
     int 21h



     main endp
end main
