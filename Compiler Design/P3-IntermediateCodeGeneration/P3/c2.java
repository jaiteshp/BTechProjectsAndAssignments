class Factorial{
    public static void main(String[] a){
        System.out.println(new c1().m1(1));
    }
}

class Fac {
    int b1;
    int c;
    public int ComputeFac(int num){
        int num_aux ;
        if (num <= 0) // Initially it was num <= 0
            num_aux = 1; // Initially it was num_aux = 1
        else
            num_aux = num * (this.ComputeFac(num-1)) ;
        return num_aux ;
    }
}

class c1 extends Fac
{
    int a1;
    Fac f;
    public int m1(int hi){
        hi = 5;
        return 0;
    }
}

class c2 extends c1
{
    int b;
    int c;
    public int m2()
    {
        int y;
        int z;
        return 0;
    }
}

class c3 extends c1
{
    int hi;
    public int m21()
    {
        int q;
        int r;
        return 1;
    }
}
