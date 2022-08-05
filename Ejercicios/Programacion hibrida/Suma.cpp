#include <stdio.h>
#include <STDLIB.H>
#include <CONIO.H>

int main(void)
{
     int n1, n2, n3, resultado;

     printf("Ingrese el primer numero: ");
     scanf("%d", &n1);
     printf("ingrese el segundo numero: ");
     scanf("%d", &n2);
     printf("ingrese el tercer numero: ");
     scanf("%d", &n3);

     
     asm{
          mov ax, n1
          add ax, n2
          add ax, n3
          mov resultado, ax
     }
     

     printf("SUMA (%d+%d+%d)= %d", n1,n2,n3,resultado);

     //printf("a: %d\n", a);
     getch();

     return 0;
}