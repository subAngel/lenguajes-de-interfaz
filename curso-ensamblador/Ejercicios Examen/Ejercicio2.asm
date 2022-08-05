.286
.model SMALL
.stack
setCoord macro x, y 
     mov ah, 02h
     mov bh, 00h
     mov dh, y
     mov dl, x
     int 10h
endm
write macro txt
     mov ah, 09h
     lea dx, txt
     int 21h
endm
asignar_pixel macro registro, eje    
     mov ax, registro    
     mov bl, 8
     div bl   
     mov eje, al   
ENDM
rangom macro inicio, fin, etiqueta
     cmp ejeX, inicio
     jb CLICK
     cmp ejeX, fin
     ja CLICK
     JMP etiqueta
endm
capturar macro string
          mov ah, 3fh
          mov bx, 00h
          mov cx, 5d    ; valor definido en ds
          lea dx, string
          int 21h
endm
.data
     letrero1  db '[-------Menu-------]$'
     letrero2  db '[   Leer  cadena   ]$'
     letrero3  db '[  Buscar Caracter ]$'
     letrero4  db '[       Salir      ]$'
     entrada   db 'Ingrese una cadena: $'
     espacio   db 'Oprima espacio para volver al menu: $'
     saliendo  db 'SALIENDO....$'
     inputchar db 'Ingresa un caracter a buscar: $'
     cadena    db 5 dup (' '),'$'
     ejeX      db ?, '$'
     ejeY      db ?, '$'
     char      db ?, '$'
.code
     main proc far
     push ds
     push 0
     mov ax, @data
     mov ds, ax
     mov es, ax

     call cls

     MENU:
          setCoord 27d, 10d
          write letrero1

          setCoord 27d, 11d
          write letrero2

          setCoord 27d, 12d
          write letrero3

          setCoord 27d, 13d
          write letrero4
     CLICK:
          call mouse
          cmp bx, 1
          je COORDENADAS
          jne CLICK
     
     COORDENADAS:
          asignar_pixel  cx, ejeX
          asignar_pixel  dx, ejeY

          cmp ejeY, 11d
          je RANGE1

          cmp ejeY, 12d
          je RANGE2

          cmp ejeY, 13d
          je RANGE3

          JMP CLICK

          RANGE1:
               rangom 27d, 51d, LLENAR_CADENA
          RANGE2:
               rangom 27d, 51d, BUSCAR_CARACTER
          RANGE3:
               rangom 27d, 51d, SALIR
     LLENAR_CADENA:
          setCoord 23d, 14d 
          write entrada
          capturar cadena

          setCoord 27d, 12d
          write letrero3

          setCoord 34d, 17d
          write cadena

          jmp COORDENADAS
     BUSCAR_CARACTER:
          call cls
          setCoord 25d, 10d
          write entrada
          capturar cadena

          setCoord 34, 15d
          write cadena

          setCoord 25d, 11d
          write inputchar
          call read
          jmp BUSCAR_CARACTER




     SALIR:
          call cls
          setCoord 0,0
          write saliendo
          mov ah, 4ch
          int 21h
     cls proc near
          mov ax, 0600h
          mov bh, 00001010B
          mov cx, 0000h
          mov dx, 184fh
          int 10h
          ret
     cls endp
     mouse PROC near
          mov ax, 01h    ; activa el cursor
          int 33h

          mov ax, 03h    ; ESTADO DEL MOUSE 
          INT 33h
          ret
     mouse endp
     read proc near
          mov ah, 02h
          int 21h
          ret
     read endp

.exit
main endp
end MAIN