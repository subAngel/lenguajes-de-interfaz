.MODEL SMALL ; modelo pequeno de compilacion *64k  como maximo)

.STACK 100h    ; segmento de pila: 256 posiciones
CR equ 13      ; declaracion de constantes l
lf equ 10      

.DATA          ; comienzo del segmento de datos
     texto db 'Hola$', cr, lf ; reserva de memoria con retorno de carro e inicio de la linea, 
                              ; la variable TEXTO es de tipo byte, el simbolo $ es el fin de la cadena
                              
.CODE     ; comienzo del segmento de datos
     mov ax, seg texto   ; mueve a ax la direccion del primer byte del segmento de datos
     mov ds, ax          ; mueve dicha direcion ax, al segmento de datos DS(data segment)
     lea dx, texto       ; cargamos en dx la direccion efectiva del texto que vamos a imprimir en pantalla

     mov ah, 09h         ; funcion escribir en pantalla 
     int 21h             ; llamada a DOS por medio de la interrupcion para ejecutar 'Retornar a DOS'

     mov ah, 04ch        ; funcion 'Retornar a DOS'
     int 21h             ; llamada a DOS para terminar el programa 
END 

