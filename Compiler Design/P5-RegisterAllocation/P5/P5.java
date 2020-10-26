import syntaxtree.*;
import visitor.*;

public class P5 {
    public static void main(String [] args) {
        try {
            Node root = new microIRParser(System.in).Goal();
            LabelGenerator1 lg = new LabelGenerator1();
            NodeGenerator1 ng = new NodeGenerator1();
            //LivenessAnalysis1 la = new LivenessAnalysis1();
            RegisterAllocation ra = new RegisterAllocation();
            RuntimeManagement rm = new RuntimeManagement();
            TempConstructor tc = new TempConstructor();

            root.accept(tc, null);
            ng.procTemp = tc.procTemp;
            root.accept(lg, null);
            ng.procStart = lg.procStart;
            ng.procEnd = lg.procEnd;
//            System.out.println(lg.stmtCount);
//            System.out.println(ng.totalNodes);
//            System.out.println(la.totalNodes);

            ng.totalNodes = lg.stmtCount;
            ng.labMap = lg.labMap;
            ng.initializeSets();
            root.accept(ng, null);
            ng.doLivenessAnalysis();
            ng.buildProcTempVec();
            ng.doRA();
            //System.out.println(ng.procStart);

//            root.accept(la, null);
            root.accept(ra, null);
            root.accept(rm, null);

//            System.out.println(tc.procTemp);
//            System.out.println(lg.labMap);

//            System.out.println("use is " + ng.use);
//            System.out.println("def is " + ng.def);
//            System.out.println("succ is " + ng.succ);

            //System.out.println(ng.in);
            //System.out.println(ng.out);
            System.out.println(ng.procTempVec);

            //System.out.println("MicroIR parsed successfully.");
        }
        catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}



