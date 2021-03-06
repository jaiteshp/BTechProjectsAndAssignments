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
public class TypeChecker<R,A> implements GJVisitor<R,A> {
	public Hashtable <String,String> classMap= new Hashtable <String,String> ();		//For className, parentClassName
	public Hashtable <String,String> varMap = new Hashtable <String,String> ();		//For C~M~V, C~V
	public Hashtable <String,String> methParamMap = new Hashtable <String,String> (); //For C~M, ~P1type~P2type~P3type..
	public Hashtable <String,String> methRetMap = new Hashtable <String,String> (); //For C~M, ~Rtype

	String className = "";
	String extendedClassName = "";
	String methName = "";
	String type = "";
	String retType = "";
	String varName = "";
	String returnType = "";
	String emptyString = "";
	int argNum = 0;
	String temp1 = "";
	String expList = "";
	String expRestList = "";

	//
	// Auto class visitors--probably don't need to be overridden.
	//
	boolean isTerminalType(String s1)
	{
		if(s1.equals("int") || s1.equals("boolean") || s1.equals("int[]"))	return true;
		else return false;
	}

	boolean compareTypes1(String l, String r)
	{
		//System.out.println("Typ 39, comparing |" + l + "|" + r + "|");
		if(l == null)	throwError("Type error");//throwError("Typ 42, left is null");
		if(r == null)	throwError("Type error");//throwError("Typ 43, right is null");
		if(l.equals(r))
		{
			//System.out.println("Typ 45, accepting");
			return true;
		}
		if(isTerminalType(l))
		{
			if(l.equals(r))	return true;
			else return false;
		}
//		if (l == "int" && r == "int") return true;
//		else if (l == "boolean" && r == "boolean") return true;
//		else if (l == "int[]" && r == "int[]") {return true;}

		if(l.equals(""))	throwError("Type error");//throwError("Typ 49, l is empty");
		if(r.equals(""))	throwError("Type error");//throwError("Typ 50, r is empty");

		if(classMap.containsKey(r))
		{
			if(!classMap.get(r).equals(""))
			{
				return compareTypes1(l, classMap.get(r));
			}
			else
			{
				throwError("Type error");//throwError("Typ 58, r has no parent and !=");
				return false;
			}
		}
		else
		{
			throwError("Symbol not found");//throwError("Typ 58, r has no entry in classMap and !=");
			return false;
		}

	}
	boolean compareTypes(String child, String parent)
	{
		//System.out.println("Typ 40 hello");
		//System.out.println("Typ 41, comparing |" + parent + "|" + child + "|");
		if (parent == "" && child != "") {return false;}
		if (child == "" && parent != "") {return false;}
		if (child == "" && parent == "") {return true;}

		if (parent == "int" && child == "int") return true;
		else if (parent == "boolean" && child == "boolean") return true;
		else if (parent == "int[]" && child == "int[]") {return true;}

		if (parent.equals(child))
		{

			//System.out.println("Typ 45, accepting");
			return true;
		}
		else
		{
			//System.out.println("Typ 52, parent is |" + parent+ "|" + child + "|" );
		}
		if(!classMap.get(parent).equals(""))
		{
			parent = classMap.get(parent);
			return compareTypes(parent,child);
		}
		else
		{
			if(parent.equals(child))
			{
				//System.out.println("Typ 76 accepting");
				return true;
			}
			else return false;
		}
		//if(parent == child)	return true;
		//System.out.println("Typ 74, |" + parent + "|" + child + "|");
		//throwError("Typ 55 used new return");
		//return false;
	}

	boolean checkProperMethod(String className1, String methName1)
	{
		String parentClassName = classMap.get(className1);
		int pass = 0;
		while(parentClassName != "")
		{
			pass++;
			if(pass > 400)	throwError("Type error");
			if(methParamMap.get(st2(parentClassName,methName1)) == null)
			{
				parentClassName = classMap.get(parentClassName);
				continue;
			}

			if(!(methParamMap.get(st2(parentClassName,methName1)).equals(methParamMap.get(st2(className1,methName1)))))
			{
				throwError("Type error");//throwError("Typ 63 overloading is done");
			}
			else
			{	//now check for return types
				//System.out.println("Typ 145, |" + methRetMap.get(parentClassName)+"|"+methRetMap.get(className1)+"|");
				if(compareTypes1(methRetMap.get(st2(parentClassName, methName1)),methRetMap.get(st2(className1,methName1))))
				{
					//overriding is done properly
					return true;
				}
				else
				{
					throwError("Type error");//throwError("Typ 80 overriding is not done properly");
				}
			}
		}
		if(parentClassName == "")	return true;

		//throwError("Type error");//throwError("Typ 90 Used new return");
		return false;
	}

	public String st3(String s1, String s2, String s3)
	{
		return (s1 + "~" + s2 + "~" + s3);
	}
	public String st2(String s1, String s2)
	{
		return (s1 + "~" + s2);
	}

	void throwError(String tempErr)
	{
		System.out.println(tempErr);
		System.exit(0);
	}
	public String searchVar1(String className1, String methName1, String v)
	{
		//System.out.println("Type 110 " + className1 + "|" +  methName1 + "|" + v);
		int count = 1;
		int pass = 0;
		while(className1 != "")
		{
			pass++;
			if(pass > 400)	throwError("Type error");
			if(methName1 == "")
			{
				if(varMap.get(className1 + "~" + v) != null) return varMap.get(className1 + "~" + v);
			}
			else
			{
				if(count == 1)
				{
					if(varMap.get(className1 + "~" + methName1 + "~" + v) != null) return varMap.get(className1 + "~" + methName1 + "~" + v);
					else if(varMap.get(className1 + "~" + v) != null) return varMap.get(className1 + "~" + v);
				}
				else
				{
					if(varMap.get(className1 + "~" + v) != null) return varMap.get(className1 + "~" + v);
				}
			}
			count++;
			className1 = classMap.get(className1);
		}

		if(className1 == "")
		{
			throwError("Symbol not found");//throwError("Variable " + v + " in " + className1 + " not found");
			return emptyString;
		}
		return "avasaramLedu";
	}

	String searchVarInAncestors(String className1, String varName1)
	{
		//return "";
		//className1 = classMap.get(className1);
		className1 = classMap.get(className1);
		//System.out.println("typ 36 " + className1);
		int pass =0 ;
		while(className1 != "")
		{
			pass++;
			if(pass > 400)	throwError("Type error");

			//System.out.println("typ 76 ");
			if(varMap.get(className1 + "~" + varName1) != null)
			{
				//System.out.println("typ 77 " + className1 + "~" + varName1);
				return varMap.get(className1 + "~" + varName1);
			}
			else
			{
				if(className1 == null)
				{
					throwError("Symbol not found");//throwError("typ 77 most probably, one of the extended class is not yet declared");
				}
				className1 = classMap.get(className1);
			}
		}
		return "";
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
		n.f1.accept(this, argu);
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
		if(classMap.get(extendedClassName) == null)
		{
			throwError("Symbol not found");//throwError("Extended parent class not declared ("+ extendedClassName + ")");
		}
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
		type = (String) n.f0.accept(this, argu);
		varName = (String) n.f1.accept(this, argu);
		n.f2.accept(this, argu);

		if((type == "int")||(type == "boolean")||(type == "int[]"))	{/*System.out.println("typ 258");*/}//It's OK, Do nothing
		else
		{
			if(classMap.get(type) == null)
			{
				throwError("Symbol not found");//throwError("In 241, type doesnt match any existing classes");
			}
		}
//		System.out.println("typ 269 " + className + "~" + varName);
//		System.out.println(classMap);
		if(searchVarInAncestors(className, varName) != "")
		{
			throwError("Type error");//throwError("Redeclaration of " + varName + " in " + className + " as it is also present in ancestors");
		}
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
		retType = (String) n.f1.accept(this, argu);
		//methMap.put(className + "~" + methName + "~" + Integer.toString(0), retType);
		//System.out.println("methMap " + className + "~" + methName + "~" + varName + "~~" + retType);
		methName = (String) n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		argNum = 0;
		n.f4.accept(this, argu);
		argNum = 0;
		n.f5.accept(this, argu);
		n.f6.accept(this, argu);
		n.f7.accept(this, argu);
		n.f8.accept(this, argu);
		n.f9.accept(this, argu);
		String returningType = (String) n.f10.accept(this, argu);
		//System.out.println("Typ 464, returningType is |" + returningType + "|" + className);
		n.f11.accept(this, argu);
		n.f12.accept(this, argu);
		checkProperMethod(className,methName);
		if(compareTypes1(retType, returningType))   {}//Ok, no problem
		else throwError("Type error");//throwError("Typ 469 Type error exp type is |" + returningType + "|");
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
		argNum++;
		type = (String) n.f0.accept(this, argu);
		if((type == "int")||(type == "boolean")||(type == "int[]"))	{/*System.out.println("typ 258");*/}//It's OK, Do nothing
		else
		{
			if(classMap.get(type) == null)
			{
				throwError("Symbol not found");//throwError("In 352, type doesnt match any existing classes");
			}
		}
		varName = (String) n.f1.accept(this, argu);

		//methMap.put(className + "~" + methName + "~" + Integer.toString(argNum), type);
		varMap.put(className + "~" + methName + "~" + varName, type);
		//System.out.println("methMap " + className + "~" + methName + "~" + Integer.toString(argNum) + "~~" + type);

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
		argNum = 0;
		return _ret;
	}

	/**
	 * f0 -> ArrayType()
	 *       | BooleanType()
	 *       | IntegerType()
	 *       | Identifier()
	 */
	public R visit(Type n, A argu) {
		R _ret= (R) n.f0.accept(this, argu);
		//System.out.println((String) _ret);
		return _ret;
	}

	/**
	 * f0 -> "int"
	 * f1 -> "["
	 * f2 -> "]"
	 */
	public R visit(ArrayType n, A argu) {
		R _ret = (R) "int[]";
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "boolean"
	 */
	public R visit(BooleanType n, A argu) {
		R _ret= (R) "boolean";
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "int"
	 */
	public R visit(IntegerType n, A argu) {
		R _ret= (R) "int";
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
	public R visit(AssignmentStatement n, A argu)
	{
		String s1;
		String s2;
		R _ret = null;

		s1 = (String) n.f0.accept(this, argu);
		s1 = searchVar1(className, methName, s1);
		s2 = (String) n.f2.accept(this, argu);
		//System.out.println("Typ 606 is |" + s2 + "| ");

		if(s1.equals("int") || s1.equals("boolean") || s1.equals("int[]"))
		{
			if(s1.equals(s2))	{}	//Ok, match
			else	throwError("Type error");//throwError("Typ 544, left is intboolint[], right is different one");
		}
		else
		{
			if(s2.equals("int") || s2.equals("boolean") || s2.equals("int[]"))	throwError("Typ 548, left is class righ is non class");
			else
			{
				if(compareTypes1(s1,s2))	{}	//Ok, matched inheritance wise
				else throwError("Type error");//throwError("Typ 552, inheritance mismatch " + s1 + "|" + s2);
			}
		}
		return _ret;
	}
//	public R visit(AssignmentStatement n, A argu) {
//		R _ret=null;
//		String vAssStr1 = "";
//		String vAssStr2 = "";
//		vAssStr1 = (String) n.f0.accept(this, argu);
//		vAssStr1 = searchVar1(className, methName, vAssStr1);
//		n.f1.accept(this, argu);
//		vAssStr2 = (String) n.f2.accept(this, argu);
//
//		if(vAssStr1 == vAssStr2)
//		{
//			//No problem
//		}
//		else
//		{
//			if(classMap.get(vAssStr1) != null)
//			{
//				if(classMap.get(vAssStr2) == null)		throwError("Typ 545 vAssStr1 is class and vAssStr2 is not class");
//				else
//				{
//					if(compareTypes(vAssStr1, vAssStr2))
//					{
//						//Ok, no problem, types "matched"
//					}
//					else	throwError("Typ 554 types didnot match inheritance wise");
//				}
//			}
//			else
//			{
//				if(classMap.get(vAssStr2) == null)
//				{
//					throwError("Typ 559, both are not classes and didn't match");
//				}
//				else
//				{
//					throwError("Typ 563, vAssStr1 is not class and vAssStr2 is class");
//				}
//			}
//		}
//		n.f3.accept(this, argu);
//		return _ret;
//	}

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
		String ArrAssStr1,ArrAssStr2,ArrAssStr3;
		ArrAssStr1 = (String) n.f0.accept(this, argu);
		ArrAssStr1 = searchVar1(className, methName, ArrAssStr1);
		n.f1.accept(this, argu);
		ArrAssStr2 = (String) n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		ArrAssStr3 = (String) n.f5.accept(this, argu);
		if(ArrAssStr1 != "int[]")	throwError("Type error");//throwError("Typ 490 int[] expected but " + ArrAssStr1);
		if(ArrAssStr2 != "int")	throwError("Type error");//throwError("Typ 491 int expected but " + ArrAssStr2);
		if(ArrAssStr3 != "int")	throwError("Type error");//throwError("Typ 492 int expected but " + ArrAssStr3);
		n.f6.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> IfthenElseStatement()
	 *       | IfthenStatement()
	 */
	public R visit(IfStatement n, A argu){
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
		String type1;
		R _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type1 = (String) n.f2.accept(this, argu);
		if(type1 != "boolean")	throwError("Type error");//throwError("Typ 512 exp not boolean in if statement but " + type1);
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
		String type1;
		R _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type1 = (String) n.f2.accept(this, argu);
		if(type1 != "boolean")	throwError("Type error");//throwError("Typ 512 exp not boolean in if else statement but " + type1);
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
		String type1;
		R _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type1 = (String) n.f2.accept(this, argu);
		if(type1 != "boolean")	throwError("Type error");//throwError("Typ 552 exp not boolean in while statement but " + type1);
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
		String type1;
		R _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type1 = (String) n.f2.accept(this, argu);
		if(type1 != "int")	throwError("Type error");//throwError("Typ 570 exp not int in System.out.println statement but " + type1);
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
		String type1;
		type1 = (String) n.f0.accept(this, argu);
		//System.out.println("Typ 802, type1 is |" + type1 + "|");
		//System.out.println("Typ 800, here className is " + className);
		R _ret = (R) type1;
		//System.out.println("Typ 803, ret is |" + (String) _ret + "|");
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "&&"
	 * f2 -> PrimaryExpression()
	 */
	public R visit(AndExpression n, A argu) {
		String type1;
		String type2;
		type1 = (String) n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);
		if(type1 != "boolean" || type2 != "boolean")
		{
			throwError("Type error");//throwError("Typ 599 type(s) not boolean but " + type1);
		}
		R _ret = (R) "boolean";
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "||"
	 * f2 -> PrimaryExpression()
	 */
	public R visit(OrExpression n, A argu) {
		String type1;
		String type2;
		type1 = (String) n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);
		if(type1 != "boolean" || type2 != "boolean")
		{
			throwError("Type error");//throwError("Typ 616 type(s) not boolean");
		}
		R _ret = (R) "boolean";
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "<="
	 * f2 -> PrimaryExpression()
	 */
	public R visit(CompareExpression n, A argu) {
		String type1;
		String type2;
		type1 = (String) n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);

		if(type1.equals("int"))
		{
			if(!type2.equals("int")) throwError("Type error");//throwError("Typ 853 Type error");
			else {}//Ok, no problem
		}
		else
		{
			if(!(classMap.containsKey(type1) && classMap.containsKey(type2)))	throwError("Symbol not found");
			else	compareTypes1(type1,type2);
		}

//		if(type1 != "int" || type2 != "int")
//		{
//			throwError("Typ 634 type(s) not int");
//		}
		R _ret = (R) "boolean";
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "!="
	 * f2 -> PrimaryExpression()
	 */
	public R visit(neqExpression n, A argu) {
		String type1;
		String type2;
		type1 = (String) n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);
		if(isTerminalType(type1))
		{
			if(!isTerminalType(type2))	throwError("Type error");//throwError("Typ 871 Type error");
			else
			{
				if(type1.equals(type2))	{}//Ok, no problem
				else throwError("Type error");//throwError("Typ 875, Type error");
			}
		}
		else
		{
			if(!(classMap.containsKey(type1) && classMap.containsKey(type2)))	throwError("Symbol not found");
			else compareTypes1(type1,type2);
		}
//		if(type1 != "int" || type2 != "int")
//		{
//			throwError("Typ 652 type(s) not int");
//		}
		R _ret = (R) "boolean";
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "+"
	 * f2 -> PrimaryExpression()
	 */
	public R visit(PlusExpression n, A argu) {
		String type1;
		String type2;
		type1 = (String) n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);
		if(type1 != "int" || type2 != "int")
		{
			throwError("Type error");//throwError("Typ 670 type(s) not int");
		}
		R _ret = (R) "int";
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "-"
	 * f2 -> PrimaryExpression()
	 */
	public R visit(MinusExpression n, A argu) {
		String type1;
		String type2;
		type1 = (String) n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);
		if(type1 != "int" || type2 != "int")
		{
			throwError("Type error");//throwError("Typ 688 type(s) not int");
		}
		R _ret = (R) "int";
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "*"
	 * f2 -> PrimaryExpression()
	 */
	public R visit(TimesExpression n, A argu) {
		String type1;
		String type2;
		type1 = (String) n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);
		if(type1 != "int" || type2 != "int")
		{
			throwError("Type error");//throwError("Typ 706 type(s) not int");
		}
		R _ret = (R) "int";
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "/"
	 * f2 -> PrimaryExpression()
	 */
	public R visit(DivExpression n, A argu) {
		String type1;
		String type2;
		type1 = (String) n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);
		if(type1 != "int" || type2 != "int")
		{
			throwError("Type error");//throwError("Typ 724 type(s) not int");
		}
		R _ret = (R) "int";
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "["
	 * f2 -> PrimaryExpression()
	 * f3 -> "]"
	 */
	public R visit(ArrayLookup n, A argu) {
		String type1;
		String type2;
		R _ret = (R) "int";
		type1 = (String) n.f0.accept(this, argu);
		if(type1 != "int[]")	throwError("Type error");//throwError("Typ 745 array name is not of type int[] but " + type1);
		n.f1.accept(this, argu);
		type2 = (String) n.f2.accept(this, argu);
		//System.out.println("Type 885 prim exp is " + type1 + " 2nd prim exp is " + type2);
		if(type2 != "int")	throwError("Type error");//throwError("Typ 886 array index is not int but " + type2);
		n.f3.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> "length"
	 */
	public R visit(ArrayLength n, A argu) {
		String type1;
		String type2;
		R _ret = (R) "int";
		type1 = (String) n.f0.accept(this, argu);
		if(type1 != "int[]")	throwError("Type error");//throwError("Typ 761 array name is not of type int[] but " + type1);
		n.f1.accept(this, argu);
		return _ret;
	}

	void searchMethInClass(String class1, String meth1, String ret1)
	{
		//System.out.println(class1 + "~" + meth1 + "=" + ret1);
		int pass = 0;
		while (class1 != "")
		{
			pass++;
			if(pass > 400)	throwError("Type error");
			if(methParamMap.get(st2(class1,meth1)) == null)
			{
				if(classMap.get(class1) == "")
				{
					throwError("Symbol not found");//throwError("Typ 894 method not found in all classes(current + ancestors)");
					return;
				}
				else
				{
					class1 = classMap.get(class1);
				}
			}
			else
			{
				if(ret1.equals(methParamMap.get(st2(class1,meth1))))
				{
					//it's fine
					return;
				}
				else
				{
					//System.out.println("ret1 is " + ret1 + "~");
					//System.out.println("Second is " + methParamMap.get(st2(class1,meth1)) + "~");
					throwError("Type error");//throwError("Typ 903 methods input parameters didnt match");
				}
			}
		}
		return;
	}
	String searchForMethInAncestors(String cn, String mn)
	{
		int pass = 0;
		while (cn != "")
		{
			pass++;
			if(pass > 400)	throwError("Type error");
			if(methParamMap.containsKey(st2(cn,mn)))
			{
				return cn;
			}
			else
			{
				if(!classMap.get(cn).equals(""))
				{
					if(methParamMap.containsKey(st2(cn,mn)))	return cn;
					else cn = classMap.get(cn);
				}
				else
				{
					if(!methParamMap.containsKey(st2(cn,mn)))	throwError("Symbol not found");//throwError("Typ 1038,(Symbol not found)  method not found even in ancestors |" + mn + "|");
					else return cn;
				}
			}
		}
		return cn;
	}
	boolean checkArgsMessage(String cn, String mn, String s2)
	{
		//System.out.println("Typ 1046 cn is |" + cn + "|" +  " mn is |" + mn  + "|");
		//return true;
		//System.out.println("Typ 1046 hi");
		if(!methParamMap.containsKey(st2(cn,mn)))
		{
			cn = searchForMethInAncestors(cn,mn);
			//throwError("Typ 1048, mn, cn not found at all");
		}

		String s1 = methParamMap.get(st2(cn,mn));
		//System.out.println("Typ 1052, s1 is |" + s1 + "|");
		//System.out.println("Typ 1053, s2 is |" + s2 + "|");

		if(s1.equals("") && s2.equals(""))	return true;

		StringTokenizer st1 = new StringTokenizer(s1, "~");
		StringTokenizer st2 = new StringTokenizer(s2, "~");

		while (st1.hasMoreTokens())
		{
			if(!st2.hasMoreTokens())	return false;
			else
			{
				if(!compareTypes1(st1.nextToken(),st2.nextToken()))	return false;
			}
		}
		//System.out.println("Typ 1071, remaining tokens of st2 are |" + st2.nextToken() + "|");
		if (st2.hasMoreTokens())	{throwError("Type error");/*throwError("Typ 1071, st2 has more tokens left");*/return false;}
		else return true;
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
		String type3;
		R _ret=null;
		String type11 = (String) n.f0.accept(this, argu);	//class name
		//System.out.println("Typ 922 type1 is " + type11);
		n.f1.accept(this, argu);
		String type22 = (String) n.f2.accept(this, argu);	//method
		n.f3.accept(this, argu);
		String type33 = (String) n.f4.accept(this, argu);
		if(type33 == null)	type33 = "";				//expr type list
		n.f5.accept(this, argu);

		//System.out.println("Typ 1083, hi");
		String cn1 = type11;
		String mn1 = type22;
		int pass = 0;
		while (!cn1.equals(""))
		{
			pass++;
			if(pass > 400)	throwError("Type error");
			if(methParamMap.containsKey(st2(cn1,mn1)))	break;
			else cn1 = classMap.get(cn1);
		}
		if(cn1.equals(""))	throwError("Symbol not found");//throwError("Typ 1142, method is not found in any class");

		if(checkArgsMessage(cn1,type22,type33))	{} //its ok.
		else throwError("Type error");//throwError("Typ 1057, argument list in message not matched to those in methods");

		//searchMethInClass(type11,type22,type33);
//		if(methParamMap.get(type1 + "~" + type2) == null)
//		{
//			throwError("Typ 848 no such method as " + type2 + " found in " + className);
//		}
//		if(methParamMap.get(type1 + "~" + type2) != type3)
//		{
//			System.out.println("Typ 852, " + methParamMap.get(type1 + "~" + type2) + " vs " + type3);
//			throwError("Typ 852 argument types did not match");
//		}

		_ret = (R) methRetMap.get(type11 + "~" + type22);
		//System.out.println("Typ 1150, ret is |" + (String) _ret + "|");
		//if(_ret == null)	return (R)"int";
		return _ret;
	}

	/**
	 * f0 -> Expression()
	 * f1 -> ( ExpressionRest() )*
	 */
	public R visit(ExpressionList n, A argu) {
		expList = "";
		String temp1 = (String) n.f0.accept(this, argu);
		expList = expList + "~" + temp1;
		//System.out.println("Typ 1114, exprList is |" + expList + "|");
		n.f1.accept(this, argu);

		//expList = "~" + temp1 + expRestList;
		if(expList == null)		expList = "";
		R _ret=(R) expList;
		//System.out.println("Typ 1115, exprList is |" + expList + "|");
		//System.out.println("Typ 954 explist is " + (String) _ret);
		return _ret;
	}

	/**
	 * f0 -> ","
	 * f1 -> Expression()
	 */
	public R visit(ExpressionRest n, A argu) {
		n.f0.accept(this, argu);
		String temp11 = (String) n.f1.accept(this, argu);
		//System.out.println("Typ 1132, temp11 is |" + temp11 + "|");
		expList = expList + "~" + temp11;
		//System.out.println("Typ 966 temp11 is " + temp11);
		R _ret=(R) temp11;
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
		String type1;
		String type2;
		R _ret = null;
		type1 = (String) n.f0.accept(this, argu);
		//System.out.println("Type 1200 is |" + type1 + "|");
		//System.out.println("Typ 1048 is |" + type1);
		if(!isTerminalType(type1))
		{
			if(classMap.containsKey(type1))
			{
				_ret = (R) type1;
			}
//			if(type1.equals("this"))
//			{
//				//throwError("Typ 834 this is found here. Handle it in future " + type1);
//				_ret = (R) className;
//				return _ret;
//			}
//			if(classMap.containsKey(type1))
//			{
//				_ret = (R) type1;
//				return _ret;
//			}
//			else {
//				System.out.println("Typ 1062 " +type1);
//				type1 = searchVar1(className, methName, type1);
//				throwError("Type 1057, type of primeExp is not class too |" + type1 );
//			}
			if(classMap.get(type1) == null)		{type1 = searchVar1(className, methName, type1);
				}

			if((type1 != "int" && type1 != "boolean") && type1 != "int[]")
			{
				if(classMap.get(type1) == null)
				{
					throwError("Type error");//throwError("Typ 837 typ of prim exp is neither boolean nor int nor classbut " + type1);
				}
				else
				{
					//ok
				}
			}
		}

		_ret = (R) type1;
		return _ret;
	}

	/**
	 * f0 -> <INTEGER_LITERAL>
	 */
	public R visit(IntegerLiteral n, A argu) {
		R _ret=(R) "int";
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "true"
	 */
	public R visit(TrueLiteral n, A argu) {
		R _ret=(R) "boolean";
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "false"
	 */
	public R visit(FalseLiteral n, A argu) {
		R _ret=(R) "boolean";
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> <IDENTIFIER>
	 */
	public R visit(Identifier n, A argu) {
		//System.out.println((String) n.f0.tokenImage);
		R _ret = (R) n.f0.tokenImage;
		return _ret;
	}

	/**
	 * f0 -> "this"
	 */
	public R visit(ThisExpression n, A argu) {
		R _ret = (R) className;
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
		String type1;
		R _ret= (R) "int[]";
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		type1 = (String) n.f3.accept(this, argu);
		if(type1 != "int")
		{
			throwError("Type error");//throwError("Typ 837 type of expression is not int, it is " + type1);
		}
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
		String type1;
		n.f0.accept(this, argu);
		type1 = (String) n.f1.accept(this, argu);
		if(classMap.get(type1) == null)	throwError("Symbol not found");//throwError("Typ 992 using undeclared class object in new idnt()");
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		R _ret = (R) type1;
		//System.out.println("Typ 1169 "+ (String) _ret);
		return _ret;
	}

	/**
	 * f0 -> "!"
	 * f1 -> Expression()
	 */
	public R visit(NotExpression n, A argu) {
		String type1;
		R _ret= (R) "boolean";
		n.f0.accept(this, argu);
		type1 = (String) n.f1.accept(this, argu);
		if(type1 != "boolean")
		{
			throwError("Type error");//throwError("Typ 868 type of expression is not boolean");
		}
		return _ret;
	}

	/**
	 * f0 -> "("
	 * f1 -> Expression()
	 * f2 -> ")"
	 */
	public R visit(BracketExpression n, A argu) {
		String type1;
		n.f0.accept(this, argu);
		type1 = (String) n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		R _ret = (R) type1;
		//	System.out.println("Typ 938 is " + type1);
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
