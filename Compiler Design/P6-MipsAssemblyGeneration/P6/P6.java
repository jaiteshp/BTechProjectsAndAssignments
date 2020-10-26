import syntaxtree.*;
import visitor.*;

public class P6 {
    public static void main(String [] args) {
        try {
            GJDepthFirst g = new GJDepthFirst();
            Node root = new MiniRAParser(System.in).Goal();
            root.accept(g, null);
        }
        catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}



