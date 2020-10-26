class Factorial{
    public static void main(String[] a){
        System.out.println(1);
    }
}

class Fac {
    public int ComputeFac(int num, Fac f2){
        int num_aux ;
        if ((num <= 1)&&(num != 1)) // Initially it was num <= 0
            num_aux = (1+0) ; // Initially it was num_aux = 1
        else
            num_aux = num * (this.ComputeFac(num-1)) ;
        return num_aux ;
    }
}

class c1 extends Fac
{
    int a;
    Fac f1;
    Fac f2;
    int x ;
    public int m1(int hi){
        x = f1.ComputeFac(1, f2);
        return 0;
    }
}

// class c2 extends c1
// {
//     int b;
//     int c;
//     public int m2()
//     {
//         int y;
//         int z;
//         return 0;
//     }
// }

// class c3 extends c1
// {
//     int hi;
//     public int m21()
//     {
//         int q;
//         int r;
//         return 1;
//     }
// }
