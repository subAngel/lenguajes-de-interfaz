; Realice un programa que ordene 3 numeros dados por le programador
.model small
.stack

imprimir MACRO param   ; macro para imprimir
     mov ah, 09h
     lea dx, param
     int 21h
ENDM
sumar macro n1, n2
     mov al, n1
     add al, n2
     add al, 30h

     mov ah, 02h
     mov dl, al
     int 21h
ENDM
restar macro n1, n2
     mov al, n1
     sub al, n2
     add al, 30h

     mov ah, 02h
     mov dl, al
     int 21h
ENDM
multiplicar macro n1, n2
     mov al, n1
     mov bl, n2
     mul bl

     mov ah, 02h
     add al, 30h
     mov dl, al
     int 21h
ENDM
dividir macro n1, n2
     mov al, n1
     mov dl, n2
     div dl

     mov 


.data
     txtsuma   db 10, 13, 'Suma              : $'
     txtresta  db 10, 13, 'Resta             : $'
     txtmul    db 10, 13, 'Multiplicacion    : $'
     txtdiv    db 10, 13, 'Division          : $'
     rsuma     db ?
     rresta    db ?
     rmulti    db ?
     rdiv      db ?
.code
     main proc far
          mov ax, @data
          mov ds, ax

          imprimir txtsuma
          sumar 2d, 4d

          imprimir txtresta
          restar 4d,1d

          imprimir txtmul
          multiplicar 2d,4d


          call exit
     main endp
     exit proc near
          mov ah, 4ch
          int 21h 
          ret
     exit endp
end main