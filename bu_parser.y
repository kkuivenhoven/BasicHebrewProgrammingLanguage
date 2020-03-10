%{
	#include <iostream>
	#include <string>
	#include <locale.h>
	#include <math.h>
	/* #define STRING_DEC "וק"*/

	using namespace std;
	extern "C" void yyerror(const char *s);
	extern "C" int yyparse();

	int main(int argc, char **argv){
		if(argc < 2){
			cout << "Provide a filename to parse!" << endl;
			exit(1);
		}

		FILE *sourceFile = fopen(argv[1], "r");
		
		if(!sourceFile){
			cout << "Could not open source file " << argv[1] << endl;
			exit(1);
		}


		yyin = sourceFile;
		yyparse();
	}

	void yyerror(const char *s){
		cerr << s << endl;
	}
	
%}


%union{
	int intVal;
	float floatVal;
	char *stringVal;
}

%start program

%token <stringVal> STRING_LITERAL
%token <intVal> INTEGER_LITERAL
%token <floatVal> FLOAT_LITERAL
%token ASSIGN "="
%token STRING_TYPE "וק"
%token SEMI
%type <floatVal> exp
%type <stringVal> str
%type <floatVal> statement
%type <stringVal> string_statement
%left PLUS MINUS
%left MULT DIV
%right POW
%left NEG

%%  
program:
	| program statement { cout << "Result: " << $2 << endl; }
	| program string_statement { cout << "Result: " << $2 << endl; }
	;


statement: exp SEMI

exp:
	INTEGER_LITERAL		 		{ $$ = $1; }
	| FLOAT_LITERAL		 		{ $$ = $1; }
	| exp PLUS exp 				{ $$ = $1 + $3; }
        | exp MINUS exp		 		{ $$ = $1 - $3; }
	| exp MULT exp 				{ $$ = $1 * $3; }
	| exp DIV exp 				{ $$ = $1 / $3; }
	| MINUS exp %prec NEG { $$ = -$2; }
	| exp POW exp 				{ $$ = pow($1,$3); }
	;


string_statement: str SEMI

str:
	STRING_LITERAL { $$ = $1; }
	| str STRING_LITERAL { $$ = $1; }
	| STRING_LITERAL STRING_TYPE { $$ = $1; }
	| str ASSIGN STRING_LITERAL STRING_TYPE { $$ = $1; }
	| str ASSIGN STRING_LITERAL { $$ = $1; }
	;
