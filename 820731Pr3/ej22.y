 //Inés Román Gracia, NIP: 820731. Práctica 3: ejercicio 22.
%{
#include <stdio.h>
int b = 10;
int num;
int pot;
int suma;
%}
%token NUMBER EOL EOLB CP OP BASE
%start calclist
%token ADD SUB
%token MUL DIV
%%

calclist : /* nada */
    | calclist BASE EOL { b = $2; }
	| calclist exp EOL { printf("=%d\n", $2); }
    | calclist exp EOLB {
        num = $2;
        pot = 1;
        suma = 0;
        while(num != 0){
            suma = suma + (num % b) * pot;
            pot = pot * 10;
            num = num / b;
        }
        printf("=%d\n", suma); 
    }
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