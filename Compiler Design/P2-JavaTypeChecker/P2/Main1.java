import syntaxtree.*;
import visitor.*;

public class Main1 {
   public static void main(String [] args) {
      try {
    	 //GJDepthFirst g = new GJDepthFirst();
         TypeChecker t = new TypeChecker();
//         Node root = new MiniJavaParser(System.in).Goal();
//         
//         root.accept(t, null); // Your assignment part is invoked here.
//	          System.out.println("Program parsed successfully");
         //t.printHelloWorld();
         //t.print2FromParent();
         t.DoAPass();
         t.DoAPass();
         Node root = new MiniJavaParser(System.in).Goal();
         System.out.println(root.accept(t, null));
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 



