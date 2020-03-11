
/* Definitions */
/* may be helpful https://steemit.com/programming/@drifter1/writing-a-simple-compiler-on-my-own-symbol-table-basic-structure */
%{
	#include <iostream>
	#include <string>
	#include <locale.h>
	using namespace std;
	extern "C" int yylex();
	#include "parser.tab.c"
%}

%%
[0-9]+.[0-9]+ 				    { yylval.floatVal = atof(yytext); return FLOAT_LITERAL; }
[0-9]+  		                    { yylval.intVal = atoi(yytext); return INTEGER_LITERAL; }
"+"    				            { return PLUS; }
"-"					    { return MINUS; }
"*"					    { return MULT; }
"/"				        	{ return DIV; }
";"						{ return SEMI; }
"="						{ return ASSIGN; }
"^"						{ return POW; }
"וק"                                        { cout << " 2. found a key" << endl; return STRING_TYPE; }
[קראטוןםפשדגכעיחלךףזסבהנמצתץ]+              { cout << " found a string: " << yytext << endl; yylval.stringVal = yytext; return STRING_LITERAL; }
[-]\d					{ return NEG; }
[\t\r\n\f]    ; /*	ignore whitespace */

%%
/* Code */
