 //Inés Román Gracia, NIP: 820731. Práctica 3: ejercicio 23.
%{
#include <stdio.h>
int ac = 0;
%}
%token NUMBER ACUM EOL CP OP DAC OAC
%start calclist
%token ADD SUB
%token MUL DIV
%%

calclist : /* nada */
	| calclist exp EOL { printf("=%d\n", $2); }
    | calclist DAC exp EOL { ac = $3; }
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
        | OAC {$$ = ac; }
		;
%%
int yyerror(char* s) {
   printf("\n%s\n", s);
   return 0;
}
int main() {
  yyparse();
}