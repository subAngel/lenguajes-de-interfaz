# Temas

Equipo 1
1 Ensamblador y tipos de ligadores
2 ciclos numericos
3 Cadenas
4 Comparaciones y pruebas

Equipo 6
Saltos
Ciclos condicionales
Incremento, decremento
cadenas en formato

Equipo 8
Instrucciones aritmeticas
Manipulacion de pila
Cadenas con representación decimal
Instrucciones lógicas

Equipo *Orion*
Desplazamiento y notación
Optención de una cadena con representación hexadecimal
Captura y almacenamieno de datos numericos
Operaciones básicas sobre archivo de disco

Equipo 5
Procedimientos y macros
Buffer de video
puerto serial
puerto paralelo
programación hibrida
programación de puerto usb

TAREA

**Analisar los Registros mas importantes de la CPU, así como las funciones de los mismos,**
**Investigar la estructura y organización de un procesador**
**Describir modos de direccionamiento de memoria**

Las instrucciones inc y dec, incrementan y decrementan valores en 1, ya que uno es un operador implicito, el código de la máquina para inc y dec es más pequeño que las instrucciones add y sub
>> inc ax
>> dec ax

## Directivas

Sirven para definir constantes,
definir memoria para almacenar datos en ella,
alojar memoria en segmentos,
incluir codigo fuente condicionalmente,
incluir otros archivos.

*Directiva EQU*

La directiva equ se puede usar para definir un simbolo, los símbolos son constantes con nombre que se pueden emplear en programa ensamblador
     ex equ 8

La directiva %, esta directiva es parecida a la del #define, se usa para definir macros
     %define size 100

**Entrada y Salida**

La entrada y salida son acciones muy dependietes del sistema, involucra comunicarse con el hardware, los lenguajes de alto nivel como c, proveen bibliotecas que suministran una interfaz de programación simple, los lenguajes ensamblador no disponen de bibliotecas, ellos deben acceder directamente al hardware, es muy común que se interfacen rutinas de ensamblador con c, una de las ventajas de esto es que el código de ensamblador puede usar las rutinas E/S de la biblioteca standar de C.
Para usar las rutinas print
     1. carga eax con el valor correcto y usa la instruccion call para invocarlo
La instruccion call equivale un llamado de instrucción en un lenguaje de alto nivel

Tarea enviar al correo, oscarartlc@hotmail.com