.model small 
.stack

.data 
     msg db 'hola mundo 3!!!', 13,'$'

;segmento de codigo
.code
     ; procedimiento principal 
     main PROC
          ; carga en memoria las variables del segmento de datos
          mov ax, @data
          mov ds, ax

          ; imprimir en pantalla
          mov dx, offset msg
          ;mov bl, 0      ; color de fondo
          mov bl, 62     ; color de letra
          mov cx, 4      ; num de repeticiones; caracteres que va a pintar
          mov ah, 09h
          ;mov ah, 9
          ;int 10h
          int 10h        ; int. controla los servivios de pantalla del pc
          int 21h        ; 
          .exit

     main ENDP
end main 