 //Inés Román Gracia, NIP: 820731. Práctica 3: ejercicio 3.
%{
#include <stdio.h>
%}
%token X Y Z EOL
%start inicio
%%
inicio: /* nada */
	| inicio S EOL
	;
S: /* nada */
	| C X S
	;
B: 	X C Y 
	| X C
	;
C: 	X B X
	| Z
	;
%%
int yyerror(char* s) {
   printf("\n%s\n", s);
   return 0;
}
int main() {
  yyparse();
}