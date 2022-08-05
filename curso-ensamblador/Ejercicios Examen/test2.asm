.model small
.stack
.data
mens db 'Teclea tu nombre',0ah,0dh,'$' ;mensaje de inicio

cadena label byte ;aquí defines la estructura de la cadena:
max db 21 ;máximo de caracteres (20 letras + el enter)
cant db ? ;almacena la cantidad real de caracteres tecleados
campo db 21 dup (' ') ;acepta espacios en la cadena

.code
.startup

mov ax,@data ;respalda los datos a introducir en
mov ds,ax ;los registros ds y es para que no se pierdan
push ds ;durante las instrucciones siguientes
pop es

;------Inicia el programa--------------------------

mov ah,09h ;petición para mostrar mensaje
lea dx,mens
int 21h

mov ah,0ah ;petición para introducir cadena
mov dx,offset cadena
int 21h

lea si,campo ;mandamos la cadena al registro si para empezar
;a evaluar

ciclo:
mov al,[si]
cmp al,20h ;verifica si es caracter o es espacio
jne disp ;i es caracter, lo despliega en pantalla
inc si ;si es espacio, lo salta y pasa al siguiente caracter
jmp ciclo

disp:

mov ah,02h ;petición para desplegar
mov dl,al
int 21h
cmp al,0dh ;si encuentra un enter,
je salir ;sale del programa
inc si
jmp ciclo

salir:

.exit
end