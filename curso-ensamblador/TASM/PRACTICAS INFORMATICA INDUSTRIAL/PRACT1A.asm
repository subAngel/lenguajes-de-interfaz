.model small

.stack 128

.data
     posX      db 5 ; posicion x (0 - 79)
     posY      db 5 ; posicion y (0 - 25)
     texto     db 10, 13, 'Texto en pantalla$'

.code
     main proc far 
          mov ax, @data
          mov ds, ax

          ; push ds
          ; sub ax, ax
          ; push ax
          mov dl, posX
          mov dh, posY

          call posicion
          
          lea dx, texto
          call escribir

          ret
     main endp ; fin del procedimiento 
     
     posicion proc 
          push dx
          push bx
          push ax
          
          cmp dl, 0      ; compara dl con 0
          jl FIN         ; si es menor (LOW) salta a fin
          cmp dl, 79
          jg FIN
          cmp dh, 0 
          jl FIN
          cmp dh, 24

