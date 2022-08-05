.model small
;--------------------------------MACROS----------------------------
posicionar macro x, y, texto
     mov ah, 02h
     mov bh, 00h
     mov dh, y
     mov dl, x
     int 10h

     mov ah, 09h
     lea dx, offset [texto]
     int 21h
endm
writechar macro char
     mov ah, 02h
     mov dl, char
     int 21h
endm

.stack
.data
     letrero1       db 'Ingrese una cadena: $'
     cadena1        db 40 dup (' '), '$'
     letrero2       db 'Ingresa un caracter para buscar: $'
     caracter       db ?
     cont           db 0
     letrero3       db 10, 13,'Posicion $'
     posicion       db ?
     valor          db ?
.code
     main proc far
          mov ax, @data
          mov ds, ax
          mov es, ax

          call cls  ; limpiar pantalla

          posicionar 0d, 0D, letrero1

          mov si, 0
          LLENAR_CADENA:
               call read ; solicito un caracter al usuario
               cmp al, 13     ; comparo hasta que se presione enter
               je PEDIR_CHAR  
               mov cadena1[si], al ;guardo en la posicion de la cadena, el char que ingrese
               inc si    ; Incremento el contador de letras en 1 
          jmp LLENAR_CADENA    

          PEDIR_CHAR:
               posicionar 0d, 1d, letrero2
               call read
               mov caracter, al    ; movemos el caracter ingresado a al
               
               mov cx, size cadena1 ; cx es igual al tamaño de mi cadena
               mov cont, 40   

               lea di, cadena1

               REPETIR:
                    repe scasb     ; repetir para buscar un caracter
                    je ENCONTRADO
                    jne SALIR

                    ENCONTRADO:
                         mov bx, cx
                         add bx, 30h

                         posicionar 0d, 3d, letrero3
                         
                         mov valor, cl
                         mov al, cont
                         sub al, valor  
                         mov posicion, al    ; posicion del caracter
                         add posicion, 30h; ajuste

                         mov ah, 02h         
                         mov dl, posicion
                         int 21h

                         mov al, caracter
                         cmp cx, di     ; compara el elemento actual con el contador
                         jz SALIR
                         jmp REPETIR


          SALIR:
               mov ah, 4ch
               int 21h
     cls proc near
          mov ah, 07h
          mov al, 00h
          mov bh, 00001010B
          mov cx, 0000h
          mov dx, 184fh
          int 10h

          ret
     cls endp
     read proc near
          mov ah, 01h
          int 21h
          ret
     read endp
     
.exit
main endp
end main
