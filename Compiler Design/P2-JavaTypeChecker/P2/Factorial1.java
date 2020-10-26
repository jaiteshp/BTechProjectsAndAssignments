class Factorial{
    public static void main(String[] a){
        System.out.println(1);
    }
}
class F
{
	int num_aux;
	public int m1(){
		int  num_aux ;
		return 1;
		}	
} 
class Fac extends F{
	//int num_aux;
    public int ComputeFac(int num, int num1){
    Fac f1;
    f1 = new Fac();
        if ((num <= 1)&&(num != 1)) // Initially it was num <= 0
            num_aux = (1+0) ; // Initially it was num_aux = 1
        else
            num_aux = num * (1) ;
        return num_aux ;
    }
}
