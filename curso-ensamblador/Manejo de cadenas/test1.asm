TITLE practica_buscar_en_cadenas
.286

; SEGMENTO DE PILA:
spila SEGMENT STACK
    DB 32 dup('stack___')
spila ENDS
; SEGMENTO DE DATOS:
sdatos SEGMENT
    cadena   DB 9 dup(?)
    posicion DB 9 dup(?)
    mensaje1 DB 'Introduzca la longitud: (Maximo 9):','$'
    mensaje2 DB 'Introduzca la cadena:','$'
    mensaje3 DB 'Introduzca el caracter a buscar:','$'
    longitud DB (0)
    contador DB (0)
sdatos ENDS
; SEGMENTO DE CÓDIGO:
scodigo SEGMENT 'CODE'
    assume ss:spila, ds:sdatos, cs:scodigo
; INICIO DE MACROS:
mover_cursor MACRO f, c ; Macro para mover el cursor:
    mov ah, 02h 
    mov bh, 0 ;página de video
    mov dh, f ;fila
    mov dl, c ;columna
    int 10h
ENDM
imprimir MACRO s ; Macro para imprimir una cadena:
    mov ah, 09h
    lea dx, s
    int 21h
ENDM
imprimir_color MACRO c ; Macro para imprimir un caracter a color:
    mov ah, 09h 
    mov bh, 0
    mov bl, c
    mov cx, 1 
    int 10h
ENDM
; INICIO DE PROCEDIMIENTOS:
main PROC FAR ; Procedimiento principal:
    push ds
    push 0

    mov ax, sdatos
    mov ds, ax

    ; RECIBE LA LONGITUD:
    call limpiar      ;limpia la pantalla
    imprimir mensaje1
    mover_cursor 1, 0 ;mueve el cursor una fila abajo
    call leer_car     ;lee un caracter y lo guarda en al
    sub  al, 30h      ;convierte el número de ASCII a caracter
    mov  longitud, al ;guarda la longitud

    ; RECIBE LA CADENA:
    call limpiar
    imprimir mensaje2
    mover_cursor 1, 0 ;mueve el cursor una fila abajo
    mov  cl, 0        ;inicializa cl con 0
    mov  si, 0        ;inicializa si con 0

    cmp longitud, 0 ;si la longitud es cero termina
    jbe FIN

    LEER: ; Lee n caracteres y los almacena en cadena:
        call leer_car
        mov  cadena[si], al ;almacena en el arreglo un caracter
        inc  cl             ;incrementa cx en 1
        inc  si             ;incrementa si en 1

        cmp cl, longitud
        jb  LEER ;si < al

    ; RECIBE EL CARACTER A BUSCAR:
    call limpiar
    imprimir mensaje3
    mover_cursor 1, 1 ;baja el cursor una fila

    call leer_car
    mov  bl, al   ;guarda el caracter en bl
    call limpiar
    mov  dh, bl   ;guarda el caracter en dh
    mov  dl, 0    ;inicializa dh con 0
    mov  si, 0    ;inicializa si con 0

    BUSCAR: ; Busca en la cadena el caracter indicado:
        mov al, cadena[si]
        inc dl ;contador
        inc si

        cmp al, dh ;compara los caracteres
        je CORRECTO
        jmp INCORRECTO
        
        CORRECTO: ; Si el caracter coincide:
            imprimir_color 000Ch  ;imprime el caracter con un color
            push dx               ;almacena dx (dl = contador y dh = caracter) en la pila
            mover_cursor 0, dl    ;mueve el cursor a la columna correspondiente
            pop  dx               ;recupera dx (dl = contador y dh = caracter)
            mov  bh, 0            ;reinicia bh a 0
            mov  bl, contador     ;índice para el arreglo posición
            mov  posicion[bx], dl ;almacena la posición del caracter
            add  contador, 1      ;aumenta contador en 1
            jmp  CONTINUAR

        INCORRECTO: ; Si el caracter no coincide:
            imprimir_color 000Fh ;imprime el caracter en blanco
            push dx              ;almacena dx (dl = contador y dh = caracter) en la pila
            mover_cursor 0, dl   ;mueve el cursor a la columna correspondiente
            pop  dx              ;recupera dx (dl = contador y dh = caracter)

        CONTINUAR: ; Comprueba si se alcanzó la longitud de la cadena:
            cmp dl, longitud
            jb BUSCAR

    ; IMPRIME LAS CANTIDAD DE APARICIONES DEL CARACTER:
    mover_cursor 2, 0
    mov al, contador
    add al, 30h ;lo convierte en decimal
    imprimir_color 000Fh

    ; IMPRIME LAS POSICIONES DEL CARACTER:
    mover_cursor 3, 0
    mov dl, 0 ;contador
    mov si, 0

    cmp contador, 0 ;si no hay apariciones termina
    je FIN

    POSICIONES: ;recorre el arreglo con las posiciones y las imprime:
        mov al, posicion[si]
        add al, 30h          ;lo convierte en decimal
        inc dl               ;contador
        inc si

        imprimir_color 1101B ;imprime la posición en color rojo
        mover_cursor 3, dl   ;mueve el cursor a la posición indicada

        cmp dl, contador
        jb POSICIONES

    FIN: ; Fin del programa:

    RET
main ENDP
limpiar PROC NEAR ; Procedimiento para limpiar la pantalla:
    ; Limpiar la pantalla:
    mov ah, 06h
    mov al, 0     ;num de líneas a desplazar (0 = todas)
    mov bh, 7     ;primer num = color de pantalla, segundo num = color de la letra
    mov cx, 0     ; ch = fila, cl = columna de la esquina superior izq
    mov dx, 184fh ;dh = fila, dl = columna de la esquina inferior der
    int 10h
    ; Mueve el cursor al origen:
    mov ah, 02h
    mov bh, 0     ;página de video
    mov dx, 0     ;dh = fila, dl = columna
    int 10h

    RET
limpiar ENDP
leer_car PROC NEAR ; Procedimiento que lee un caracter y lo guarda en al:
    mov ah, 01h
    int 21h

    RET
leer_car ENDP
scodigo ENDS
END main