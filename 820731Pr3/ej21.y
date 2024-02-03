 //Inés Román Gracia, NIP: 820731. Práctica 3: ejercicio 21.
%{
#include <stdio.h>
%}
%token NUMBER EOL CP OP BASE
%start calclist
%token ADD SUB
%token MUL DIV
%%

calclist : /* nada */
	| calclist BASE EOL
	| calclist exp EOL { printf("=%d\n", $2); }
	;
exp : 	factor 
	| exp ADD factor { $$ = $1 + $3; }
	| exp SUB factor { $$ = $1 - $3; }	
	;
factor : 	factor MUL factorsimple { $$ = $1 * $3; }
		| factor DIV factorsimple { $$ = $1 / $3; }
		| factorsimple
		;
factorsimple : 	OP exp CP { $$ = $2; }
		| NUMBER
		;
%%
int yyerror(char* s) {
   printf("\n%s\n", s);
   return 0;
}
int main() {
  yyparse();
}