# Expociciones de equipos

## EQUIPO 1

### Modularizacion

crear varias rutinas que sean utiles para

- Modulos: segmento, rutina, macros y procedimientos

*Procedimientos*:     secuencia de instrucciones las cuales se pueden acceder desde cualquier parte del codigo, sin reesscribir su codigo dentro del programa. Estan conformados con la declaración del procedimiento, después el código del procedimiento, directiva de regreso o retorno, la cual regresa el control al programa y por último la terminacion del procedimiento.
Procedimientos internos: declarados dentro de la estructura del programa, CALL PROC.
Procedimientos externos: Se llaman en arrchivos separados, PUBLIC, ExTERN, INCLUDE.

*Macros*:      conjunto de instrucciones las cuales se pueden llamar varias veces dentro del codigo, contra de 3 partes.

1. declaracion de la macro, palabra reservada macro, parametros
2. cuerpo, bloque de codigo
3. endm

Los procedimientos y las macros son similares, las macros pueden usar parametros. se pone el nombre de la macro

- Macros internas: dentro del codigo
- Macros externas: en un archivo externo

*Buffer de video en modo texto*: almacenamiento para la informacion, (servicios de streaming)
Modo texto: el modo de video donde la pantalla se representa en caracteres en ascii, se extendió durante los 70's, el uso de video en modo texto requiere menos recursos. El ensamblador despliega imagenes

*Acceso a discos en ensamblador*: es una forma de lectura y escritura de datos en un dispositivo auxiliar en la memoria principal,

- Aleatorio: El metodo de acceso a la compu del que se accede de manera directa.
- Secuencial: Es el metodo en la que la compu accede a los datos que es necesario interactura con el espacio fisico, si la compu requiere un dato especifico tiene que recorrer el espacio de la compu.

Buffer espacio de memoriadedicado al almacenamiento temporal de informacion
Modo de texto es un modo de video que representa la informacion en modo texto

## Equipo 6

### Programacion de dispositivos

Puerto serial es una interfaz de comunicacion de datos digitales, utilizados en perifericos. Se encuentran en dispositivos como routers, switches, etc,

### *INTERRUPCION 14*

Programacion de puerto paralelo para controlar motores o leds, muy facil de manejar, no es muy rápido, su uso ha sido dedicado al control de impresoras, se puede manejar una lavadora, luces, hasta una excavadora

- Puerto de datos:
- Puerto de control: solo de salida,
- Puerto de estaod, para recibir el estado de la impresora.

*Programacion Hibrida*: Mezcla lenguaje ensamblador con lenguaje dde alto nivel, para escribir programas más rapidos y eficientes

Ventajas: mejora la escalabilidad, reduccion de codigo, paralelismo

Directivas: cod

*Programacion de puertos USB*: bus estandar que define protocolos, para comunicar, proveer de alimentacion electrica a dispositivos y perifericos, su prinicipal objetivo es tener el mejor rendimiento y utilizar al maximo sus capacidade

Realizar un ensayo del 4.1

### Practicas

- Realizar un programa que dibuje una diagonal de colores en la pantalla
- Realizar un programa que imprima la letra z en la pantalla hasta que se precione la tecla ESC