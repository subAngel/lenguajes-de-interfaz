.model small
.stack
write macro param
     mov ah,02h
     mov dl, param
     int 21h
endm
writeres macro registro
     mov ah, 02h
     mov dl, registro
     int 21h
endm
.data
     contador dw 2       ; contador lo iniciamo en 2 pq ya hay dos iteraciones
     arreglo  db 13 dup (0)   ; 13 sucesiones de fibonacci
     n3       db 0
     ;titulo   db 'Sucesion de Fibonacci', 13d, '$'
    
.code
main proc far
     mov  ax,@data
     mov  ds,ax

     ; imprimir el titulo
     ; mov ah, 09h
     ; lea dx, titulo
     ; int 21h

     ; sub dx, dx     ; limpiamos el registro dx

     mov  ah,0   ; ah = 0
     mov  al,1   ; al = 1

     mov  arreglo[0],ah    ; arreglo[0] = 0
     mov  arreglo[1],al    ; arreglo[1] = 1

     mov  si,0   ; indice de origen = 0
     mov  di,1   ; indice destino = 1

     mov  cx,13d ; movemos al registro cx 13, que van a ser la sucesiones
     ciclo:            
          mov  al,arreglo[si]   ; al = arreglo[0] = 0 aqui empezamos 
          mov  bl,arreglo[di]   ; bl es la siguiente iteracion
          add  al,bl            ; sumamos bl en al
          mov  bx,contador      ; iniciamos el contador que vale 2 en bx
          mov  arreglo[bx],al   ; la suma de los anteriores se pasa a la iteracion 2 del arreglo de numeros
                              ; 
          inc  si     ; incrementamos el indice source
          inc  di     ; incrementamos el indice detino
          inc  contador    ; incrementamos el contador para que sea el siguiente de 2 y así
          loop ciclo  ; repetimos el ciclo

     mov  si,0      ; limpiamos si
     mov  cx,13d    ; cx = 13, numero de veces que va a recorrer el arreglo

     ciclo_imprime:    
          mov  ax,0   ; limpiamos el registro ax
          mov  al,arreglo[si]   ; 
          cmp  ax,144d          ; 
          jge  ajusta_3_digitos ; salto con signo si el numero se pasa de 3 digitos

     ajustar_2_digitos:
          aam         ; ajustamos el numero de dos digitos
          mov  bx,ax  ; bx = ax
          add  bx,3030h    ; como es de 16 bits, y se divide en 2, alto y bajo 
                         ; al bajo le ajustamos 30h, y al alto lo mismo

          writeres bh ; imprimimos el registro alto de BX

          writeres bl ; imprimimos el registro bajo de BX

          call espacio     ; imprimo un espacio
          jmp  avanza ; continumamos con el programa

     ajusta_3_digitos: 
          aam            ; ajuste
          add  al,30h    ; ajustamos el caracter 
          mov  n3,al     ; n3 = al

          mov  al,ah
          mov  ah,0      ; limpiamos el registro ah
          aam
          mov  bx,ax     ; bx = ax
          add  bx,3030h  ; ajustamos bx

          writeres bh ; imprimos lo que hay en el registro bh

          writeres bl ; imprimimos lo que hay en el registro bl

          write n3       ; imprimimos el n3

          call espacio     ; imprimimos un espacio

     avanza:           
          inc  si
          loop ciclo_imprime

          jmp FIN
     FIN:
          mov ah, 4ch
          int 21h

main endp
espacio proc near 
     mov  al,02h
     mov  dl,' '
     int  21h
     ret
espacio endp
end main