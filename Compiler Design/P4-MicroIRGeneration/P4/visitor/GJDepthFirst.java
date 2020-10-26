//
// Generated by JTB 1.3.2
//

package visitor;
import syntaxtree.*;
import java.util.*;

/**
 * Provides default methods which visit each node in the tree in depth-first
 * order.  Your visitors may extend this class.
 */
public class GJDepthFirst<R,A> implements GJVisitor<R,A> {

   int tempCount = 2000;
   int labCount = 2000;
   boolean printLab = true;

   String genTemp()
   {
      return ("TEMP " + Integer.toString(tempCount++));
   }

   String genLab()
   {
      return ("L" + Integer.toString(labCount++));
   }

   void gen(String s)
   {
      System.out.print(s);
      return;
   }

   void genln(String s)
   {
      System.out.println(s);
      return;
   }

   public R visit(NodeList n, A argu) {
      R _ret=null;
      int _count=0;
      for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
         e.nextElement().accept(this,argu);
         _count++;
      }
      return _ret;
   }

   public R visit(NodeListOptional n, A argu) {
      if ( n.present() ) {
         R _ret=null;
         int _count=0;
         for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
            e.nextElement().accept(this,argu);
            _count++;
         }
         return _ret;
      }
      else
         return null;
   }

   public R visit(NodeOptional n, A argu) {
      if ( n.present() )
         return n.node.accept(this,argu);
      else
         return null;
   }

   public R visit(NodeSequence n, A argu) {
      R _ret=null;
      int _count=0;
      for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
         e.nextElement().accept(this,argu);
         _count++;
      }
      return _ret;
   }

   public R visit(NodeToken n, A argu) { return null; }

   //
   // User-generated visitor methods below
   //

   /**
    * f0 -> "MAIN"
    * f1 -> StmtList()
    * f2 -> "END"
    * f3 -> ( Procedure() )*
    * f4 -> <EOF>
    */
   public R visit(Goal n, A argu) {
//      genln("95");
      R _ret=null;
      n.f0.accept(this, argu);
      genln("MAIN ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      genln("END ");
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> ( ( Label() )? Stmt() )*
    */
   public R visit(StmtList n, A argu) {
//      genln("109");
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> Label()
    * f1 -> "["
    * f2 -> IntegerLiteral()
    * f3 -> "]"
    * f4 -> StmtExp()
    */
   public R visit(Procedure n, A argu) {
//      genln("123");
      R _ret=null;
      printLab = false;
      String a0 = n.f0.f0.toString();
      printLab = true;
      n.f1.accept(this, argu);
      String a2 = (String) n.f2.accept(this, argu);
      n.f3.accept(this, argu);

      genln(a0 + " [ " + a2 + " ] ");
      genln("BEGIN ");
      String a4 = (String) n.f4.accept(this, argu);
      genln("RETURN ");
      genln(a4);
      genln("END ");
      return _ret;
   }

   /**
    * f0 -> NoOpStmt()
    *       | ErrorStmt()
    *       | CJumpStmt()
    *       | JumpStmt()
    *       | HStoreStmt()
    *       | HLoadStmt()
    *       | MoveStmt()
    *       | PrintStmt()
    */
   public R visit(Stmt n, A argu) {
//      genln("150");
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "NOOP"
    */
   public R visit(NoOpStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      genln("NOOP ");
      return _ret;
   }

   /**
    * f0 -> "ERROR"
    */
   public R visit(ErrorStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      genln("ERROR ");
      return _ret;
   }

   /**
    * f0 -> "CJUMP"
    * f1 -> Exp()
    * f2 -> Label()
    */
   public R visit(CJumpStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String a1 = (String) n.f1.accept(this, argu);
      printLab = false;
      String a2 = (String) n.f2.accept(this, argu);
      printLab = true;
      genln("CJUMP " + a1 + " " + a2);
      return _ret;
   }

   /**
    * f0 -> "JUMP"
    * f1 -> Label()
    */
   public R visit(JumpStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      printLab = false;
      String a1 = (String) n.f1.accept(this, argu);
      printLab = true;
      genln("JUMP " + a1);
      return _ret;
   }

   /**
    * f0 -> "HSTORE"
    * f1 -> Exp()
    * f2 -> IntegerLiteral()
    * f3 -> Exp()
    */
   public R visit(HStoreStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String a1 = (String) n.f1.accept(this, argu);
      String a2 = (String) n.f2.accept(this, argu);
      String a3 = (String) n.f3.accept(this, argu);
      genln("HSTORE " + a1 + " " + a2 + " " + a3);
      return _ret;
   }

   /**
    * f0 -> "HLOAD"
    * f1 -> Temp()
    * f2 -> Exp()
    * f3 -> IntegerLiteral()
    */
   public R visit(HLoadStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String a1 = (String) n.f1.accept(this, argu);
      String a2 = (String) n.f2.accept(this, argu);
      String a3 = (String) n.f3.accept(this, argu);
      genln("HLOAD " + a1 + " " + a2 + " " + a3);
      return _ret;
   }

   /**
    * f0 -> "MOVE"
    * f1 -> Temp()
    * f2 -> Exp()
    */
   public R visit(MoveStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String a1 = (String) n.f1.accept(this, argu);
      String a2 = (String) n.f2.accept(this, argu);
      genln("MOVE " + a1 + " " + a2);
      return _ret;
   }

   /**
    * f0 -> "PRINT"
    * f1 -> Exp()
    */
   public R visit(PrintStmt n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      String a1 = (String) n.f1.accept(this, argu);
      genln("PRINT " + a1);
      return _ret;
   }

   /**
    * f0 -> StmtExp()
    *       | Call()
    *       | HAllocate()
    *       | BinOp()
    *       | Temp()
    *       | IntegerLiteral()
    *       | Label()
    */
   public R visit(Exp n, A argu) {
//      genln("270");
      R _ret=null;
      String t1 = genTemp();
      String a1;
      if(n.f0.which == 6)
      {
         printLab = false;
         a1 = (String) n.f0.accept(this, argu);
         printLab = true;
      }
      else a1 = (String) n.f0.accept(this, argu);
      genln("MOVE " + t1 + " " + a1);
//      genln("275");
      return (R) t1;
   }

   /**
    * f0 -> "BEGIN"
    * f1 -> StmtList()
    * f2 -> "RETURN"
    * f3 -> Exp()
    * f4 -> "END"
    */
   public R visit(StmtExp n, A argu) {
//      genln("286");
      R _ret=null;
      String t1 = genTemp();
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      String a3 = (String) n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      genln("MOVE " + t1 + " " + a3);
      return (R) t1;
   }

   /**
    * f0 -> "CALL"
    * f1 -> Exp()
    * f2 -> "("
    * f3 -> ( Exp() )*
    * f4 -> ")"
    */
   public R visit(Call n, A argu) {
//      genln("307");
      R _ret=null;
      String t1 = genTemp();
      Vector <String> paramExpVec = new Vector <String> ();
      n.f0.accept(this, argu);
      String a1 = (String) n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);

      if(n.f3.present())
      {
         for(int i = 0; i < n.f3.size(); i++)
         {
            paramExpVec.add((String) n.f3.elementAt(i).accept(this, argu));
         }
      }
      genln("MOVE " + t1 + " ");
      gen("CALL " + a1 + " ( ");
      for(int i = 0; i < paramExpVec.size(); i++)  gen(paramExpVec.get(i) + " ");
      genln(" ) ");
      return (R) t1;
   }

   /**
    * f0 -> "HALLOCATE"
    * f1 -> Exp()
    */
   public R visit(HAllocate n, A argu) {
//      genln("336");
      R _ret=null;
      String t1 = genTemp();
      n.f0.accept(this, argu);
      String a2 = (String) n.f1.accept(this, argu);
      gen("MOVE " + t1 + " ");
      genln("HALLOCATE " + a2);
      return (R) t1;
   }

   /**
    * f0 -> Operator()
    * f1 -> Exp()
    * f2 -> Exp()
    */
   public R visit(BinOp n, A argu) {
//      genln("352");
      R _ret=null;
      String op = (String) n.f0.accept(this, argu);
      String a1 = (String) n.f1.accept(this, argu);
      String a2 = (String) n.f2.accept(this, argu);
      String t1 = genTemp();
      String t2 = genTemp();
      String tf = genTemp();
      genln("MOVE " + t1 + " " + a1);
      genln("MOVE " + t2 + " " + a2);
      gen("MOVE " + tf + " ");
      genln(op + " " + t1 + " " + t2);
      return (R) tf;
   }

   /**
    * f0 -> "LE"
    *       | "NE"
    *       | "PLUS"
    *       | "MINUS"
    *       | "TIMES"
    *       | "DIV"
    */
   public R visit(Operator n, A argu) {
      if(n.f0.which == 0)  return (R) "LE";
      else if(n.f0.which == 1)  return (R) "NE";
      else if(n.f0.which == 2)  return (R) "PLUS";
      else if(n.f0.which == 3)  return (R) "MINUS";
      else if(n.f0.which == 4)  return (R) "TIMES";
      else if(n.f0.which == 5)  return (R) "DIV";

      return (R) "DIFFERENT OPERATOR";
   }

   /**
    * f0 -> "TEMP"
    * f1 -> IntegerLiteral()
    */
   public R visit(Temp n, A argu) {
//      genln("386");
      R _ret=null;
      n.f0.accept(this, argu);
      String a2 = (String) n.f1.accept(this, argu);
      return (R) ("TEMP " + a2);
   }

   /**
    * f0 -> <INTEGER_LITERAL>
    */
   public R visit(IntegerLiteral n, A argu) {
//      genln("397");
      R _ret=null;
      String a1 = (String) n.f0.toString();
      return (R) a1;
   }

   /**
    * f0 -> <IDENTIFIER>
    */
   public R visit(Label n, A argu) {
//      genln("407");
      R _ret=null;
      String a1 = (String) n.f0.toString();
      if(printLab)   gen(" " + a1 + " ");
      //genln("405, label is " + a1);
      return (R) a1;
   }

}
