include 'emu8086.inc'
name "Suma de dos numeros"
org 100h
.286
.model small
.data
     suma db 2 dup (?)
.code
     sumas proc 
     print "introduce el primer numero: "
     call scan_num
     mov suma[0], cl
     printn " "
     print " Intruduce el segundo numero: "
     call scanL_num
     mov suma[1], cl
     xor ax, ax
     add al, suma[0]
     add al, suma[1]
     printn " "
     print " La suma es: "
     call print_num
sumas endp
exit:
     print " "
     printn " "
     print "Presiona enter para salir..."
     mov ah, 0h
     int 16h
     ret
define_print_string
define_print_num
define_print_num_uns
define_scan_num
end