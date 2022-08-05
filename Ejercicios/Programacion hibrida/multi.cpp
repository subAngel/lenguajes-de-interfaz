#include <stdio.h>
#include <STDLIB.H>
#include <CONIO.H>

int main(void)
{
     int n1 = 3, n2 = 2, resultado;    // VARIABLES

     
     // printf("Ingrese el primer numero: ");
     // scanf("%d", &n1);
     // printf("ingrese el segundo numero: ");
     // scanf("%d", &n2);
     

     
     asm{ // SUMA
          mov ax, n1     // ax = n1
          //add bx, n2     // ax += n2
          mul n2
          mov resultado, ax   // resultado = ax
     }
     

     printf("Multiplicacion = %d",resultado);

     //printf("a: %d\n", a);
     getch();

     return 0;
}