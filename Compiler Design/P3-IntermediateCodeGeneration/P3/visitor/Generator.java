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
public class Generator<R,A> implements GJVisitor<R,A> {

//   public Hashtable <String,String> cm0 = new Hashtable <String,String> ();    //class name vs parent's class name
//   public Hashtable <String, Hashtable <String, String>> cm1 = new Hashtable <String, Hashtable <String, String>> ();
//   public Hashtable <String, Hashtable <String, String>> cm1c = new Hashtable <String, Hashtable <String, String>> ();
//   public Hashtable <String, Hashtable <String, Hashtable <String, String>>> cm2 = new Hashtable <String, Hashtable<String, Hashtable<String,String>>> ();
//   public Hashtable <String, Hashtable <String, Hashtable <String, String>>> cm2c = new Hashtable <String, Hashtable<String, Hashtable<String,String>>> ();
//   public Hashtable <String, String> cmd = new Hashtable <String, String> ();    //Contains classes for which accumulation is done
   public Hashtable <String, Hashtable <String, String>> cm1c = new Hashtable <String, Hashtable <String, String>> ();
   public Hashtable <String, String> cm3 = new Hashtable <String, String>();     //Contains c~m vs methodOffset
   public Hashtable <String, Hashtable <String,String>> cm3f = new Hashtable <String ,Hashtable <String, String>> ();
   public Hashtable <String, String> cm4 = new Hashtable <String, String> ();    //Final for fields, methVars
   public Hashtable <String, String> classMap = new Hashtable <String, String> ();    //class vs parent class
   public Hashtable <String, Hashtable<String, String>> classMethMap = new Hashtable<String, Hashtable<String, String>>();    //C~OriginalMethods in it.
   public Hashtable <String,String> varMap = new Hashtable <String,String> ();   //For C~M~V, C~V
   public Hashtable <String,String> methRetMap = new Hashtable <String,String> (); //For C~M, ~Rtype
   public Hashtable <String,String> methParamMap = new Hashtable <String,String> (); //For C~M, ~P1type~P2type~P3type..
   public Hashtable <String, String> methParamCountMap = new Hashtable<String, String>();   //C~M vs no of (params + 1)
   public Hashtable <String, Hashtable <String, String>> cm5 = new Hashtable <String, Hashtable <String, String>>(); // C~M -> methOffset.

   public Hashtable <String, String> fo = new Hashtable <String, String> ();
   public Hashtable <String, String> vt = new Hashtable <String, String> ();
   public Hashtable <String, Hashtable <String, String>> mvt = new Hashtable <String, Hashtable <String, String>> ();
   boolean isFormalParam = false;
   boolean IdentIsVarDecl = false;
   boolean isMsgSnd = false;
   boolean isMsgSndPexp = false;
   boolean isAssignIdent = false;
   boolean isArrLkp = false;
   boolean isInAssignExp = false;
   boolean isInMesgSendParam = false;


   public String className = "";
   public String extendedClassName = "";
   public String methName = "";
   public String varName = "";
//   public int varOffCount = 0;
   public int tempCount;
   public int labCount = 1;
   int tabs = 0;
//   public int argTempCount = 0;


   public String retPropMethLabel(String c, String m)
   {
      while (true)
      {
         if(classMethMap.get(c).containsKey(m)) return(c + "_" + m);
         else
         {
            c = classMap.get(c);
            if(c.equals(""))  break;
         }
      }
      System.out.println("59, method not found even in parent classes.");
      return "";
   }
   public String st3(String s1, String s2, String s3)
   {
      return (s1 + "~" + s2 + "~" + s3);
   }
   public String st2(String s1, String s2)
   {
      return (s1 + "~" + s2);
   }

   int countOccurences(String s1, char c)
   {
      int count = 0;
      for(int i = 0; i < s1.length(); i++)
      {
         if(s1.charAt(i) == c)   count++;
      }
      return count;
   }

   public void build_methParamCountMap()
   {
      Set <String> cmkeys = methParamMap.keySet();

      for(String cm : cmkeys)
      {
         methParamCountMap.put(cm, Integer.toString(1 + countOccurences(methParamMap.get(cm), '~')));
      }
      return;
   }

//   boolean allDone()
//   {
//      Set <String> keys = cm0.keySet();
//      for(String k : keys)
//      {
//         if(!cmd.containsKey(k)) return false;
//      }
//      return true;
//   }
//
//   String getClass1()
//   {
//      Set <String> keys = cm0.keySet();
//      for(String k : keys)
//      {
//         if(!cmd.containsKey(k))
//         {
//            if(cm0.get(k).equals(""))  return k;
//            else
//            {
//               if(cmd.containsKey(cm0.get(k)))  return k;
//            }
//         }
////         if(cm0.get(k).equals(""))
////         {
////            if(!cmd.containsKey(k)) return k;
////         }
////         else
////         {
////            if(cmd.containsKey(cm0.get(k)))  return k;
////         }
//      }
//      return "";
//   }
//
//   public void build_cm4f()
//   {
//      Set <String> ckeys = cm1c.keySet();
//
//      for(String c : ckeys)
//      {
//         Set <String> fkeys = cm1c.get(c).keySet();
//
//         for(String f : fkeys)
//         {
//            cm4.put(st2(c, f), cm1c.get(c).get(f));
//         }
//      }
//      return;
//   }
//
//   public void build_cm4mv()
//   {
//      Set <String> ckeys = cm2c.keySet();
//
//      for(String c : ckeys)
//      {
//         Set <String> mkeys = cm2c.get(c).keySet();
//
//         for(String m : mkeys)
//         {
//            Set <String> vkeys = cm2c.get(c).get(m).keySet();
//
//            for(String v : vkeys)
//            {
//               cm4.put(st3(c,m,v), cm2c.get(c).get(m).get(v));
//            }
//         }
//      }
//      return;
//   }
//
//   public void build_cm3()
//   {
//      Set <String> ckeys = cm2c.keySet();
//
//      for(String c : ckeys)
//      {
//         int mOffset = 0;
//         Set <String> mkeys = cm2c.get(c).keySet();
//
//         for(String m : mkeys)
//         {
//            cm3.put(st2(c, m), Integer.toString(mOffset));
//            mOffset += 4;
//         }
//      }
//      return;
//   }
//
//   public void build_copy()
//   {
//      String c, p;
//
//      while (true)
//      {
//         //System.out.println("132");
//         c = getClass1();
//         if(c.equals(""))  break;
//         p = cm0.get(c);
//
//         if(p.equals(""))
//         {
//            cm1c.put(c, cm1.get(c));
//            cm2c.put(c, cm2.get(c));
//            cmd.put(c,"");
//         }
//         else
//         {
//            Hashtable <String, String> temp1 = (Hashtable<String, String>) (cm1c.get(p)).clone();
//            cm1c.put(c, temp1);
//            //cm1c.put(c, cm1c.get(p));
//            Set <String> keys1 = cm1.get(c).keySet();
//
//            for(String k1 : keys1)
//            {
//               if(!cm1c.get(c).containsKey(k1))
//               {
//                  int sz = cm1c.get(c).size();
//                  sz++;
//                  cm1c.get(c).put(k1, Integer.toString(4 * sz));
//                  //System.out.println("165, offset is " + Integer.toString(4 * sz));
//               }
//            }
//            Hashtable <String, Hashtable <String, String>> temp2 = (Hashtable<String, Hashtable<String, String>>)(cm2c.get(p)).clone();
//            cm2c.put(c, temp2);
////            cm2c.put(c, cm2c.get(p));
//            Set <String> keys2 = cm2.get(c).keySet();
//
//            for(String k2 : keys2)
//            {
//               cm2c.get(c).put(k2, cm2.get(c).get(k2));
//            }
//            cmd.put(c, "");
//         }
//      }
//      return;
//   }
//
//   String genArgTemp()
//   {
//      return ("TEMP " + Integer.toString(argTempCount++));
//   }
//
   String genTemp()
   {
      return ("TEMP " + Integer.toString(tempCount++));
   }

   String genLab()
   {
      return ("L" + Integer.toString(labCount++));
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
    * f0 -> MainClass()
    * f1 -> ( TypeDeclaration() )*
    * f2 -> <EOF>
    */
   void gen(String s)
   {
      System.out.print(s);
      return;
   }
   void genln(String s)
   {
      //if(s.equals("BEGIN") || s.equals("MAIN"))    gen("\t");
      System.out.println(s);
      //if(s.equals("BEGIN") || s.equals("MAIN")) tabs++;
//      if(s.equals("BEGIN")) tabs++;
//      if(s.equals("END"))  tabs--;
//      for(int i = 0; i < tabs; i++) gen("\t");
      return;
   }
   public R visit(Goal n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> "public"
    * f4 -> "static"
    * f5 -> "void"
    * f6 -> "main"
    * f7 -> "("
    * f8 -> "String"
    * f9 -> "["
    * f10 -> "]"
    * f11 -> Identifier()
    * f12 -> ")"
    * f13 -> "{"
    * f14 -> PrintStatement()
    * f15 -> "}"
    * f16 -> "}"
    */
   public R visit(MainClass n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      className = (String) n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);
      n.f6.accept(this, argu);
      n.f7.accept(this, argu);
      n.f8.accept(this, argu);
      n.f9.accept(this, argu);
      n.f10.accept(this, argu);
      n.f11.accept(this, argu);
      n.f12.accept(this, argu);
      n.f13.accept(this, argu);
      genln("MAIN");
      n.f14.accept(this, argu);
      genln("END");
      genln("");
      n.f15.accept(this, argu);
      n.f16.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> ClassDeclaration()
    *       | ClassExtendsDeclaration()
    */
   public R visit(TypeDeclaration n, A argu) {
      R _ret=null;
      className = "";
      methName = "";
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> ( VarDeclaration() )*
    * f4 -> ( MethodDeclaration() )*
    * f5 -> "}"
    */
   public R visit(ClassDeclaration n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      className = (String) n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      methName = "";
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "extends"
    * f3 -> Identifier()
    * f4 -> "{"
    * f5 -> ( VarDeclaration() )*
    * f6 -> ( MethodDeclaration() )*
    * f7 -> "}"
    */
   public R visit(ClassExtendsDeclaration n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      className = (String)n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      extendedClassName = (String) n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      methName = "";
      n.f5.accept(this, argu);
      n.f6.accept(this, argu);
      n.f7.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
   public R visit(VarDeclaration n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      IdentIsVarDecl = true;
      varName = (String) n.f1.accept(this, argu);
      IdentIsVarDecl = false;
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "public"
    * f1 -> Type()
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( FormalParameterList() )?
    * f5 -> ")"
    * f6 -> "{"
    * f7 -> ( VarDeclaration() )*
    * f8 -> ( Statement() )*
    * f9 -> "return"
    * f10 -> Expression()
    * f11 -> ";"
    * f12 -> "}"
    */
   public R visit(MethodDeclaration n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      methName = (String) n.f2.accept(this, argu);
      genln(className + "_" + methName + " [ " + methParamCountMap.get(st2(className,methName)) + " ]");
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);
      genln("BEGIN");
      n.f6.accept(this, argu);
      n.f7.accept(this, argu);
      n.f8.accept(this, argu);
      n.f9.accept(this, argu);
      genln("RETURN");
      n.f10.accept(this, argu);
      genln(" ");
      genln("END");
      genln("");
      n.f11.accept(this, argu);
      n.f12.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> FormalParameter()
    * f1 -> ( FormalParameterRest() )*
    */
   public R visit(FormalParameterList n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> Type()
    * f1 -> Identifier()
    */
   public R visit(FormalParameter n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      isFormalParam = true;
      varName = (String) n.f1.accept(this, argu);
      isFormalParam = false;
      return _ret;
   }

   /**
    * f0 -> ","
    * f1 -> FormalParameter()
    */
   public R visit(FormalParameterRest n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> ArrayType()
    *       | BooleanType()
    *       | IntegerType()
    *       | Identifier()
    */
   public R visit(Type n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "int"
    * f1 -> "["
    * f2 -> "]"
    */
   public R visit(ArrayType n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "boolean"
    */
   public R visit(BooleanType n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "int"
    */
   public R visit(IntegerType n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> Block()
    *       | AssignmentStatement()
    *       | ArrayAssignmentStatement()
    *       | IfStatement()
    *       | WhileStatement()
    *       | PrintStatement()
    */
   public R visit(Statement n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "{"
    * f1 -> ( Statement() )*
    * f2 -> "}"
    */
   public R visit(Block n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> Identifier()
    * f1 -> "="
    * f2 -> Expression()
    * f3 -> ";"
    */
   public R visit(AssignmentStatement n, A argu) {
//      R _ret=null;
//      String st1 = genTemp();
//      gen("MOVE ");
//      n.f0.accept(this, argu);
//      n.f1.accept(this, argu);
//      gen(" ");
//      n.f2.accept(this, argu);
//      genln(" ");
//      n.f3.accept(this, argu);
//      return _ret;
      boolean isInMeth = false;
      R _ret=null;
      isAssignIdent = true;
      String id = (String) n.f0.accept(this, argu);
      String e1;
      isAssignIdent = false;

      if(cm4.containsKey(st3(className,methName,id))) isInMeth = true;

      if(isInMeth)
      {
         id = cm4.get(st3(className,methName,id));
         gen("MOVE " + id + " ");
         n.f1.accept(this, argu);
         isInAssignExp = true;
         e1 = (String) n.f2.accept(this, argu);
         isInAssignExp = false;
         //System.out.println("619, e1 is " + e1);
         if(e1 != null) if(e1.equals("this"))   gen(" TEMP 0 ");
         n.f3.accept(this, argu);
         genln("");
      }
      else
      {
         id = cm4.get(st2(className,id));
         gen("HSTORE TEMP 0 " + id + " ");
         n.f1.accept(this, argu);
         e1 = (String) n.f2.accept(this, argu);
         //System.out.println("630, e1 is " + e1);
         if(e1 != null) if(e1.equals("this"))   gen(" TEMP 0 ");
         n.f3.accept(this, argu);
         genln("");
      }
      return _ret;
   }

   /**
    * f0 -> Identifier()
    * f1 -> "["
    * f2 -> Expression()
    * f3 -> "]"
    * f4 -> "="
    * f5 -> Expression()
    * f6 -> ";"
    */
   public R visit(ArrayAssignmentStatement n, A argu) {
//      R _ret=null;
//      gen("HSTORE ");
//      n.f0.accept(this, argu);
//      n.f1.accept(this, argu);
//      gen(" TIMES 4 ");
//      n.f2.accept(this, argu);
//      n.f3.accept(this, argu);
//      n.f4.accept(this, argu);
//      n.f5.accept(this, argu);
//      n.f6.accept(this, argu);
//      return _ret;
      boolean isInMeth = false;
      R _ret=null;
      isAssignIdent = true;
      String id = (String) n.f0.accept(this, argu);
      isAssignIdent = false;
      if(cm4.containsKey(st3(className,methName,id))) isInMeth = true;
      if(isInMeth)
      {
         id = cm4.get(st3(className,methName,id));
         gen("HSTORE PLUS " + id);
         gen(" PLUS 4 TIMES 4 ");
         n.f1.accept(this, argu);
         n.f2.accept(this, argu);
         n.f3.accept(this, argu);
         n.f4.accept(this, argu);
         gen(" 0 ");
         n.f5.accept(this, argu);
         n.f6.accept(this, argu);
      }
      else
      {
         id = cm4.get(st2(className,id));
         String s1 = genTemp();
         String s2 = genTemp();

         genln("MOVE " + s2);
         genln("BEGIN ");
         genln("HLOAD " + s1 + " TEMP 0 " + id);
         genln("RETURN ");
         genln(s1);
         genln("END ");

         gen("HSTORE PLUS " + s2);
         gen(" PLUS 4 TIMES 4 ");
         n.f1.accept(this, argu);
         n.f2.accept(this, argu);
         n.f3.accept(this, argu);
         n.f4.accept(this, argu);
         gen(" 0 ");
         n.f5.accept(this, argu);
         n.f6.accept(this, argu);
      }
      return _ret;
   }

   /**
    * f0 -> IfthenElseStatement()
    *       | IfthenStatement()
    */
   public R visit(IfStatement n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "if"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    */
   public R visit(IfthenStatement n, A argu) {
      R _ret=null;
      String l1 = genLab();
      n.f0.accept(this, argu);
      gen("CJUMP ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      genln(" " + l1);
      n.f4.accept(this, argu);
      genln(l1 + " NOOP ");
      return _ret;
   }

   /**
    * f0 -> "if"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    * f5 -> "else"
    * f6 -> Statement()
    */
   public R visit(IfthenElseStatement n, A argu) {
      R _ret=null;
      String l1 = genLab();
      String l2 = genLab();
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      gen("CJUMP ");
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      genln(" " + l1);
      n.f4.accept(this, argu);
      genln("JUMP " + l2);
      genln(l1 + " NOOP ");
      n.f5.accept(this, argu);
      n.f6.accept(this, argu);
      genln(l2 + " NOOP ");
      return _ret;
   }

   /**
    * f0 -> "while"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    */
   public R visit(WhileStatement n, A argu) {
      R _ret=null;
      String l1 = genLab();
      String l2 = genLab();
      genln(l1 + " NOOP ");
      gen("CJUMP ");
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      genln(" " + l2);
      n.f4.accept(this, argu);
      genln("JUMP " + l1);
      genln(l2 + " NOOP ");
      return _ret;
   }

   /**
    * f0 -> "System.out.println"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> ";"
    */
   public R visit(PrintStatement n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      gen("PRINT ");
      n.f2.accept(this, argu);
      genln(" ");
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> OrExpression()
    *       | AndExpression()
    *       | CompareExpression()
    *       | neqExpression()
    *       | PlusExpression()
    *       | MinusExpression()
    *       | TimesExpression()
    *       | DivExpression()
    *       | ArrayLookup()
    *       | ArrayLength()
    *       | MessageSend()
    *       | PrimaryExpression()
    */
   public R visit(Expression n, A argu) {
      R _ret=null;
      _ret = (R) n.f0.accept(this, argu);
      String s = (String) _ret;
      
      gen(" ");
      if(isInMesgSendParam)  
      { 
      	if(s != null)
      	{
      		if(s.equals("this"))	gen(" TEMP 0 ");
      	}     
      }
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "&&"
    * f2 -> PrimaryExpression()
    */
   public R visit(AndExpression n, A argu) {
      R _ret=null;
      String t1 = genTemp();
      String l1 = genLab();
      genln("");
      genln("BEGIN");
      genln("MOVE " + t1 + " 0 ");
      gen("CJUMP ");
      n.f0.accept(this, argu);
      genln(" " + l1);
      n.f1.accept(this, argu);
      gen("CJUMP ");
      n.f2.accept(this, argu);
      genln(" " + l1);
      genln("MOVE " + t1 + " 1 ");
      genln(l1 + " NOOP ");
      genln("RETURN");
      genln(t1);
      genln("END");
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "||"
    * f2 -> PrimaryExpression()
    */
   public R visit(OrExpression n, A argu) {
      R _ret=null;
      String t1 = genTemp();
      String l1 = genLab();
      genln("");
      genln("BEGIN ");
      genln("MOVE " + t1  + " 1 ");
      gen("CJUMP ");
      n.f0.accept(this, argu);
      genln(" " + l1);
      n.f1.accept(this, argu);
      gen("CJUMP ");
      n.f2.accept(this, argu);
      genln(" " + l1);
      genln("MOVE " + t1 + " 0 ");
      genln(l1 + " NOOP ");
      genln("RETURN");
      genln(t1);
      genln("END");
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "<="
    * f2 -> PrimaryExpression()
    */
   public R visit(CompareExpression n, A argu) {
      R _ret=null;
      gen("LE ");
      n.f0.accept(this, argu);
      gen(" ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      gen(" ");
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "!="
    * f2 -> PrimaryExpression()
    */
   public R visit(neqExpression n, A argu) {
      R _ret=null;
      gen("NE ");
      n.f0.accept(this, argu);
      gen(" ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      gen(" ");
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "+"
    * f2 -> PrimaryExpression()
    */
   public R visit(PlusExpression n, A argu) {
      R _ret=null;
      gen("PLUS ");
      n.f0.accept(this, argu);
      gen(" ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      gen(" ");
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "-"
    * f2 -> PrimaryExpression()
    */
   public R visit(MinusExpression n, A argu) {
      R _ret=null;
      gen("MINUS ");
      n.f0.accept(this, argu);
      gen(" ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      gen(" ");
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "*"
    * f2 -> PrimaryExpression()
    */
   public R visit(TimesExpression n, A argu) {
      R _ret=null;
      gen("TIMES ");
      n.f0.accept(this, argu);
      gen(" ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      gen(" ");
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "/"
    * f2 -> PrimaryExpression()
    */
   public R visit(DivExpression n, A argu) {
      R _ret=null;
      gen("DIV ");
      n.f0.accept(this, argu);
      gen(" ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      gen(" ");
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "["
    * f2 -> PrimaryExpression()
    * f3 -> "]"
    */
   public R visit(ArrayLookup n, A argu) {
      R _ret=null;
      String st1 = genTemp();
      genln("BEGIN ");
      gen("HLOAD " + st1 + " PLUS ");
      String r1 = (String) n.f0.accept(this, argu);
      gen(" TIMES 4 PLUS 1 ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      genln(" 0 ");
      genln("RETURN ");
      genln(st1);
      genln("END ");
      n.f3.accept(this, argu);
      return (R) r1;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> "length"
    */
   public R visit(ArrayLength n, A argu) {
      R _ret=null;
      String st1 = genTemp();
      genln("BEGIN ");
      genln("HLOAD " + st1 + " ");
      n.f0.accept(this, argu);
      genln(" 0 ");
      genln("RETURN ");
      genln(st1);
      genln("END ");
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return (R) "int";
   }
   String getObjType(String c, String v)
   {
      String p = classMap.get(c);
      while (true)
      {
         if(varMap.containsKey(st2(c,v)))    return varMap.get(st2(c,v));
         else
         {
            c = classMap.get(c);
            if(c.equals(""))  break;
         }
      }
      System.out.println("1025, object " + v + " not found even in parent classes.");
      return "";
   }
   /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( ExpressionList() )?
    * f5 -> ")"
    */
   public R visit(MessageSend n, A argu) {
      R _ret=null;
      String startField = genTemp();
      String startMeth = genTemp();
      String MethName = genTemp();
      genln("CALL ");
      genln("BEGIN ");
      genln("MOVE " + startField + " ");
      isMsgSndPexp = true;
      String c1 = (String) n.f0.accept(this, argu);
      String c1t;
      String c1f;

      if(c1.equals("this"))
      {
         c1t = className;
         genln(" TEMP 0 ");
      }
      else if(classMap.containsKey(c1))
      {
         c1t = c1;
      }
      else if(cm4.containsKey(st3(className,methName,c1)))
      {
         c1t = varMap.get(st3(className,methName,c1));
         c1f = cm4.get(st3(className,methName,c1));
         genln(c1f);
      }
      else if(cm4.containsKey(st2(className,c1)))
      {
         c1t = getObjType(className, c1);       //Now, c1t must contain class name.(which is the type of the object c1).
         c1f = cm4.get(st2(className,c1));      //Now, c1f contains offset.
         //Let's generate begin end code using offset(c1f)
         String st11 = genTemp();
         genln("BEGIN ");
         genln("HLOAD " + st11 + " TEMP 0 " + c1f);
         genln("RETURN ");
         genln(st11);
         genln("END ");
      }
      else
      {
         System.out.println("1075, obj c1 " + c1 + " is not found");
         c1t = c1;
      }

//      if(!classMap.containsKey(c1))
//      {
//         if(varMap.containsKey(st3(className, methName, c1)))  c1 = varMap.get(st3(className, methName, c1));
//         else if(varMap.containsKey(st2(className,c1)))  c1 = varMap.get(st2(className,c1));
//         else
//         {
//            System.out.println("978, hi");
//            System.out.println("965, not found, c1 is " + c1);
//            System.out.println("980, ClassName is " + className);
//            System.out.println(varMap);
//         }
//      }

      isMsgSndPexp = false;

      n.f1.accept(this, argu);
      isMsgSnd = true;
      String m1 = (String) n.f2.accept(this, argu);
      isMsgSnd = false;
      genln("HLOAD " + startMeth + " " + startField + " 0 ");
      genln("HLOAD " + MethName + " " + startMeth + " " + cm3.get(st2(c1t,m1)));
      genln("RETURN ");
      genln(MethName);
      genln("END ");
      n.f3.accept(this, argu);
      gen("( " + startField + " ");
      isInMesgSendParam = true;
      n.f4.accept(this, argu);
      isInMesgSendParam = false;
      n.f5.accept(this, argu);
      genln(" )");
      String r1 = methRetMap.get(st2(c1t, m1));
      return (R) r1;
   }
//   public R visit(MessageSend n, A argu) {
////      genln("952");
//      R _ret=null;
//      String startField = genTemp();
//      String startMeth = genTemp();
//      String MethName = genTemp();
//      genln("CALL ");
//      genln("BEGIN ");
//      genln("MOVE " + startField + " ");
//      isMsgSndPexp = true;
//      String c1 = (String) n.f0.accept(this, argu);
////      genln("962");
////      genln("963");
////      genln("964");
////      System.out.println("965 c1 is " + c1);
//      if(c1.equals("this"))
//      {
//         c1 = className;
//         genln(" TEMP 0 ");
//      }
//      if(!classMap.containsKey(c1))
//      {
////         genln("966");
//         if(varMap.containsKey(st3(className, methName, c1)))  c1 = varMap.get(st3(className, methName, c1));
//         else if(varMap.containsKey(st2(className,c1)))  c1 = varMap.get(st2(className,c1));
//         else
//         {
//            System.out.println("978, hi");
//            System.out.println("965, not found, c1 is " + c1);
//            System.out.println("980, ClassName is " + className);
//            System.out.println(varMap);
//         }
//
////         c1 = varMap.get(st3(className, methName, c1));
////         genln("968");
////         if(c1.equals(null))  c1 = varMap.get(st2(className,c1));
////         genln("970");
////         if(c1.equals(null))  System.out.println("965, not found, c1 is " + c1);
////         genln("972");
//      }
////      genln("974");
//      isMsgSndPexp = false;
//
////      genln("985");
//      n.f1.accept(this, argu);
//      isMsgSnd = true;
//      String m1 = (String) n.f2.accept(this, argu);
////      System.out.println("970, class and method names are " + c1 + ", " + m1);
//      isMsgSnd = false;
//      genln("HLOAD " + startMeth + " " + startField + " 0 ");
//      genln("HLOAD " + MethName + " " + startMeth + " " + cm3.get(st2(c1,m1)));
//      genln("RETURN ");
//      genln(MethName);
//      genln("END ");
//      n.f3.accept(this, argu);
//      gen("( " + startField + " ");
//      n.f4.accept(this, argu);
//      n.f5.accept(this, argu);
//      genln(" )");
//      String r1 = methRetMap.get(st2(c1, m1));
////      System.out.println("1004, r1 is " + r1);
//      return (R) r1;
//   }

   /**
    * f0 -> Expression()
    * f1 -> ( ExpressionRest() )*
    */
   public R visit(ExpressionList n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> ","
    * f1 -> Expression()
    */
   public R visit(ExpressionRest n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> IntegerLiteral()
    *       | TrueLiteral()
    *       | FalseLiteral()
    *       | Identifier()
    *       | ThisExpression()
    *       | ArrayAllocationExpression()
    *       | AllocationExpression()
    *       | NotExpression()
    *       | BracketExpression()
    */
   public R visit(PrimaryExpression n, A argu) {
      R _ret=null;
      _ret = (R) n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> <INTEGER_LITERAL>
    */
   public R visit(IntegerLiteral n, A argu) {
      R _ret=null;
      gen((String) n.f0.tokenImage);
      return _ret;
   }

   /**
    * f0 -> "true"
    */
   public R visit(TrueLiteral n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      gen(" 1 ");
      return _ret;
   }

   /**
    * f0 -> "false"
    */
   public R visit(FalseLiteral n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      gen(" 0 ");
      return _ret;
   }

   /**
    * f0 -> <IDENTIFIER>
    */
   public R visit(Identifier n, A argu) {
      String s = (String) n.f0.tokenImage;
      if(isArrLkp) return (R) s;
      if(isAssignIdent) return (R) s;
      if(isMsgSndPexp)   return (R) s;
      if(isMsgSnd)   return (R) s;
      if(isFormalParam) return (R) s;
      if(IdentIsVarDecl) return (R) s;
      if(cm4.containsKey(st3(className,methName,s)))
      {
         gen(cm4.get(st3(className,methName,s)));
         s = varMap.get(st3(className,methName,s));
         //System.out.println("970, s is " + s);
      }
      else if(cm4.containsKey(st2(className,s)))
      {
         String t1 = genTemp();
         genln("");
         genln("BEGIN ");
         genln("HLOAD " + t1 + " TEMP 0 " + cm4.get(st2(className,s)));
         genln("RETURN");
         genln(t1);
         genln("END");
         s = varMap.get(st2(className, s));
         //System.out.println("982, s is " + s);
      }
      else
      {
         // s is a class name or a method name.
      }
      //System.out.println("988, s is " + s);
      R _ret = (R) s;
      return _ret;
   }

   /**
    * f0 -> "this"
    */
   public R visit(ThisExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      _ret = (R) "this";
      return _ret;
   }

   /**
    * f0 -> "new"
    * f1 -> "int"
    * f2 -> "["
    * f3 -> Expression()
    * f4 -> "]"
    */
   public R visit(ArrayAllocationExpression n, A argu) {
      R _ret=null;
      String arrSize = genTemp();
      String start = genTemp();
      String count = genTemp();
      String l1 = genLab();
      String l2 = genLab();

      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      genln("BEGIN ");

      gen("MOVE " + start + " ");
      gen("HALLOCATE PLUS 4 TIMES 4 ");
      genln("BEGIN ");
      genln("MOVE " + arrSize + " ");
      n.f3.accept(this, argu);
      genln("");
      genln("RETURN ");
      genln(arrSize);
      genln("END ");
      n.f4.accept(this, argu);

      genln("MOVE " + count + " 0 ");
      genln("MOVE " + arrSize + " TIMES 4 PLUS 1 " + arrSize);

      genln(l1 + " NOOP ");
      genln("CJUMP LE " + count + " MINUS " + arrSize + " 1 " + l2);
      genln("HSTORE PLUS " + start + " " + count + " 0 0 ");
      genln("MOVE " + count + " PLUS 4 " + count);
      genln("JUMP " + l1);
      genln(l2 + " NOOP ");

      genln("RETURN ");
      genln(start);
      genln("END ");

      return (R) "int[]";
   }
//   public R visit(ArrayAllocationExpression n, A argu) {
//      R _ret=null;
//      String arrSize = genTemp();
//      n.f0.accept(this, argu);
//      n.f1.accept(this, argu);
//      n.f2.accept(this, argu);
//      gen("HALLOCATE PLUS 4 TIMES 4 ");
//      genln("BEGIN ");
//      genln("MOVE " + arrSize + " ");
//      arrSize = (String) n.f3.accept(this, argu);
//      genln("");
//      genln("RETURN ");
//      genln(arrSize);
//      genln("END ");
//      n.f4.accept(this, argu);
//      String count = genTemp();
//
//
//
//      return (R) "int[]";
//   }
   int getNumFields(String c)
   {
      return cm1c.get(c).size();
   }

   int getNumMethods(String c)
   {
      return cm3f.get(c).size();
   }
   void CreateObject(String c)
   {
      String startField = genTemp();
      String startMeth = genTemp();

      genln("BEGIN");
      genln("MOVE " + startField + " HALLOCATE " + Integer.toString(4 * (1 + getNumFields(c))));
      genln("MOVE " + startMeth + " HALLOCATE " + Integer.toString(4 * (getNumMethods(c))));

      genln("");
      Set <String> mkeys = cm3f.get(c).keySet();

      for(String m : mkeys)
      {
         genln("HSTORE " + startMeth + " " + cm3.get(st2(c,m)) + " " + retPropMethLabel(c,m));
      }
      genln("");

      Set <String> fkeys = cm1c.get(c).keySet();

      for(String f : fkeys)
      {
         genln("HSTORE " + startField + " " + cm4.get(st2(c,f)) + " 0 ");
      }
      genln("");

      genln("HSTORE " + startField + " 0 " + startMeth);
      genln("RETURN ");
      genln(startField);
      genln("END ");
   }
   /**
    * f0 -> "new"
    * f1 -> Identifier()
    * f2 -> "("
    * f3 -> ")"
    */
   public R visit(AllocationExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      _ret = (R) n.f1.accept(this, argu);
      CreateObject((String) _ret);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "!"
    * f1 -> Expression()
    */
   public R visit(NotExpression n, A argu) {
      R _ret=null;
      gen(" MINUS 1 ");
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "("
    * f1 -> Expression()
    * f2 -> ")"
    */
   public R visit(BracketExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      _ret = (R) n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> Identifier()
    * f1 -> ( IdentifierRest() )*
    */
   public R visit(IdentifierList n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> ","
    * f1 -> Identifier()
    */
   public R visit(IdentifierRest n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      return _ret;
   }

}
