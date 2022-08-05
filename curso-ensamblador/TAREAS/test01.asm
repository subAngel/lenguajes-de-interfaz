TITLE practica_arreglo
.286

; SEGMENTO DE PILA:
spila SEGMENT STACK
    DB 32 dup('stack___')
spila ENDS
; SEGMENTO DE DATOS:
sdatos SEGMENT
    arreglo DB 3 dup(?)
sdatos ENDS
; SEGMENTO DE CÓDIGO:
scodigo SEGMENT 'CODE'
    assume ss:spila, ds:sdatos, cs:scodigo
main PROC FAR ; Módulo principal:
    push ds
    push 0

    mov ax, sdatos
    mov ds, ax

    call limpiar ;llama al módulo para limpiar pantalla
    mov si, 0 ;registro source index

    LEER: ; Bucle para leer 3 caracteres y almacenarlos:
        mov ah, 01h ;lee un caracter y lo guarda en al
        int 21h

        mov arreglo[si], al ;almacena un caracter en el arreglo
        inc si ;incrementa si en 1

        cmp si, 2
        jbe LEER
    
    mov si, 0 ;reinicia si con 0
    mov al, arreglo[si] ;almacena en al el primer número

    COMPARAR:
        cmp al, arreglo[si+1]
        jg MAYOR
        mov al, arreglo[si+1]  ;almacena arreglo[si+1] en dl (mayor)
        
        MAYOR: ; Si al es mayor que el arreglo[si+1], no hace nada

        inc si ;incrementa si en 1

        cmp si, 1
        jbe COMPARAR

    ; Mueve el cursor una línea abajo:
    mov ah, 02h
    mov bh, 0 
    mov dx, 0100h
    int 10h
    ; Imprime el número más grande:
    mov ah, 02h
    mov dl, al
    int 21h

    RET
main ENDP
limpiar PROC NEAR ; Módulo para limpiar pantalla y posicionar el cursor:
    ; Limpiar pantalla:
    mov ah, 06h ;función que desplaza el texto de una ventana hacia arriba
    mov al, 0 ;número de líneas a desplazar (0 = todas)
    mov bh, 00001010B ;primer número = color de pantalla, segundo = color de letra
    mov cx, 0 ;ch = fila, cl = columna de la esquina superior izquierda
    mov dx, 184fh ;dh = fila, dl = columna de la esquina inferior derecha (24, 79)
    int 10h ;llama a la interrupción 10h
    ; Mueve el cursor al origen:
    mov ah, 02h ;función que localiza el cursor en una posición específica
    mov bh, 0 ;página de video
    mov dx, 0 ;dh = fila, dl = columna (0 = desde el origen)
    int 10h ;llama a la interrupción 10h

    RET
limpiar ENDP
scodigo ENDS
END main