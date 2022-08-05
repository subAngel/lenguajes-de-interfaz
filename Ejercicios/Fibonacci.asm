; sucesion de fibonacci

; 

.model small
.stack
print macro letrero
     mov ah, 09h
     lea dx, letrero
     int 21h
endm
write macro param
     mov ah, 02h
     mov dl, param
     int 21h 
endm
.data
     ; para la sucesion de fibonacci se empieza con dos numeros que son el 1 y 0
     n1   db 0  
     n2   db 1
     cont dw 2 ; contador en 2 pq ya tenemos dos posiciones del arreglo
     fin  db 4
     entrada   db 'Numero de iteraciones [1-13]: $'
     array     db 13 dup (0)
.code
     main proc far
          mov ax, @data
          mov ds, ax

          mov bh, n1     ; ah = n1 = 0
          mov bl, n2     ; al = n2 = 1

          mov array[0], bh    ; array[0] = 0
          mov array[1], bl    ; array[1] = 1
          
          ; ajustar los registros si y di para
          mov si, 0 ; si = 0
          mov di, 1 ; di = 1  

          print entrada
          call read

          mov cx, ax     ; pasamos el numero que tiene al al registro cx
          CICLO:
               mov bl, array[si]   ; bl = array[0]
               mov dl, array[di]   ; cl = array[]
               add bl, dl

          
          mov ah, 4ch
          int 21h
          
     main endp
     read proc near 
          mov ah, 01h
          int 21h
          ret 
     read endp
end main
 