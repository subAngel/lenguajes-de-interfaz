#include <conio.h>
#include <iostream>

using namespace std;

int SumarDosEnteros(int a, int b)
{
     int result;

     __asm
     {
          mov eax, a
          add eax, b
          mov result, eax
     }

     return result;
}

int main()
{

     int a = 300, b = 255, c = 0;
     c = SumarDosEnteros(a, b);
     cout << c;
     getch();
     return 0;
}