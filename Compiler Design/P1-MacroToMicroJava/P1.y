//Compilation and running: bison -d pract.y && flex pract.l && gcc pract.tab.c lex.yy.c -lfl -o pract && ./pract
/*
	|
{
	$$ = (char * ) malloc(2 * strlen($)+2 * strlen($)+2 * strlen($)+2 * strlen($)+2 * strlen($)+2 * strlen($)+2 * strlen($)+2 * strlen($)+2 * strlen($)+2 * strlen($)+50);
	strcat($$, $1);
	strcat($$, $2);
	strcat($$, $3);
	strcat($$, $4);
	strcat($$, $5);
	strcat($$, $6);
	strcat($$, $7);
	strcat($$, $8);
	strcat($$, $9);
	strcat($$, $10);
	strcat($$, $11);
	strcat($$, $12);
	strcat($$, $13);
	strcat($$, $14);
	strcat($$, $15);
	strcat($$, $16);
	strcat($$, $17);
	strcat($$, $18);
	strcat($$, $19);
	strcat($$, $20);
}

*/
%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	int yyerror (char* h);
	int yylex(void) ;
	
	char * mName[1000];
	int mArgCount[1000];
	char * mArgStr[1000];
	char * mDefStr[1000];
	int mCount = 0;
	
	char * replaceWord(const char * s, const char * s1, const char * s2)
	{
		char * s3 = (char * ) malloc(strlen(s) + 1000);
		
		char * originalWords[1000];
		
		char * copy  = (char * ) malloc(strlen(s) + 1000);  
		strcpy(copy, s);
		
		char * token = strtok(copy, " ");
		int count = 0;
		
		while(token != NULL)
		{
			originalWords[count] = (char *) malloc(100);
			//printf("hello %s \n", token);
			
			strcpy(originalWords[count] , token);
			count++;
			
			token = strtok(NULL, " ");
		}
		
		int i = 0;
		for(i = 0; i < count; i++)
		{
			if(strcmp(originalWords[i], s1) == 0)
			{
				strcpy(originalWords[i], s2);
			}
			
		}
		
		for(i = 0; i < count; i++)
		{
			strcat(s3, originalWords[i]);
			//printf("-- %s\n", originalWords[i]);
			strcat(s3, " ");	
		}
		
		return s3;	
	}
	
	

%}
%union
{
	char *i1;
}
%start goal;
%type <i1> Exp Pexp Integer Identifier Statement Statements Type MacDef1 MacDef  MacDefExp MacDefStat MainClass  TypeDec1 TypeDec TypeIdent1 TypeIdent	MethDec1 MethDec ComIdent1 ComIdent ComTypeIdent1 ComTypeIdent ComExp1 ComExp goal
%token Class Public Static Void Main String Sq1 Sq2 Curl1 Curl2 Common1 Common2 SystemOutPrintln Extends Return Int Boolean Equals If Else While Question Comma DoubleAnd DoubleOr NotEqual LessEqual Plus Minus Star Slash Dot Length True False This New HashDefine Integer Identifier End Not 

%%
goal : MacDef1 MainClass TypeDec1  
{
	$$ = (char * ) malloc(2 * 2 * strlen($1)+2 * 2 * strlen($2)+2 * strlen($3)+50);
	//$$ = (char * ) malloc(2 * strlen($1)+50);
	strcat($$, $1);
	strcat($$, "\n");
	strcat($$, $2);
	strcat($$, "\n");
	strcat($$, $3);
	strcat($$, "\n");
	printf("%s\n", $$);
}; 

MainClass : Class Identifier Curl1 Public Static Void Main Common1 String Sq1 Sq2 Identifier Common2 Curl1 SystemOutPrintln Common1 Exp Common2 End Curl2 Curl2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($12)+2 * strlen($17)+100);
	strcat($$, "class ");
	strcat($$, $2);
	strcat($$, " { ");
	strcat($$, " public ");
	strcat($$, "static ");
	strcat($$, "void ");
	strcat($$, "main ");
	strcat($$, "( ");
	strcat($$, "String ");
	strcat($$, "[");
	strcat($$, "] ");
	strcat($$, $12);
	strcat($$, " ) ");
	strcat($$, "\n");
	strcat($$, "{ ");
	strcat($$, "\n");
	strcat($$, "System.out.println ");
	strcat($$, "( ");
	strcat($$, $17);
	strcat($$, ") ");
	strcat($$, ";");
	strcat($$, "\n");
	strcat($$, "} ");
	strcat($$, "\n");
	strcat($$, "}");
};

TypeDec1 : TypeDec TypeDec1
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+50);	
	strcat($$, $1);
	strcat($$, "\n");
	strcat($$, $2);	
}
	|
{
	$$ = "";
};

TypeDec : Class Identifier Curl1 TypeIdent1 MethDec1 Curl2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($4)+2 * strlen($5)+50);
	strcat($$, "class ");
	strcat($$, $2);
	strcat($$, "\n");
	strcat($$, "{ ");
	strcat($$, "\n");
	strcat($$, $4);
	strcat($$, "\n");
	strcat($$, $5);
	strcat($$, "\n");
	strcat($$, "}");
	strcat($$, "\n");
}
	| Class Identifier Extends Identifier Curl1 TypeIdent1 MethDec1 Curl2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($4)+2 * strlen($6)+2 * strlen($7)+50);
	strcat($$, "class ");
	strcat($$, $2);
	strcat($$, "\n");
	strcat($$, " extends ");
	strcat($$, $4);
	strcat($$, "\n");
	strcat($$, "{ ");
	strcat($$, $6);
	strcat($$, "\n");
	strcat($$, $7);
	strcat($$, "\n");
	strcat($$, " } ");
	strcat($$, "\n");
};

TypeIdent1 : TypeIdent1 TypeIdent
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+50);	
	strcat($$, $1);
	strcat($$, "\n");
	strcat($$, $2);	
	strcat($$, "\n");
}
	|
{
	$$ = "";
};

TypeIdent : Type Identifier End
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+50);	
	strcat($$, $1);
	strcat($$, $2);	
	strcat($$, "; ");	
};

MethDec1 : MethDec MethDec1
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+50);	
	strcat($$, $1);
	strcat($$, "\n");
	strcat($$, $2);	
	strcat($$, "\n");
}
	|
{
	$$ = "";
};


MethDec : Public Type Identifier Common1 Type Identifier ComTypeIdent1 Common2 Curl1 TypeIdent1 Statements Return Exp End Curl2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($3)+2 * strlen($5)+2 * strlen($6)+2 * strlen($7)+2 * strlen($10)+2 * strlen($11)+2 * strlen($13)+50);
	strcat($$, "public ");
	strcat($$, $2);
	strcat($$, " ");
	strcat($$, $3);
	strcat($$, " ");
	strcat($$, " ( ");
	strcat($$, $5);
	strcat($$, " ");
	strcat($$, $6);
	strcat($$, " ");
	strcat($$, $7);
	strcat($$, " ) ");
	strcat($$, " {" );
	strcat($$, $10);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, " ");
	strcat($$, $11);
	strcat($$, " return ");
	strcat($$, $13);
	strcat($$, " ; ");
	strcat($$, "\n");
	strcat($$, " } ");
	strcat($$, "\n");
}
	| Public Type Identifier Common1 Common2 Curl1 TypeIdent1 Statements Return Exp End Curl2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($3)+2 * strlen($7)+2 * strlen($8)+2 * strlen($10)+50);
	strcat($$, " public ");
	strcat($$, $2);
	strcat($$, " ");
	strcat($$, $3);
	strcat($$, " ( ");
	strcat($$, " ) ");
	strcat($$, " { ");
	strcat($$, $7);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, $8);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, " return ");
	strcat($$, $10);
	strcat($$, " ; ");
	strcat($$, " } ");
	strcat($$, "\n");
};

ComTypeIdent1 : ComTypeIdent ComTypeIdent1
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+50);	
	strcat($$, $1);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, $2);	
}
	|
{
	$$ = "";
};

ComTypeIdent : Comma Type Identifier
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($3)+50);	
	strcat($$, " , ");
	strcat($$, " ");
	strcat($$, $2);
	strcat($$, " ");
	strcat($$, $3);	
	strcat($$, "\n");
};

MacDef1 : MacDef MacDef1
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+50);	
	strcat($$, $1);
	strcat($$, "\n");
	strcat($$, $2);	
}
	|
{
	$$ = "";
};

MacDef : MacDefExp
{
	$$ = (char * ) malloc(2 * strlen($1)+50);	
	strcat($$, $1);
	strcat($$, "\n");
}
	| MacDefStat
{
	$$ = (char * ) malloc(2 * strlen($1)+50);	
	strcat($$, $1);
	strcat($$, "\n");
};

MacDefStat : HashDefine Identifier Common1 Identifier ComIdent1 Common2 Curl1 Statements Curl2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($4)+2 * strlen($5)+2 * strlen($8)+50);
	/*strcat($$, " #define ");
	strcat($$, $2);
	strcat($$, " ( ");
	strcat($$, $4);
	strcat($$, " ");
	strcat($$, $5);
	strcat($$, " ");
	strcat($$, " ) ");
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, " { ");
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, $8);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, " } ");
	strcat($$, "\n");*/
	$$ = "";
	
	mName[mCount] = (char *) malloc(strlen($2) + 10);
	mName[mCount] = $2;
	
	mArgStr[mCount] = (char *) malloc(strlen($4) + strlen($5) + 30);
	mArgStr[mCount] = $4;
	strcat(mArgStr[mCount], " ");
	strcat(mArgStr[mCount], $5);
	strcat(mArgStr[mCount], " ");
	
	mDefStr[mCount] =(char *) malloc(strlen($8) + 50);
	strcat(mDefStr[mCount], "  ");
	strcat(mDefStr[mCount], $8);
	strcat(mDefStr[mCount], "  ");	
	
	//printf("1 -> %s\n 2 -> %s \n 3 -> %s\n",mName[mCount], mArgStr[mCount], mDefStr[mCount]);
	
	mCount++;	
	
	
}
	| HashDefine Identifier Common1 Common2 Curl1 Statements Curl2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($6)+50);
	/*strcat($$, " #define ");
	strcat($$, $2);
	strcat($$, " ( ");
	strcat($$, " ) ");
	strcat($$, " { ");
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, $6);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, " } ");
	strcat($$, "\n");*/
	$$ = "";
	
	mName[mCount] = (char *) malloc(strlen($2) + 10);
	mName[mCount] = $2;
	
	mArgStr[mCount] = (char *) malloc(10);
	mArgStr[mCount] = "";
	
	mDefStr[mCount] =(char *) malloc(strlen($6) + 50);
	strcat(mDefStr[mCount], "  ");
	strcat(mDefStr[mCount], $6);
	strcat(mDefStr[mCount], "  ");	
	
	//printf("1 -> %s\n 2 -> %s \n 3 -> %s\n",mName[mCount], mArgStr[mCount], mDefStr[mCount]);
	
	mCount++;	
}
;

MacDefExp :  HashDefine Identifier Common1 Identifier ComIdent1 Common2 Common1 Exp Common2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($4)+2 * strlen($5)+2 * strlen($8)+50);
	/*strcat($$, " #define ");
	strcat($$, $2);
	strcat($$, " ( ");
	strcat($$, $4);
	strcat($$, " ");
	strcat($$, $5);
	strcat($$, " ");
	strcat($$, " ) ");
	strcat($$, " ( ");
	strcat($$, " ");
	strcat($$, $8);
	strcat($$, " ) ");
	strcat($$, "\n");
	strcat($$, " ");*/
	$$ = "";
	
	mName[mCount] = (char *) malloc(strlen($2) + 10);
	mName[mCount] = $2;
	
	mArgStr[mCount] = (char *) malloc(strlen($4) + strlen($5) + 30);
	mArgStr[mCount] = $4;
	strcat(mArgStr[mCount], " ");
	strcat(mArgStr[mCount], $5);
	strcat(mArgStr[mCount], " ");
	
	mDefStr[mCount] =(char *) malloc(strlen($8) + 50);
	strcat(mDefStr[mCount], " ( ");
	strcat(mDefStr[mCount], $8);
	strcat(mDefStr[mCount], " ) ");	
	
	//printf("1 -> %s\n 2 -> %s \n 3 -> %s\n",mName[mCount], mArgStr[mCount], mDefStr[mCount]);
	
	
	mCount++;	
}

	| HashDefine Identifier Common1 Common2 Common1 Exp Common2
{
	$$ = (char * ) malloc(2 * strlen($2)+2 * strlen($6)+50);
	/*strcat($$, " #define ");
	strcat($$, $2);
	strcat($$, " ( ");
	strcat($$, " ) ");
	strcat($$, " ( ");
	strcat($$, $6);
	strcat($$, " ) ");
	strcat($$, "\n");*/
	$$ = "";
	
	mName[mCount] = (char *) malloc(strlen($2) + 10);
	mName[mCount] = $2;
	
	mArgStr[mCount] = (char *) malloc(10);
	mArgStr[mCount] = "";
	
	mDefStr[mCount] =(char *) malloc(strlen($6) + 50);
	strcat(mDefStr[mCount], " ( ");
	strcat(mDefStr[mCount], $6);
	strcat(mDefStr[mCount], " ) ");		
	
	//printf("1 -> %s\n 2 -> %s \n 3 -> %s\n",mName[mCount], mArgStr[mCount], mDefStr[mCount]);
	
	mCount++;	
};	

ComIdent1 : ComIdent ComIdent1 
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+50);	
	strcat($$, $1);
	strcat($$, " ");
	strcat($$, $2);	
	strcat($$, " ");
}
	|
{
	$$ = "";
};

ComIdent : Comma Identifier
{
	$$ = (char * ) malloc(2 * strlen($2)+50);	
	strcat($$, " , ");
	strcat($$, $2);	
};

ComExp1 : ComExp ComExp1
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+50);	
	strcat($$, $1);
	strcat($$, " ");
	strcat($$, $2);	
	strcat($$, " ");
}
	|
{
	$$ = "";
};

ComExp : Comma Exp
{
	$$ = (char * ) malloc(2 * strlen($2)+50);	
	strcat($$, " , ");
	strcat($$, $2);	
};

Statement : Curl1 Statements Curl2
{
	$$ = (char * ) malloc(2 * strlen($2)+10);
	strcat($$, " { ");
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, $2);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, " } ");
	strcat($$, "\n");
	strcat($$, " ");
}
	| SystemOutPrintln Common1 Exp Common2 End
{
	$$ = (char * ) malloc(2 * strlen($3)+30);
	strcat($$, " System.out.println ");
	strcat($$, " ( ");
	strcat($$, $3);
	strcat($$, " ) ");
	strcat($$, " ; ");
	strcat($$, "\n");
	strcat($$, " ");
}
	| Identifier Equals Exp End
{
	strcat($1,"\0");
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+30);
	strcat($$, $1);
	strcat($$, " = ");
	strcat($$, $3);
	strcat($$, " ; ");
	strcat($$, "\n");
	strcat($$, " ");
}
	| Identifier Sq1 Exp Sq2 Equals Exp End
{
	strcat($1,"\0");
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+2 * strlen($6)+30);
	strcat($$, $1);
	strcat($$, " [ ");
	strcat($$, $3);
	strcat($$, " ] ");
	strcat($$, " = ");
	strcat($$, $6);
	strcat($$, " ; ");
	strcat($$, "\n");
	strcat($$, " ");
}
	| If Common1 Exp Common2 Statement
{
	strcat($5, "\0");
	$$ = (char * ) malloc(2 * strlen($3)+2 * strlen($5)+30);
	strcat($$, " if ");
	strcat($$, " ( ");
	strcat($$, $3);
	strcat($$, " ) ");
	strcat($$, $5);
	strcat($$, "\n");
	strcat($$, " ");
}
	| If Common1 Exp Common2 Statement Else Statement
{
	$$ = (char * ) malloc(2 * strlen($3)+2 * strlen($5)+2 * strlen($7)+10);
	strcat($$, " if ");
	strcat($$, " ( ");
	strcat($$, $3);
	strcat($$, " ) ");
	strcat($$, $5);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, " else ");
	strcat($$, $7);
	strcat($$, "\n");
	strcat($$, " ");
}
	| While Common1 Exp Common2 Statement
{
	$$ = (char * ) malloc(2 * strlen($3)+2 * strlen($5)+30);
	strcat($$, " while ");
	strcat($$, " ( ");
	strcat($$, $3);
	strcat($$, " ) ");
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, $5);
	strcat($$, "\n");
	strcat($$, " ");
}
	| Identifier Common1 Exp ComExp1 Common2 End				//Do Macro
{
	/*$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+2 * strlen($4)+50);
	strcat($$, $1);
	strcat($$, " ( ");
	strcat($$, $3);
	strcat($$, " ");
	strcat($$, $4);
	strcat($$, " ");
	strcat($$, " ) ");
	strcat($$, " ; ");
	strcat($$, "\n");
	strcat($$, " ");*/
	
	//printf("doll3 -> %s\n", $3);
	
	/////start
	int index = 0;
	
	for(index = mCount - 1; index >= 0; index--)
	{
		if(strcmp(mName[index], $1) == 0)	break;
	}	
	if(index == -1)		
	{
		yyerror(NULL);
		exit(0);
	}
	//printf("Index found %d\n", index);
	//if(index == mCount)		printf("macro not found\n");//Display Parse Error!
	
	//Taking copies from macros
	
	char * ArgsCopy = (char *) malloc(strlen(mArgStr[index]) + 50);
	//ArgsCopy = "";
	strcpy(ArgsCopy, mArgStr[index]);
	
	char * DefCopy = (char *) malloc(strlen(mDefStr[index]) + 500000);
	strcpy(DefCopy, mDefStr[index]);
	
	char * ExpsCopy = (char *) malloc(strlen($3) + strlen($4) + 50);
	strcpy(ExpsCopy, $3);
	strcat(ExpsCopy, " , ");
	strcat(ExpsCopy, $4);
	strcat(ExpsCopy, " ");	
	//printf("deedexpscopy -> %s\n", ExpsCopy);
	
	//Creating Args, Exps columns
	
	char * mArgs[100];		//Array of argument strings as per macro def
	char * mExps[100];		//Array of expression strings as per bison code
	
	char * token;
	
	token = strtok(ArgsCopy, " ,");
	
	int ai = 0;
	//printf("Index found %d\n", index);
	while(token != NULL)
	{
		mArgs[ai] = (char * ) malloc(strlen(token) + 20);
		mArgs[ai] = token;
		
		token = strtok(NULL, " ,");
		ai++;
	}
	//printf("Index found %d\n", index);
	//strcpy(token, "");
	char * token1;
	token1 = strtok(ExpsCopy, ",");
	
	int ei = 0;
	//printf("Index found %d\n", index);
	while(token1 != NULL)
	{
		mExps[ei] = (char *) malloc(strlen(token1) + 30);
		mExps[ei] = token1;
		
		token1 = strtok(NULL, " ,");
		ei++;
	}
	//printf("Index found %d\n", index);
	if(ai != ei)		yyerror(NULL);//printf("ai is %d and ei is %d\n", ai, ei);//		
	
	//Now replacing, adding to $$
	
	//printf("exp is %s -- arg1 is %s  \n", mExps[0], mArgs[0]);
	
	int i = 0;
	
	for(i = 0; i < ai; i++)
	{
		strcpy(DefCopy, replaceWord(DefCopy, mArgs[i], mExps[i]));
	}
	
	$$ = (char *) malloc(strlen(DefCopy) + 50);
	strcpy($$, DefCopy);
	strcat($$, "  \n");
	//printf("statmacrooo -> %s \n", $$);
	
}	
	| Identifier Common1 Common2 End						//Do Macro
{
	/*$$ = (char * ) malloc(2 * strlen($1)+50);
	strcat($$, $1);
	strcat($$, " ( "); 
	strcat($$, " ) ");
	strcat($$, " ; ");
	strcat($$, "\n");
	strcat($$, " ");*/
	
	/////start
	int index = 0;
	
	for(index = mCount - 1; index >= 0; index--)
	{
		if(strcmp(mName[index], $1) == 0)	break;
	}	
	if(index == -1)		
	{
		yyerror(NULL);
		exit(0);
	}
	//printf("Index found %d\n", index);
	//if(index == mCount)		printf("macro not found\n");		//Display Parse Error!
	
	char * DefCopy = (char *) malloc(strlen(mDefStr[index]) + 5000);
	strcpy(DefCopy, mDefStr[index]);
	$$ = (char *) malloc(strlen(DefCopy) + 50);
	strcpy($$, DefCopy);
	strcat($$, "  \n");
}
;


Statements: Statement Statements
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($2)+10);
	strcat($$, $1);
	strcat($$, "\n");
	strcat($$, " ");
	strcat($$, $2);
	strcat($$, "\n");
}
	|
{
	$$ = "";
};

Type : Int Sq1 Sq2
{
	$$ = (char * ) malloc(30);
	strcat($$, "int");
	strcat($$, " [ ");
	strcat($$, " ] ");
}
	| Boolean
{
	$$ = (char * ) malloc(30);
	strcat($$, " boolean ");
}
	| Int 
{
	$$ = (char * ) malloc(30);
	strcat($$, " int ");
}
	| Identifier
{
	strcat($1,"\0");
	$$ = (char * ) malloc(2 * strlen($1) + 30);
	strcat($$, $1);
	strcat($$, " ");
};

Exp : Pexp  DoubleAnd Pexp	
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);
	strcat($$, $1);
	strcat($$, " && ");
	strcat($$, $3);
	strcat($$, " ");
	////printf("I am DoubleAnd\n");
	//printf("%s and %s\n", $1,$3);
}
	| Pexp DoubleOr Pexp
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);
	strcat($$, $1);
	strcat($$, " || ");
	strcat($$, $3);
	strcat($$, " ");
}
	| Pexp NotEqual Pexp
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);
	strcat($$, $1);
	strcat($$, " != ");
	strcat($$, $3);
	strcat($$, " ");
}
	| Pexp LessEqual Pexp
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);
	strcat($$, $1);
	strcat($$, " <= ");
	strcat($$, $3);
	strcat($$, " ");
}
	| Pexp Plus Pexp
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);
	strcat($$, $1);
	strcat($$, " + ");
	strcat($$, $3);
	strcat($$, " ");
}
	| Pexp Minus Pexp
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);
	strcat($$, $1);
	strcat($$, " - ");
	strcat($$, $3);
	strcat($$, " ");
}
	| Pexp Star Pexp//
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);

	//printf("Hi64 %s, %s\n", $1, $3);
	strcat($$, $1);
	strcat($$, " * ");
	strcat($$, $3);
	strcat($$, " ");
}
	| Pexp Slash Pexp//??
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);
	strcat($$, $1);
	strcat($$, " / ");
	strcat($$, $3);
	strcat($$, " ");
}
	| Pexp Sq1 Pexp Sq2//
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+10);
	strcat($$, $1);
	strcat($$," [ ");
	strcat($$,$3);
	strcat($$," ] ");
	strcat($$, " ");
}
	| Pexp Dot Length//
{
	$$ = (char * ) malloc(2 * strlen($1)+10);
	strcat($$, $1);
	strcat($$, ".");
	strcat($$, "length");
}
	| Pexp
{
	$$ = (char * ) malloc(2 * strlen($1)+10);
	strcat($$, $1);
	//printf("At pexp 99 %s\n", $$);
}
	| Pexp Dot Identifier Common1 Exp ComExp1 Common2
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+2 * strlen($5)+2 * strlen($6)+50);
	strcat($$, $1);
	strcat($$, ".");
	strcat($$, $3);
	strcat($$, " ");
	strcat($$, " ( ");
	strcat($$, $5);
	strcat($$, " ");
	strcat($$, $6);
	strcat($$, " ) ");
}	
	| Pexp Dot Identifier Common1 Common2
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+50);
	strcat($$, $1);
	strcat($$, ".");
	strcat($$, $3);
	strcat($$, " ");
	strcat($$, " ( ");
	strcat($$, " ) ");
}
	| Identifier Common1 Exp ComExp1 Common2					//Do Macro
{
	$$ = (char * ) malloc(2 * strlen($1)+2 * strlen($3)+2 * strlen($4)+50);
	strcat($$, $1);
	strcat($$, " ( ");
	strcat($$, $3);
	strcat($$, " ");
	strcat($$, $4);
	strcat($$, " ) ");
	
		/////start
	int index = 0;
	
	for(index = mCount - 1; index >= 0; index--)
	{
		if(strcmp(mName[index], $1) == 0)	break;
	}	
	if(index == -1)		
	{
		yyerror(NULL);
		exit(0);
	}
	//printf("Index found %d\n", index);
	//if(index == mCount)		printf("macro not found\n");		//Display Parse Error!
	
	//Taking copies from macros
	
	char * ArgsCopy = (char *) malloc(strlen(mArgStr[index]) + 50);
	strcpy(ArgsCopy, mArgStr[index]);
	
	char * DefCopy = (char *) malloc(strlen(mDefStr[index]) + 5000);
	strcpy(DefCopy, mDefStr[index]);
	
	char * ExpsCopy = (char *) malloc(strlen($3) + strlen($4) + 50);
	strcpy(ExpsCopy, $3);
	strcat(ExpsCopy, ",");
	strcat(ExpsCopy, $4);
	strcat(ExpsCopy, " ");	
	//printf("Index found %d\n", index);
	
	//Creating Args, Exps columns
	
	char * mArgs[100];		//Array of argument strings as per macro def
	char * mExps[100];		//Array of expression strings as per bison code
	
	char * token;
	
	token = strtok(ArgsCopy, " ,");
	
	// printf("Index found %d\n", index);
	int ai = 0;
	while(token != NULL)
	{
		mArgs[ai] = (char * ) malloc(strlen(token) + 20);
		mArgs[ai] = token;
		
		token = strtok(NULL, " ,");
		ai++;
	}
	
	//printf("Index found %d\n", index);
	//token = strtok(ExpsCopy, " ,");
	char * token1;
	token1 = strtok(ExpsCopy, ",");
	int ei = 0;
	
	while(token1 != NULL)
	{
		mExps[ei] = (char *) malloc(strlen(token1) + 30);
		mExps[ei] = token1;
		
		token1 = strtok(NULL, " ,");
		ei++;
	}
	
	//printf("Index found %d\n", index);
	//if(ai != ei)		yyerror(NULL);			// Display Parse Error!
	
	//Now replacing, adding to $$
	
	int i = 0;
	
	for(i = 0; i < ai; i++)
	{
		strcpy(DefCopy,replaceWord(DefCopy, mArgs[i], mExps[i]));
	}
	
	$$ = (char *) malloc(strlen(DefCopy) + 50);
	strcpy($$, DefCopy);
	strcat($$, " \n");

}	
	| Identifier Common1 Common2								//Do Macro
{
	/*$$ = (char * ) malloc(2 * strlen($1)+50);
	strcat($$, $1);
	strcat($$, " ( ");
	strcat($$, " ) ");*/	
	
	/////start
	int index = 0;
	
	for(index = mCount - 1; index >= 0; index--)
	{
		if(strcmp(mName[index], $1) == 0)	break;
	}	
	if(index == -1)		
	{
		yyerror(NULL);
		exit(0);
	}
	//printf("Index found %d\n", index);
	//if(index == mCount)		printf("macro not found\n");		//Display Parse Error!
	//printf("hello\n");
	char * DefCopy = (char *) malloc(strlen(mDefStr[index]) + 5000);
	strcpy(DefCopy, mDefStr[index]);
	
	//printf("asdlfhasop -> %s\n", mDefStr[index]);
	$$ = (char *) malloc(strlen(DefCopy) + 50);
	strcpy($$, DefCopy);
	strcat($$, "  \n");
	//printf("hello1\n");
	//printf("deed -> %s\n", $$);
};




Pexp : Integer
{
	$$ = (char * ) malloc(2 * strlen($1)+5);
	strcat($$, $1);
	strcat($$, " ");
	//printf("Hello integer! %s\n", $$);
}
	| True
{
	$$ = (char * ) malloc(10);
	strcat($$, " true ");
	//printf("Hi at 115, %s\n", $$);
}
	| False
{
	$$ = (char * ) malloc(10);
	strcat($$, " false ");	
}
	| Identifier
{
	strcat($1,"\0");
	$$ = (char * ) malloc(100);
	strcat($$, $1);	
	strcat($$, " ");
}
	| This
{
	$$ = (char * ) malloc(10);
	strcat($$, " this ");	
}
	| New Int Sq1 Exp Sq2
{
	$$ = (char * ) malloc(2 * strlen($4)+15);
	strcat($$," new ");
	strcat($$," int ");
	strcat($$," [ ");
	strcat($$, $4);
	strcat($$," ] ");	
	strcat($$, "\n");
	strcat($$, " ");
}
	| New Identifier Common1 Common2
{
	strcat($2,"\0");
	$$ = (char * ) malloc(2 * strlen($2)+10);
	strcat($$," new ");
	strcat($$, $2);
	strcat($$," ( ");
	strcat($$," ) ");	
}
	
	| Common1 Exp Common2
{
	$$ = (char * ) malloc(2 * strlen($2)+10);
	strcat($$," ( ");
	strcat($$, $2);
	strcat($$, " ) ");
}
	| Not Exp
{
	$$ = (char * ) malloc(2 * strlen($2)+10);
	strcat($$," !");
	strcat($$, $2);
	strcat($$, " ");	
	//printf("I am not\n");
	//printf("Dollar 2 is %s\n", $2);
};

%%








int yyerror(char *s)
{
	printf ("// Failed to parse macrojava code.");
	//exit(0);
	return 0;
}

int main ()
{
	yyparse();
	return 0;
}
