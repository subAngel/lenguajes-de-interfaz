
/**
 *
 * @author angel
 */
public class Suma {
    public native int sumar(int a, int b, int c);
    
    static {
        System.loadLibrary("sumaImpl");
    }
    
    public static void main (String args[]){
        int n1 = 2;
        int n2 = 4;
        int n3 = 9;
        
        Suma s = new Suma();
        int resultado = s.sumar(n1, n2, n3);
        
        System.out.println("El resultado de la suma es: " + resultado);
    }
    
}
