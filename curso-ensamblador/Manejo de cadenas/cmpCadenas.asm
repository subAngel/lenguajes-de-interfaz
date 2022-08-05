.286
.model small
.stack
write macro texto     ; macro para escribir la palabra
     mov ah, 09h
     lea dx, texto
     int 21h
ENDM
posicionar macro x, y    ; macro para posicionar el cursor
     mov ah, 02h
     mov bh, 00h
     mov dh, y
     mov dl, x
     int 10h
ENDM
limpiar macro  ; macro para limpiar pantalla
     mov ax, 0600h
     mov bh, 00001010B
     mov cx, 0000h
     mov dx, 184fh
     int 10h
ENDM
capturar macro cadena
          mov ah, 3fh
          mov bx, 00h
          mov cx, 50d    ; valor definido en ds
          lea dx, cadena
          int 21h
endm
.data
     letrero01      db   'Ingresa una palabra: $'
     letrero02      db   'Son iguales$'
     letrero03      db   'No son iguales$'

     cadena1        db 50 dup(' '),'$'
     cadena2        db 50 dup(' '), '$'
.code
     main proc far
          mov ax, @data
          mov ds, ax
          mov es, ax
          ; cmpsb   
          limpiar
          posicionar 0,13d
          write letrero01

          capturar cadena1
          
          posicionar 0, 15d
          write letrero01

          capturar cadena2
          ; COMPARAR
          lea si, cadena1
          lea di, cadena2

          repe cmpsb
          je IGUALES
          JNE NOIGUALES

          IGUALES:
               posicionar 28d, 14d
               write letrero02
               jmp SALIR
          NOIGUALES:
               posicionar 28d, 14d
               write letrero03
               jmp SALIR

          



          
               

     SALIR:
          mov ah, 4ch
          int 21h
.exit
main endp
end main