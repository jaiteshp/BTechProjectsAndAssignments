class Factorial{
    public static void main(String[] a){
        System.out.println(new Fac().ComputeFac((10+0)));
    }
}

class Fac {
    // int cv1;
    // int cv2;
    // Factorial f1;
    // boolean hi;
    // int[] arr;
    // boolean hi1;
    public int ComputeFac(int num){
        int num_aux ;
        if ((num <= 1)&&(num != 1)) // Initially it was num <= 0
            num_aux = (1+0) ; // Initially it was num_aux = 1
        else
            num_aux = num * (this.ComputeFac(num-1)) ;
        return num_aux ;
    }

    // public boolean m1()
    // {
    //     return true;
    // }
    // public int m2()
    // {
    //     boolean v;
    //     return 7;
    // }
    // public boolean m3(int x)
    // {

    //     return true;
    // }
    // public boolean m4()
    // {
    //     cv1 = 0;
    //     return true;
    // }
}

// class Fac2 extends Fac 
// {
//     public boolean m1()
//     {
//         return false;
//     }
// }

// class Empty
// {
    
// }
