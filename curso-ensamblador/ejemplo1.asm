.model small
.stack
.data
mensaje db "hola Mundo",10,13,"$"
.code
main proc
mov ax, seg mensaje
mov ds, ax
mov dx, offset mensaje
mov ah, 09
int 21h
main endp
end main 