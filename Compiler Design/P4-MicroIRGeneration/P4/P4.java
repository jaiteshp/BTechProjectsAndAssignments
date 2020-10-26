import syntaxtree.*;
import visitor.*;

public class P4 {
    public static void main(String [] args) {
        try {
            GJDepthFirst g = new GJDepthFirst();
            Node root = new MiniIRParser(System.in).Goal();
            root.accept(g, null);
            //System.out.println("Conversion successfull");
        }
        catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}



