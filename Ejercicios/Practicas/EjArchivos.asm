; rEALIZAR UN PROGRAMA QUE CONTENGA Y EJECUTE LAS SIGUIENTES INSTRUCCIONES, DESPLEGAR UN MENU QUE CONTENGA
     ; 1. CREAR UN ARCHIVO 
     ; 2. ESCRIBIR UN ARCHIVO 
     ; 3. VER EL TEXTO DEL ARCHIVO 
     ; 4. SALIR

posicionar macro x, y    ; macro para posicionar el cursor
     mov ah, 02h    
     mov bh, 00h    ; pagina de video
     mov dh, y      ; linea del cursor
     mov dl, x      ; columna del cursor
     int 10h
ENDM

limpiar macro color  ; macro para limpiar pantalla
     mov ax, 0600h  ; 
     mov bh, color
     mov cx, 0000h
     mov dx, 184fh
     int 10h
endm

terminar macro      ; macro para terminar procesos
     mov ah, 4ch
     int 21h
endm

imprimir macro mensaje   ; macro para imprimir un mensaje 
     mov ah, 09h    ; 
     lea dx, mensaje
     int 21h
endm
       
createfile macro file ; macro para crear un archivo
    mov ah, 3ch 
    mov cx, 00
    lea dx, file
    int 21h
endm

openfile macro file ; macro para abrir archivo
    mov ah, 3dh
    mov al, 2   ; permisos
    int 21h
endm

writefile macro file, txt     ; macro para escribir archivo
;LOCAL ERROR, INICIO
    ; abrir un archivo
    mov ah, 3dh
    mov al, 1
    mov dx, offset file
    int 21h
    ; escribir archivo 
    jc ERROR  
    
    mov bx, ax  ; mover hadfile
    mov cx, 50  ; numero de caracteres a grabar 
    mov dx, offset txt
    mov ah, 40h
    int 21h 
    
    cmp cx, ax ; si son iguales no pasa nada
    jne ERROR   
    ; si toda ta bien se cierra el archivo
    limpiar 00001010B
    posicionar 24d, 10d
    imprimir writemsg
    posicionar 24d, 13d
    imprimir continuar
    call read
    mov ah, 3eh     ; cierra el archivo
    int 21h     
    jmp INICIO
    
endm   

readfile macro file ; leer un archivo en ensamblador
    ; abrir un archivo
    mov ah, 3dh
    mov al, 0   ; modo lectura
    mov dx, offset file
    int 21h
    ; escribir archivo 
    jc ERROR  
    mov manejador, ax
    
    
    mov ah, 3fh     ; leer
    mov bx, manejador   
    mov cx, 50
    mov dx, offset texto
    int 21h
    jc ERROR
    
    
    
    ; si toda ta bien se cierra el archivo
    limpiar 00001010B       ; limpia y cambia el color
    posicionar 24d, 10d
    imprimir texto  ; imprime el texto del archivo
    posicionar 24d, 13d
    imprimir continuar
    call read
    mov ah, 3eh     ; cierra el archivo
    int 21h     
    jmp INICIO
ENDM    

pedirtxt macro mtxt     ; PEDIR CARACTERES DEL TECLADO
LOCAL PEDIR 
        mov si, 0
    PEDIR:
        mov ah, 01h
        int 21h
        mov mtxt[si], al
        inc si
        cmp al, 13d
        ja PEDIR
        jb PEDIR 
ENDM
.model small
.stack
.data
     mensaje        db 'Hola mundo, adios mundo......$'
     separador      db '********************************************************************************','$'
     opciones       db '                           ******************************',10,13,'                           * [1] Crear archivo          *',10,13,'                           * [2] Escribir en un archivo *',10,13, '                           * [3] Ver archivo            *',10,13,'                           * [4] Salir del programa     *',10,13,'                           ******************************',10,13,10,'                            Selecciona una opcion: ','$'
     manejador      dw ?
     errormsg       db 'Hubo un error en el fichero$' 
     exitomsg       db 'Fichero creado correctamente$'
     writemsg       db 'Fichero escrito correctamente$'  
     continuar      db 'Espacio para continuar: $'
     saliendo       db 'SALIENDO....$'
     path           db 'D:\test',0
     fichero        db 'D:\prueba.txt',0
     accion         dw ?
     bytesleidos    dw ?
     texto          db 50 dup ('$')
.code
     main proc far 
          mov ax, @data
          mov ds, ax

          INICIO:    
               limpiar 00001011B   ; limpiar pantalla

               posicionar 0d, 0d
               imprimir separador
               posicionar 0d, 1d
               imprimir opciones
               call read

               cmp al, '1'    ; comparar op1
               je OP1
               cmp al, '2'    ; compara op2
               je OP2
               cmp al, '3'    ; compara op3
               je OP3
               cmp al, '4'    ; compara op4
               je OP4

          OP1: ; crear archivo
               createfile fichero
               jc ERROR
               mov manejador, ax 
               limpiar 00001010B    ; limpiar y cambiar color  
               posicionar 24d, 10d
               imprimir exitomsg  
               posicionar 24d, 12d  ; posicionar el mensaje
               imprimir continuar
               call read            ; leer el espacio para continuar
               jmp INICIO           ; regresar el menu

          OP2: ; escribir archivo
               writefile fichero, mensaje
               
                 
          OP3: ; ver archivo
               readfile fichero  
               
          OP4: ; salir
               limpiar 00001110B
               posicionar 24d, 5d
               imprimir saliendo
               mov ah, 4ch
               int 21h 
               ;terminar  ; llamada de macro terminar
          ERROR:
               limpiar 00001100B
               posicionar 34d,12d
               imprimir errormsg

               jmp OP4


     main endp
     read proc near
          mov ah, 01h
          int 21h
          ret 
     read endp
     





end main