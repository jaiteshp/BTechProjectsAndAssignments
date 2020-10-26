class TreeVisitor{
    public static void main(String[] a){
	System.out.println(1);
    }
}

class Parent
{
	
}

class Child
{
	int x;
	
	public int foo()
	{
		return 0;
	}

	public int bar()
	{
		x = this.foo();
		return this.foo();
	}	
}
