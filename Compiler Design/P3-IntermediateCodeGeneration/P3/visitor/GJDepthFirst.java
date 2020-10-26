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

   public Hashtable <String, Hashtable<String, String>> classMethMap = new Hashtable<String, Hashtable<String, String>> ();    //C~OriginalMethods in it.
   public Hashtable <String,String> cm0 = new Hashtable <String,String> ();    //class name vs parent's class name
   public Hashtable <String, Hashtable <String, String>> cm1 = new Hashtable <String, Hashtable <String, String>> ();
   public Hashtable <String, Hashtable <String, String>> cm1c = new Hashtable <String, Hashtable <String, String>> ();
   public Hashtable <String, Hashtable <String, Hashtable <String, String>>> cm2 = new Hashtable <String, Hashtable<String, Hashtable<String,String>>> ();
   public Hashtable <String, Hashtable <String, Hashtable <String, String>>> cm2c = new Hashtable <String, Hashtable<String, Hashtable<String,String>>> ();
   public Hashtable <String, String> cm3 = new Hashtable <String, String>();     //
   public Hashtable <String, Hashtable <String,String>> cm3f = new Hashtable <String ,Hashtable <String, String>> ();
   public Hashtable <String, String> cmd = new Hashtable <String, String> ();    //Contains classes for which accumulation is done
   public Hashtable <String, String> cm4 = new Hashtable <String, String> ();    //Final for fields, methVars
   public Hashtable <String, Hashtable <String, String>> cm5 = new Hashtable <String, Hashtable <String, String>>(); // C~M -> methOffset.

   public Hashtable <String, String> fo = new Hashtable <String, String> ();
   public Hashtable <String, String> vt = new Hashtable <String, String> ();
   public Hashtable <String, Hashtable <String, String>> mvt = new Hashtable <String, Hashtable <String, String>> ();

   public Hashtable <String,String> methEmp = new Hashtable <String, String> ();

   public String className = "";
   public String extendedClassName = "";
   public String methName = "";
   public String varName = "";
   public int varOffCount = 0;
   public int tempCount = 20;
   public int argTempCount = 0;


   public String st3(String s1, String s2, String s3)
   {
      return (s1 + "~" + s2 + "~" + s3);
   }
   public String st2(String s1, String s2)
   {
      return (s1 + "~" + s2);
   }

   boolean allDone()
   {
      Set <String> keys = cm0.keySet();
      for(String k : keys)
      {
         if(!cmd.containsKey(k)) return false;
      }
      return true;
   }

   String getClass1()
   {
      Set <String> keys = cm0.keySet();
      for(String k : keys)
      {
         if(!cmd.containsKey(k))
         {
            if(cm0.get(k).equals(""))  return k;
            else
            {
               if(cmd.containsKey(cm0.get(k)))  return k;
            }
         }
//         if(cm0.get(k).equals(""))
//         {
//            if(!cmd.containsKey(k)) return k;
//         }
//         else
//         {
//            if(cmd.containsKey(cm0.get(k)))  return k;
//         }
      }
      return "";
   }

   public void build_cm4f()
   {
      Set <String> ckeys = cm1c.keySet();

      for(String c : ckeys)
      {
         Set <String> fkeys = cm1c.get(c).keySet();

         for(String f : fkeys)
         {
            cm4.put(st2(c, f), cm1c.get(c).get(f));
         }
      }
      return;
   }

   public void build_cm4mv()
   {
      Set <String> ckeys = cm2c.keySet();

      for(String c : ckeys)
      {
         Set <String> mkeys = cm2c.get(c).keySet();

         for(String m : mkeys)
         {
            Set <String> vkeys = cm2c.get(c).get(m).keySet();

            for(String v : vkeys)
            {
               cm4.put(st3(c,m,v), cm2c.get(c).get(m).get(v));
            }
         }
      }

      return;
   }

   public void build_cm3()
   {
      Set <String> ckeys = cm2c.keySet();

      for(String c : ckeys)
      {
         int mOffset = 0;
         Set <String> mkeys = cm2c.get(c).keySet();
         Hashtable <String, String> mo1 = new Hashtable <String, String> ();

         for(String m : mkeys)
         {
            cm3.put(st2(c, m), Integer.toString(mOffset));
            mo1.put(m, Integer.toString(mOffset));
            mOffset += 4;
         }
         cm3f.put(c, mo1);
      }
      return;
   }

   public void build_cm5()
   {
      Set <String> ckeys = cm2c.keySet();

      for(String c : ckeys)
      {
         Hashtable <String, String> mmo = new Hashtable <String, String>();
         Set <String> mkeys = cm2c.get(c).keySet();

         for(String m : mkeys)
         {
            //cm5.get(c).put(m, cm3.get(st2(c,m)));
            mmo.put(m, cm3.get(st2(c,m)));
         }
         cm5.put(c, mmo);
      }
      return;
   }

   public void build_copy()
   {
      String c, p;

      while (true)
      {
         //System.out.println("132");
         c = getClass1();
         if(c.equals(""))  break;
         p = cm0.get(c);

         if(p.equals(""))
         {
            cm1c.put(c, cm1.get(c));
            cm2c.put(c, cm2.get(c));
            cmd.put(c,"");
         }
         else
         {
            Hashtable <String, String> temp1 = (Hashtable<String, String>) (cm1c.get(p)).clone();
            cm1c.put(c, temp1);
            //cm1c.put(c, cm1c.get(p));
            Set <String> keys1 = cm1.get(c).keySet();

            for(String k1 : keys1)
            {
               if(!cm1c.get(c).containsKey(k1))
               {
                  int sz = cm1c.get(c).size();
                  sz++;
                  cm1c.get(c).put(k1, Integer.toString(4 * sz));
                  //System.out.println("165, offset is " + Integer.toString(4 * sz));
               }
            }
            Hashtable <String, Hashtable <String, String>> temp2 = (Hashtable<String, Hashtable<String, String>>)(cm2c.get(p)).clone();
            cm2c.put(c, temp2);
//            cm2c.put(c, cm2c.get(p));
            Set <String> keys2 = cm2.get(c).keySet();

            for(String k2 : keys2)
            {
               cm2c.get(c).put(k2, cm2.get(c).get(k2));
            }
            cmd.put(c, "");
         }
      }
      return;
   }

   String genArgTemp()
   {
      return ("TEMP " + Integer.toString(argTempCount++));
   }

   String genTemp()
   {
      return ("TEMP " + Integer.toString(tempCount++));
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
   public R visit(Goal n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      //build_cm3();
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
      n.f14.accept(this, argu);
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
      methEmp = new Hashtable<String, String>();
      fo = new Hashtable<String, String>();
      mvt = new Hashtable <String, Hashtable <String, String>> ();
      n.f0.accept(this, argu);
      className = (String) n.f1.accept(this, argu);
      cm0.put(className, "");
      n.f2.accept(this, argu);
      methName = "";
      varOffCount = 4;
      n.f3.accept(this, argu);
      //System.out.println("247, fo is " + className);
      //System.out.println(fo);
      cm1.put(className, fo);
      //System.out.println("220, printing inserted entry " + className);
      //System.out.println(cm1.get(className));
      n.f4.accept(this, argu);
      classMethMap.put(className, methEmp);
//      System.out.println("223, Printing mvt ");
//      System.out.println(mvt);
      cm2.put(className, mvt);
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
      methEmp = new Hashtable<String, String>();
      fo = new Hashtable<String, String>();
      mvt = new Hashtable <String, Hashtable <String, String>> ();
      n.f0.accept(this, argu);
      className = (String)n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      extendedClassName = (String) n.f3.accept(this, argu);
      cm0.put(className, extendedClassName);
      n.f4.accept(this, argu);
      methName = "";
      varOffCount = 4;
      n.f5.accept(this, argu);
      //System.out.println("247, fo is " + className);
      //System.out.println(fo);
      cm1.put(className, fo);
      n.f6.accept(this, argu);
      classMethMap.put(className, methEmp);
      cm2.put(className, mvt);
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
      varName = (String) n.f1.accept(this, argu);
      if(methName.equals(""))
      {
         //Then this is a field variable
         fo.put(varName, Integer.toString(varOffCount));
         varOffCount += 4;
      }
      else
      {
         //Then this is a method variable.
         vt.put(varName, genTemp());
      }
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
      vt = new Hashtable <String, String> ();
//      System.out.println("304, After clearing, vt is ");
//      System.out.println(vt);
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      methName = (String) n.f2.accept(this, argu);
      methEmp.put(methName, "");
      n.f3.accept(this, argu);
      argTempCount = 1;
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);
      n.f6.accept(this, argu);
      n.f7.accept(this, argu);
      //System.out.println("Now, vt is ");
      mvt.put(methName, vt);
      n.f8.accept(this, argu);
      n.f9.accept(this, argu);
      n.f10.accept(this, argu);
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
      varName = (String) n.f1.accept(this, argu);
      vt.put(varName, genArgTemp());
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
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
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
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);
      n.f6.accept(this, argu);
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
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
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
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);
      n.f6.accept(this, argu);
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
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
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
      n.f2.accept(this, argu);
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
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "&&"
    * f2 -> PrimaryExpression()
    */
   public R visit(AndExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "||"
    * f2 -> PrimaryExpression()
    */
   public R visit(OrExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "<="
    * f2 -> PrimaryExpression()
    */
   public R visit(CompareExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "!="
    * f2 -> PrimaryExpression()
    */
   public R visit(neqExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "+"
    * f2 -> PrimaryExpression()
    */
   public R visit(PlusExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "-"
    * f2 -> PrimaryExpression()
    */
   public R visit(MinusExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "*"
    * f2 -> PrimaryExpression()
    */
   public R visit(TimesExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "/"
    * f2 -> PrimaryExpression()
    */
   public R visit(DivExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
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
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> "length"
    */
   public R visit(ArrayLength n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      return _ret;
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
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);
      return _ret;
   }

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
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> <INTEGER_LITERAL>
    */
   public R visit(IntegerLiteral n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "true"
    */
   public R visit(TrueLiteral n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> "false"
    */
   public R visit(FalseLiteral n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> <IDENTIFIER>
    */
   public R visit(Identifier n, A argu) {
      R _ret = (R) n.f0.tokenImage;
      return _ret;
   }

   /**
    * f0 -> "this"
    */
   public R visit(ThisExpression n, A argu) {
      R _ret=null;
      n.f0.accept(this, argu);
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
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      return _ret;
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
      n.f1.accept(this, argu);
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
      n.f1.accept(this, argu);
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