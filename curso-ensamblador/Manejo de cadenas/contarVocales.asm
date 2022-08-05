.286
.model small
.stack
.data
     cadena    db 'Frase de ejemplo.$'
     entrada   db 'Ingrese una cadena: $'
     num equ $-cadena
     tiene     db 10, 13, 'Tiene un total de vocales: $'
     total     db ?

     cadena2   db 50 dup (' '),'$'
     num2 db ?

.code
     main proc far
          mov ax, @data
          mov ds, ax
          
          jmp DINAMICA


          ; jmp ESTATICA
          ESTATICA:
               mov si, 0
               mov dx, 0h     ; limpiar el registro cx
               mov cx, num    ; cx = longitud de la cadena

               ETIQUETA:
                    mov al, cadena[si]
                    cmp al, 61h    ; a en ascii
                    je vocal
                    cmp al, 65h    ; e en ascii
                    je vocal
                    cmp al, 69h    ; i en ascii
                    je vocal
                    cmp al, 6fh    ; o en ascii
                    je vocal
                    cmp al, 75h    ; u en ascii
                    je vocal

                    REGRESA:   ; SALTA A LA ETIQUETA PARA AUMENTAR SI
                         inc si
               loop ETIQUETA

               mov dh, 0 ; limpio el registro temporal donde guardo la informacion
               mov total, dl

               mov ah, 09h
               lea dx, cadena
               int 21h

               lea dx, tiene
               int 21h

               mov ax, 0      ; limpiar el registro para no tener problemas 
               mov al, total
               aaa
               add ax, 3030h
               mov bx, ax

               mov ah, 02h
               mov dl, bh
               int 21h

               ;mov ah, 02h
               mov dl, bl
               int 21h
               jmp SALIR

          vocal:
               inc dl
               jmp REGRESA
;--------------------------------------------
     DINAMICA:
          mov ah, 09h 
          lea dx, entrada
          int 21h
          
          mov si, 0
          ; Proporcionar que el usuario llene la cadena
          LLENAR_CADENA:
               mov ah, 01h    ; solicito el caracter
               int 21h
               cmp al, 13     ; si le damos enter saltamos a
               je CONTAR_VOCALES

               mov cadena2[si], al
               inc si
          jmp LLENAR_CADENA

          CONTAR_VOCALES:
               mov si, 0
               mov dx, 0h
               mov cx, size cadena2   ; control del ciclo

               EtiqDinam:
                    mov al, cadena2[si]
                    cmp al, 61h    ; a en ascii
                    je vocalD
                    cmp al, 65h    ; e en ascii
                    je vocalD
                    cmp al, 69h    ; i en ascii
                    je vocalD
                    cmp al, 6fh    ; o en ascii
                    je vocalD
                    cmp al, 75h    ; u en ascii
                    je vocalD

                    REGRESAD:
                         inc si
               loop EtiqDinam

               ; proceso de imprimir en pantalla
               mov dh, 0
               mov total, dl

               mov ah, 09h
               lea dx, cadena2
               ;int 21h

               lea dx, tiene
               int 21h

               mov ax, 0
               mov al, total
               aam
               add ax, 3030h
               mov bx, ax    
               
               ; mostrar por partes
               mov ah, 02h
               mov dl, bh
               int 21h

               mov dl, bl
               int 21h
               jmp SALIR

               vocalD:
                    inc dl

               jmp REGRESAD
                    


     SALIR:
          mov ah, 4ch
          int 21h
.exit
main endp
end main