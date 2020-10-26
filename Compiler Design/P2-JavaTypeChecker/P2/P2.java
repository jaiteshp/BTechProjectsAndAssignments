import syntaxtree.*;
import visitor.*;

public class P2 {
    public static void main(String [] args) {
        try {
            GJDepthFirst g = new GJDepthFirst();
            Node root = new MiniJavaParser(System.in).Goal();
            root.accept(g, null);
            //System.out.println("Program parsed successfully");
            //System.out.println(g.varMap);
            //System.out.println(g.methParamMap);
            //System.out.println(g.methRetMap);
            //System.out.println(g.classMap);

            TypeChecker t = new TypeChecker();
            t.classMap = g.classMap;
            t.methRetMap = g.methRetMap;
            t.varMap = g.varMap;
            t.methParamMap = g.methParamMap;
            root.accept(t, null);
            System.out.println("Program type checked successfully");
            //System.out.println(t.varMap);


            //System.out.println(g.classMap);
            //System.out.println(t.methMap);
            //System.out.println(g.varMap);
        }
        catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}



