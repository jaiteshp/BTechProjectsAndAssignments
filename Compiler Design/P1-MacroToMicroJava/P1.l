%{
	#include <stdio.h>
	#include "P1.tab.h"
	#include <string.h>
	//int yylex(void);
	//(-|"")
%}

digit 		[0-9]
integer 	((0|[1-9]){digit}*)
letter		([a-z]|[A-Z])
identifier		({letter}({underscore}|{letter}|{digit})*)
space 		"\t"|"\n"|"\r"|"\f"|" "
underscore	"_"
semicolon	";"
%%


{space}		{;}
"//".*		{;}
"-"			{return Minus;}
"class"		{return Class;}
"public"	{return Public;}
"static"	{return Static;}
"void"		{return Void;}
"main"		{return Main;}
"String"	{return String;}
"["			{return Sq1;}
"]"			{return Sq2;}
"{"			{return Curl1;}
"}"			{return Curl2;}
"("			{return Common1;}
")"			{return Common2;}
"System.out.println"	{return SystemOutPrintln;}
"extends"	{return Extends;}
"return"	{return Return;}
"int"		{return Int;}
"boolean"	{return Boolean;}
"="			{return Equals;}
"if"		{return If;}
"else"		{return Else;}
"while"		{return While;}
"?"			{return Question;}
","			{return Comma;}
"&&"		{return DoubleAnd;}
"||"		{return DoubleOr;}
"!="		{return NotEqual;}
"!"			{return Not;}
"<="		{return LessEqual;}
"+" 		{return Plus;}
"*"			{return Star;}
"/"			{return Slash;}
"."			{return Dot;}
"length"	{return Length;}
"true"		{return True;}
"false"		{return False;}
"this"		{return This;}
"new"		{return New;}
"#define"	{return HashDefine;}
{integer}		{yylval.i1 = (char *) malloc(sizeof(yytext)); strcat(yylval.i1, yytext); 
//printf("Inside flex %s and %s\n", yytext, yylval.i1);
return Integer;}
{identifier}	{yylval.i1 = (char *) malloc(sizeof(yytext)); strcat(yylval.i1, yytext); return Identifier;}
{semicolon}	{return End;}
%%

/*int main()
{
	yylex();
}*/

