.model small 
.stack

limpiar macro color  ; macro para limpiar pantalla
     mov ax, 0600h  ; 
     mov bh, color
     mov cx, 0000h
     mov dx, 184fh
     int 10h
endm
print macro texto
     mov ah, 09h
     lea dx, texto
     int 21h
endm

.data
     vocales   db 'esto es una cadena de prueba si: $'
     cadena    db 30 dup (' '), '$'
     num       equ $-cadena   ; tama;o de la cadena
     tiene     db 10, 13, 'Total de vocales: $'
     total     db ?
     cadena2   db 50 dup (' '), '$'
     num2      db ?
     
     
.code
     main proc far
          mov ax, @data
          mov ds, ax
          jmp DINAMICA
     DINAMICA:
          mov si, 0
          LLENAR_STR:
               call read
               cmp al, 13     ; enter para salir
               je CONTAR_VOCAL
               mov cadena2[si], al ; mover el caracter a la cadena
               inc si
               jmp LLENAR_STR

          CONTAR_VOCAL:
               mov si, 0      ; limpiar registros
               mov dx, 00h
               mov cx, size cadena2

               @@ETIQUETADIN:
                    mov al, cadena2[si]
                    cmp al, 61h
                    je VOCALD
                    cmp al, 65h
                    je VOCALD
                    cmp al, 69h
                    je VOCALD
                    cmp al, 6fh
                    je VOCALD
                    cmp al, 75h
                    je VOCALD

                    AVANZAD:
                         inc si
               loop @@ETIQUETADIN
               ; proceso de imprimir en panntalla
               mov dh, 0
               mov total, dl

               ;print vocales
               print tiene
               mov ax, 0

               mov al, total
               aam
               add ax, 3030h
               mov bx, ax

               mov ah, 02h    ; imprimir el primer numero
               mov dl, bh
               int 21h

               mov ah, 02h    ; imprimir el segundo numero
               mov dl, bl
               int 21h
               jmp SALIR
               

               VOCALD:
                    inc dl
                    jmp AVANZAD


; ------------------ DINAMICA  END------------------
     ESTATICA:
          mov si, 0
          mov dx, 00h
          mov cx, num

          ; print vocales
          ; mov ah, 3fh
          ; mov bx, 00h
          ; mov cx, 30
          ; lea dx, [cadena]
          ; int 21h

          mov si, 0
          @@ETIQUETA:
               mov al, vocales[si]
               cmp al, 61h
               je VOCAL
               cmp al, 65h
               je VOCAL
               cmp al, 69h
               je VOCAL
               cmp al, 6fh
               je VOCAL
               cmp al, 75h
               je VOCAL

               AVANZA:
                    inc si
          loop @@ETIQUETA

          mov dh, 0
          mov total, dl

          print vocales
          print tiene
          mov ax, 0

          mov al, total
          aaa
          add ax, 3030h
          mov bx, ax

          mov ah, 02h    ; imprimir el primer numero
          mov dl, bh
          int 21h

          mov ah, 02h    ; imprimir el segundo numero
          mov dl, bl
          int 21h
          jmp SALIR
          

          VOCAL:
               inc dl
               jmp AVANZA


          SALIR:
               mov ah, 4ch
               int 21h
     main endp
     read proc near      ;leer un caracter del teclado
          mov ah, 01h
          int 21h
          ret
     read endp
end main