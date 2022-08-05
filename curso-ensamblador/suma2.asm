TITLE Interrupciones_teclado
.286
Spila SEGMENT STACK
    DB 32 dup ('stack___')
Spila ENDS
Sdatos SEGMENT
    dato DB (0)
Sdatos ENDS
Scodigo SEGMENT 'CODE'
    ASSUME ss:Spila, ds:Sdatos, cs:Scodigo

Main PROC FAR
     Push ds
     Push 0
     Mov ax, Sdatos
     Mov ds,ax 
     ; Leer dos numero
     Mov ah,01h
     Int 21h
     Mov dato,al
     Mov ah,01h
     Int 21h
     ; Sumar los dos números
     Add al,dato
     SUB al,30h
     Mov dl,al
     Mov ah,02h

     mov ah, 0Ah
     mov al, dl
     mov bl, 56      ; color de fondo
     mov bl, 58     ; color de letra
     mov cx, 1      ; num caracteres pintados
     mov ah, 9 
     ;mov ah, 09h
     int 10h        ; int. controla los servicios de pantalla del pc
     Int 21h


     Ret
Main ENDP
Scodigo ENDS
END MAIN
