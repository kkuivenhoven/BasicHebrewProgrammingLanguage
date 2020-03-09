/* Definitions */
%{
	#include <iostream>
	#include <string>
	#include <locale.h>
	using namespace std;
	extern "C" int yylex();
	#include "parser.tab.c"
%}

%%
[קראטוןםפשדגכעיחלךףזסבהנמצתץ]+        { yylval.stringVal = yytext; return STRING_LITERAL; }
[\u05D5]{1}[\u05E7]{1}       cout << " MATCHED: " << yytext << endl;
[0-9]+.[0-9]+ { yylval.floatVal = atof(yytext); return FLOAT_LITERAL; }
[0-9]+  		  { yylval.intVal = atoi(yytext); return INTEGER_LITERAL; }
"+"    				{ return PLUS; }
"-"						{ return MINUS; }
"*"						{ return MULT; }
"/"						{ return DIV; }
";"						{ return SEMI; }
"="						{ return ASSIGN; }
"^"						{ return POW; }
[-]\d					{ return NEG; }
[\t\r\n\f]    ; /*	ignore whitespace */

%%
/* Code */

