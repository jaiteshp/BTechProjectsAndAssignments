import syntaxtree.*;
import visitor.*;

public class P3 {
    public static void main(String [] args) {
        try {
            OldGJDepthFirst g0 = new OldGJDepthFirst();
            GJDepthFirst g = new GJDepthFirst();
            Node root = new MiniJavaParser(System.in).Goal();
            root.accept(g0, null);
            root.accept(g, null);
//            System.out.println("Program parsed successfully");
//            System.out.println(g.tempCount);
//            System.out.println(g.cm0);
//            System.out.println(g.cm1);
//            System.out.println(g.cm2);
            g.build_copy();
//            System.out.println(g.cm1c);
//            System.out.println(g.cm2c);
            g.build_cm3();
            g.build_cm4f();
            g.build_cm4mv();
            g.build_cm5();
//            System.out.println(g.cm4);
//            System.out.println(g.cm3);
//            System.out.println(g.cm4);

            Generator g2 = new Generator();
            g2.classMap = g0.classMap;
            g2.methRetMap = g0.methRetMap;
            g2.varMap = g0.varMap;
            g2.methParamMap = g0.methParamMap;
            g2.classMethMap = g.classMethMap;
            g2.cm3 = g.cm3;
            g2.cm3f = g.cm3f;
            g2.cm4 = g.cm4;
            g2.cm5 = g.cm5;
            g2.cm1c = g.cm1c;
            g2.tempCount = g.tempCount;
            g2.build_methParamCountMap();

            //System.out.println(g2.methRetMap);
            //System.out.println(g2.methParamCountMap);
//            System.out.println(g2.cm4);

            root.accept(g2, null);

            //System.out.println(g2.cm3);
//            System.out.println(g2.cm3f);
            //System.out.println(g2.classMethMap);

        }
        catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}



