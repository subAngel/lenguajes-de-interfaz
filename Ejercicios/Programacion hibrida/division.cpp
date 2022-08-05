#include <stdio.h>
#include <STDLIB.H>
#include <CONIO.H>

int main(void)
{
     int n1, n2, resultado;    // VARIABLES

     
     printf("Ingrese el primer numero: ");
     scanf("%d", &n1);
     printf("ingrese el segundo numero: ");
     scanf("%d", &n2);
     

     
     asm{ // SUMA
          mov dx, 0
          mov ax, n1
          mov cx, n2
          div cx
          mov resultado, ax   // resultado = ax
     }
     

     printf("Division (%d/%d) = %d",n1, n2, resultado);

     //printf("a: %d\n", a);
     getch();

     return 0;
}