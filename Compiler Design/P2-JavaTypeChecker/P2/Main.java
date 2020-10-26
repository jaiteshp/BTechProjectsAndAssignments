import syntaxtree.*;
import visitor.*;

public class Main {
   public static void main(String [] args) {
      try {
         GJDepthFirst g = new GJDepthFirst();
         Node root = new MiniJavaParser(System.in).Goal();
         root.accept(g, null); // Your assignment part is invoked here.
         System.out.println("Program parsed successfully");
         //System.out.println(g.classMap);
         //System.out.println(g.methMap);
         //System.out.println(g.varMap);
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 



