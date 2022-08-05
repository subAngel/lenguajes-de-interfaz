
.model small
.stack

.data
     mensaje   db  'hola mundo$'
.code
     main proc far 
          mov ax, @data
          mov ds, ax

          mov al, 6h
          mov bl, 2h
          div bl

          sub al, 30h
          mov ah, 02h
          mov dl, al
          int 21h
          
          mov ah, 4ch    ; salir 
          int 21h
     main endp
end main 


; 
